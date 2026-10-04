"""Run commands on the itcoder VPS, and copy files to it.

    python -X utf8 vps.py "lsb_release -ds"        # one command, prints the output

Or import it from your own script:

    import vps
    code, out = vps.run('nginx -t')
    vps.put('D:/path/to/file.conf', '/etc/nginx/sites-available/file.conf')
    vps.put_tree('D:/DB Sync/Dropbox/Projects/AIPascalCourse', '/var/www/itcoder')
"""

import atexit
import os
import posixpath
import sys

import paramiko

HOST = '102.214.9.207'
USER = 'root'
KEY = os.path.expanduser('~/.ssh/gnomemedia_vps')

_client = None


def client():
    global _client
    if _client is None:
        c = paramiko.SSHClient()
        c.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        c.connect(HOST, username=USER,
                  pkey=paramiko.RSAKey.from_private_key_file(KEY),
                  timeout=30, allow_agent=False, look_for_keys=False)
        c.get_transport().set_keepalive(30)   # a quiet link is noticed, not left half-open
        atexit.register(c.close)
        _client = c
    return _client


# A file that has not finished sending in this long is sent again, on a fresh
# connection (Chris, 4 October 2026: two live deploys hung for good on one
# picture - sftp.put had no time limit - "if it goes over an hour, terminate
# and restart"). Three tries, then the deploy stops with the error.
PUT_TIMEOUT = 120
PUT_TRIES = 3


def _fresh_sftp():
    """An SFTP session with a time limit - on a new connection when the old one has died."""
    global _client
    try:
        transport = _client.get_transport() if _client is not None else None
        if transport is None or not transport.is_active():
            raise EOFError('no live connection')
        sftp = _client.open_sftp()
    except Exception:
        try:
            if _client is not None:
                _client.close()
        except Exception:
            pass
        _client = None
        sftp = client().open_sftp()
    sftp.get_channel().settimeout(PUT_TIMEOUT)
    return sftp


def run(cmd, timeout=900):
    """Run a shell command as root. Returns (exit code, output).

    stdout and stderr come back as one stream, in order. Reading them as two
    separate pipes can hang: a chatty command (apt, certbot) fills the one
    you are not reading and waits forever.
    """
    chan = client().get_transport().open_session(timeout=30)
    chan.set_combine_stderr(True)
    chan.settimeout(timeout)
    chan.exec_command(cmd)
    chunks = []
    while True:
        data = chan.recv(65536)
        if not data:
            break
        chunks.append(data)
    code = chan.recv_exit_status()
    chan.close()
    return code, b''.join(chunks).decode('utf-8', 'replace').strip()


def put(local, remote):
    """Copy one file up, overwriting whatever is there."""
    sftp = client().open_sftp()
    try:
        sftp.put(local, remote)
    finally:
        sftp.close()


SKIP_DIRS = {'.git', '__pycache__', 'node_modules', '.vscode'}
SKIP_ENDINGS = ('.sqlite', '.sqlite-wal', '.sqlite-shm', '.lock', '.bak', '.backup')
SKIP_FILES = {'Thumbs.db', '.DS_Store'}


def put_tree(local_dir, remote_dir):
    """Upload a whole folder. Returns the number of files sent.

    Never deletes anything on the server. Never uploads a database, a WAL file
    or a lock file, so a deploy cannot overwrite live data with a test copy.
    """
    sftp = _fresh_sftp()
    sent = 0
    try:
        for root, dirs, files in os.walk(local_dir):
            dirs[:] = [d for d in dirs if d not in SKIP_DIRS]
            rel = os.path.relpath(root, local_dir)
            target = remote_dir if rel == '.' else posixpath.join(remote_dir, rel.replace(os.sep, '/'))
            try:
                sftp.stat(target)
            except IOError:
                sftp.mkdir(target)
            for name in files:
                if name in SKIP_FILES or name.endswith(SKIP_ENDINGS):
                    continue
                remote = posixpath.join(target, name)
                for attempt in range(1, PUT_TRIES + 1):
                    try:
                        sftp.put(os.path.join(root, name), remote)
                        break
                    except Exception as error:   # stalled past PUT_TIMEOUT, or the link dropped
                        try:
                            sftp.close()
                        except Exception:
                            pass
                        if attempt == PUT_TRIES:
                            raise
                        print('      %s stalled (%s) - sending it again' % (remote, error.__class__.__name__), flush=True)
                        sftp = _fresh_sftp()
                sent += 1
    finally:
        try:
            sftp.close()
        except Exception:
            pass
    return sent


if __name__ == '__main__':
    if len(sys.argv) < 2:
        sys.exit('usage: python -X utf8 vps.py "command"')
    code, out = run(' '.join(sys.argv[1:]))
    print(out)
    sys.exit(code)

"""Run a Java program as if in a terminal, and save what the screen got.

    python jscreen.py Prog.java keys.json out-prefix

The program is compiled with the course's flags and run with stdin and
stdout as pipes. keys.json is a list of steps: a string is typed (echoed
into the saved output, followed by CR LF, as a terminal in line mode does)
once the program has been quiet for QUIET seconds; "@@SNAP:name" saves
everything so far as out-prefix-name.ans. At the end the whole output is
saved as out-prefix.ans. A Java program never asks the terminal anything
(Crt's ESC[6n), so a real pty is not needed - only the echo of typed lines.
"""
import json, os, shutil, subprocess, sys, tempfile, threading, time
# The course's javac and java flags (lib/compile.php). JDK is the local JDK 21.
JDK = r'D:\xampp\jdk-21\bin'
JAVAC = [os.path.join(JDK, 'javac.exe'), '-encoding', 'UTF-8']
JAVA = [os.path.join(JDK, 'java.exe'), '-Dfile.encoding=UTF-8', '-Dstdout.encoding=UTF-8', '-Dstderr.encoding=UTF-8',
        '-Duser.language=en', '-Duser.country=', '-cp', '.']

QUIET = 0.6


def main():
    source, keys_file, prefix = sys.argv[1], sys.argv[2], sys.argv[3]
    steps = json.load(open(keys_file, encoding='utf-8')) if keys_file != '-' else []
    folder = tempfile.mkdtemp(prefix='jscreen-')
    try:
        name = os.path.basename(source)
        shutil.copy(source, os.path.join(folder, name))
        compiled = subprocess.run(JAVAC + [name], cwd=folder, capture_output=True, text=True)
        if compiled.returncode != 0:
            print(compiled.stdout + compiled.stderr)
            sys.exit(1)
        program = subprocess.Popen(JAVA + [name[:-5]], cwd=folder, stdin=subprocess.PIPE, stdout=subprocess.PIPE,
                                   stderr=subprocess.STDOUT)
        captured = bytearray()
        last = [time.time()]
        lock = threading.Lock()

        def reader():
            while True:
                chunk = program.stdout.read1(4096)
                if not chunk:
                    break
                with lock:
                    captured.extend(chunk)
                    last[0] = time.time()

        thread = threading.Thread(target=reader, daemon=True)
        thread.start()

        def settle():
            time.sleep(0.2)
            while time.time() - last[0] < QUIET and program.poll() is None:
                time.sleep(0.05)
            time.sleep(0.1)

        settle()
        for step in steps:
            settle()
            if step.startswith('@@SNAP:'):
                with lock:
                    open(prefix + '-' + step[7:] + '.ans', 'wb').write(bytes(captured))
                print('snap', step[7:], len(captured))
                continue
            with lock:
                captured.extend(step.encode('utf-8') + b'\r\n')     # the terminal's echo
            program.stdin.write(step.encode('utf-8') + b'\n')
            program.stdin.flush()
            last[0] = time.time()
        settle()
        try:
            program.stdin.close()
        except OSError:
            pass
        program.wait(timeout=20)
        thread.join(timeout=5)
        open(prefix + '.ans', 'wb').write(bytes(captured))
        print('done', len(captured), 'bytes, exit', program.returncode)
    finally:
        shutil.rmtree(folder, ignore_errors=True)


main()

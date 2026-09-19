#!/usr/bin/python3
"""
Proves the live sandbox on the server: drives the supervisor exactly the way the
runner daemon will, through the launcher, and checks what comes back.

Runs ON THE SERVER (python3, stdlib only). Usage:

    python3 live-check.py <launcher command...>

where the launcher is whatever starts a session and speaks the frame protocol on
stdin/stdout - e.g. `sudo -n /usr/local/bin/itcoder-live-sandbox.sh run pascal RUNID`
(the id is appended for you as the last argument, freshly random each case).

See AIResources/live-console-design.md and bin/live/supervisor.py for the
protocol. Exit status is 0 only if every gating check passed.
"""

import os
import re
import subprocess
import sys
import time

LAUNCHER = sys.argv[1:]


class Session:
    def __init__(self, files, main, extra_env=None):
        run_id = os.urandom(8).hex()
        command = LAUNCHER + [run_id]
        self.run_id = run_id
        self.proc = subprocess.Popen(command, stdin=subprocess.PIPE, stdout=subprocess.PIPE,
                                     stderr=subprocess.PIPE)
        self.buffer = b""
        self.output = b""          # everything the program printed
        self.compile_rc = None
        self.compile_out = b""
        self.reason = None
        self.exit_code = None
        self.running = False

        for name, body in files.items():
            self.send("F", name, body)
        self.send("M", main)
        self.send("G", "-")

    def send(self, tag, arg, body=b""):
        if isinstance(body, str):
            body = body.encode()
        try:
            self.proc.stdin.write(("%s %s %d\n" % (tag, arg, len(body))).encode() + body)
            self.proc.stdin.flush()
        except BrokenPipeError:
            pass

    def keys(self, text):
        self.send("K", "-", text)

    def pump(self, seconds, until=None):
        """Read frames for up to `seconds`, or until `until(self)` is true."""
        import select
        end = time.time() + seconds
        while time.time() < end and self.reason is None:
            if until and until(self):
                return
            ready, _, _ = select.select([self.proc.stdout], [], [], 0.1)
            if ready:
                chunk = os.read(self.proc.stdout.fileno(), 65536)
                if chunk == b"":
                    break
                self.buffer += chunk
                self.parse()

    def parse(self):
        while True:
            newline = self.buffer.find(b"\n")
            if newline < 0:
                return
            tag, arg, length = self.buffer[:newline].decode().split(" ")
            length = int(length)
            if len(self.buffer) < newline + 1 + length:
                return
            body = self.buffer[newline + 1:newline + 1 + length]
            self.buffer = self.buffer[newline + 1 + length:]
            if tag == "C":
                self.compile_rc, self.compile_out = int(arg), body
            elif tag == "R":
                self.running = True
            elif tag == "O":
                self.output += body
            elif tag == "E":
                self.reason, self.exit_code = arg, int(body or b"0")

    def text(self):
        return self.output.decode("utf-8", "replace")

    def finish(self, seconds=10):
        self.pump(seconds)
        try:
            self.proc.stdin.close()
        except Exception:
            pass
        try:
            self.proc.wait(timeout=5)
        except subprocess.TimeoutExpired:
            self.proc.kill()


RESULTS = []


def check(name, condition, detail="", gating=True):
    RESULTS.append((name, bool(condition), gating))
    print(("PASS " if condition else ("FAIL " if gating else "note ")) + name +
          ("" if condition or not detail else "   -> " + detail[:300].replace("\n", "\\n")))


def pas(body):
    return {"main.pas": body}


# ---------------------------------------------------------------------------

def t_hello():
    s = Session(pas("Program Hello;\nBegin\n  Writeln ('hello live');\nEnd.\n"), "main.pas")
    s.finish()
    check("hello: compiles", s.compile_rc == 0, s.compile_out.decode())
    check("hello: prints and exits 0", "hello live" in s.text() and s.reason == "exit" and s.exit_code == 0,
          "%s %s %r" % (s.reason, s.exit_code, s.text()))


def t_compile_error():
    s = Session(pas("Program Bad;\nBegin\n  Writeln ('x')\n  Writeln ('y');\nEnd.\n"), "main.pas")
    s.finish()
    check("compile error: reported, nothing ran", s.compile_rc not in (None, 0) and s.reason == "nocompile"
          and not s.running and "main.pas(" in s.compile_out.decode(), s.compile_out.decode())


def t_readln():
    src = ("Program Ask;\nVar playerName : String;\nBegin\n  Write ('Name? ');\n  Readln (playerName);\n"
           "  Writeln ('Hello, ', playerName, '!');\nEnd.\n")
    s = Session(pas(src), "main.pas")
    s.pump(8, lambda x: "Name?" in x.text())
    check("readln: prompt appears BEFORE any input is given", "Name?" in s.text() and s.reason is None, s.text())
    s.keys("Thabo\n")
    s.finish()
    check("readln: live input is read", "Hello, Thabo!" in s.text() and s.reason == "exit", s.text())


def t_readkey():
    src = ("Program Key;\nUses Crt;\nVar pressed : Char;\nBegin\n  Writeln ('press');\n  pressed := ReadKey;\n"
           "  Writeln ('got ', pressed);\nEnd.\n")
    s = Session(pas(src), "main.pas")
    s.pump(8, lambda x: "press" in x.text())
    s.keys("q")
    s.finish()
    check("ReadKey: a single live keystroke is seen", "got q" in s.text() and s.reason == "exit", s.text())


def t_crt_colour():
    src = ("Program Colour;\nUses Crt;\nBegin\n  ClrScr;\n  TextColor (Yellow);\n  GotoXY (5, 3);\n"
           "  Writeln ('hi');\nEnd.\n")
    s = Session(pas(src), "main.pas")
    s.finish()
    check("Crt: emits real escape sequences", b"\x1b[" in s.output, repr(s.output[:80]))


def t_two_files():
    files = {
        "shapes.pas": "Unit Shapes;\nInterface\nFunction Double (n : Integer) : Integer;\nImplementation\n"
                      "Function Double (n : Integer) : Integer;\nBegin\n  Double := n * 2;\nEnd;\nEnd.\n",
        "main.pas": "Program UseUnit;\nUses Shapes;\nBegin\n  Writeln ('twice: ', Double (21));\nEnd.\n",
    }
    s = Session(files, "main.pas")
    s.finish()
    check("two files: main program uses the pupil's own unit", "twice: 42" in s.text(), s.compile_out.decode() + s.text())


def t_read_file():
    files = {
        "data.txt": "alpha\nbeta\n",
        "main.pas": "Program ReadIt;\nVar dataFile : Text; line : String;\nBegin\n  Assign (dataFile, 'data.txt');\n"
                    "  Reset (dataFile);\n  While Not Eof (dataFile) Do\n  Begin\n    Readln (dataFile, line);\n"
                    "    Writeln ('got:', line);\n  End;\n  Close (dataFile);\nEnd.\n",
    }
    s = Session(files, "main.pas")
    s.finish()
    check("data file: a supplied text file can be read", "got:alpha" in s.text() and "got:beta" in s.text(), s.text())


def t_write_file():
    src = ("Program WriteIt;\nVar outFile : Text; line : String;\nBegin\n  Assign (outFile, 'out.txt');\n"
           "  Rewrite (outFile);\n  Writeln (outFile, 'saved');\n  Close (outFile);\n  Assign (outFile, 'out.txt');\n"
           "  Reset (outFile);\n  Readln (outFile, line);\n  Writeln ('read back:', line);\n  Close (outFile);\nEnd.\n")
    s = Session(pas(src), "main.pas")
    s.finish()
    check("write file: a program can write a text file and read it back", "read back:saved" in s.text(), s.text())


def t_now_random_delay():
    src = ("Program Timing;\nUses SysUtils, Crt;\nVar started : TDateTime;\nBegin\n  Randomize;\n  started := Now;\n"
           "  Delay (300);\n  Writeln ('elapsed ok:', (Now - started) * 86400 >= 0.25);\n  Writeln ('rnd ', Random (10));\nEnd.\n")
    s = Session(pas(src), "main.pas")
    s.finish()
    check("Now, Random and Delay work in a live run", "elapsed ok:TRUE" in s.text() and "rnd " in s.text(), s.text())


def t_stop():
    src = "Program Spin;\nVar n : Integer;\nBegin\n  n := 0;\n  While True Do n := n + 1;\nEnd.\n"
    s = Session(pas(src), "main.pas")
    s.pump(6, lambda x: x.running)
    check("stop: the loop is running", s.running)
    started = time.time()
    s.send("X", "-")
    s.finish(8)
    check("stop: X ends it promptly", s.reason == "killed" and time.time() - started < 5, "%s" % s.reason)


def t_output_flood():
    src = "Program Flood;\nBegin\n  While True Do Writeln ('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');\nEnd.\n"
    s = Session(pas(src), "main.pas")
    s.finish(20)
    check("flood: endless output is cut off", s.reason == "output" and len(s.output) < 1_300_000,
          "%s %d" % (s.reason, len(s.output)))


def t_isolation():
    # IOResult must be read into a variable BEFORE any Writeln: with a pending
    # I/O error, the Writeln itself raises "Runtime error" before the argument
    # is evaluated. (The first version of this test tripped over exactly that.)
    src = ("Program Peek;\nVar f : Text; configCode, lessonCode : Integer;\nBegin\n"
           "  Assign (f, '/var/www/itcoder/config/config.php');\n  {$I-}\n  Reset (f);\n  configCode := IOResult;\n  {$I+}\n"
           "  Assign (f, '/var/www/itcoder/content/pascal/lesson02.php');\n  {$I-}\n  Reset (f);\n  lessonCode := IOResult;\n  {$I+}\n"
           "  Writeln ('config:', configCode);\n  Writeln ('lesson:', lessonCode);\nEnd.\n")
    s = Session(pas(src), "main.pas")
    s.finish()
    codes = re.findall(r"(?:config|lesson):(\d+)", s.text())
    check("isolation: config.php and lesson files are unreadable", len(codes) == 2 and all(c != "0" for c in codes), s.text())


def t_disk_cap():
    src = ("Program Fill;\nVar f : Text; i : Integer;\nBegin\n  Assign (f, 'big.txt');\n  Rewrite (f);\n"
           "  For i := 1 To 100000 Do Writeln (f, 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');\n"
           "  Close (f);\n  Writeln ('finished');\nEnd.\n")
    s = Session(pas(src), "main.pas")
    s.finish(20)
    check("disk: a runaway file write is stopped", "finished" not in s.text(), s.text() + " code=%s" % s.exit_code)


def t_bad_names():
    s = Session({"../evil.pas": "x", "main.pas": "Begin End."}, "main.pas")
    s.finish()
    check("names: a path in a file name is refused", s.reason == "nocompile" and s.compile_rc is None, "%s" % s.reason)
    s = Session({"Main.PAS": "Begin End."}, "Main.PAS")
    s.finish()
    check("names: upper-case names are refused", s.reason == "nocompile" and s.compile_rc is None, "%s" % s.reason)


def t_daemon_vanishes():
    src = "Program Wait;\nVar x : String;\nBegin\n  Readln (x);\nEnd.\n"
    s = Session(pas(src), "main.pas")
    s.pump(6, lambda x: x.running)
    s.proc.stdin.close()
    s.pump(8)
    code = s.proc.poll()
    check("daemon gone: the session ends by itself", s.reason == "killed" or code is not None, "%s %s" % (s.reason, code))


def t_unit_is_gone():
    # A unit that has just finished takes a moment to disappear, and checking
    # the instant the last test ends caught one mid-teardown. Give it a few
    # seconds: a genuinely stuck unit is still there after that.
    out = ""
    for _ in range(10):
        out = subprocess.run(["systemctl", "list-units", "--all", "--no-legend", "itcoder-live-*"],
                             capture_output=True, text=True).stdout.strip()
        if out == "":
            break
        time.sleep(1)
    check("cleanup: no live units left behind", out == "", out)


ALL = [t_hello, t_compile_error, t_readln, t_readkey, t_crt_colour, t_two_files, t_read_file, t_write_file,
       t_now_random_delay, t_stop, t_output_flood, t_isolation, t_disk_cap, t_bad_names, t_daemon_vanishes,
       t_unit_is_gone]

if __name__ == "__main__":
    only = os.environ.get("ONLY")
    for test in ALL:
        if only and only not in test.__name__:
            continue
        try:
            test()
        except Exception as error:                        # a broken test is a failure, not a crash
            check(test.__name__ + " raised", False, repr(error))
    failed = [name for name, ok, gating in RESULTS if not ok and gating]
    print("\n%d checks, %d failed" % (len(RESULTS), len(failed)))
    sys.exit(1 if failed else 0)

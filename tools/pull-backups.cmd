@echo off
rem Wrapper for the scheduled task "itcoder backup pull". Point Task Scheduler
rem at this file, not at python directly.
rem
rem Two things this exists to solve, both learned the hard way:
rem
rem 1. Task Scheduler gives the process no console and swallows stderr, so a
rem    crash before the script's own logging begins leaves no trace at all - the
rem    task simply reports exit 1 in silence. Everything is redirected to a file
rem    here, which is the only reason the problem below could be found.
rem
rem 2. The task could not import paramiko even with PYTHONPATH pointing at the
rem    per-user site-packages that plainly contained it. Rather than keep
rem    chasing why, the tool runs from its own venv, which depends on nothing in
rem    the environment. The venv lives OUTSIDE Dropbox on purpose - it is 32 MB
rem    across 1443 files and there is no reason to sync that.
rem
rem    If the venv is ever missing, rebuild it:
rem        py -m venv D:\xampp\itcoder-tools-venv
rem        D:\xampp\itcoder-tools-venv\Scripts\python.exe -m pip install paramiko

rem The tool lives in AIResources, the shared home for everything the itcoder
rem chats use. The backups it writes do NOT - they are pupils' personal data,
rem and AIResources is the folder most likely to be shared with someone one day.
rem If the backups folder ever moves, change DATA here and LOCAL_DIR in
rem pull-backups.py together.
set "TOOLS=D:\DB Sync\Dropbox\Projects\AIResources\tools"
set "DATA=D:\DB Sync\Dropbox\Projects\AIWebCourse\backups"
set "TASKLOG=%DATA%\task-output.log"
set "PY=D:\xampp\itcoder-tools-venv\Scripts\python.exe"

if not exist "%DATA%" mkdir "%DATA%"

if not exist "%PY%" (
    echo [%DATE% %TIME%] venv missing at %PY% - see the comments in this file >> "%TASKLOG%"
    exit /b 9
)

echo [%DATE% %TIME%] starting >> "%TASKLOG%"
"%PY%" "%TOOLS%\pull-backups.py" >> "%TASKLOG%" 2>&1
set RC=%ERRORLEVEL%
echo [%DATE% %TIME%] python exit code %RC% >> "%TASKLOG%"

exit /b %RC%

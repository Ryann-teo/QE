@echo off
REM Friendly alias: double-click this to push updates.
REM Just calls push-updates.bat. Kept separate so it stands out
REM in the folder, and so you can pin / shortcut it without
REM disturbing the canonical push-updates.bat name.

cd /d "%~dp0"
call "%~dp0push-updates.bat" %*

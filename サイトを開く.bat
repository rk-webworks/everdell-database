@echo off
setlocal

set "SITE_DIR=%~dp0"
set "SITE_URL=http://127.0.0.1:8765/index.html"
set "BUNDLED_PYTHON=%USERPROFILE%\.cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe"

if exist "%BUNDLED_PYTHON%" (
  start "Everdell Local Server" /min "%BUNDLED_PYTHON%" -m http.server 8765 --bind 127.0.0.1 --directory "%SITE_DIR%"
) else (
  where py >nul 2>nul
  if not errorlevel 1 (
    start "Everdell Local Server" /min py -3 -m http.server 8765 --bind 127.0.0.1 --directory "%SITE_DIR%"
  ) else (
    where python >nul 2>nul
    if errorlevel 1 (
      echo Python could not be found.
      echo Please open this folder with a local web server.
      pause
      exit /b 1
    )
    start "Everdell Local Server" /min python -m http.server 8765 --bind 127.0.0.1 --directory "%SITE_DIR%"
  )
)

timeout /t 1 /nobreak >nul
start "" "%SITE_URL%"

@echo off
rem Launch Catverter. Prefers the optimized release build (no console window);
rem falls back to the debug build; builds one if neither exists yet.
cd /d "%~dp0src-tauri"
if not exist "target\release\catverter.exe" if not exist "target\debug\catverter.exe" (
  echo First run - building Catverter, hang tight...
  cargo build
)
if exist "target\release\catverter.exe" (
  start "" "target\release\catverter.exe"
) else (
  start "" "target\debug\catverter.exe"
)

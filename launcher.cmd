@echo off
setlocal enabledelayedexpansion

powershell -WindowStyle Hidden -ExecutionPolicy Bypass -File "%~dp0launcher.ps1"

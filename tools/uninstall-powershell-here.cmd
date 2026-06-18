@echo off
REM ============================================================
REM  PowerShell 右键菜单一键卸载（HKCU 范围，不需管理员）
REM  对应: install-powershell-here.cmd
REM ============================================================

setlocal EnableExtensions

chcp 65001 >nul
title PowerShell 右键菜单一键卸载

echo.
echo === PowerShell 右键菜单一键卸载 ===
echo.

reg delete "HKCU\Software\Classes\Directory\Background\shell\PowerShellHere" /f >nul 2>&1
reg delete "HKCU\Software\Classes\Directory\shell\PowerShellHere" /f >nul 2>&1
reg delete "HKCU\Software\Classes\Drive\shell\PowerShellHere" /f >nul 2>&1

if exist "%USERPROFILE%\Open-PowerShell-Here.ps1" (
    del /f /q "%USERPROFILE%\Open-PowerShell-Here.ps1"
    echo 已删除脚本: %USERPROFILE%\Open-PowerShell-Here.ps1
)

taskkill /f /im explorer.exe >nul 2>&1
timeout /t 2 /nobreak >nul
start explorer.exe

echo.
echo === 完成 ===
echo 右键菜单已移除，资源管理器已重启
echo.
pause
endlocal

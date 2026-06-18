@echo off
REM ============================================================
REM  PowerShell 右键菜单一键部署（HKCU 范围，不需管理员）
REM  作者: 缘来是你
REM  说明: 1) 写 Open-PowerShell-Here.ps1 到 %USERPROFILE%
REM         2) 注册 HKCU 右键菜单（桌面/文件夹/驱动器）
REM         3) 重启资源管理器
REM  卸载: 运行 uninstall-powershell-here.cmd
REM ============================================================

setlocal EnableExtensions EnableDelayedExpansion

chcp 65001 >nul
title PowerShell 右键菜单一键部署

echo.
echo === PowerShell 右键菜单一键部署 ===
echo.

REM ---- 1. 写 Open-PowerShell-Here.ps1 ----
set "PS1=%USERPROFILE%\Open-PowerShell-Here.ps1"
echo [1/3] 写入脚本: %PS1%

> "%PS1%" (
    echo param^([string]$Path^)
    echo Set-Location -LiteralPath $Path
)

if not exist "%PS1%" (
    echo [X] 脚本写入失败
    pause
    exit /b 1
)
echo [√] 脚本已生成
echo.

REM ---- 2. 写注册表（HKCU，不需管理员） ----
echo [2/3] 注册右键菜单...

set "CMD=^"powershell -NoExit -ExecutionPolicy Bypass -File ^\"^%USERPROFILE^%\Open-PowerShell-Here.ps1\^" -Path ^\"^%1\^"^""

reg add "HKCU\Software\Classes\Directory\Background\shell\PowerShellHere" /ve /d "在此处打开 PowerShell 窗口" /f >nul
reg add "HKCU\Software\Classes\Directory\Background\shell\PowerShellHere" /v "Icon" /d "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" /f >nul
reg add "HKCU\Software\Classes\Directory\Background\shell\PowerShellHere\command" /ve /d "powershell -NoExit -ExecutionPolicy Bypass -File \"%USERPROFILE%\Open-PowerShell-Here.ps1\" -Path \"%V\"" /f >nul

reg add "HKCU\Software\Classes\Directory\shell\PowerShellHere" /ve /d "在此处打开 PowerShell 窗口" /f >nul
reg add "HKCU\Software\Classes\Directory\shell\PowerShellHere" /v "Icon" /d "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" /f >nul
reg add "HKCU\Software\Classes\Directory\shell\PowerShellHere\command" /ve /d "powershell -NoExit -ExecutionPolicy Bypass -File \"%USERPROFILE%\Open-PowerShell-Here.ps1\" -Path \"%1\"" /f >nul

reg add "HKCU\Software\Classes\Drive\shell\PowerShellHere" /ve /d "在此处打开 PowerShell 窗口" /f >nul
reg add "HKCU\Software\Classes\Drive\shell\PowerShellHere" /v "Icon" /d "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" /f >nul
reg add "HKCU\Software\Classes\Drive\shell\PowerShellHere\command" /ve /d "powershell -NoExit -ExecutionPolicy Bypass -File \"%USERPROFILE%\Open-PowerShell-Here.ps1\" -Path \"%1\"" /f >nul

if errorlevel 1 (
    echo [X] 注册表写入失败
    pause
    exit /b 1
)
echo [√] 注册表已写入
echo.

REM ---- 3. 重启资源管理器 ----
echo [3/3] 重启资源管理器...
taskkill /f /im explorer.exe >nul 2>&1
timeout /t 2 /nobreak >nul
start explorer.exe
echo [√] 资源管理器已重启
echo.

echo === 完成 ===
echo 验证方法: 桌面或任意文件夹空白处右键 -^> 应看到 "在此处打开 PowerShell 窗口"
echo 卸载方法: 运行 uninstall-powershell-here.cmd
echo.
pause
endlocal

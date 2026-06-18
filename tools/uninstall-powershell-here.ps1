# ============================================================
#  PowerShell 右键菜单一键卸载（v2 - 修复版）
#  作者: 缘来是你
#  说明: 调用 - 任意位置执行:  & "D:\SOLO work\writer_p\tools\uninstall-powershell-here.ps1"
# ============================================================

$keys = @(
    'HKCU\Software\Classes\Directory\Background\shell\PowerShellHere',
    'HKCU\Software\Classes\Directory\shell\PowerShellHere',
    'HKCU\Software\Classes\Drive\shell\PowerShellHere'
)

Write-Host "[1/3] 删除注册表..." -ForegroundColor Green
foreach ($key in $keys) {
    & reg.exe delete $key /f 2>$null | Out-Null
}

Write-Host "[2/3] 删除脚本..." -ForegroundColor Green
$ps1Path = Join-Path $env:USERPROFILE "Open-PowerShell-Here.ps1"
if (Test-Path $ps1Path) {
    Remove-Item $ps1Path -Force
    Write-Host "    已删除: $ps1Path" -ForegroundColor DarkGray
}

Write-Host "[3/3] 重启资源管理器..." -ForegroundColor Green
$explorer = Get-Process explorer -ErrorAction SilentlyContinue
if ($explorer) {
    Stop-Process -Name explorer -Force
    Start-Sleep -Seconds 2
}
Start-Process explorer

Write-Host ""
Write-Host "=== 完成 ===" -ForegroundColor Green
Write-Host ""

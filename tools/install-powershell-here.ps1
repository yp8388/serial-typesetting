# ============================================================
#  PowerShell 右键菜单一键部署（v2 - 修复版）
#  作者: 缘来是你
#  说明: 调用 - 任意位置执行:  & "D:\SOLO work\writer_p\tools\install-powershell-here.ps1"
#  修复: 使用 here-string + reg.exe 直接写注册表，避开 cmd 二次转义
#  卸载: & "D:\SOLO work\writer_p\tools\uninstall-powershell-here.ps1"
# ============================================================

# 1. 写 Open-PowerShell-Here.ps1（用 here-string 写死内容）
$ps1Path = Join-Path $env:USERPROFILE "Open-PowerShell-Here.ps1"
$ps1Content = @"
param([string]`$Path)
Set-Location -LiteralPath `$Path
"@
Set-Content -Path $ps1Path -Value $ps1Content -Encoding utf8 -Force
Write-Host "[1/3] 脚本已生成: $ps1Path" -ForegroundColor Green

# 2. 注册表命令 - 用 here-string 写死，杜绝转义问题
$regCmd = 'powershell -NoExit -ExecutionPolicy Bypass -File "{0}" -Path "{1}"' -f $ps1Path, '__PLACEHOLDER__'

# 三处注册表：桌面/文件夹/驱动器
$entries = @(
    @{
        Key = 'HKCU\Software\Classes\Directory\Background\shell\PowerShellHere'
        PathVar = '%V'
    },
    @{
        Key = 'HKCU\Software\Classes\Directory\shell\PowerShellHere'
        PathVar = '%1'
    },
    @{
        Key = 'HKCU\Software\Classes\Drive\shell\PowerShellHere'
        PathVar = '%1'
    }
)

Write-Host "[2/3] 写注册表..." -ForegroundColor Green

foreach ($entry in $entries) {
    $cmd = $regCmd -replace '__PLACEHOLDER__', $entry.PathVar

    # 主菜单项
    & reg.exe add $entry.Key /ve /d "在此处打开 PowerShell 窗口" /f | Out-Null
    # 图标
    & reg.exe add $entry.Key /v "Icon" /d "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" /f | Out-Null
    # 命令
    & reg.exe add "$($entry.Key)\command" /ve /d $cmd /f | Out-Null

    Write-Host "    注册: $($entry.Key)" -ForegroundColor DarkGray
}

Write-Host "[3/3] 重启资源管理器..." -ForegroundColor Green

# 3. 重启资源管理器
$explorer = Get-Process explorer -ErrorAction SilentlyContinue
if ($explorer) {
    Stop-Process -Name explorer -Force
    Start-Sleep -Seconds 2
}
Start-Process explorer

Write-Host ""
Write-Host "=== 完成 ===" -ForegroundColor Green
Write-Host "验证: 桌面或任意文件夹空白处右键 -> 应看到 [在此处打开 PowerShell 窗口]" -ForegroundColor Green
Write-Host "卸载: 运行 uninstall-powershell-here.ps1" -ForegroundColor Green
Write-Host ""

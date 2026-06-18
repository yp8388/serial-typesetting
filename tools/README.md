# Windows 工具脚本

> 一键部署 / 卸载 PowerShell 右键菜单，PowerShell + .cmd 双版本。

## 文件清单

| 文件 | 用途 | 调用方式 |
|------|------|----------|
| `install-powershell-here.cmd` | 一键部署（双击运行） | 资源管理器双击 |
| `uninstall-powershell-here.cmd` | 一键卸载（双击运行） | 资源管理器双击 |
| `install-powershell-here.ps1` | 一键部署（PowerShell 调用） | `& "D:\SOLO work\writer_p\tools\install-powershell-here.ps1"` |
| `uninstall-powershell-here.ps1` | 一键卸载（PowerShell 调用） | `& "D:\SOLO work\writer_p\tools\uninstall-powershell-here.ps1"` |

## 功能

部署后在以下位置右键会出现 `在此处打开 PowerShell 窗口`：

- 桌面 / 文件夹空白处
- 任意文件夹
- 任意驱动器（C:、D: 等）

注册表范围：`HKCU`（`HKEY_CURRENT_USER`），**不需要管理员权限**。

## 工作原理

1. **写 ps1 脚本**：在 `%USERPROFILE%\Open-PowerShell-Here.ps1` 创建一个 2 行的 PowerShell 脚本，接收路径参数并 `Set-Location`。
2. **注册右键菜单**：通过 `reg add` 在 `HKCU\Software\Classes` 下注册三类位置的右键菜单项，命令调用上面的 ps1 脚本。
3. **重启资源管理器**：让注册表变更立即生效。

## 为什么用 .ps1 调用 .cmd

PowerShell 直接调用 `reg add` 时，`\"` 会被二次转义导致注册表命令损坏。`.ps1` 内部生成临时 .cmd 文件并通过 `cmd.exe` 执行，**完全避开引号转义陷阱**。

## 卸载

```cmd
:: 双击
D:\SOLO work\writer_p\tools\uninstall-powershell-here.cmd

:: 或 PowerShell
& "D:\SOLO work\writer_p\tools\uninstall-powershell-here.ps1"
```

卸载会同时删除注册表项和 `Open-PowerShell-Here.ps1` 脚本。

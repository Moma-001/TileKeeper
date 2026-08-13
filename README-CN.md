# Start Menu Backup & Restore（中文）

Windows 10 开始菜单磁贴布局备份与恢复工具。仅依赖系统自带组件，无需安装任何第三方软件。

## 为什么需要？

Windows 10 开始菜单磁贴布局非常脆弱：磁贴经常丢失、图标消失、系统更新或个人资料重置后自定义布局会损坏。本工具可以保存你的开始菜单布局，随时恢复。

## 文件说明

| 文件 | 说明 |
|------|------|
| `Backup Start Menu.bat` | 备份开始菜单布局和注册表 |
| `Restore Start Menu.bat` | 恢复开始菜单布局和注册表 |

## 使用方法

### 备份

1. 双击运行 `Backup Start Menu.bat`
2. 脚本会自动请求管理员权限（UAC）
3. 等待运行结束，生成的三个文件位于脚本同目录：
   - `StartMenuBackup.xml` —— 当前布局（下次备份会被覆盖）
   - `StartMenuBackup_YYYYMMDD_HHmmss.xml` —— 历史快照
   - `CloudStore_Backup_YYYYMMDD_HHmmss.reg` —— 注册表备份

### 恢复

1. 双击运行 `Restore Start Menu.bat`
2. 脚本会自动请求管理员权限（UAC）
3. 脚本会**先将当前注册表备份到 `CloudStore_Backup.reg`**，然后应用布局并重启资源管理器
4. 恢复完成后会自动重启 Explorer

### 回滚

如果恢复后布局异常，双击运行脚本目录下的 `CloudStore_Backup.reg` 即可还原恢复前的状态。

## 注意事项

- 必须以管理员权限运行（脚本会自动请求 UAC）
- 恢复时会重启资源管理器（explorer.exe），所有正在使用的资源管理器窗口会关闭
- 把脚本放到任意目录都能正常使用，输出文件位于脚本同目录
- 不建议将 `StartMenuBackup.xml` 等输出文件提交到 Git 仓库

## License

MIT

# Start Menu Backup & Restore (English)

A lightweight tool to back up and restore the Windows 10 Start Menu tile layout. No third-party dependencies — only built-in `cmd`, `PowerShell`, and `reg` commands.

## Why?

The Windows 10 Start Menu tile layout is fragile: tiles get lost, icons disappear, and customizations can break after Windows updates or profile resets. This tool preserves your Start Menu layout so you can restore it anytime.

## Files

| File | Description |
|------|-------------|
| `Backup Start Menu.bat` | Back up Start Menu layout + registry |
| `Restore Start Menu.bat` | Restore Start Menu layout + registry |

## Usage

### Backup

1. Double-click `Backup Start Menu.bat`
2. The script auto-requests administrator privileges (UAC)
3. Wait for completion. Three files are generated in the script's folder:
   - `StartMenuBackup.xml` — current layout (overwritten on next backup)
   - `StartMenuBackup_YYYYMMDD_HHmmss.xml` — historical snapshot
   - `CloudStore_Backup_YYYYMMDD_HHmmss.reg` — registry backup

### Restore

1. Double-click `Restore Start Menu.bat`
2. The script auto-requests administrator privileges (UAC)
3. The script **first backs up the current registry to `CloudStore_Backup.reg`**, then applies the layout and restarts Explorer
4. Explorer will restart automatically

### Rollback

If the layout looks wrong after restoring, double-click `CloudStore_Backup.reg` in the script's folder to restore the pre-restore state.

## Caveats

- Must run as Administrator (the script auto-requests UAC)
- Restore will restart Explorer (`explorer.exe`) — all open Explorer windows will close
- Drop the scripts into any folder; outputs are written next to the script
- Don't commit backup outputs (`StartMenuBackup.xml`, etc.) to your Git repo

## License

MIT

# TileKeeper (English)

A lightweight tool to back up and restore the Windows 10 Start Menu tile layout. No third-party dependencies — only built-in `cmd`, `PowerShell`, and `reg` commands.

## Why?

The Windows 10 Start Menu tile layout is fragile: tiles get lost, icons disappear, and customizations can break after Windows updates or profile resets. This tool preserves your Start Menu layout so you can restore it anytime.

### Tile Layout Tips!!!

- The current version only supports backup for one group,Place all tiles in **the first group**. Avoid 2 or more groups, otherwise backup data will be lost!!!
- After running the backup script, please manually verify that the number of `<start:DesktopApplicationTile />` elements in the XML file matches the actual count. Refer to `check-StartMenuBackup.xml.png` for reference.

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
   - `StartMenuBackup.xml` — current layout (overwritten on next backup; convenient for direct Restore)
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
- The project uses relative paths; it works in any directory, but the generated files will be located in the same directory as the script.

## License

Apache 2.0

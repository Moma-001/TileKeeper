@echo off
title Restore Start Menu Layout
>nul 2>&1 "%windir%\system32\cacls.exe" "%windir%\system32\config\system"
if '%errorlevel%' NEQ '0' (
    echo Requesting administrator privileges...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)
cd /d "%~dp0"
powershell -ExecutionPolicy Bypass -Command "$LayoutPath='%~dp0StartMenuBackup.xml'; if (-not (Test-Path $LayoutPath)) { Write-Host 'ERROR: Backup file not found.' -ForegroundColor Red; Read-Host 'Press Enter to exit'; exit }; $RegBackupPath='%~dp0CloudStore_Backup.reg'; Write-Host 'Backing up current registry to' $RegBackupPath -ForegroundColor Yellow; reg export 'HKCU\Software\Microsoft\Windows\CurrentVersion\CloudStore\Store\Cache\DefaultAccount' $RegBackupPath /y; Write-Host 'Importing layout...' -ForegroundColor Yellow; Import-StartLayout -LayoutPath $LayoutPath -MountPath 'C:\'; Write-Host 'Clearing current user cache...' -ForegroundColor Yellow; Remove-Item -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\CloudStore\Store\Cache\DefaultAccount' -Recurse -Force; Write-Host 'Restarting Explorer...' -ForegroundColor Yellow; taskkill /im explorer.exe /f; Start-Process explorer.exe; Write-Host 'Restore completed.' -ForegroundColor Green; Write-Host 'To rollback, import registry backup in the directory.' -ForegroundColor Gray;"
echo.
echo Restore completed. Press any key to exit...
pause >nul
exit /b
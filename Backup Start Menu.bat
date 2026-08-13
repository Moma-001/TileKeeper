@echo off
title Start Menu Layout - Backup Tool (Enhanced)
>nul 2>&1 "%windir%\system32\cacls.exe" "%windir%\system32\config\system"
if '%errorlevel%' NEQ '0' (
    echo Requesting administrator privileges...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)
cd /d "%~dp0"

echo Refreshing Start Menu cache...
taskkill /im StartMenuExperienceHost.exe /f >nul 2>&1
timeout /t 2 /nobreak >nul

echo Exporting layout...
powershell -ExecutionPolicy Bypass -Command "$TargetDir='%~dp0'; if (-not (Test-Path $TargetDir)) { New-Item -ItemType Directory -Path $TargetDir -Force | Out-Null }; $FixedFile=Join-Path $TargetDir 'StartMenuBackup.xml'; $Timestamp=Get-Date -Format 'yyyyMMdd_HHmmss'; $TimestampFile=Join-Path $TargetDir "StartMenuBackup_$Timestamp.xml"; Export-StartLayout -Path $TimestampFile; Copy-Item -Path $TimestampFile -Destination $FixedFile -Force; Write-Host 'Fixed backup:' $FixedFile -ForegroundColor Green; Write-Host 'Timestamped backup:' $TimestampFile -ForegroundColor Green;"

echo Exporting Registry...
reg export "HKCU\Software\Microsoft\Windows\CurrentVersion\CloudStore\Store\Cache\DefaultAccount" "%~dp0CloudStore_Backup_%date:~0,4%%date:~5,2%%date:~8,2%_%time:~0,2%%time:~3,2%%time:~6,2%.reg" /y

echo Restarting Explorer to refresh Start Menu...
@REM taskkill /im explorer.exe /f >nul 2>&1
@REM start explorer.exe

echo.
echo ====================================
echo Backup completed successfully!
echo XML backup: %~dp0StartMenuBackup.xml
echo Registry backup: %~dp0CloudStore_Backup_*.reg
echo ====================================
pause >nul
exit /b






@echo off
echo ====================================================
echo WARNING: THIS SCRIPT WILL DELETE ALL FILES, PROGRAMS, AND USER DATA.
echo IT WILL RESET YOUR SYSTEM TO A CLEAN STATE.
echo THIS ACTION CANNOT BE UNDONE.
echo ====================================================
pause

:: Step 1: Uninstall non-essential Windows Store Apps
echo Removing all non-essential Windows Store apps...
powershell -Command "Get-AppxPackage | Remove-AppxPackage -ErrorAction SilentlyContinue"

:: Step 2: Uninstall third-party applications (non-system installed apps)
echo Removing third-party applications...
for /f "tokens=*" %%a in ('wmic product get name') do (
    set "app=%%a"
    if not "%%a"=="Name" (
        echo Uninstalling: %%a
        wmic product where "name='%%a'" call uninstall /nointeractive
    )
)

:: Step 3: Remove leftover program folders
echo Removing leftover program folders...
rd /s /q "C:\Program Files" 2>nul
rd /s /q "C:\Program Files (x86)" 2>nul
rd /s /q "C:\Users\%username%\AppData\Local" 2>nul
rd /s /q "C:\Users\%username%\AppData\Roaming" 2>nul

:: Step 4: Delete all user files
echo Deleting all user files...
rd /s /q "C:\Users\%username%" 2>nul

:: Step 5: Remove OneDrive completely
echo Removing OneDrive...
taskkill /f /im OneDrive.exe 2>nul
powershell -Command "Start-Process -FilePath \"$env:SystemRoot\SysWOW64\OneDriveSetup.exe\" -ArgumentList '/uninstall' -Wait"

:: Step 6: Delete temporary files and other leftover system junk
echo Cleaning temporary files...
del /f /q /s "C:\Windows\Temp\*" 2>nul
del /f /q /s "C:\Users\%username%\AppData\Local\Temp\*" 2>nul

:: Step 7: Reset system settings (optional)
echo Resetting system settings...
reg delete "HKCU\Software\Microsoft" /f
reg delete "HKLM\Software\Microsoft" /f

:: Step 8: Restart to ensure a clean slate
echo Restarting the computer...
shutdown /r /t 0

echo ====================================================
echo ALL APPS, USER FILES, AND SETTINGS HAVE BEEN REMOVED.
echo ====================================================
pause
exit

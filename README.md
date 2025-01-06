# refresh
Batch file to refresh windows to a near clean slate
will need to use a powershell to install a browser and 
File Explorer as these may be affected.

There will still be programs that will act as if they are installed but not.
would need to use the following to address it

Windows:
```
Press Windows + R, type appwiz.cpl, and press Enter.
Look for the program you want to uninstall, right-click it, and select "Uninstall."
```
```
Mac:
Go to Finder > Applications.
Locate the app, right-click it, and select "Move to Trash."
```

## Be sure to RUN AS ADMINISTRATOR for it to work properly

### Tested on HP laptop running Windows 11 Pro


## Use the following commands for PowerShell installing Chrome

```
Invoke-WebRequest -Uri https://dl.google.com/chrome/install/375.126/chrome_installer.exe -OutFile "C:\Users\YourUsername\Downloads\chrome_installer.exe"
```
```
Start-Process "C:\Users\YourUsername\Downloads\chrome_installer.exe"
```
## Use the following to fix the file explorer

```
# Create the path if it doesn't exist
New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies" -Name "Explorer" -Force
```
```
# Now add the "NoFileExplorer" registry key and set its value to 0 (to enable File Explorer)
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "NoFileExplorer" -Value 0 -PropertyType DWord -Force
```

### Restart computer

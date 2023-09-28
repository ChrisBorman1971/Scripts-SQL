# ***** Read Me First *****

# 1) make sure you have PowerShell version 5 running as a minimum check by running $PSVersionTable
# 2) Make sure you run PowerShell in Administrator Mode 
# 3) Try to get a Snapshot in VMware before starting
# 4) Make sure all the Variables below are correct

# ***** End of Read Me *****


# Variables to change per server - Amended by Ned for XSW-000-SD13 on 06/05/2022

$PortNo = "12345"
$SQLServerAcc = "SWHEALTH\XSW-000-SD13_SS"
$SQLServerAccPW = "Swgfrvew56gqe6e#@#~!"
$SQLServerAGAcc = "SWHEALTH\XSW-000-SD13_AS"
$SQLServerAGAccPW = "fR2GVKHLN7FHab3bEXkY"
$SysAdminPW = "e3nxfDaCCGSFWnGpVCA2"
$PageFileInitialSize = 10240
$PageFileMaximumSize = 97280 #make it a few GB smaller than the disk size

# End of variables

#****************** Part 1 - Variables required ******************

# Set pagefile
wmic computersystem set AutomaticManagedPagefile=False
Set-WMIInstance -Class Win32_PageFileSetting -Arguments @{ Name = "P:\pagefile.sys"; InitialSize = $PageFileInitialSize; MaximumSize = $PageFileMaximumSize; }

#Check Start time of scripted install
Get-Date

# Install NuGET
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force

# Do a GPUpdate /Force
GPUpdate /Force

# Create Folder to copy files too
new-item C:\Temp -itemtype directory
cd C:\Temp
new-item C:\Temp\Scripts -itemtype directory
new-item C:\Temp\SQLPatchUpdates  -itemtype directory

# Mount the Folders for the ISOS and files required
New-PSDrive –Name "W" –PSProvider FileSystem –Root "\\csu-000-fs02.csu.xswhealth.nhs.uk\Distribution\AllSites\Software\Server Applications\Microsoft\SQL Server\Win" –Persist
New-PSDrive –Name "X" –PSProvider FileSystem –Root "\\csu-000-fs02.csu.xswhealth.nhs.uk\Distribution\AllSites\Software\Server Applications\Microsoft\SQL Server\2019" –Persist
New-PSDrive –Name "Y" –PSProvider FileSystem –Root "\\csu-000-fs02.csu.xswhealth.nhs.uk\scw\BSS\IT\Shared Area\TMA\SQL\SQL Scripts\AutomatedInstall" –Persist
New-PSDrive –Name "Z" –PSProvider FileSystem –Root "\\csu-000-fs02.csu.xswhealth.nhs.uk\scw\BSS\IT\Shared Area\TMA\SQL\SQL Scripts\New Build Scripts" –Persist


# Copy the files accross
CD C:\Temp
Copy-Item -Path "X:\SQL Server Management Studio\SSMS-*.exe" -Destination C:\Temp\
Copy-Item -Path "W:\SW_DVD9_Win_Server_STD_CORE_2019_1809.18_64Bit_English_DC_STD_MLF_X22-74330.ISO" -Destination C:\Temp\
Copy-Item -Path "X:\SQL Server ISO\SW_DVD9_NTRL_SQL_Svr_Ent_Core_2019Dec2019_64Bit_English_OEM_VL_X22-22120.iso" -Destination C:\Temp\
Copy-Item -Path "X:\SQL Patch Updates\*.*"  -Destination C:\Temp\SQLPatchUpdates
Copy-Item -Path Y:\2019\SQL2019_DBEngine_ConfigurationFile.ini -Destination C:\Temp\
Copy-Item -Path Y:\Stop_AutoRestart.reg -Destination C:\Temp\Scripts
Copy-Item -Path Z:\*.sql -Destination C:\Temp\Scripts


# Mount the ISOs
Mount-DiskImage -ImagePath "C:\Temp\SW_DVD9_NTRL_SQL_Svr_Ent_Core_2019Dec2019_64Bit_English_OEM_VL_X22-22120.iso"
Mount-DiskImage -ImagePath "C:\Temp\SW_DVD9_Win_Server_STD_CORE_2019_1809.18_64Bit_English_DC_STD_MLF_X22-74330.ISO"


# Add in .NET 3.5
Install-WindowsFeature NET-Framework-Core -Source G:\sources\sxs

#Create new directories on folders
cd E:
E:
new-item E:\SQL_System_DBs -itemtype directory

cd K:
K:
new-item K:\MSSQL -itemtype directory
cd MSSQL
new-item K:\MSSQL\Data -itemtype directory

cd L:
L:
new-item L:\MSSQL -itemtype directory
cd MSSQL
new-item L:\MSSQL\Log -itemtype directory

cd T:
T:
new-item T:\TEMPDB -itemtype directory


# Add the Local Administrators
C:
([adsi]'WinNT://./administrators,group').Add('WinNT://SWHealth/XSW-XSW-PG_SQL_Local_Admin,group'); 
([adsi]'WinNT://./administrators,group').Add('WinNT://SWHealth/XSW-SQL_Spotlight,group');  
([adsi]'WinNT://./administrators,group').Add('WinNT://SWHealth/xsw-actifio,group'); 


# Set CmMaxNumberBindRetries
$RegKey ="HKLM:\Software\Microsoft\MSDTC"
Set-ItemProperty -Path $RegKey -Name CmMaxNumberBindRetries -Value 60

#****************** Part 1 completed  ******************


#****************** Part 2 - Variables required ******************
#
#Add permissions to folders for access to the E Drive
$path = 'E:\SQL_System_DBs'
$acl = Get-Acl -Path $path
$permission = $SQLServerAcc, 'FullControl', 'ContainerInherit, ObjectInherit', 'None', 'Allow'
$rule = New-Object -TypeName System.Security.AccessControl.FileSystemAccessRule -ArgumentList $permission
$acl.SetAccessRule($rule)
$acl | Set-Acl -Path $path

$path1 = 'E:\SQL_System_DBs'
$acl1 = Get-Acl -Path $path1
$permission1 = $SQLServerAGAcc, 'FullControl', 'ContainerInherit, ObjectInherit', 'None', 'Allow'
$rule1 = New-Object -TypeName System.Security.AccessControl.FileSystemAccessRule -ArgumentList $permission1
$acl1.SetAccessRule($rule1)
$acl1 | Set-Acl -Path $path1

# Install SQL Server
F:\Setup.exe /ConfigurationFile=C:\Temp\SQL2019_DBEngine_ConfigurationFile.ini /QS /IACCEPTSQLSERVERLICENSETERMS=1 /SAPWD=$SysAdminPW /SQLSVCACCOUNT=$SQLServerAcc /SQLSVCPASSWORD=$SQLServerAccPW /AGTSVCACCOUNT=$SQLServerAGAcc /AGTSVCPASSWORD=$SQLServerAGAccPW

# GET SQL CMDLETS
Install-Module -Name SqlServer -Force
get-pssnapin -Registered

# Install SQL Server Management Studio
# Set file and folder path for SSMS installer .exe
$folderpath="c:\temp"
$filepath="$folderpath\SSMS-Setup-ENU.exe"
 
#If SSMS not present, download
if (!(Test-Path $filepath)){
write-host "Downloading SQL Server 2019 SSMS..."
$URL = "https://download.microsoft.com/download/3/1/D/31D734E0-BFE8-4C33-A9DE-2392808ADEE6/SSMS-Setup-ENU.exe"
$clnt = New-Object System.Net.WebClient
$clnt.DownloadFile($url,$filepath)
Write-Host "SSMS installer download complete" -ForegroundColor Green
 
}
else {
 
write-host "Located the SQL SSMS Installer binaries, moving on to install..."
}
 
# start the SSMS installer
write-host "Beginning SSMS 2019 install..." -nonewline
$Parms = " /Install /Quiet /Norestart /Logs log.txt"
$Prms = $Parms.Split(" ")
& "$filepath" $Prms | Out-Null
Write-Host "SSMS installation complete" -ForegroundColor Green

# Change the SQL Server Configuration Manager
$env:PSModulePath = $env:PSModulePath + ";E:\Program Files (x86)\Microsoft SQL Server\150\Tools\PowerShell\Modules"
Import-Module "sqlps"
$smo = 'Microsoft.SqlServer.Management.Smo.'
$wmi = new-object ($smo + 'Wmi.ManagedComputer').

# List the object properties, including the instance names.
# $Wmi

# Enable the TCP protocol on the default instance.
$uri = "ManagedComputer[@Name='" + (get-item env:\computername).Value + "']/ServerInstance[@Name='MSSQLSERVER']/ServerProtocol[@Name='Tcp']"
$Tcp = $wmi.GetSmoObject($uri)
$Tcp.IsEnabled = $true
$Tcp.Alter()
$Tcp

# Change the port number
$Assemblies=
"Microsoft.SqlServer.Management.Common",
"Microsoft.SqlServer.Smo",
"Microsoft.SqlServer.SqlWmiManagement "
 
Foreach ($Assembly in $Assemblies) {
    $Assembly = [Reflection.Assembly]::LoadWithPartialName($Assembly)
}

$SMO = 'Microsoft.SqlServer.Management.Smo.'
$WMIObject = New-Object ($smo + 'Wmi.ManagedComputer')

$URN = "ManagedComputer[@Name='$env:computername']/ServerInstance `
[@Name='MSSQLSERVER']/ServerProtocol[@Name='Tcp']"
$TCPProtocol = $WMIObject.GetSmoObject($URN)

$WMIObject.GetSmoObject($URN + "/ `
   IPAddress[@Name='IPAll']").IPAddressProperties[1].Value=$PortNo
$TCPProtocol.Alter()

$WMIObject.GetSmoObject($URN + "/ `
   IPAddress[@Name='IP1']").IPAddressProperties[4].Value=$PortNo
$TCPProtocol.Alter()

$WMIObject.GetSmoObject($URN + "/ `
   IPAddress[@Name='IP1']").IPAddressProperties[1].Value=$true
$TCPProtocol.Alter()

$WMIObject.GetSmoObject($URN + "/ `
   IPAddress[@Name='IP2']").IPAddressProperties[4].Value=$PortNo
$TCPProtocol.Alter()

$WMIObject.GetSmoObject($URN + "/ `
   IPAddress[@Name='IP2']").IPAddressProperties[1].Value=$true
$TCPProtocol.Alter()

#****************** Part 2 Completed ******************

#****************** Part 3 - Variables required ******************

# Start SQL Server Agent / Full Text Daemon to Automatix and start SQL Server Agent
Set-Service SQLSERVERAGENT -startuptype Automatic
Start-Service SQLSERVERAGENT
Set-Service MSSQLFDLauncher -startuptype Automatic

# Run SQL Setup Scripts
Invoke-Sqlcmd -InputFile "C:\Temp\Scripts\0 - Set the functional SQL Server Requirements.sql" | Out-File -filePath "C:\Temp\Scripts\Results - 0 - Set the functional SQL Server Requirements.txt"
Invoke-Sqlcmd -InputFile "C:\Temp\Scripts\1 - Create Database Admin Users.sql" | Out-File -filePath "C:\Temp\Scripts\Results - 1 - Create Database Admin Users.txt"
Invoke-Sqlcmd -InputFile "C:\Temp\Scripts\2 - Create SQL Server Operators.sql" | Out-File -filePath "C:\Temp\Scripts\Results - 2 - Create SQL Server Operators.txt"
Invoke-Sqlcmd -InputFile "C:\Temp\Scripts\3 - Create&Enable Database Mail - 2016 onwards.sql" | Out-File -filePath "C:\Temp\Scripts\Results - 3 - Create&Enable Database Mail.txt"
Invoke-Sqlcmd -InputFile "C:\Temp\Scripts\5 - Set the MAXDOP Correctly.sql" | Out-File -filePath "C:\Temp\Scripts\Results - 5 - Set the MAXDOP Correctly.txt"
Invoke-Sqlcmd -InputFile "C:\Temp\Scripts\7 - Enable Audit level for Failed and Successful logins.sql" | Out-File -filePath "C:\Temp\Scripts\Results - 7 - Enable Audit level for Failed and Successful logins.txt"
Invoke-Sqlcmd -InputFile "C:\Temp\Scripts\8 - Rename the SA account.sql" | Out-File -filePath "C:\Temp\Scripts\Results - 8 - Rename the SA account.txt"
Invoke-Sqlcmd -InputFile "C:\Temp\Scripts\9 - Increase amount of sp_error Logs.sql" | Out-File -filePath "C:\Temp\Scripts\Results - 9 - Increase amount of sp_error Logs.txt"
Invoke-Sqlcmd -InputFile "C:\Temp\Scripts\11 - Create DBA Database.sql" | Out-File -filePath "C:\Temp\Scripts\Results - 11 - Create DBA Database.txt"
Invoke-Sqlcmd -InputFile "C:\Temp\Scripts\12 - Automated Index Defrag SP.sql" | Out-File -filePath "C:\Temp\Scripts\Results - 12 - Automated Index Defrag SP.txt"
Invoke-Sqlcmd -InputFile "C:\Temp\Scripts\14 - Database_Trigger_For_DBA TEAM.sql" | Out-File -filePath "C:\Temp\Scripts\Results - 14 - Database_Trigger_For_DBA TEAM.txt"
Invoke-Sqlcmd -InputFile "C:\Temp\Scripts\15 - Create tbl_DefragLog.sql" | Out-File -filePath "C:\Temp\Scripts\Results - 15 - Create tbl_DefragLog.txt"
Invoke-Sqlcmd -InputFile "C:\Temp\Scripts\16 - Set Up Database Maintenance & HealthCheck.sql" | Out-File -filePath "C:\Temp\Scripts\Results - 16 - Set Up Database Maintenance & HealthCheck.txt"
Invoke-Sqlcmd -InputFile "C:\Temp\Scripts\17 - Set Up Alerts Best Practice.sql" | Out-File -filePath "C:\Temp\Scripts\Results - 17 - Set Up Alerts Best Practice.txt"
Invoke-Sqlcmd -InputFile "C:\Temp\Scripts\18 - Set Up Automated Maintenance Jobs.sql" | Out-File -filePath "C:\Temp\Scripts\Results - 18 - Set Up Automated Maintenance Jobs.txt"
Invoke-Sqlcmd -InputFile "C:\Temp\Scripts\19 - Create Function fn_SQLServerBackupDir.sql" | Out-File -filePath "C:\Temp\Scripts\Results - 19 - Create Function fn_SQLServerBackupDir.txt"

#Add permissions to folders for access to the T Drive
$path3 = 'T:\TEMPDB'
$acl3 = Get-Acl -Path $path3
$permission3 = $SQLServerAcc, 'FullControl', 'ContainerInherit, ObjectInherit', 'None', 'Allow'
$rule3 = New-Object -TypeName System.Security.AccessControl.FileSystemAccessRule -ArgumentList $permission3
$acl3.SetAccessRule($rule3)
$acl3 | Set-Acl -Path $path3

$path4 = 'T:\TEMPDB'
$acl4 = Get-Acl -Path $path4
$permission4 = $SQLServerAGAcc, 'FullControl', 'ContainerInherit, ObjectInherit', 'None', 'Allow'
$rule4 = New-Object -TypeName System.Security.AccessControl.FileSystemAccessRule -ArgumentList $permission4
$acl4.SetAccessRule($rule4)
$acl4 | Set-Acl -Path $path4

Invoke-Sqlcmd -querytimeout 0 -InputFile "C:\Temp\Scripts\4 - Set the TempDB Correctly.sql" | Out-File -filePath "C:\Temp\Scripts\Results - 4 - Set the TempDB Correctly.txt"

# Move Master, MSDB and Model Database files

Invoke-Sqlcmd -querytimeout 0 -InputFile "C:\Temp\Scripts\10 - Move MSDB and Model Databases.sql"

Stop-Service MSSQLSERVER -Force

Copy-Item -Path "E:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\model.mdf" -Destination E:\SQL_System_DBs\
Copy-Item -Path "E:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\modellog.ldf" -Destination E:\SQL_System_DBs\
Copy-Item -Path "E:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\MSDBData.mdf" -Destination E:\SQL_System_DBs\
Copy-Item -Path "E:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\MSDBLog.ldf" -Destination E:\SQL_System_DBs\
Copy-Item -Path "E:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\master.mdf" -Destination E:\SQL_System_DBs\
Copy-Item -Path "E:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\mastlog.ldf" -Destination E:\SQL_System_DBs\

# Set Master Database Location

$RegKey ="HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQLServer\Parameters"
Set-ItemProperty -Path $RegKey -Name SQLArg0 -Value '-dE:\SQL_System_DBs\master.mdf'
Set-ItemProperty -Path $RegKey -Name SQLArg2 -Value '-lE:\SQL_System_DBs\mastlog.ldf'

Start-Service MSSQLSERVER
Start-Service SQLSERVERAGENT

Remove-Item –path "E:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\*" 

#****************** Part 3 Completed ******************

#****************** Restart Computer ******************


Restart-Computer 

#****************** Restart Computer ******************

#****************** Part 4 - Patching ******************

#-- Patch 1 --#
REGEDIT /S Stop_AutoRestart.REG

$cmd ='C:\Temp\SQLPatchUpdates\SQLServer2019-KB5011644-x64'
$arg1 = '/qs'
$arg2 = '/IAcceptSQLServerLicenseTerms'
$arg3 = '/Action=Patch'
$arg4 = ' /InstanceName=MSSQLSERVER'

& $cmd $arg1 $arg2 $arg3 $arg4
 

Start-Sleep 300

#-- Patch 2 --#
REGEDIT /S Stop_AutoRestart.REG
$cmd1 ='C:\Temp\SQLPatchUpdates\SQLServer2019-KB5014353-x64'
$arg5 = '/qs'
$arg6 = '/IAcceptSQLServerLicenseTerms'
$arg7 = '/Action=Patch'
$arg8 = ' /InstanceName=MSSQLSERVER'

& $cmd1 $arg5 $arg6 $arg7 $arg8


Start-Sleep 300
REGEDIT /S Stop_AutoRestart.REG

#****************** Part 4 completed  ******************

#****************** Part 5 - TIDY UP - To be completed in PowerShell

Dismount-DiskImage -ImagePath "C:\Temp\SW_DVD9_NTRL_SQL_Svr_Ent_Core_2019Dec2019_64Bit_English_OEM_VL_X22-22120.iso"
Dismount-DiskImage -ImagePath "C:\Temp\SW_DVD9_Win_Server_STD_CORE_2019_1809.18_64Bit_English_DC_STD_MLF_X22-74330.ISO"

cd \
Remove-Item C:\Temp\Scripts\*.*
Remove-Item C:\Temp\Scripts
Remove-Item C:\Temp\SQLPatchUpdates\*.* 
Remove-Item C:\Temp\SQLPatchUpdates
Remove-Item C:\Temp\*.*

Remove-PSDrive –Name X
Remove-PSDrive –Name Y
Remove-PSDrive –Name Z

Restart-Computer 

#****************** Part 5 completed  ******************

Get-Date

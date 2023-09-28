# Load WinSCP .NET assembly
Add-Type -Path "C:\Program Files (x86)\WinSCP\WinSCPnet.dll"

# Set up session options
$sessionOptions = New-Object WinSCP.SessionOptions -Property @{
    Protocol = [WinSCP.Protocol]::Sftp
    HostName = "reports.efficiencythroughchange.com"
    UserName = "scwcsu"
    Password = "gYju_wAF1`$ptOBn"
    SshHostKeyFingerprint = "ecdsa-sha2-nistp384 384 YfImBoQn6ZD4V7dOpXY4oX1glngUA+E1i6lxFIm6SPE="
}

$session = New-Object WinSCP.Session

try
{
    # Connect
    $session.Open($sessionOptions)

    # Transfer files
    $session.GetFiles("/*.Bak", "C:\Temp\*").Check()
}
finally
{
    $session.Dispose()
}

New-PSDrive –Name "X" –PSProvider FileSystem –Root "\\CSU-000-SQLBK01.csu.xswhealth.nhs.uk\SQLBackup\KC"
Copy-Item -Path "C:\TEMP\*.bak" -Destination "X:\"

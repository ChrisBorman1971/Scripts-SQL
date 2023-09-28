# Pick a Server by removing the #

#Then press F5

#$ServerName = 'BIS-000-SP01.BIS.xswhealth.nhs.uk,14431'
#$ServerName = 'BIS-000-SP02.BIS.xswhealth.nhs.uk,14431'
#$ServerName = 'BIS-000-SP03.BIS.xswhealth.nhs.uk,14431'
#$ServerName = 'BIS-000-SP04.BIS.xswhealth.nhs.uk,14431'
#$ServerName = 'BIS-000-SP05.bis.xswhealth.nhs.uk,14431'
#$ServerName = 'BIS-000-SP06.bis.xswhealth.nhs.uk,14431'
#$ServerName = 'BIS-000-SP07.bis.xswhealth.nhs.uk,14431'
#$ServerName = 'BIS-000-SP08.BIS.xswhealth.nhs.uk,14431'
#$ServerName = 'BIS-000-SP11.BIS.xswhealth.nhs.uk,14431'
#$ServerName = 'BIS-000-TFS01.BIS.xswhealth.nhs.uk,14431'
#$ServerName = 'XSW-000-SP03'
#$ServerName = 'XSW-000-SP04'
#$ServerName = 'XSW-00-ASH01'


$Username = 'BreakGlassDBA'
$Password = 'Br34k~Gl455!'

Invoke-Sqlcmd -Query 'ALTER SERVER ROLE [sysadmin] ADD MEMBER [SWHEALTH\XSW-XSW-PG-BI-BreakGlass-Developers-SysAdmin];' -ServerInstance "$ServerName" -Username $Username -Password $Password

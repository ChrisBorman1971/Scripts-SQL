
Net Use B: "\\csu-01-na02.csu.xswhealth.nhs.uk\csu_01_sqlbak\CSU-01-SVN01-SQLEXPRESS"

sqlcmd -S .\SQLEXPRESS -E -Q "EXEC dbo.sp_BackupDatabases @backupLocation='E:\Backups\', @backupType='D'"  

move E:\Backups\*.*   B:\

Net Use B: /delete
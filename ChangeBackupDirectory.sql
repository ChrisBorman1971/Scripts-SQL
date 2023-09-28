-- ChangeBackupdirectory.sql    rm     14/11/16
--
-- Change the default backup directory to the hard-coded new location 
-- for all instances on the CMS

DECLARE @NewBackupDir nVarchar(200);
SET @NewBackupDir = N'\\RPC-001-BK01\SQLBackup\' + @@SERVERNAME

EXEC master.dbo.xp_instance_regwrite N'HKEY_LOCAL_MACHINE', 
  N'Software\Microsoft\MSSQLServer\MSSQLServer', 
  N'BackupDirectory', REG_SZ, @NewBackupDir
GO


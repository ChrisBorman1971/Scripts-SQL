-- FindBackupDirectory.sql     rm    27/04/16
--
-- get the default backup directory
--
DECLARE    @BackupDirectory varchar(1000)

EXEC master.dbo.xp_instance_regread N'HKEY_LOCAL_MACHINE',
  N'Software\Microsoft\MSSQLServer\MSSQLServer',
  N'BackupDirectory',
  @BackupDirectory OUTPUT ;
SELECT @BackupDirectory

--  + '\' + DB_NAME() + '\' 
--  + REPLACE(REPLACE(REPLACE(CONVERT(CHAR(19), CURRENT_TIMESTAMP, 120), '-', '_'), ' ', '_'), ':', '')
--  + '.fbak'
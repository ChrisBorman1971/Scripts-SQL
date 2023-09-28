-- RestoreLDSD_DEVAnd_TESTFromLDSD.sql     rm    15/03/16
--
-- For Graham Morse, overwrite dev and test from last night's backup in prod
-- Corresponds to the diagram 'Updates After Go-live'
--
-- Source:	XSW-000-SP02	LDSD
--
-- Destination:	XSW-000-ST02	LDSD_DEV
--		XSW-000-ST02	LDSD_TEST
--
-- Have already copied the Full and latest Diff LDSD backups to the ST02 area
-- 
-- Disable the tranasction log backups in the GUI


/********************************************************************************/
/* LDSD_DEV                                                                     */ 
/********************************************************************************/

-- Have to close all connections before the restore 
-- and put the database in single user mode

USE [msdb];

declare @execSql varchar(1000), 
	@databaseName varchar(100)  

set @databaseName = 'LDSD_DEV'  

set @execSql = ''   
select  @execSql = @execSql + 'kill ' + convert(char(10), spid) + ' '  
from    master.dbo.sysprocesses  
where   db_name(dbid) = @databaseName  
     and  
     DBID <> 0  
     and  
     spid <> @@spid  
exec(@execSql);

-- Keep them out
ALTER DATABASE [LDSD_DEV] SET SINGLE_USER WITH NO_WAIT;

-- check that they have all gone
sp_who2;

-- Can now restore LDSD as LDSD_DEV with replace and renaming the files to *_DEV.  
-- Users etc already set up

USE [master]
RESTORE DATABASE [LDSD_DEV] 
FROM  DISK = N'\\csu-01-na01.csu.xswhealth.nhs.uk\csu_h01_sqlbak\XSW-000-ST02\LDSD_backup_2016_06_05_200001_4814378.fbak' 
WITH  FILE = 1,  
      MOVE N'LDSD_OOTB_ENG' TO N'K:\MSSQL\Data\LDSD_DEV.mdf',  
      MOVE N'LDSD_OOTB_ENG_log' TO N'L:\MSSQL\Log\LDSD_DEV_log.LDF',  
      NORECOVERY,  NOUNLOAD,  REPLACE,  STATS = 5;

RESTORE DATABASE [LDSD_DEV] 
FROM  DISK = N'\\csu-01-na01.csu.xswhealth.nhs.uk\csu_h01_sqlbak\XSW-000-ST02\LDSD_backup_2016_06_06_200001_2802407.dbak' 
WITH  FILE = 1,  NOUNLOAD,  STATS = 5;

-- Sort out the User mappings.  
-- LDSDADMIN and SWHEALTH\LANDeskSDMgmt have db_owner
-- SDReports is db_datareader

USE [LDSD_DEV];

DROP USER [LDSDADMIN];
DROP USER [SWHEALTH\LANDeskSDMgmt];
DROP USER [SDReports];

CREATE USER [LDSDADMIN] FOR LOGIN [LDSDADMIN];
ALTER USER [LDSDADMIN] WITH DEFAULT_SCHEMA=[dbo];
ALTER ROLE [db_owner] ADD MEMBER [LDSDADMIN];

CREATE USER [SWHEALTH\LANDeskSDMgmt] FOR LOGIN [SWHEALTH\LANDeskSDMgmt];
ALTER USER [SWHEALTH\LANDeskSDMgmt] WITH DEFAULT_SCHEMA=[dbo];
ALTER ROLE [db_owner] ADD MEMBER [SWHEALTH\LANDeskSDMgmt];

CREATE USER [SDReports] FOR LOGIN [SDReports];
ALTER ROLE [db_datareader] ADD MEMBER [SDReports];

-- Check access
EXECUTE AS LOGIN = 'LDSDADMIN';
SELECT 1 FROM SYS.DATABASES;
REVERT;

SELECT SUSER_NAME();

-- Backup the new database overwriting the old backup sets

BACKUP DATABASE [LDSD_DEV] 
  TO	DISK = N'\\csu-01-na01.csu.xswhealth.nhs.uk\csu_h01_sqlbak\XSW-000-ST02\LDSD_DEV_Backup_2016_03_15_1000.fbak' 
  WITH  COPY_ONLY, NOFORMAT, INIT,  
	NAME = N'LDSD_DEV-Full Database Backup', 
	SKIP, NOREWIND, NOUNLOAD, COMPRESSION,  STATS = 10;

-- Let them back in
ALTER DATABASE [LDSD_DEV] SET MULTI_USER WITH NO_WAIT;


/********************************************************************************/
/* LDSD_TEST                                                                     */ 
/********************************************************************************/

-- Have already copied the Full and latest Diff LDSD backups to the ST02 area
-- 
-- Disable the tranasction log backups in the GUI

-- Have to close all connections before the restore 
-- and put the database in single user mode

USE [msdb];

declare @execSql varchar(1000), 
	@databaseName varchar(100)  

set @databaseName = 'LDSD_TEST'  

set @execSql = ''   
select  @execSql = @execSql + 'kill ' + convert(char(10), spid) + ' '  
from    master.dbo.sysprocesses  
where   db_name(dbid) = @databaseName  
     and  
     DBID <> 0  
     and  
     spid <> @@spid  
exec(@execSql);

-- Keep them out
ALTER DATABASE [LDSD_TEST] SET SINGLE_USER WITH NO_WAIT;

-- check that they have all gone
sp_who2;

-- Before the restore takes place ensure the backup files LDSD_backup_2016_08_07_200001_1873070.fbak  
-- are copied to the destination E.G. XSW-000-ST02
--If the script restore says it completed, and you try to drop and create users but get an error saying cant drop/create users as the database is in restore mode.
-- Use the restore GUI instead as this seems to work without any issues. wh 08/08/2016  
-- Can now restore LDSD as LDSD_TEST with replace and renaming the files to *_TEST.  
-- Users etc already set up

USE [master]
RESTORE DATABASE [LDSD_TEST] 
FROM  DISK = N'\\csu-01-na01.csu.xswhealth.nhs.uk\csu_h01_sqlbak\XSW-000-ST02\LDSD_backup_2016_05_29_200001_8153757.fbak' 
WITH  FILE = 1,  
      MOVE N'LDSD_OOTB_ENG' TO N'K:\MSSQL\Data\LDSD_TEST.mdf',  
      MOVE N'LDSD_OOTB_ENG_log' TO N'L:\MSSQL\Log\LDSD_TEST_log.LDF',  
      NORECOVERY,  NOUNLOAD,  REPLACE,  STATS = 5;

RESTORE DATABASE [LDSD_TEST] 
FROM  DISK = N'\\csu-01-na01.csu.xswhealth.nhs.uk\csu_h01_sqlbak\XSW-000-ST02\LDSD_backup_2016_05_31_200001_2931565.dbak' 
WITH  FILE = 1,  NOUNLOAD,  STATS = 5;

-- Sort out the User mappings.  
-- LDSDADMIN and SWHEALTH\LANDeskSDMgmt have db_owner
-- SDReports is db_datareader

USE [LDSD_TEST];

DROP USER [LDSDADMIN];
DROP USER [SWHEALTH\LANDeskSDMgmt];
DROP USER [SDReports];

CREATE USER [LDSDADMIN] FOR LOGIN [LDSDADMIN];
ALTER USER [LDSDADMIN] WITH DEFAULT_SCHEMA=[dbo];
ALTER ROLE [db_owner] ADD MEMBER [LDSDADMIN];

CREATE USER [SWHEALTH\LANDeskSDMgmt] FOR LOGIN [SWHEALTH\LANDeskSDMgmt];
ALTER USER [SWHEALTH\LANDeskSDMgmt] WITH DEFAULT_SCHEMA=[dbo];
ALTER ROLE [db_owner] ADD MEMBER [SWHEALTH\LANDeskSDMgmt];

CREATE USER [SDReports] FOR LOGIN [SDReports];
ALTER ROLE [db_datareader] ADD MEMBER [SDReports];

-- Check access
EXECUTE AS LOGIN = 'LDSDADMIN';
SELECT 1 FROM SYS.DATABASES;
REVERT;

SELECT SUSER_NAME();

-- Backup the new database overwriting the old backup sets

BACKUP DATABASE [LDSD_TEST] 
  TO	DISK = N'\\csu-01-na01.csu.xswhealth.nhs.uk\csu_h01_sqlbak\XSW-000-ST02\LDSD_TEST_Backup_2016_03_15_1030.fbak' 
  WITH  COPY_ONLY, NOFORMAT, INIT,  
	NAME = N'LDSD_TEST-Full Database Backup', 
	SKIP, NOREWIND, NOUNLOAD, COMPRESSION,  STATS = 10;

-- Let them back in
ALTER DATABASE [LDSD_TEST] SET MULTI_USER WITH NO_WAIT;

-- Enable the tranasction log backups in the GUI

-- Job done
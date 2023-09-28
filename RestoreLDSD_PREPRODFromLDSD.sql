-- RestoreLDSD_PREPRODFromLDSD.sql     rm    18/02/16
--
-- Updated RM 26/04/16 for Refresh due on 04/05/16
--
--
-- For Graham Morse, restore the tiny new Landesk DB into pre_prod
--
-- Having first backed up the current prod and the dev database (dev on a different box)
-- as an insurance policy
--
-- The actual transfer of the databases to be done programatically in the application


-- Backup the current databases - on XSW-000-ST02, LDSD_DEV, Copy only

USE [master];

BACKUP DATABASE [LDSD_DEV] 
  TO  DISK = N'\\csu-01-na01.csu.xswhealth.nhs.uk\csu_h01_sqlbak\XSW-000-ST02\LDSD_DEV_Backup_2016_07_06_1800.fbak' 
  WITH	COPY_ONLY, NOFORMAT, NOINIT,  
  	NAME = N'LDSD_DEV-Full Database Backup', 
  	SKIP, NOREWIND, NOUNLOAD, COMPRESSION,  STATS = 10;

--
-- All the rest takes place on XSW-000-SP02
--
-- Backup the current production LDSD, copy only
--

USE [master];

BACKUP DATABASE [LDSD]
  TO  DISK = N'\\csu-01-na01.csu.xswhealth.nhs.uk\csu_h01_sqlbak\XSW-000-SP02\LDSD_Backup_2016_07_06_1800.fbak' 
  WITH	COPY_ONLY, NOFORMAT, NOINIT,  
	NAME = N'LDSD-Full Database Backup', 
	SKIP, NOREWIND, NOUNLOAD, COMPRESSION,  STATS = 10;

-- Not worried about keeping a copy of LDSD_PREPROD..
--
-- Have to close all connections before the restore 

USE [msdb];

declare @execSql varchar(1000), 
	@databaseName varchar(100)  

set @databaseName = 'LDSD_PREPROD'  

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
ALTER DATABASE [LDSD_PREPROD] SET SINGLE_USER WITH NO_WAIT;

-- check that they have all gone
sp_who2;

-- Can now restore LDSD as LDSD_PREPROD with replace.  Users etc already set up

USE [master];

RESTORE DATABASE [LDSD_PREPROD] 
  FROM  DISK = N'\\csu-01-na01.csu.xswhealth.nhs.uk\csu_h01_sqlbak\XSW-000-SP02\LDSD_Backup_2016_07_06_1800.fbak' 
  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 5;


-- Sort out the User mappings.  
-- LDSDADMIN and SWHEALTH\LANDeskSDMgmt have db_owner
-- SDReports is db_datareader

USE [LDSD_PREPROD];

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

-- Backup the new database overwriting the old backup sets

BACKUP DATABASE [LDSD_PREPROD] 
  TO	DISK = N'\\csu-01-na01.csu.xswhealth.nhs.uk\csu_h01_sqlbak\XSW-000-SP02\LDSD_PREPROD_Backup_2016_07_06_1810.fbak' 
  WITH  COPY_ONLY, NOFORMAT, INIT,  
	NAME = N'LDSD_PREPROD-Full Database Backup', 
	SKIP, NOREWIND, NOUNLOAD, COMPRESSION,  STATS = 10;

-- Not sure why LDSDADMIN lost db_owner on LDSD

USE [LDSD];

DROP USER [LDSDADMIN];

CREATE USER [LDSDADMIN] FOR LOGIN [LDSDADMIN];
ALTER USER [LDSDADMIN] WITH DEFAULT_SCHEMA=[dbo];
ALTER ROLE [db_owner] ADD MEMBER [LDSDADMIN];




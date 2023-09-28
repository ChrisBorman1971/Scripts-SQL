-- RestoreTruncateLogfileAndShrink.sql    rm     19/06/15
--
-- Was Restore_OH_Integration_17_06_2015.sql     rm    19/06/15
--
-- Restore a copy of the old school OH_Integration database onto the new production server
--
-- Source database is in full recovery mode and has large transaction log files
-- So back these up, recover the space, shrink the files down 
-- and put it in to simple recovery mode.
--
-- Check that there is enough diskspace to restore into first, obvs
-- On this one I also had to defrag the indexes once restored

-- restore

USE [master]
RESTORE DATABASE [OH_Integration_17_06_2015] 
FROM  DISK = N'E:\Phase1TDSBackup\OH_Integration_backup_2015_06_17_220003_2450077.bak' 
WITH  FILE = 1,  
MOVE N'OH_Integration' TO N'F:\SQL_CDR\MSSQL\Data\OH_Integration_17_06_2015.mdf',  
MOVE N'OH_Integration_log' TO N'F:\SQL_Logs\MSSQL\Logs\OH_Integration_17_06_2015_log.ldf',  
MOVE N'OH_Integration_2_log' TO N'F:\SQL_Logs\MSSQL\Logs\OH_Integration_17_06_2015_2_log.ldf',  
NOUNLOAD,  REPLACE,  STATS = 5

GO

-- backup the transaction logs

BACKUP LOG [OH_Integration_17_06_2015] 
TO  DISK = N'\\csu-01-na01\csu_h01_sqlbak\XSW-00-CCSQL01\OH_Integration_17_06_2015_backup_2015_06_19_090002_7767346.trn' 
WITH NOFORMAT, NOINIT,  
NAME = N'OH_Integration_17_06_2015-Transaction Log  Backup', SKIP, NOREWIND, NOUNLOAD, COMPRESSION,  STATS = 10
GO

-- truncate transaction logs

USE [OH_Integration_17_06_2015]
GO
DBCC SHRINKFILE (N'OH_Integration_log' , 0, TRUNCATEONLY)
GO

-- try to shrink them as much as possible then reset initial size

USE [OH_Integration_17_06_2015]
GO
DBCC SHRINKFILE (N'OH_Integration_2_log' , 400)
GO
USE [master]
GO
ALTER DATABASE [OH_Integration_17_06_2015] MODIFY FILE ( NAME = N'OH_Integration_log', SIZE = 3072KB )
GO

-- put the slimmed down db into simple mode 

USE [master]
GO
ALTER DATABASE [OH_Integration_17_06_2015] SET RECOVERY SIMPLE WITH NO_WAIT
GO

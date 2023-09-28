--  Get Data File information

--drop table #datafiles
CREATE TABLE #datafiles (	ServerID INT not null, 
							ServerName varchar(40) not null, 
							name varchar(40) not null, 
							filename varchar(150) not null, 
							groupid INT not null, 
							dbid INT not null, 
							type  varchar(10) not null,  
							SizeInMBs numeric(15,6)
						)

INSERT INTO #datafiles
Select	CASE (@@servername)			
			When 'CCSVR01' THEN  1
			When 'CCSVR02' THEN  2
			When 'CCSVR03' THEN  3
			When 'ZAD' THEN  4
			When 'ZIA' THEN  5
			When 'ZXIOM' THEN  6
			When 'SPECOMMHH' THEN  7
			When 'XSW-00-QMM\QMMINSTANCE' THEN  8
			When 'ZEST' THEN  9
			When 'ZNETWORK\SQLEXPRESS' THEN  10
			When 'ZONE' THEN  11
			When 'ZSQL2005' THEN  12
			When 'ZSTAR\ZSTAR' THEN  13
			When 'Z2232AP2' THEN  14
			When 'ZSPCOM' THEN  15
			When 'ZWEB' THEN  16
			When 'CSU-00-COST01\COSTMASTER' THEN  17
			When 'CSU-00-SLAM' THEN  18
			When 'DW1\ZIG' THEN  19
			When 'DW2\ZAG' THEN  20
			When 'NS-00-DATIX01\DATIX' THEN  21
			When 'XSW-00-ITSQL01' THEN  22
			When 'XSW-00-PRT01\SQLEXPRESS' THEN  23
			When 'XSW-00-QMM' THEN  24
			When 'ZAGDEV' THEN  25
			When 'ZAGTEST' THEN  26
			When 'ZIGDEV' THEN  27
			When 'ZIGTEST' THEN  28
			When 'ZRIO' THEN  29
			When 'ZSPOT' THEN  30
			When 'RPC-000-AS01\SNAPPROTECTPROXY' THEN  31
			When 'RPC01' THEN  32
			When 'RPCDEV01' THEN  33
			When 'RPCMN01' THEN  34
			When 'RPCTEST01' THEN  35
			When 'XSW-00-ASH01' THEN  36
			When 'XSW-00-ASHDEV01' THEN  37
			When 'XSW-00-ASHTEST0' THEN  38
			When 'XSW-00-CCDSQL01' THEN  39
			When 'XSW-00-CCSQL01' THEN  40
			When 'XSW-00-CCSQL02' THEN  41
			When 'XSW-00-CCSQL03' THEN  42
			When 'XSW-00-CCSQL04' THEN  43
			When 'XSW-00-CCTSQL01' THEN  44
			When 'XSW-00-SQL01' THEN  45
			When 'XSW-00-SQLDEV01' THEN  46
			When 'YEOVIL01' THEN  47
			When 'WYN-KAV\KAV_CS_ADMIN_KIT' THEN  48
			When 'WYNSQL' THEN  49
			When 'WYNSQL\FORMIC' THEN  50
			When 'WYNSQL\SHIS' THEN  51
			When 'CSU-01-SQL01' THEN  52
			When 'CSU-01-SQL02' THEN  53
			When 'CSU-01-SQL03' THEN  54
			When 'CSU-01-SQL04' THEN  55
			When 'DR-COMMSERVE\COMMVAULT' THEN  56
			When 'SADIESQL' THEN  57
			When 'SADIESQLDW' THEN  58
			When 'SADIESQLDW\DORSET' THEN  59
			When 'SADIESQLDW\GLOUS' THEN  60
			When 'SADIESQLDW\SOMERSET' THEN  61
			When 'SADIESQLDW\YDH' THEN  62
			When 'SM-01-QMM' THEN  63
			When 'SM-01-WEB01' THEN  64
			When 'SM-01-WEB01\DATIX' THEN  65
			When 'SM-01-WEB01\EASYSITE' THEN  66
			When 'SM-01-WEB01\FORMIC' THEN  67
			When 'WYN-CDTS' THEN  68
			When 'WYN-COMMSERVE\COMMVAULT' THEN  69
			When 'WYN-KAV' THEN  70
			When 'WYNRISC08' THEN  71
			When 'WYNSQL\SLAM' THEN  72
			When 'WYNSQL08' THEN  73
			When 'WYNSQL08DW\SUSDATA' THEN  74
			When 'WYNSQL08DW-DEV\SUSDATA' THEN  75
			When 'XSW-01-QMM' THEN  76
			When 'XSW-01-SQL01' THEN  77
			When 'XSW-01-WSSQL01' THEN  78
			When 'SM-01-SQL01\E65SOMERSETCCG' THEN  79
			When 'CSU-01-SVN01\SQLEXPRESS' THEN  80
			When 'SM-01-OM\SQLEXPRESSOME' THEN  81
			When 'SM-01-OM' THEN  82
			When 'BCH-00-QA' THEN  83
			When 'WYNSNOW (SNOWMAN)' THEN  84
			When 'ZDESKDATA' THEN  85
			When 'ZSD3' THEN  86
			When 'XSW-000-ST02' THEN  87
			When 'CSU-000-ST01' THEN  88
			When 'XSW-000-SP02' THEN  89
			When 'XSW-000-SP01' THEN  90
			When 'SOM-001-SP02' THEN  91
			When 'SOM-001-SP01' THEN  92
			When 'SOM-001-SD02' THEN  93
			When 'SOM-001-SP01\FORMIC' THEN  94
			When 'CSU-000-SP01' THEN  95
			When 'WYN-CDTS-DEV' THEN  96
			When 'CSU-000-SD02' THEN  97
			When 'CSU-000-SP02' THEN  98
		END as [ServerID],	
		@@SERVERNAME as ServerName,
		name as DBName,
		filename,
		groupid,
		dbid,
		case groupid when 1 then 'Data' ELSE 'Log' END AS type,
		(size*8)/(1024.) AS SizeInMBs
from	master..sysaltfiles
WHERE	groupid = 1


-- Get Lof file information

--drop table #logfiles
CREATE TABLE #logfiles (	ServerID INT not null, 
							ServerName varchar(40) not null, 
							name varchar(40) not null, 
							filename varchar(150) not null, 
							groupid INT not null, 
							dbid INT not null, 
							type  varchar(10) not null,  
							SizeInMBs numeric(15,6)
						)

INSERT INTO #logfiles
Select	CASE (@@servername)			
			When 'CCSVR01' THEN  1
			When 'CCSVR02' THEN  2
			When 'CCSVR03' THEN  3
			When 'ZAD' THEN  4
			When 'ZIA' THEN  5
			When 'ZXIOM' THEN  6
			When 'SPECOMMHH' THEN  7
			When 'XSW-00-QMM\QMMINSTANCE' THEN  8
			When 'ZEST' THEN  9
			When 'ZNETWORK\SQLEXPRESS' THEN  10
			When 'ZONE' THEN  11
			When 'ZSQL2005' THEN  12
			When 'ZSTAR\ZSTAR' THEN  13
			When 'Z2232AP2' THEN  14
			When 'ZSPCOM' THEN  15
			When 'ZWEB' THEN  16
			When 'CSU-00-COST01\COSTMASTER' THEN  17
			When 'CSU-00-SLAM' THEN  18
			When 'DW1\ZIG' THEN  19
			When 'DW2\ZAG' THEN  20
			When 'NS-00-DATIX01\DATIX' THEN  21
			When 'XSW-00-ITSQL01' THEN  22
			When 'XSW-00-PRT01\SQLEXPRESS' THEN  23
			When 'XSW-00-QMM' THEN  24
			When 'ZAGDEV' THEN  25
			When 'ZAGTEST' THEN  26
			When 'ZIGDEV' THEN  27
			When 'ZIGTEST' THEN  28
			When 'ZRIO' THEN  29
			When 'ZSPOT' THEN  30
			When 'RPC-000-AS01\SNAPPROTECTPROXY' THEN  31
			When 'RPC01' THEN  32
			When 'RPCDEV01' THEN  33
			When 'RPCMN01' THEN  34
			When 'RPCTEST01' THEN  35
			When 'XSW-00-ASH01' THEN  36
			When 'XSW-00-ASHDEV01' THEN  37
			When 'XSW-00-ASHTEST0' THEN  38
			When 'XSW-00-CCDSQL01' THEN  39
			When 'XSW-00-CCSQL01' THEN  40
			When 'XSW-00-CCSQL02' THEN  41
			When 'XSW-00-CCSQL03' THEN  42
			When 'XSW-00-CCSQL04' THEN  43
			When 'XSW-00-CCTSQL01' THEN  44
			When 'XSW-00-SQL01' THEN  45
			When 'XSW-00-SQLDEV01' THEN  46
			When 'YEOVIL01' THEN  47
			When 'WYN-KAV\KAV_CS_ADMIN_KIT' THEN  48
			When 'WYNSQL' THEN  49
			When 'WYNSQL\FORMIC' THEN  50
			When 'WYNSQL\SHIS' THEN  51
			When 'CSU-01-SQL01' THEN  52
			When 'CSU-01-SQL02' THEN  53
			When 'CSU-01-SQL03' THEN  54
			When 'CSU-01-SQL04' THEN  55
			When 'DR-COMMSERVE\COMMVAULT' THEN  56
			When 'SADIESQL' THEN  57
			When 'SADIESQLDW' THEN  58
			When 'SADIESQLDW\DORSET' THEN  59
			When 'SADIESQLDW\GLOUS' THEN  60
			When 'SADIESQLDW\SOMERSET' THEN  61
			When 'SADIESQLDW\YDH' THEN  62
			When 'SM-01-QMM' THEN  63
			When 'SM-01-WEB01' THEN  64
			When 'SM-01-WEB01\DATIX' THEN  65
			When 'SM-01-WEB01\EASYSITE' THEN  66
			When 'SM-01-WEB01\FORMIC' THEN  67
			When 'WYN-CDTS' THEN  68
			When 'WYN-COMMSERVE\COMMVAULT' THEN  69
			When 'WYN-KAV' THEN  70
			When 'WYNRISC08' THEN  71
			When 'WYNSQL\SLAM' THEN  72
			When 'WYNSQL08' THEN  73
			When 'WYNSQL08DW\SUSDATA' THEN  74
			When 'WYNSQL08DW-DEV\SUSDATA' THEN  75
			When 'XSW-01-QMM' THEN  76
			When 'XSW-01-SQL01' THEN  77
			When 'XSW-01-WSSQL01' THEN  78
			When 'SM-01-SQL01\E65SOMERSETCCG' THEN  79
			When 'CSU-01-SVN01\SQLEXPRESS' THEN  80
			When 'SM-01-OM\SQLEXPRESSOME' THEN  81
			When 'SM-01-OM' THEN  82
			When 'BCH-00-QA' THEN  83
			When 'WYNSNOW (SNOWMAN)' THEN  84
			When 'ZDESKDATA' THEN  85
			When 'ZSD3' THEN  86
			When 'XSW-000-ST02' THEN  87
			When 'CSU-000-ST01' THEN  88
			When 'XSW-000-SP02' THEN  89
			When 'XSW-000-SP01' THEN  90
			When 'SOM-001-SP02' THEN  91
			When 'SOM-001-SP01' THEN  92
			When 'SOM-001-SD02' THEN  93
			When 'SOM-001-SP01\FORMIC' THEN  94
			When 'CSU-000-SP01' THEN  95
			When 'WYN-CDTS-DEV' THEN  96
			When 'CSU-000-SD02' THEN  97
			When 'CSU-000-SP02' THEN  98
		END as [ServerID],	
		@@SERVERNAME as ServerName,
		name as DBName,
		filename,
		groupid,
		dbid,
		case groupid when 1 then 'Data' ELSE 'Log' END AS type,
		(size*8)/(1024.) AS SizeInMBs
from	master..sysaltfiles
WHERE	groupid = 0


-- Get free space


SET NOCOUNT ON;

Declare 
	@TargetDatabase sysname,
	@Level varchar(10),
	@UpdateUsage bit,
	@Unit char(2)

Select @TargetDatabase = NULL,		--  NULL: all dbs
	@Level = 'File',				--  or "Database"
	@UpdateUsage = 0,				--  default no update
	@Unit = 'GB'					--  Megabytes, Kilobytes or Gigabytes

CREATE TABLE #Tbl_CombinedInfo (
	DatabaseName sysname NULL, 
	[type] VARCHAR(10) NULL, 
	FileGroup VARCHAR(50) NULL, 
	LogicalName VARCHAR(150) NULL,
	T dec(10, 2) NULL,
	U dec(10, 2) NULL,
	[U(%)] dec(5, 2) NULL,
	F dec(10, 2) NULL,
	[F(%)] dec(5, 2) NULL,
	PhysicalName sysname NULL );

CREATE TABLE #Tbl_DbFileStats (
	Id int identity, 
	DatabaseName sysname NULL, 
	FileId int NULL, 
	FileGroupID int NULL, 
	TotalExtents bigint NULL, 
	UsedExtents bigint NULL, 
	Name sysname NULL, 
	[FileName] varchar(255) NULL );
  
CREATE TABLE #Tbl_ValidDbs (
	Id int identity, 
	Dbname sysname NULL,
	dbid int not null );
  
CREATE TABLE #Tbl_Logs (
	DatabaseName sysname NULL, 
	LogSize dec (10, 2) NULL, 
	LogSpaceUsedPercent dec (5, 2) NULL,
	Status int NULL );

DECLARE @Ver varchar(10), 
	@DatabaseName sysname, 
	@Ident_last int, 
	@String varchar(2000),
	@BaseString varchar(2000);
        
SELECT @DatabaseName = '', 
	@Ident_last = 0, 
	@String = '', 
	@Ver = CASE WHEN @@VERSION LIKE '%9.0%' THEN 'SQL 2005' 
		WHEN @@VERSION LIKE '%8.0%' THEN 'SQL 2000' 
		WHEN @@VERSION LIKE '%10.%' THEN 'SQL 2008' 
		END;

SELECT @BaseString = ' SELECT DB_NAME(), ' + 
	CASE WHEN @Ver = 'SQL 2000' THEN 'CASE WHEN a.status & 0x40 = 0x40 THEN ''Log''  ELSE ''Data'' END' 
		ELSE 'CASE type WHEN 0 THEN ''Data'' WHEN 1 THEN ''Log'' WHEN 4 THEN ''Full-text'' ELSE ''reserved'' END' 
	END 
	+ ', groupname, name, ' + 
	CASE WHEN @Ver = 'SQL 2000' THEN 'filename' 
		ELSE 'physical_name' 
	END 
	+ ', size*8.0/1024.0 FROM ' + 
	CASE WHEN @Ver = 'SQL 2000' THEN 'sysfiles a Left Join sysfilegroups b on a.groupid = b.groupid' 
		ELSE 'sys.database_files a Left Join sysfilegroups b on a.data_space_id = b.groupid' 
	END 
	+ ' WHERE ' + 
	CASE WHEN @Ver = 'SQL 2000' THEN ' HAS_DBACCESS(DB_NAME()) = 1' 
		ELSE 'state_desc = ''ONLINE''' 
	END 
	+ '';

SELECT @String = 'INSERT INTO #Tbl_ValidDbs SELECT name, dbid FROM ' + 
	CASE WHEN @Ver = 'SQL 2000' THEN 'master.dbo.sysdatabases' 
		WHEN @Ver IN ('SQL 2005', 'SQL 2008') THEN 'master.sys.databases' 
	END 
	+ ' WHERE HAS_DBACCESS(name) = 1 ORDER BY name ASC';
EXEC (@String);

INSERT INTO #Tbl_Logs EXEC ('DBCC SQLPERF (LOGSPACE) WITH NO_INFOMSGS');

BEGIN
	WHILE 1 = 1
	BEGIN
		SELECT TOP 1 @DatabaseName = Dbname 
			FROM #Tbl_ValidDbs 
			WHERE Dbname > @DatabaseName 
			ORDER BY Dbname;

		IF @@ROWCOUNT = 0
		BREAK;
		
		SELECT @Ident_last = ISNULL(MAX(Id), 0) 
			FROM #Tbl_DbFileStats;

		SELECT @String = 'INSERT INTO #Tbl_CombinedInfo (DatabaseName, type, FileGroup, LogicalName, PhysicalName, T) ' + @BaseString; 

		EXEC ('USE [' + @DatabaseName + '] ' + @String);

		INSERT INTO #Tbl_DbFileStats (FileId, FileGroupID, TotalExtents, UsedExtents, Name, FileName)
		EXEC ('USE [' + @DatabaseName + '] DBCC SHOWFILESTATS WITH NO_INFOMSGS');

		UPDATE #Tbl_DbFileStats 
			SET DatabaseName = @DatabaseName 
			WHERE Id BETWEEN @Ident_last + 1 
				AND @@IDENTITY;
	END
END

UPDATE #Tbl_CombinedInfo 
	SET U = s.UsedExtents*8*8/1024.0 
	FROM #Tbl_CombinedInfo t 
		JOIN #Tbl_DbFileStats s ON t.LogicalName = s.Name 
			AND s.DatabaseName = t.DatabaseName;

UPDATE #Tbl_CombinedInfo 
	SET [U(%)] = LogSpaceUsedPercent, 
		U = T * LogSpaceUsedPercent/100.0
	FROM #Tbl_CombinedInfo t 
		JOIN #Tbl_Logs l ON l.DatabaseName = t.DatabaseName 
	WHERE t.type = 'Log';

UPDATE #Tbl_CombinedInfo SET F = T - U, [U(%)] = U*100.0/T;

UPDATE #Tbl_CombinedInfo SET [F(%)] = F*100.0/T;

IF UPPER(ISNULL(@Level, 'DATABASE')) = 'FILE'
BEGIN
	IF @Unit = 'KB'
	UPDATE #Tbl_CombinedInfo
		SET T = T * 1024, U = U * 1024, F = F * 1024;

	IF @Unit = 'GB'
	UPDATE #Tbl_CombinedInfo
		SET T = T / 1024, U = U / 1024, F = F / 1024;

	Select	CASE (@@servername)			
			When 'CCSVR01' THEN  1
			When 'CCSVR02' THEN  2
			When 'CCSVR03' THEN  3
			When 'ZAD' THEN  4
			When 'ZIA' THEN  5
			When 'ZXIOM' THEN  6
			When 'SPECOMMHH' THEN  7
			When 'XSW-00-QMM\QMMINSTANCE' THEN  8
			When 'ZEST' THEN  9
			When 'ZNETWORK\SQLEXPRESS' THEN  10
			When 'ZONE' THEN  11
			When 'ZSQL2005' THEN  12
			When 'ZSTAR\ZSTAR' THEN  13
			When 'Z2232AP2' THEN  14
			When 'ZSPCOM' THEN  15
			When 'ZWEB' THEN  16
			When 'CSU-00-COST01\COSTMASTER' THEN  17
			When 'CSU-00-SLAM' THEN  18
			When 'DW1\ZIG' THEN  19
			When 'DW2\ZAG' THEN  20
			When 'NS-00-DATIX01\DATIX' THEN  21
			When 'XSW-00-ITSQL01' THEN  22
			When 'XSW-00-PRT01\SQLEXPRESS' THEN  23
			When 'XSW-00-QMM' THEN  24
			When 'ZAGDEV' THEN  25
			When 'ZAGTEST' THEN  26
			When 'ZIGDEV' THEN  27
			When 'ZIGTEST' THEN  28
			When 'ZRIO' THEN  29
			When 'ZSPOT' THEN  30
			When 'RPC-000-AS01\SNAPPROTECTPROXY' THEN  31
			When 'RPC01' THEN  32
			When 'RPCDEV01' THEN  33
			When 'RPCMN01' THEN  34
			When 'RPCTEST01' THEN  35
			When 'XSW-00-ASH01' THEN  36
			When 'XSW-00-ASHDEV01' THEN  37
			When 'XSW-00-ASHTEST0' THEN  38
			When 'XSW-00-CCDSQL01' THEN  39
			When 'XSW-00-CCSQL01' THEN  40
			When 'XSW-00-CCSQL02' THEN  41
			When 'XSW-00-CCSQL03' THEN  42
			When 'XSW-00-CCSQL04' THEN  43
			When 'XSW-00-CCTSQL01' THEN  44
			When 'XSW-00-SQL01' THEN  45
			When 'XSW-00-SQLDEV01' THEN  46
			When 'YEOVIL01' THEN  47
			When 'WYN-KAV\KAV_CS_ADMIN_KIT' THEN  48
			When 'WYNSQL' THEN  49
			When 'WYNSQL\FORMIC' THEN  50
			When 'WYNSQL\SHIS' THEN  51
			When 'CSU-01-SQL01' THEN  52
			When 'CSU-01-SQL02' THEN  53
			When 'CSU-01-SQL03' THEN  54
			When 'CSU-01-SQL04' THEN  55
			When 'DR-COMMSERVE\COMMVAULT' THEN  56
			When 'SADIESQL' THEN  57
			When 'SADIESQLDW' THEN  58
			When 'SADIESQLDW\DORSET' THEN  59
			When 'SADIESQLDW\GLOUS' THEN  60
			When 'SADIESQLDW\SOMERSET' THEN  61
			When 'SADIESQLDW\YDH' THEN  62
			When 'SM-01-QMM' THEN  63
			When 'SM-01-WEB01' THEN  64
			When 'SM-01-WEB01\DATIX' THEN  65
			When 'SM-01-WEB01\EASYSITE' THEN  66
			When 'SM-01-WEB01\FORMIC' THEN  67
			When 'WYN-CDTS' THEN  68
			When 'WYN-COMMSERVE\COMMVAULT' THEN  69
			When 'WYN-KAV' THEN  70
			When 'WYNRISC08' THEN  71
			When 'WYNSQL\SLAM' THEN  72
			When 'WYNSQL08' THEN  73
			When 'WYNSQL08DW\SUSDATA' THEN  74
			When 'WYNSQL08DW-DEV\SUSDATA' THEN  75
			When 'XSW-01-QMM' THEN  76
			When 'XSW-01-SQL01' THEN  77
			When 'XSW-01-WSSQL01' THEN  78
			When 'SM-01-SQL01\E65SOMERSETCCG' THEN  79
			When 'CSU-01-SVN01\SQLEXPRESS' THEN  80
			When 'SM-01-OM\SQLEXPRESSOME' THEN  81
			When 'SM-01-OM' THEN  82
			When 'BCH-00-QA' THEN  83
			When 'WYNSNOW (SNOWMAN)' THEN  84
			When 'ZDESKDATA' THEN  85
			When 'ZSD3' THEN  86
			When 'XSW-000-ST02' THEN  87
			When 'CSU-000-ST01' THEN  88
			When 'XSW-000-SP02' THEN  89
			When 'XSW-000-SP01' THEN  90
			When 'SOM-001-SP02' THEN  91
			When 'SOM-001-SP01' THEN  92
			When 'SOM-001-SD02' THEN  93
			When 'SOM-001-SP01\FORMIC' THEN  94
			When 'CSU-000-SP01' THEN  95
			When 'WYN-CDTS-DEV' THEN  96
			When 'CSU-000-SD02' THEN  97
			When 'CSU-000-SP02' THEN  98
		END as [ServerID],	
		@@SERVERNAME as ServerName, 
		Case When CAST(SERVERPROPERTY('InstanceName') as varchar(50)) is NULL 
		Then CAST(SERVERPROPERTY('MachineName')  as varchar(50))
		Else CAST(SERVERPROPERTY('InstanceName') as varchar(50))
		End as 'InstanceName',
		DatabaseName AS 'Database',
		type AS 'Type',
		FileGroup,
		LogicalName,
		T AS 'Total',
		U AS 'Used',
		[U(%)] AS 'Used (%)',
		F AS 'Free',
		[F(%)] AS 'Free (%)',
		PhysicalName
		FROM #Tbl_CombinedInfo 
		WHERE DatabaseName LIKE ISNULL(@TargetDatabase, '%') 
		ORDER BY DatabaseName, type;

END

DROP TABLE #Tbl_CombinedInfo
DROP TABLE #Tbl_DbFileStats
DROP TABLE #Tbl_ValidDbs
DROP TABLE #Tbl_Logs 




Select	d.ServerID, 
		d.ServerName, 
		d.name,
		(d.SizeInMBs + l.SizeInMBs) as DBsize
from	#datafiles d inner join #logfiles l on d.ServerID = l.ServerID and d.dbid = l.dbid

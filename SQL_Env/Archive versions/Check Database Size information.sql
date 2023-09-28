
--Get Database information

if exists (select * from tempdb.sys.all_objects where name like '%#dbsize%') 
	drop table #dbsize 

create table #dbsize 
	(
		Dbname sysname,
		dbstatus varchar(50),
		Recovery_Model varchar(40) default ('NA'), 
		file_Size_MB decimal(30,2)default (0),
		Space_Used_MB decimal(30,2)default (0),
		Free_Space_MB decimal(30,2) default (0)
	) 
go 
  
insert into #dbsize(Dbname,dbstatus,Recovery_Model,file_Size_MB,Space_Used_MB,Free_Space_MB) 
exec sp_msforeachdb 
	'use [?]; 
	select	DB_NAME() AS DbName, 
			CONVERT(varchar(20),DatabasePropertyEx(''?'',''Status'')) ,  
			CONVERT(varchar(20),DatabasePropertyEx(''?'',''Recovery'')),  
			sum(size)/128.0 AS File_Size_MB, 
			sum(CAST(FILEPROPERTY(name, ''SpaceUsed'') AS INT))/128.0 as Space_Used_MB, 
			SUM( size)/128.0 - sum(CAST(FILEPROPERTY(name,''SpaceUsed'') AS INT))/128.0 AS Free_Space_MB  
	from sys.database_files  where type=0 group by type' 
go 
  
if exists (select * from tempdb.sys.all_objects where name like '#logsize%') 
	drop table #logsize 

create table #logsize 
	(
		Dbname sysname, 
		Log_File_Size_MB decimal(38,2)default (0),
		log_Space_Used_MB decimal(30,2)default (0),
		log_Free_Space_MB decimal(30,2)default (0)
	) 
go 
  
insert into #logsize(Dbname,Log_File_Size_MB,log_Space_Used_MB,log_Free_Space_MB) 
exec sp_msforeachdb 
	'use [?]; 
	select	DB_NAME() AS DbName, 
			sum(size)/128.0 AS Log_File_Size_MB, 
			sum(CAST(FILEPROPERTY(name, ''SpaceUsed'') AS INT))/128.0 as log_Space_Used_MB, 
			SUM( size)/128.0 - sum(CAST(FILEPROPERTY(name,''SpaceUsed'') AS INT))/128.0 AS log_Free_Space_MB  
	from sys.database_files  where type=1 group by type' 
go 

if exists (select * from tempdb.sys.all_objects where name like '%#dbfreesize%') 
	drop table #dbfreesize 

create table #dbfreesize 
	(
		name sysname, 
		database_size varchar(50), 
		Freespace varchar(50)default (0.00)
	) 
  
insert into #dbfreesize(name,database_size,Freespace) 
exec sp_msforeachdb 

	'use [?];
	SELECT	database_name = db_name(), 
			database_size = ltrim(str((convert(DECIMAL(15, 2), dbsize) + convert(DECIMAL(15, 2), logsize)) * 8192 / 1048576, 15, 2) + ''MB''),
			''unallocated space'' = ltrim(str(( 
            CASE  
				WHEN	dbsize >= reservedpages 
				THEN	(convert(DECIMAL(15, 2), dbsize) - convert(DECIMAL(15, 2), reservedpages)) * 8192 / 1048576 
				ELSE 0 
			END 
            ), 15, 2) + '' MB'') 
	FROM ( 
    SELECT dbsize = sum(convert(BIGINT, 
		CASE  
           WHEN type = 0 
           THEN size 
           ELSE 0 
        END)) 
        ,logsize = sum(convert(BIGINT, 
		CASE  
			WHEN type <> 0 
			THEN size 
			ELSE 0 
		END)) 
	FROM sys.database_files 
) AS files 
,( 
    SELECT	reservedpages = sum(a.total_pages) 
			,usedpages = sum(a.used_pages) 
			,pages = sum(	CASE  
								WHEN it.internal_type IN 
								( 
									202 
									,204 
									,211 
									,212 
									,213 
									,214 
									,215 
									,216 
								) 
								THEN 0 
								WHEN a.type <> 1 
								THEN a.used_pages 
								WHEN p.index_id < 2 
								THEN a.data_pages 
								ELSE 0 
								END) 
    FROM sys.partitions p 
    INNER JOIN sys.allocation_units a ON p.partition_id = a.container_id 
    LEFT JOIN sys.internal_tables it ON p.object_id = it.object_id 
) AS partitions' 


if exists (select * from tempdb.sys.all_objects where name like '%#alldbstate%') 
	drop table #alldbstate  

create table #alldbstate  
	(
		dbname sysname, 
		DBstatus varchar(55), 
		R_model Varchar(30)
	) 
   
--select * from sys.master_files 
  
insert into #alldbstate (dbname,DBstatus,R_model) 
select name,CONVERT(varchar(20),DATABASEPROPERTYEX(name,'status')),recovery_model_desc from sys.databases 
--select * from #dbsize 
  
insert into #dbsize(Dbname,dbstatus,Recovery_Model) 
select dbname,dbstatus,R_model from #alldbstate where DBstatus <> 'online' 
  
insert into #logsize(Dbname) 
select dbname from #alldbstate where DBstatus <> 'online' 
  
insert into #dbfreesize(name) 
select dbname from #alldbstate where DBstatus <> 'online' 
  


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
			When 'XSW-00-ASHTEST0' or 'XSW-00-ASHTEST01' THEN  38
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
		dbid, 
		CONVERT(VARCHAR(25), s.name) AS dbName,
-- last backup
		ISNULL((SELECT TOP 1
		CASE TYPE WHEN 'D' THEN 'Full' WHEN 'I' THEN 'Differential' WHEN 'L' THEN 'Transaction log' END + ' – ' +
			LTRIM(ISNULL(STR(ABS(DATEDIFF(DAY, GETDATE(),Backup_finish_date))) + ' days ago', 'NEVER')) + ' – ' +
			CONVERT(VARCHAR(20), backup_start_date, 103) + ' ' + CONVERT(VARCHAR(20), backup_start_date, 108) + ' – ' +
			CONVERT(VARCHAR(20), backup_finish_date, 103) + ' ' + CONVERT(VARCHAR(20), backup_finish_date, 108) +
			' (' + CAST(DATEDIFF(second, BK.backup_start_date,
			BK.backup_finish_date) AS VARCHAR(4)) + ' '
			+ 'seconds)'
			FROM msdb..backupset BK WHERE BK.database_name = s.name ORDER BY backup_set_id DESC),'-') AS [Last backup],
		(file_size_mb + log_file_size_mb) as DBsize, 
		d.file_Size_MB,
		d.Space_Used_MB,
		d.Free_Space_MB, 
		l.Log_File_Size_MB,
		log_Space_Used_MB,
		l.log_Free_Space_MB,
		fs.Freespace as DB_Freespace 
from	sysdatabases s inner join sys.databases sd on s.name = sd.name
		inner join #dbsize d  on s.name = d.Dbname
		Inner join #logsize l on d.Dbname=l.Dbname 
		join #dbfreesize fs on d.Dbname=fs.name 
		left join sys.master_files smf on s.dbid = smf.database_id
WHERE	smf.file_id = 1
order by	s.dbid asc


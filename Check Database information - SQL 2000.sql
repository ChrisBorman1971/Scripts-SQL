-- Login information

SELECT  CASE (@@servername)			
		 When 'ZAD' THEN 1
		 When 'ZIA' THEN 2
		 When 'ZXIOM' THEN 3
		 When 'SPECOMMHH' THEN 4
		 When 'XSW-00-QMM\QMMINSTANCE' THEN 5
		 When 'ZEST' THEN 6
		 When 'ZNETWORK\SQLEXPRESS' THEN 7
		 When 'ZONE' THEN 8
		 When 'ZSQL2005' THEN 9
		 When 'ZSTAR\ZSTAR' THEN 10
		 When 'Z2232AP2' THEN 11
		 When 'ZSPCOM' THEN 12
		 When 'ZWEB' THEN 13
		 When 'CSU-00-COST01\COSTMASTER' THEN 14
		 When 'CSU-00-SLAM' THEN 15
		 When 'DW1\ZIG' THEN 16
		 When 'DW2\ZAG' THEN 17
		 When 'NS-00-DATIX01\DATIX' THEN 18
		 When 'XSW-00-ITSQL01' THEN 19
		 When 'XSW-00-PRT01\SQLEXPRESS' THEN 20
		 When 'XSW-00-QMM' THEN 21
		 When 'ZAGDEV' THEN 22
		 When 'ZAGTEST' THEN 23
		 When 'ZIGDEV' THEN 24
		 When 'ZIGTEST' THEN 25
		 When 'ZRIO' THEN 26
		 When 'ZSPOT' THEN 27
		 When 'RPC-000-AS01\SNAPPROTECTPROXY' THEN 28
		 When 'RPC01' THEN 29
		 When 'RPCDEV01' THEN 30
		 When 'RPCMN01' THEN 31
		 When 'RPCTEST01' THEN 32
		 When 'XSW-00-ASH01' THEN 33
		 When 'XSW-00-ASHDEV01' THEN 34
		 When 'XSW-00-ASHTEST0' THEN 35
		 When 'XSW-00-CCDSQL01' THEN 36
		 When 'XSW-00-CCSQL01' THEN 37
		 When 'XSW-00-CCSQL02' THEN 38
		 When 'XSW-00-CCSQL03' THEN 39
		 When 'XSW-00-CCSQL04' THEN 40
		 When 'XSW-00-CCTSQL01' THEN 41
		 When 'XSW-00-SQL01' THEN 42
		 When 'XSW-00-SQLDEV01' THEN 43
		 When 'YEOVIL01' THEN 44
		 When 'WYN-KAV\KAV_CS_ADMIN_KIT' THEN 45
		 When 'WYNSQL' THEN 46
		 When 'WYNSQL\FORMIC' THEN 47
		 When 'WYNSQL\SHIS' THEN 48
		 When 'CSU-01-SQL01' THEN 49
		 When 'CSU-01-SQL02' THEN 50
		 When 'CSU-01-SQL03' THEN 51
		 When 'CSU-01-SQL04' THEN 52
		 When 'DR-COMMSERVE\COMMVAULT' THEN 53
		 When 'SADIESQL' THEN 54
		 When 'SADIESQLDW' THEN 55
		 When 'SADIESQLDW\DORSET' THEN 56
		 When 'SADIESQLDW\GLOUS' THEN 57
		 When 'SADIESQLDW\SOMERSET' THEN 58
		 When 'SADIESQLDW\YDH' THEN 59
		 When 'SM-01-QMM' THEN 60
		 When 'SM-01-WEB01' THEN 61
		 When 'SM-01-WEB01\DATIX' THEN 62
		 When 'SM-01-WEB01\EASYSITE' THEN 63
		 When 'SM-01-WEB01\FORMIC' THEN 64
		 When 'WYN-CDTS' THEN 65
		 When 'WYN-COMMSERVE\COMMVAULT' THEN 66
		 When 'WYN-KAV' THEN 67
		 When 'WYNRISC08' THEN 68
		 When 'WYNSQL\SLAM' THEN 69
		 When 'WYNSQL08' THEN 70
		 When 'WYNSQL08DW\SUSDATA' THEN 71
		 When 'WYNSQL08DW-DEV\SUSDATA' THEN 72
		 When 'XSW-01-QMM' THEN 73
		 When 'XSW-01-SQL01' THEN 74
		 When 'XSW-01-WSSQL01' THEN 75
		 When 'SM-01-SQL01\E65SOMERSETCCG' THEN 76
		 When 'CSU-01-SVN01\SQLEXPRESS' THEN 77
		 When 'SM-01-OM\SQLEXPRESSOME' THEN 78
		 When 'SM-01-OM' THEN 79
		 When 'BCH-00-QA' THEN 80
		 When 'WYNSNOW(SNOWMAN)' THEN 81
		 When 'ZDESKDATA' THEN 82
		 When 'ZSD3' THEN 83
		 When 'XSW-000-ST02' THEN 84
		 When 'CSU-000-ST01' THEN 85
		 When 'XSW-000-SP02' THEN 86
		 When 'XSW-000-SP01' THEN 87
		 When 'SOM-001-SP02' THEN 88
		 When 'SOM-001-SP01' THEN 89
		 When 'SOM-001-SD02' THEN 90
		 When 'SOM-001-SP01\FORMIC' THEN 91
		 When 'CSU-000-SP01' THEN 92
		 When 'WYN-CDTS-DEV' THEN 93
		 When 'CSU-000-SD02' THEN 94
		 When 'CSU-000-SP02' THEN 95
		 When 'XSW-000-SD03' THEN 96
		 When 'XSW-000-SD04' THEN 97
		 When 'XSW-000-ST03' THEN 98
		 When 'XSW-000-ST04' THEN 99
		 When 'XSW-000-SP03' THEN 100
		 When 'XSW-000-SP04' THEN 101
		END as [Server_ID],	
		@@servername as ServerName,
		name AS [loginname],
		CASE 
			WHEN isntname = 1 and isntgroup = 1 THEN 'G'
			WHEN isntname = 1 and isntgroup = 0 THEN 'U'   
			ELSE 'S'   
		END as [type_desc],
		CASE 
			WHEN isntname = 1 and isntgroup = 1 THEN 'WINDOWS_GROUP'
			WHEN isntname = 1 and isntgroup = 0 THEN 'WINDOWS_LOGIN'   
			ELSE 'SQL_LOGIN'   
		END as [type_desc],
		denylogin as is_disabled,
		CONVERT(VARCHAR(10),createdate ,103) AS [created],
        CONVERT(VARCHAR(10),updatedate , 103) AS [update],
		hasaccess,
		isntname,
		isntgroup,
		isntuser,
		sysadmin,
		securityadmin,
		serveradmin,
		setupadmin,
		processadmin,
		diskadmin,
		dbcreator,
		bulkadmin
FROM	SYSLOGINS		



-- Database Information

if exists (select * from tempdb..sysobjects where name like '%#WinVer%') 
	drop table #WinVer 

Create table #WinVer  
	(
		idx Int, 
		name varchar(20), 
		internalValue bigint,
		character_Value varchar(15)
	) 


insert into #WinVer(idx,name,internalValue,character_Value) 
exec xp_msver 'WindowsVersion'

--Select left(character_Value, 3) from #WinVer
--drop table #WinVer

--Select * from sysdatabases

Select	CASE (@@servername)			
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
			When 'BCH-00-QA' THEN  83		
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
			When 'CCSVR01' THEN  1		
			When 'CCSVR02' THEN  2		
			When 'CCSVR03' THEN  3		
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
		END as [ServerID],	
		@@SERVERNAME as ServerName, 
		s.dbid, 
		SERVERPROPERTY('productversion') as Product_Version, 
		SERVERPROPERTY('productlevel') as Product_Level, 
		replace(cast(SERVERPROPERTY('Edition')as varchar),'Edition','') EditionInstalled,
		CASE (Select left(character_Value, 3) from #WinVer)
			When '10.0' THEN 'Windows Server Technical Preview'
			When '6.3' THEN 'Windows Server 2012 R2'
			When '6.2' THEN 'Windows Server 2012'
			When '6.1' THEN 'Windows Server 2008 R2'
			When '6' THEN 'Windows Server 2008'
			When '5.2' THEN 'Windows Server 2003 R2'
			When '5.2' THEN 'Windows Server 2003'
			When '5.0' THEN 'Windows 2000'
		END as [OSVersion],
		SERVERPROPERTY('Collation') Collation_Type,
		SERVERPROPERTY('IsClustered') [IsClustered?],
		CASE SERVERPROPERTY('IsIntegratedSecurityOnly')   
			WHEN 1 THEN 'Windows Authentication'   
			WHEN 0 THEN 'Windows and SQL Server Authentication'   
		END as [Authentication Mode],
		CONVERT(VARCHAR(25), s.name) AS dbName,
		CONVERT(VARCHAR(10), DATABASEPROPERTYEX(s.name, 'status')) AS [Status],
		'' as [User Access],
		'' as [Recovery Model],
		CASE cmptlevel
			WHEN 60 THEN '60 (SQL Server 6.0)'
			WHEN 65 THEN '65 (SQL Server 6.5)'
			WHEN 70 THEN '70 (SQL Server 7.0)'
			WHEN 80 THEN '80 (SQL Server 2000)'
			WHEN 90 THEN '90 (SQL Server 2005)'
			WHEN 100 THEN '100 (SQL Server 2008)'
			WHEN 110 THEN '110 (SQL Server 2012)'
		END AS [cmptlevel],
--		s.name,
--		s.dbid,
		a.fileid,
		'' as [type_desc],
		s.filename,
		CONVERT(VARCHAR(20), crdate, 103) + ' ' + CONVERT(VARCHAR(20), crdate, 108) AS [Creation date],
-- last backup
		ISNULL((SELECT TOP 1
		CASE type WHEN 'D' THEN 'Full' WHEN 'I' THEN 'Differential' WHEN 'L' THEN 'Transaction log' END + ' – ' +
			LTRIM(ISNULL(STR(ABS(DATEDIFF(DAY, GETDATE(),BK.backup_finish_date))) + ' days ago', 'NEVER')) + ' – ' +
			CONVERT(VARCHAR(20), BK.backup_start_date, 103) + ' ' + CONVERT(VARCHAR(20), BK.backup_start_date, 108) + ' – ' +
			CONVERT(VARCHAR(20), BK.backup_finish_date, 103) + ' ' + CONVERT(VARCHAR(20), BK.backup_finish_date, 108) +
			' (' + CAST(DATEDIFF(second, BK.backup_start_date,
			BK.backup_finish_date) AS VARCHAR(4)) + ' '
			+ 'seconds)'
			FROM msdb..backupset BK WHERE BK.database_name = s.name ORDER BY backup_set_id DESC),'-') AS [Last backup],
		CASE WHEN DATABASEPROPERTYEX(s.name, 'isfulltextenabled') = 1 THEN 'Fulltext enabled' ELSE '' END AS [fulltext],
		CASE WHEN DATABASEPROPERTYEX(s.name, 'isautoclose') = 1 THEN 'autoclose' ELSE '' END AS [autoclose],
		'' AS [page verify option],
		'' AS [read only],
		CASE WHEN DATABASEPROPERTYEX(s.name, 'isautoshrink') = 1 THEN 'autoshrink' ELSE '' END AS [autoshrink],
		CASE WHEN DATABASEPROPERTYEX(s.name, 'IsAutoCreateStatistics') = 1 THEN 'auto create statistics' ELSE '' END AS [auto create statistics],
		CASE WHEN DATABASEPROPERTYEX(s.name, 'IsAutoUpdateStatistics') = 1 THEN 'auto update statistics' ELSE '' END AS [auto update statistics],
		CASE WHEN DATABASEPROPERTYEX(s.name, 'isinstandby') = 1 THEN 'standby' ELSE '' END AS [standby],
		'' AS [cleanly shutdown]
from	sysdatabases s inner join sysaltfiles a on s.dbid = a.dbid


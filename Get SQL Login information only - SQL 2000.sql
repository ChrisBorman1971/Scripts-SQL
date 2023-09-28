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
		END as [type_desc1],
		CASE 
			WHEN isntname = 1 and isntgroup = 1 THEN 'WINDOWS_GROUP'
			WHEN isntname = 1 and isntgroup = 0 THEN 'WINDOWS_LOGIN'   
			ELSE 'SQL_LOGIN'   
		END as [type_desc2],
		denylogin AS [is_disabled],
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





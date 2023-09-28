SELECT	CASE (@@servername)			
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
		@@SERVERNAME as Server_Name,
		[sJOB].[job_id] AS [JobID], 
		[sJOB].[name] AS [JobName], 
		[sDBP].[name] AS [JobOwner], 
		[sCAT].[name] AS [JobCategory], 
	--	[sJOB].[description] AS [JobDescription], 
		CASE [sJOB].[enabled]
			WHEN 1 THEN 'Yes'
			WHEN 0 THEN 'No'
		END AS [IsEnabled], 
		[sJOB].[date_created] AS [JobCreatedOn], 
		[sJOB].[date_modified] AS [JobLastModifiedOn], 
		[sSVR].[name] AS [OriginatingServerName], 
		[sJSTP].[step_id] AS [JobStartStepNo], 
		[sJSTP].[step_name] AS [JobStartStepName], 
		CASE
			WHEN [sSCH].[schedule_uid] IS NULL THEN 'No'
			ELSE 'Yes'
		END AS [IsScheduled], 
		[sSCH].[schedule_uid] AS [JobScheduleID], 
		[sSCH].[name] AS [JobScheduleName], 
		CASE [sJOB].[delete_level]
			WHEN 0 THEN 'Never'
			WHEN 1 THEN 'On Success'
			WHEN 2 THEN 'On Failure'
			WHEN 3 THEN 'On Completion'
		END AS [JobDeletionCriterion]
FROM	[msdb].[dbo].[sysjobs] AS [sJOB] LEFT JOIN [msdb].[sys].[servers] AS [sSVR] ON [sJOB].[originating_server_id] = [sSVR].[server_id]
		LEFT JOIN [msdb].[dbo].[syscategories] AS [sCAT] ON [sJOB].[category_id] = [sCAT].[category_id]
		LEFT JOIN [msdb].[dbo].[sysjobsteps] AS [sJSTP] ON [sJOB].[job_id] = [sJSTP].[job_id] AND [sJOB].[start_step_id] = [sJSTP].[step_id]
		LEFT JOIN [msdb].[sys].[database_principals] AS [sDBP] ON [sJOB].[owner_sid] = [sDBP].[sid]
		LEFT JOIN [msdb].[dbo].[sysjobschedules] AS [sJOBSCH] ON [sJOB].[job_id] = [sJOBSCH].[job_id]
		LEFT JOIN [msdb].[dbo].[sysschedules] AS [sSCH] ON [sJOBSCH].[schedule_id] = [sSCH].[schedule_id]
ORDER BY	[JobName]

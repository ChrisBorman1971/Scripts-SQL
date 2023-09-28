-- RestoreOHCP_OHAUDIT&OHCP_OHPORTAL.sql   rm    26/01/16
--
-- Scripted job see RestoreReportingDatabaseFromAnotherServer.sql
-- for individual steps, sp and explanation
--
-- 
-- This can, however lead to some strange behaviour.  If there are problems with the backup
-- On XSW-00-CCSQL01, the restore job on XSW-00-CCSQL03 can throw some strange errors.
-- If a full backup of the OHCP_OHAUDIT and OHCP_OHPORTAL is taken on CCSQL01 other than on 
-- a Sunday, the job will fail as the full backup will have a later date than the diff.
-- Hilariously, the restore job does not check for this until after it has dropped the 
-- copies on CCSQL03.  In this case, the process is to run a diff on CCSQL01, then run the 
-- restore job on CCSQL03.  The last time I did this (20/11/16) I ran the individual steps of 
-- job separately.  If the restore job does not complete, the Reporting Services site on
-- Connecting Care shows no data.  This is most crucila at week and month end.

USE [msdb]
GO

/****** Object:  Job [Restore OHCP_OHAUDIT & OHCP_OHPORTAL]    Script Date: 26/01/2016 15:24:45 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 26/01/2016 15:24:45 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Restore OHCP_OHAUDIT & OHCP_OHPORTAL', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=2, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', 
		@notify_email_operator_name=N'DBA_Team', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Restore database]    Script Date: 26/01/2016 15:24:45 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Restore database', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=4, 
		@on_success_step_id=2, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'DECLARE @db_name VARCHAR(50) -- database name  
DECLARE @db_path VARCHAR(600) -- path for backup files 
DECLARE @db_datapath VARCHAR(600) -- path for backup files 
DECLARE @db_logpath VARCHAR(600) -- path for backup files 
DECLARE @db_devtype VARCHAR(10)
DECLARE @db_logicalname VARCHAR(600)
DECLARE @db_physicalname VARCHAR(600)
DECLARE @db_physicalname_diff VARCHAR(600)
DECLARE @tmpstr NVARCHAR(600)
DECLARE @tmpstr2 NVARCHAR(600)
DECLARE @tmpstr3 NVARCHAR(100)
DECLARE @server_name VARCHAR(50)
DECLARE @RestoreDB varchar(75)
DECLARE @RestoreDB_diff varchar(75)
DECLARE @date datetime
DECLARE @date_diff datetime

SET @db_path = ''\\adm-000-dr6300.xswhealth.nhs.uk\XSW_SQLBACK_UHB''  -- Set this to the required path
--SET @db_devtype = '' From DISK'' 
SET @server_name = ''XSW-00-CCSQL01''


DECLARE db_cursor CURSOR FOR  
-- Select statement for all User databases
--SELECT name FROM [XSW-00-CCSQL01].master.dbo.sysdatabases WHERE name NOT IN (''master'', ''model'', ''msdb'', ''tempdb'') 

-- Select statement for a single User database
SELECT name FROM [XSW-00-CCSQL01].master.dbo.sysdatabases WHERE name IN (''OHCP_OHAUDIT'', ''OHCP_OHPORTAL'') 

OPEN db_cursor   
FETCH NEXT FROM db_cursor INTO @db_name   
IF (SELECT DATENAME(WEEKDAY,GETDATE())) = ''Monday''
	WHILE @@FETCH_STATUS = 0   
	BEGIN  
		SET @tmpstr3 = ''Drop Database '' + @db_name 
		EXECUTE sp_executesql @tmpstr3
		PRINT ''Drop Database Completed''
		SET @date = (SELECT MAX([backup_finish_date]) FROM [XSW-00-CCSQL01].[msdb].[dbo].[backupset] WHERE [database_name] = @db_name and [type] = ''D'')
		SET @RestoreDB = (SELECT [name] + ''.fbak'' FROM [XSW-00-CCSQL01].[msdb].[dbo].[backupset] WHERE [database_name] = @db_name  and [type] = ''D'' and [backup_finish_date] >= @date)
		SET @db_datapath = (SELECT filename FROM [XSW-00-CCSQL01].master.sys.sysaltfiles mf INNER JOIN [XSW-00-CCSQL01].master.sys.databases db ON db.database_id = mf.dbid where db.name = @db_name and fileid = 1)
		SET @db_physicalname = @db_path + ''\'' +  @server_name + ''\'' + @RestoreDB
		SET @db_logpath = (SELECT filename FROM [XSW-00-CCSQL01].master.sys.sysaltfiles mf INNER JOIN [XSW-00-CCSQL01].master.sys.databases db ON db.database_id = mf.dbid where db.name = @db_name and fileid = 2)
		SET @tmpstr = ''RESTORE DATABASE '' + ''['' + @db_name + '']'' + '' FROM DISK = N'''''' + @db_physicalname + '''''' WITH  FILE = 1,  MOVE N'''''' + @db_name + '''''' TO N'''''' + @db_datapath + '''''', MOVE N'''''' + @db_name + ''_log'''' TO N'''''' + @db_logpath + '''''',  NOUNLOAD,  REPLACE,  STATS = 5;'' 
	--	PRINT @tmpstr
		EXECUTE sp_executesql @tmpstr
		FETCH NEXT FROM db_cursor INTO @db_name   
	END   
ELSE
	WHILE @@FETCH_STATUS = 0   
	BEGIN  
		SET @tmpstr3 = ''Drop Database '' + @db_name 
		EXECUTE sp_executesql @tmpstr3
		PRINT ''Drop Database Completed''
		SET @date = (SELECT MAX([backup_finish_date]) FROM [XSW-00-CCSQL01].[msdb].[dbo].[backupset] WHERE [database_name] = @db_name and [type] = ''D'')
		SET @date_diff = (SELECT MAX([backup_finish_date]) FROM [XSW-00-CCSQL01].[msdb].[dbo].[backupset] WHERE [database_name] = @db_name and [type] = ''I'')
		SET @server_name = ''XSW-00-CCSQL01''
		SET @RestoreDB = (SELECT [name] + ''.fbak'' FROM [XSW-00-CCSQL01].[msdb].[dbo].[backupset] WHERE [database_name] = @db_name  and [type] = ''D'' and [backup_finish_date] >= @date)
		SET @RestoreDB_diff = (SELECT [name] + ''.dbak'' FROM [XSW-00-CCSQL01].[msdb].[dbo].[backupset] WHERE [database_name] = @db_name  and [type] = ''I'' and [backup_finish_date] >= @date_diff)
		SET @db_datapath = (SELECT filename FROM [XSW-00-CCSQL01].master.sys.sysaltfiles mf INNER JOIN [XSW-00-CCSQL01].master.sys.databases db ON db.database_id = mf.dbid where db.name = @db_name and fileid = 1)
		SET @db_physicalname = @db_path + ''\'' +  @server_name + ''\'' + @RestoreDB
		SET @db_physicalname_diff = @db_path + ''\'' +  @server_name + ''\'' + @RestoreDB_diff
		SET @db_logpath = (SELECT filename FROM [XSW-00-CCSQL01].master.sys.sysaltfiles mf INNER JOIN [XSW-00-CCSQL01].master.sys.databases db ON db.database_id = mf.dbid where db.name = @db_name and fileid = 2)
		SET @tmpstr = ''RESTORE DATABASE '' + ''['' + @db_name + '']'' + '' FROM DISK = N'''''' + @db_physicalname + '''''' WITH  FILE = 1,  MOVE N'''''' + @db_name + '''''' TO N'''''' + @db_datapath + '''''', MOVE N'''''' + @db_name + ''_log'''' TO N'''''' + @db_logpath + '''''',  NORECOVERY,  NOUNLOAD,  REPLACE,  STATS = 5;'' 
		SET @tmpstr2 = ''RESTORE DATABASE '' + ''['' + @db_name + '']'' + '' FROM DISK = N'''''' + @db_physicalname_diff + '''''' WITH  FILE = 1,  MOVE N'''''' + @db_name + '''''' TO N'''''' + @db_datapath + '''''', MOVE N'''''' + @db_name + ''_log'''' TO N'''''' + @db_logpath + '''''',  NOUNLOAD,  STATS = 5;'' 

--		PRINT @tmpstr
		EXECUTE sp_executesql @tmpstr
--		PRINT @tmpstr2
		EXECUTE sp_executesql @tmpstr2
		FETCH NEXT FROM db_cursor INTO @db_name   
	END   

CLOSE db_cursor  
DEALLOCATE db_cursor

', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Add in Reporting Servises users]    Script Date: 26/01/2016 15:24:45 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Add in Reporting Servises users', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=4, 
		@on_success_step_id=3, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'USE [OHCP_OHPORTAL]
GO
CREATE USER [CCP_Reporting] FOR LOGIN [CCP_Reporting]
GO
USE [OHCP_OHPORTAL]
GO
ALTER ROLE [db_datareader] ADD MEMBER [CCP_Reporting]
GO


USE [OHCP_OHAUDIT]
GO
CREATE USER [CCP_Reporting] FOR LOGIN [CCP_Reporting]
GO
USE [OHCP_OHAUDIT]
GO
ALTER ROLE [db_datareader] ADD MEMBER [CCP_Reporting]
GO', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Run Stored procedure exec [uspRefreshReportingData]    Script Date: 26/01/2016 15:24:45 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Run Stored procedure exec [uspRefreshReportingData', 
		@step_id=3, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'exec [dbo].[uspRefreshReportingData]', 
		@database_name=N'CC_Reporting_Data', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Restore OHCP_OHAUDIT schedule', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20151103, 
		@active_end_date=99991231, 
		@active_start_time=10000, 
		@active_end_time=235959, 
		@schedule_uid=N'a5d7f6cb-4f43-45ed-9241-97ff264f0f9c'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO



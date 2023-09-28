-- CheckBackupPercentage.sql     rm     07/10/15
--
-- Backup/Restore - Times either plus RESTORE HEADERON if running a verify only
--
-- See CheckJobCompletionPercentage.sql for everything else

SELECT
	session_id,
	start_time,
	status,
	command,
	percent_complete,
	estimated_completion_time,
	estimated_completion_time /60/1000 as estimate_completion_minutes,
	DATEADD(n,(estimated_completion_time /60/1000),GETDATE()) as estimated_completion_time
FROM    sys.dm_exec_requests 
WHERE COMMAND IN ('BACKUP DATABASE', 'RESTORE DATABASE', 'RESTORE HEADERON')

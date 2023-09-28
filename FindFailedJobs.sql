-- FindFailedJobs.sql    rm    05/07/16
--
--

declare @tmp_sp_help_jobhistory table
(
    instance_id int null, 
    job_id uniqueidentifier null, 
    job_name sysname null, 
    step_id int null, 
    step_name sysname null, 
    sql_message_id int null, 
    sql_severity int null, 
    message nvarchar(4000) null, 
    run_status int null, 
    run_date int null, 
    run_time int null, 
    run_duration int null, 
    operator_emailed sysname null, 
    operator_netsent sysname null, 
    operator_paged sysname null, 
    retries_attempted int null, 
    server sysname null  
)

-- Get the results for a particular job
insert into @tmp_sp_help_jobhistory 
exec msdb.dbo.sp_help_jobhistory 
  --  @job_name = 'Control Warehouse - Sollis full update',
    @mode='FULL' 
        
SELECT
    tshj.run_status  AS [RunStatus],
    STUFF(STUFF(CAST(tshj.run_date AS Nchar(8)), 7, 0, '-'), 5, 0, '-') AS [RunDate],
    STUFF(STUFF(SUBSTRING(CAST(1000000 + tshj.run_time AS Nchar(7)), 2, 6), 5, 0, ':'), 3, 0, ':') AS [RunTime],
    STUFF(STUFF(SUBSTRING(CAST(1000000 + tshj.run_duration AS Nchar(7)), 2, 6), 5, 0, ':'), 3, 0, ':') AS [RunDuration],
    tshj.step_id AS [StepID],
    tshj.server AS [Server],
    tshj.job_name AS [JobName],
    tshj.step_name AS [StepName],
    tshj.message AS [Message],
    tshj.sql_severity AS [SqlSeverity],
    tshj.sql_message_id AS [SqlMessageID],
    tshj.operator_emailed AS [OperatorEmailed],
    tshj.operator_netsent AS [OperatorNetsent],
    tshj.operator_paged AS [OperatorPaged],
    tshj.retries_attempted AS [RetriesAttempted],
    getdate() as [CurrentDate]
FROM @tmp_sp_help_jobhistory as tshj
where tshj.run_status  = 0  -- Failed
ORDER BY [run_date] DESC , [run_time]  DESC

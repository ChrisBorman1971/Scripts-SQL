-- FindJobsRunningEarlier.sql    rm     07/12/15
--
-- What jobs were running at a particular moment in the past?

Declare @target_time Datetime = '2016-05-06 12:15:30.000'

If      @target_time >= (
        Select  Min(msdb.dbo.agent_datetime(sjh.run_date, sjh.run_time))
        From    msdb.dbo.sysjobhistory sjh
        )
Begin
    Select  sj.name,
            sjh.step_id,
            a.start_time,
            a.end_time,
            sjh.message
    From    msdb.dbo.sysjobs sj
    Join    msdb.dbo.sysjobhistory sjh
    On      sj.job_id = sjh.job_id
    Outer Apply (
            Select  msdb.dbo.agent_datetime(sjh.run_date, sjh.run_time) As start_time,
                    Dateadd(Second, 
                        sjh.run_duration % 100 + -- Seconds
                        (((sjh.run_duration / 100) % 100) * 60) + -- Minutes
                        ((sjh.run_duration / 10000) * 60 * 60), -- Hours
                        msdb.dbo.agent_datetime(sjh.run_date, sjh.run_time)) As end_time
            ) a
    Where   @target_time Between start_time And end_time
    Or      end_time Is Null
    Order By 3, 1, 2
End
Else
Begin
    Raiserror('msdb.dbo.sysjobhistory retention period has already passed', 16, 1)
End


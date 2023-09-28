/*
This script shows the status of SQL Server Agent jobs run on a specific date.
*/


Use msdb 
go 
select distinct j.Name as "Job Name", --j.job_id, 
case j.enabled  
when 1 then 'Enabled'  
when 0 then 'Disabled'  
end as "Job Status", jh.run_date as [Last_Run_Date(YY-MM-DD)] ,  
case jh.run_status  
when 0 then 'Failed'   
when 1 then 'Successful'  
when 2 then 'Retry' 
when 3 then 'Cancelled'  
when 4 then 'In Progress'   
end as Job_Execution_Status , 
jh.run_time AS "Run time"
from sysJobHistory jh, sysJobs j 
where j.job_id = jh.job_id and jh.run_date =  '20160905'
ORDER BY jh.run_time desc


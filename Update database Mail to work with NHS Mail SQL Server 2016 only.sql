declare @server nvarchar(50)
declare @email nvarchar(75)
declare @dispname nvarchar(75)
set @server = @@servername
set @email = 'scwcsu.sqlservers@nhs.net'
set @dispname = @server + ' SQL MAIL'

EXECUTE msdb.dbo.sysmail_update_account_sp
    @account_name = 'SQLMailAccount',
    @description = 'Mail account for sending outgoing notifications from Database Mail',
    @email_address = @email,
    @display_name = @dispname,
    @mailserver_name = 'send.nhs.net', -- NHS Mail for SQL Server 2016 onward
	@port = 587,
    @enable_ssl = 1,
    @username = 'scwcsu.sqlservers@nhs.net',
    @password = '2ghknEIsyJM2MGh2uTp!' ;  
	
-- Test Execution of mail

declare @body1 varchar(100)
set @body1 = 'Server :'+@@servername+ ' Is now set up for database mail using nhs.net '

--EXEC msdb.dbo.sp_send_dbmail @recipients='scwcsu.DBATeam@nhs.net',
EXEC msdb.dbo.sp_send_dbmail @recipients='Chris.Borman@nhs.net',
    @subject = 'Testing NHS Net works on Database Mail for SQL Server ',
    @body = @body1,
    @body_format = 'HTML' ;	
select	@@servername, 
		'', 
		name, 
		CASE logintype
			WHEN isntname = 1 THEN 'WINDOWS_USER'
			ELSE 'SQL_USER'
		END,
		createdate,
		updatedate
from sysusers 
where name not in ('public', 'db_owner', 'db_accessadmin', 'db_securityadmin', 
'db_ddladmin', 'db_backupoperator', 'db_datareader', 'db_datawriter', 'db_denydatareader', 'db_denydatawriter', 'secAdmin', 'guest', 'dbo')
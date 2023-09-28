Create Table	#DB_Info (
				ServerName NVARCHAR(40),
				ShortServerName NVARCHAR(40),
				dbid int, 
				Product_Version NVARCHAR(15), 
				Product_Level NVARCHAR(10), 
				Collation_Type NVARCHAR(50),
				IsClustered int,
				Authentication_Mode NVARCHAR(50),
				dbName NVARCHAR(50),
				Status NVARCHAR(15),
				User_access NVARCHAR(15),
				Recovery_model  NVARCHAR(10),
				compatibility_level  NVARCHAR(25),
				Physical_Name NVARCHAR(200),
				Creation_date datetime)
Go
		

insert into #DB_Info (ServerName, ShortServerName, dbid, Product_Version, Product_Level, Collation_Type, IsClustered, Authentication_Mode, dbName, Status, User_access, Recovery_model, compatibility_level, Physical_Name) 
Select	@@SERVERNAME as ServerName, 
		dbid, 
		SERVERPROPERTY('productversion') as Product_Version, 
		SERVERPROPERTY('productlevel') as Product_Level, 
		SERVERPROPERTY('Collation') Collation_Type,
		SERVERPROPERTY('IsClustered') [IsClustered?],
		CASE SERVERPROPERTY('IsIntegratedSecurityOnly')   
			WHEN 1 THEN 'Windows Authentication'   
			WHEN 0 THEN 'Windows and SQL Server Authentication'   
		END as [Authentication Mode],
		CONVERT(VARCHAR(25), s.name) AS dbName,
		CONVERT(VARCHAR(10), DATABASEPROPERTYEX(s.name, 'status')) AS [Status],
		user_access_desc AS [User access],
		recovery_model_desc AS [Recovery model],
		CASE compatibility_level
			WHEN 60 THEN '60 (SQL Server 6.0)'
			WHEN 65 THEN '65 (SQL Server 6.5)'
			WHEN 70 THEN '70 (SQL Server 7.0)'
			WHEN 80 THEN '80 (SQL Server 2000)'
			WHEN 90 THEN '90 (SQL Server 2005)'
			WHEN 100 THEN '100 (SQL Server 2008)'
			WHEN 110 THEN '110 (SQL Server 2012)'
			WHEN 120 THEN '120 (SQL Server 2014)'
			WHEN 130 THEN '130 (SQL Server 2016)'
			WHEN 140 THEN '140 (SQL Server 2017)'
			WHEN 150 THEN '150 (SQL Server 2019)'
			WHEN 160 THEN '160 (SQL Server 2022)'
		END AS [compatibility level],
		s.filename as [Physical_Name],
		s.crdate as [Creation_date]
from	sys.sysdatabases s inner join sys.databases sd on s.name = sd.name
		left join sys.master_files smf on s.dbid = smf.database_id
WHERE	smf.file_id = 1
order by	s.dbid asc, 
			smf.file_id asc




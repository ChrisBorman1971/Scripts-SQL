/*
USE [ProjectData]
GO

INSERT INTO [dbo].[SQLInfo_ServerData]
           ([FQDNServerName]
           ,[ShortServerName]
           ,[Windows Version]
           ,[CPU]
           ,[Memory_MB]
           ,[Windows Service Pack])
     VALUES
			('ADM-000-SP02.Admin.local','ADM-000-SP02', 'Windows Server 2012 R2 Datacenter', 8, 32768, NULL),
			('ADM-000-SP03.Admin.local','ADM-000-SP03', 'Windows Server 2016 Datacenter', 4, 65536, NULL),
			('ADM-000-SP04.Admin.local','ADM-000-SP04', 'Windows Server 2019 Datacenter', 8, 262144, NULL)

GO


USE [ProjectData]
GO

--Alter Table [dbo].[SQLInfo_SQLServerData] Alter column [SQLServerVersion] nvarchar(70)

INSERT INTO [dbo].[SQLInfo_SQLServerData]
           ([ID]
           ,[FQDNServerName]
           ,[ShortServerName]
           ,[SQLServerRelease]
           ,[ServicePackVersion]
           ,[KBArticle]
           ,[BuildNumber]
           ,[SQLServerVersion]
           ,[Product_Version]
           ,[Product_Level]
           ,[Collation_Type]
           ,[IsClustered?]
           ,[Authentication Mode])
     VALUES
(83, 'ADM-000-SP02.ADMIN.local', 'ADM-000-SP02', 'SQL Server 2016', 'SP3', 'KB5021129', '13.0.6430.49', 'Microsoft SQL Server Standard (64-bit)', '13.0.6430.49', 'SP3', 'Latin1_General_CI_AS', 0,	'Windows and SQL Server Authentication'),
(84, 'ADM-000-SP03.ADMIN.local', 'ADM-000-SP03', 'SQL Server 2016', 'SP2', 'KB5014351', '13.0.5893.48', 'Microsoft SQL Server Standard (64-bit)', '13.0.5893.48', 'SP2', 'Latin1_General_CI_AS', 0,	'Windows and SQL Server Authentication'),
(85, 'ADM-000-SP04.ADMIN.local', 'ADM-000-SP04', 'SQL Server 2019', 'CU18', 'KB5017593', '15.0.4261.1', 'Microsoft SQL Server Enterprise: Core-based Licensing (64-bit)', '15.0.4261.1', 'RTM', 'Latin1_General_CI_AS', 0,	'Windows and SQL Server Authentication')
GO

*/


USE [ProjectData]
GO

INSERT INTO [dbo].[SQLInfo_SQL_DB_Data]
           ([ID]
           ,[dbid]
           ,[dbName]
           ,[Status]
           ,[User access]
           ,[Recovery model]
           ,[compatibility level]
           ,[Physical_Name]
           ,[Creation_date])
     VALUES
			(83, 1,  'master',  'ONLINE',  'MULTI_USER',  'SIMPLE',  '130 (SQL Server 2016)',  'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\master.mdf',  convert(datetime,'08/04/2003 09:13:36.4',103)),
			(83, 2,  'tempdb',  'ONLINE',  'MULTI_USER',  'SIMPLE',  '130 (SQL Server 2016)',  'T:\TEMPDB\tempdb.mdf',  convert(datetime,'28/02/2023 02:03:17.1',103)),
			(83, 3,  'model',  'ONLINE',  'MULTI_USER',  'SIMPLE',  '130 (SQL Server 2016)',  'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\model.mdf',  convert(datetime,'08/04/2003 09:13:36.4',103)),
			(83, 4,  'msdb',  'ONLINE',  'MULTI_USER',  'SIMPLE',  '130 (SQL Server 2016)',  'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\MSDBData.mdf',  convert(datetime,'30/04/2016 00:46:38.8',103)),
			(83, 5,  'CerteroConfig',  'ONLINE',  'MULTI_USER',  'SIMPLE',  '130 (SQL Server 2016)',  'K:\MSSQL\Data\CerteroConfig.mdf',  convert(datetime,'19/04/2022 21:57:58.4',103)),
			(83, 6,  'CerteroTmp',  'ONLINE',  'MULTI_USER',  'SIMPLE',  '130 (SQL Server 2016)',  'K:\MSSQL\Data\CerteroTmp.mdf',  convert(datetime,'19/04/2022 21:58:17.4',103)),
			(83, 7,  'CerteroData',  'ONLINE',  'MULTI_USER',  'SIMPLE',  '130 (SQL Server 2016)',  'K:\MSSQL\Data\CerteroData.mdf',  convert(datetime,'08/04/2020 19:37:59.1',103)),
			(83, 8,  'BDS Directory Manager',  'ONLINE',  'MULTI_USER',  'SIMPLE',  '130 (SQL Server 2016)',  'K:\MSSQL\Data\BDS Directory Manager1.mdf',  convert(datetime,'15/11/2022 07:34:31.8',103)),
			(83, 11,  'SUSDB',  'ONLINE',  'MULTI_USER',  'SIMPLE',  '100 (SQL Server 2008)',  'K:\MSSQL\Data\SUSDB.mdf',  convert(datetime,'08/10/2018 12:57:46.8',103)),
			(83, 12,  'DBA',  'ONLINE',  'MULTI_USER',  'SIMPLE',  '130 (SQL Server 2016)',  'K:\MSSQL\Data\DBA.mdf',  convert(datetime,'17/01/2019 08:45:41.5',103)),
			(83, 16,  'CerteroReports',  'ONLINE',  'MULTI_USER',  'SIMPLE',  '130 (SQL Server 2016)',  'K:\MSSQL\Data\CerteroReports.mdf',  convert(datetime,'28/01/2019 15:26:45.7',103)),
			(84,  1,  'master',  'ONLINE',  'MULTI_USER',  'SIMPLE',  '130 (SQL Server 2016)',  'E:\SQL_System_DBs\master.mdf',  convert(datetime,'08/04/2003 09:13:36.4',103)),
			(84,  2,  'tempdb',  'ONLINE',  'MULTI_USER',  'SIMPLE',  '130 (SQL Server 2016)',  'T:\TEMPDB\tempdb.mdf',  convert(datetime,'21/02/2023 02:46:44.3',103)),
			(84,  3,  'model',  'ONLINE',  'MULTI_USER',  'FULL',  '130 (SQL Server 2016)',  'E:\SQL_System_DBs\model.mdf',  convert(datetime,'08/04/2003 09:13:36.4',103)),
			(84,  4,  'msdb',  'ONLINE',  'MULTI_USER',  'SIMPLE',  '130 (SQL Server 2016)',  'E:\SQL_System_DBs\MSDBData.mdf',  convert(datetime,'30/04/2016 00:46:38.8',103)),
			(84,  5,  'DBA',  'ONLINE',  'MULTI_USER',  'SIMPLE',  '130 (SQL Server 2016)',  'K:\MSSQL\Data\DBA.mdf',  convert(datetime,'05/07/2019 10:04:09.1',103)),
			(84,  6,  'TrendDSM',  'ONLINE',  'MULTI_USER',  'SIMPLE',  '100 (SQL Server 2008)',  'K:\MSSQL\Data\TrendDSM.mdf',  convert(datetime,'09/07/2019 09:46:28.1',103)),
			(84,  9,  'desktopcentral',  'ONLINE',  'MULTI_USER',  'SIMPLE',  '130 (SQL Server 2016)',  'K:\MSSQL\Data\desktopcentral.mdf',  convert(datetime,'26/08/2020 14:04:30.8',103)),
			(84,  10,  'compmsadb',  'ONLINE',  'MULTI_USER',  'FULL',  '130 (SQL Server 2016)',  'K:\MSSQL\Data\compmsadb.mdf', convert(datetime,'29/06/2021 08:42:33.0',103)),
			(84,  11,  'PBI_datafeed',  'OFFLINE',  'MULTI_USER',  'FULL',  '100 (SQL Server 2008)',  'K:\MSSQL\Data\PBI_datafeed.mdf',  convert(datetime,'17/11/2020 12:49:44.7',103)),
			(84,  12,  'SLP',  'OFFLINE',  'MULTI_USER',  'FULL',  '100 (SQL Server 2008)',  'K:\MSSQL\Data\SLP_test.mdf',  convert(datetime,'17/11/2020 12:50:12.1',103)),
			(84,  13,  'SLPArchive',  'OFFLINE',  'MULTI_USER',  'FULL',  '100 (SQL Server 2008)',  'K:\MSSQL\Data\SLPArchive.mdf',  convert(datetime,'17/11/2020 12:51:18.4',103)),
			(84,  14,  'Services',  'OFFLINE',  'MULTI_USER',  'FULL',  '100 (SQL Server 2008)',  'K:\MSSQL\Data\Services.mdf',  convert(datetime,'20/11/2020 09:56:51.7',103)),
			(84,  16,  'ePO_V5',  'ONLINE',  'MULTI_USER',  'FULL',  '100 (SQL Server 2008)',  'K:\MSSQL\Data\ePO_V5.mdf',  convert(datetime,'23/11/2020 10:48:28.8',103)),
			(84,  17,  'ePO4_XSW-00-EPO',  'ONLINE',  'MULTI_USER',  'SIMPLE',  '100 (SQL Server 2008)',  'K:\MSSQL\Data\ePO4_XSW-00-EPO.mdf',  convert(datetime,'23/11/2020 10:57:42.8',103)),
			(85,  1,  'master',  'ONLINE',  'MULTI_USER',  'SIMPLE',  '150 (SQL Server 2019)',  'E:\SQL_System_DBs\master.mdf', convert(datetime,'08/04/2003 09:13:36.4',103)),
			(85,  2,  'tempdb',  'ONLINE',  'MULTI_USER',  'SIMPLE',  '150 (SQL Server 2019)',  'T:\TEMPDB\tempdb.mdf',  convert(datetime,'06/12/2022 10:36:47.8',103)),
			(85,  3,  'model',  'ONLINE',  'MULTI_USER',  'FULL',  '150 (SQL Server 2019)',  'E:\SQL_System_DBs\model.mdf',  convert(datetime,'08/04/2003 09:13:36.4',103)),
			(85,  4,  'msdb',  'ONLINE',  'MULTI_USER',  'SIMPLE',  '150 (SQL Server 2019)',  'E:\SQL_System_DBs\MSDBData.mdf',  convert(datetime,'24/09/2019 14:21:42.3',103)),
			(85,  5,  'DBA',  'ONLINE',  'MULTI_USER',  'SIMPLE',  '150 (SQL Server 2019)',  'K:\MSSQL\Data\DBA.mdf',  convert(datetime,'14/11/2022 11:48:22.1',103)),
			(85,  8,  'SitesIntel',  'ONLINE',  'MULTI_USER',  'SIMPLE',  '150 (SQL Server 2019)',  'K:\MSSQL\Data\SitesIntel.mdf',  convert(datetime,'16/11/2022 14:49:21.9',103)),
			(85,  9,  'SolarwindsArchive',  'ONLINE',  'MULTI_USER',  'SIMPLE',  '150 (SQL Server 2019)',  'K:\MSSQL\Data\SolarwindsArchive.mdf',  convert(datetime,'16/11/2022 14:49:23.8',103)),
			(85,  10, 'SolarWindsFlowStorage',  'ONLINE',  'MULTI_USER',  'SIMPLE',  '150 (SQL Server 2019)',  'K:\MSSQL\Data\SolarWindsFlowStorage.mdf',  convert(datetime,'16/11/2022 14:49:29.3',103)),
			(85,  11,  'SolarwindsLive',  'ONLINE',  'MULTI_USER',  'SIMPLE',  '150 (SQL Server 2019)',  'K:\MSSQL\Data\SolarwindsLive.mdf',  convert(datetime,'16/11/2022 14:50:35.9',103)),
			(85,  12,  'SolarWindsOrion',  'ONLINE',  'MULTI_USER',  'SIMPLE',  '150 (SQL Server 2019)',  'K:\MSSQL\Data\SolarWindsOrion.mdf',  convert(datetime,'16/11/2022 15:12:19.6',103)),
			(85,   13, 'SolarWindsOrionLog',  'ONLINE',  'MULTI_USER',  'SIMPLE',  '150 (SQL Server 2019)',  'K:\MSSQL\Data\SolarWindsOrionLog.mdf',  convert(datetime,'16/11/2022 15:12:25.7',103))
GO




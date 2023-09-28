USE [master]
GO
CREATE LOGIN [svcTurbonomics] WITH PASSWORD=N'svcTur80n0m!c5#', DEFAULT_DATABASE=[master], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO
USE [SWCSUData]
GO
CREATE USER [svcTurbonomics] FOR LOGIN [svcTurbonomics]
GO
USE [SWCSUData]
GO
ALTER ROLE [db_datareader] ADD MEMBER [svcTurbonomics]
GO
USE [SWCSUDataReporting]
GO
CREATE USER [svcTurbonomics] FOR LOGIN [svcTurbonomics]
GO
USE [SWCSUDataReporting]
GO
ALTER ROLE [db_datareader] ADD MEMBER [svcTurbonomics]
GO
use [master]
GO
GRANT CONNECT SQL TO [svcTurbonomics]
GO
use [master]
GO
GRANT VIEW SERVER STATE TO [svcTurbonomics]
GO

-- Finderrorlogs.sql   16/12/14
--
--
USE master
GO

xp_readerrorlog 0, 1, N'Logging SQL Server messages in file', NULL, NULL, N'asc' 
GO
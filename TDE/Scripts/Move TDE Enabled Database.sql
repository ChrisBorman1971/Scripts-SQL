-- Detach the TDE protected database from the source server. 
USE master ;
GO
EXEC master.dbo.sp_detach_db @dbname = N'CustRecords';
GO

-- ***************************** MANUAL TASK **********************************************************************
-- Move or copy the database files from the source server to the same location on the destination server. 
-- Move or copy the backup of the server certificate and the private key file from the source server to the 
-- same location on the destination server. 
-- ***************************** MANUAL TASK COMPLETED**********************************************************************


-- Create a database master key on the destination instance of SQL Server. 
USE master;
GO
CREATE MASTER KEY ENCRYPTION BY PASSWORD = '*rt@40(FL&dasl1';
GO
-- Recreate the server certificate by using the original server certificate backup file. 
-- The password must be the same as the password that was used when the backup was created.

CREATE CERTIFICATE TestSQLServerCert 
FROM FILE = 'TestSQLServerCert'
WITH PRIVATE KEY 
(
    FILE = 'SQLPrivateKeyFile',
    DECRYPTION BY PASSWORD = '*rt@40(FL&dasl1'
);
GO
-- Attach the database that is being moved. 
-- The path of the database files must be the location where you have stored the database files.
CREATE DATABASE [CustRecords] ON 
( FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\CustRecords.mdf' ),
( FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\CustRecords_log.LDF' )
FOR ATTACH ;
GO

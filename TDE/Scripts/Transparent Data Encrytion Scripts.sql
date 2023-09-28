
-- STEP 1 - Backup the database prior to setting up Encryption

BACKUP DATABASE [PasswordManager] TO  DISK = N'\\ld5a-SQLbackup\SQLBACKUP\LD5P-SQLMON-I01\PasswordManager_backup_PRE_TDE_20130215.fbak' WITH NOFORMAT, INIT,  NAME = N'PasswordManager-Full Database Backup', SKIP, NOREWIND, NOUNLOAD, COMPRESSION,  STATS = 10
GO
declare @backupSetId as int
select @backupSetId = position from msdb..backupset where database_name=N'PasswordManager' and backup_set_id=(select max(backup_set_id) from msdb..backupset where database_name=N'PasswordManager' )
if @backupSetId is null begin raiserror(N'Verify failed. Backup information for database ''PasswordManager'' not found.', 16, 1) end
RESTORE VERIFYONLY FROM  DISK = N'\\ld5a-SQLbackup\SQLBACKUP\LD5P-SQLMON-I01\PasswordManager_backup_PRE_TDE_20130215.fbak' WITH  FILE = @backupSetId,  NOUNLOAD,  NOREWIND
GO

-- STEP 2 - Backup the master database prior to setting up 
BACKUP DATABASE [master] TO  DISK = N'\\ld5a-sqlbackup\SQLBACKUP\LD5P-MONSQL-I01\master_backup_Pre_TDE_2013_02_15.fbak' WITH NOFORMAT, INIT,  NAME = N'master-Full Database Backup', SKIP, NOREWIND, NOUNLOAD, COMPRESSION,  STATS = 10
GO
declare @backupSetId as int
select @backupSetId = position from msdb..backupset where database_name=N'master' and backup_set_id=(select max(backup_set_id) from msdb..backupset where database_name=N'master' )
if @backupSetId is null begin raiserror(N'Verify failed. Backup information for database ''master'' not found.', 16, 1) end
RESTORE VERIFYONLY FROM  DISK = N'\\ld5a-sqlbackup\SQLBACKUP\LD5P-MONSQL-I01\master_backup_Pre_TDE_2013_02_15.fbak' WITH  FILE = @backupSetId,  NOUNLOAD,  NOREWIND
GO

-- STEP 3 - First step to setup TDE is to create a database master key for our master database. 
--			To do that, open the New Query window and execute the following script:

USE [master]
GO

CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'mwa=>[f*#v3&]3^?U8+5'
GO 
 
-- STEP 4 - Information about the database master key is visible in the sys.symmetric_keys catalog view. 
--			Execute the following query to verify that database master key is encrypted by the service 
--			master key:

USE [master]
GO

SELECT b.[name], a.[crypt_type_desc]
FROM [sys].[key_encryptions] a INNER JOIN [sys].[symmetric_keys] b ON a.[key_id] = b.[symmetric_key_id]
WHERE b.[name] = '##MS_DatabaseMasterKey##';
GO

-- STEP 5 - Now the next step is to create a self-signed certificate that is protected by the database master 
--			key of our master database. 
 
--			Execute the following script to create the self-signed certificate:

USE [master]
GO

CREATE CERTIFICATE  DataCentre_PasswordManager_Certificate
WITH SUBJECT = 'DataCentre_PasswordManager_Certificate', EXPIRY_DATE = '20220101'
GO


-- STEP 6 - Now backup your certificate and database master key immediately as you need them in a 
--			recovery situation. To do that, execute the following script to backup certificate:

--			This is backing up the Client Database Certificate
USE [master]
GO

BACKUP CERTIFICATE DataCentre_PasswordManager_Certificate
TO FILE = '\\ld5a-SQLbackup\SQLBACKUP\TDE\LD5P-SQLMON-I01\DataCentre_PasswordManager_Certificate.cer'
WITH PRIVATE KEY (FILE = '\\ld5a-SQLbackup\SQLBACKUP\TDE\LD5P-SQLMON-I01\DataCentre_PasswordManager_Certificate.key'
                 ,ENCRYPTION BY PASSWORD  = 'Si~8mhqF#PGZZbJsxtm~')
GO 
 
--			This is backing up the database master key of master database:
USE [master]
GO

--			Master key password must be specified when it is opened.
OPEN MASTER KEY DECRYPTION BY PASSWORD = 'mwa=>[f*#v3&]3^?U8+5'
BACKUP MASTER KEY TO FILE = '\\ld5a-SQLbackup\SQLBACKUP\TDE\LD5P-SQLMON-I01\ExportedMasterKey.key'
ENCRYPTION BY PASSWORD = 'qDN4eE45#~#XUr22RgeCgDc'
GO


-- STEP 7-	Now that we have created the database master key and the certificate in the master database, 
--			we are now ready to create the database encryption key for our database.
 
--			Execute the following script to create the database encryption key 

USE [PasswordManager]
GO

CREATE DATABASE ENCRYPTION KEY
WITH ALGORITHM = AES_256
ENCRYPTION BY SERVER CERTIFICATE DataCentre_PasswordManager_Certificate
GO

--STEP 8 -	The final step in the setup process of TDE is to enable it. 
--			This is accomplished by executing the ALTER DATABASE command with the 
--			SET ENCRYPTION ON argument.
 
--			Execute the following script to enable TDE on AdventureWorks2012 database:

USE [master]
GO

ALTER DATABASE [PasswordManager]
SET ENCRYPTION ON
GO










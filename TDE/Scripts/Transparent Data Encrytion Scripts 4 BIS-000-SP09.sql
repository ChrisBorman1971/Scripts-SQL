
-- STEP 1 - Backup the database prior to setting up Encryption

BACKUP DATABASE [SomersetAandE] TO  DISK = N'L:\TDE_BCKP\SomersetAandE_backup_PRE_TDE_202211.fbak' WITH NOFORMAT, INIT,  NAME = N'SomersetAandE-Full Database Backup', SKIP, NOREWIND, NOUNLOAD, COMPRESSION,  STATS = 10
GO
declare @backupSetId as int
select @backupSetId = position from msdb..backupset where database_name=N'SomersetAandE' and backup_set_id=(select max(backup_set_id) from msdb..backupset where database_name=N'SomersetAandE' )
if @backupSetId is null begin raiserror(N'Verify failed. Backup information for database ''SomersetAandE'' not found.', 16, 1) end
RESTORE VERIFYONLY FROM  DISK = N'L:\TDE_BCKP\SomersetAandE_backup_PRE_TDE_202211.fbak' WITH  FILE = @backupSetId,  NOUNLOAD,  NOREWIND
GO

-- STEP 2 - Backup the master database prior to setting up 
BACKUP DATABASE [master] TO  DISK = N'L:\TDE_BCKP\\master_backup_PRE_TDE_202211.fbak' WITH NOFORMAT, INIT,  NAME = N'master-Full Database Backup', SKIP, NOREWIND, NOUNLOAD, COMPRESSION,  STATS = 10
GO
declare @backupSetId as int
select @backupSetId = position from msdb..backupset where database_name=N'master' and backup_set_id=(select max(backup_set_id) from msdb..backupset where database_name=N'master' )
if @backupSetId is null begin raiserror(N'Verify failed. Backup information for database ''master'' not found.', 16, 1) end
RESTORE VERIFYONLY FROM  DISK = N'L:\TDE_BCKP\\master_backup_PRE_TDE_202211.fbak' WITH  FILE = @backupSetId,  NOUNLOAD,  NOREWIND
GO

-- STEP 3 - First step to setup TDE is to create a database master key for our master database. 
--			To do that, open the New Query window and execute the following script:

USE [master]
GO

CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'a!q£$&@~#~tXp6WdTwxjzxp5UEkzjqwz'
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

CREATE CERTIFICATE  BIS_SP09_TDE_Certificate
WITH SUBJECT = 'BIS_SP09_TDE_Certificate'--, EXPIRY_DATE = '20321130'
GO


-- STEP 6 - Now backup your certificate and database master key immediately as you need them in a 
--			recovery situation. To do that, execute the following script to backup certificate:

--			This is backing up the Client Database Certificate
USE [master]
GO

BACKUP CERTIFICATE BIS_SP09_TDE_Certificate
TO FILE = 'E:\TDE_Cert_Backup\BIS_SP09_TDE_Certificate.cer'
WITH PRIVATE KEY (FILE = 'E:\TDE_Cert_Backup\BIS_SP09_TDE_Certificate.key'
                 ,ENCRYPTION BY PASSWORD  = 'QM37BdN£$&@~#~d7dN34MezSrWUHH!Ea')
GO 
 
--			This is backing up the database master key of master database:
USE [master]
GO

--			Master key password must be specified when it is opened.
OPEN MASTER KEY DECRYPTION BY PASSWORD = 'a!q£$&@~#~tXp6WdTwxjzxp5UEkzjqwz'
BACKUP MASTER KEY TO FILE = 'E:\TDE_Cert_Backup\ExportedMasterKey.key'
ENCRYPTION BY PASSWORD = 'ZjKECNT6vTM!mbArwE8£$&@~#~3fPdqt'
GO


-- STEP 7-	Now that we have created the database master key and the certificate in the master database, 
--			we are now ready to create the database encryption key for our database.
 
--			Execute the following script to create the database encryption key 

USE [SomersetAandE]
GO

CREATE DATABASE ENCRYPTION KEY
WITH ALGORITHM = AES_256
ENCRYPTION BY SERVER CERTIFICATE BIS_SP09_TDE_Certificate
GO

--STEP 8 -	The final step in the setup process of TDE is to enable it. 
--			This is accomplished by executing the ALTER DATABASE command with the 
--			SET ENCRYPTION ON argument.
 
--			Execute the following script to enable TDE on AdventureWorks2012 database:

USE [master]
GO

ALTER DATABASE [SomersetAandE]
SET ENCRYPTION ON
GO










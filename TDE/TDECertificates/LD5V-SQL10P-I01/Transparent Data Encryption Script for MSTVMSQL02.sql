
-- STEP 1 - STEP 1 - Backup the database prior to setting up Encryption

BACKUP DATABASE [TA_SEPFinance] TO  DISK = N'\\Ld5a-sqlbackup\sqlbackup\LD5V-SQL10P-I01\TA_SEPFinance_backup_Pre_TDE_2012_09_17_141000.fbak' WITH NOFORMAT, INIT,  NAME = N'TA_SEPFinance-Full Database Backup', SKIP, NOREWIND, NOUNLOAD, COMPRESSION,  STATS = 10
GO
declare @backupSetId as int
select @backupSetId = position from msdb..backupset where database_name=N'TA_SEPFinance' and backup_set_id=(select max(backup_set_id) from msdb..backupset where database_name=N'TA_SEPFinance' )
if @backupSetId is null begin raiserror(N'Verify failed. Backup information for database ''TA_SEPFinance'' not found.', 16, 1) end
RESTORE VERIFYONLY FROM  DISK = N'\\Ld5a-sqlbackup\sqlbackup\LD5V-SQL10P-I01\TA_SEPFinance_backup_Pre_TDE_2012_09_17_141000.fbak' WITH  FILE = @backupSetId,  NOUNLOAD,  NOREWIND
GO

-- STEP 2 - Backup the master database prior to setting up 
BACKUP DATABASE [master] TO  DISK = N'\\Ld5a-sqlbackup\sqlbackup\LD5V-SQL10P-I01\master_backup_Pre_TDE_2012_09_17_141000.fbak' WITH NOFORMAT, INIT,  NAME = N'master-Full Database Backup', SKIP, NOREWIND, NOUNLOAD, COMPRESSION,  STATS = 10
GO
declare @backupSetId as int
select @backupSetId = position from msdb..backupset where database_name=N'master' and backup_set_id=(select max(backup_set_id) from msdb..backupset where database_name=N'master' )
if @backupSetId is null begin raiserror(N'Verify failed. Backup information for database ''master'' not found.', 16, 1) end
RESTORE VERIFYONLY FROM  DISK = N'\\Ld5a-sqlbackup\sqlbackup\LD5V-SQL10P-I01\master_backup_Pre_TDE_2012_09_17_141000.fbak' WITH  FILE = @backupSetId,  NOUNLOAD,  NOREWIND
GO

-- STEP 3 - First step to setup TDE is to create a database master key for our master database. 
--			To do that, open the New Query window and execute the following script:

USE [master]
GO

CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'TA#SEP_!F1n4c3!#-#~'
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

CREATE CERTIFICATE  CertificateforTDE_TA_Teachers
WITH SUBJECT = 'CertificateforTDE_TA_Teachers', EXPIRY_DATE = '20220101'
GO


-- STEP 6 - Now backup your certificate and database master key immediately as you need them in a 
--			recovery situation. To do that, execute the following script to backup certificate:

--			This is backing up the Client Database Certificate
USE [master]
GO

BACKUP CERTIFICATE CertificateforTDE_TA_Teachers
TO FILE = '\\Ld5a-sqlbackup\sqlbackup\TDE\LD5V-SQL10P-I01\CertificateforTDE_TA_Teachers.cer'
WITH PRIVATE KEY (FILE = '\\Ld5a-sqlbackup\sqlbackup\TDE\LD5V-SQL10P-I01\CertificateforTDE_TA_Teachers.key'
                 ,ENCRYPTION BY PASSWORD  = 'C3rt!f1c4t3f0rTDE#TA#Teachers1#~')
GO 
 
--			This is backing up the database master key of master database:
USE [master]
GO

--			Master key password must be specified when it is opened.
OPEN MASTER KEY DECRYPTION BY PASSWORD = 'TA#SEP_!F1n4c3!#-#~'
BACKUP MASTER KEY TO FILE = '\\Ld5a-sqlbackup\sqlbackup\TDE\LD5V-SQL10P-I01\ExportedMasterKey.key'
ENCRYPTION BY PASSWORD = 'Exp0rt3dM45t3rK3y1!#~'
GO


-- STEP 7-	Now that we have created the database master key and the certificate in the master database, 
--			we are now ready to create the database encryption key for our database.
 
--			Execute the following script to create the database encryption key 

USE [TA_SEPFinance]
GO

CREATE DATABASE ENCRYPTION KEY
WITH ALGORITHM = AES_256
ENCRYPTION BY SERVER CERTIFICATE CertificateforTDE_TA_Teachers
GO

--STEP 8 -	The final step in the setup process of TDE is to enable it. 
--			This is accomplished by executing the ALTER DATABASE command with the 
--			SET ENCRYPTION ON argument.
 
--			Execute the following script to enable TDE on AdventureWorks2012 database:

USE [master]
GO

ALTER DATABASE [TA_SEPFinance]
SET ENCRYPTION ON
GO










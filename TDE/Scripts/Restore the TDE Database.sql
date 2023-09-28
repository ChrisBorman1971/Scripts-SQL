-- Ensure a Master key is already created if not Create one

USE [master]
GO

CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'DEV_M45t3r#K3yEncrypt!0n##~~##'
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


-- Add the certificate to the server

CREATE CERTIFICATE  CertificateforTDE_TA_Teachers
FROM FILE = '\\ld5a-sqlbackup.TPUK.local\SQLBACKUP\TDE\LD5V-SQL10D-I01\DEV_CertificateforTDE_TA_Teachers.cer'     
WITH PRIVATE KEY (FILE = '\\ld5a-sqlbackup.TPUK.local\SQLBACKUP\TDE\LD5V-SQL10D-I01\DEV_CertificateforTDE_TA_Teachers.key', 
DECRYPTION BY PASSWORD = 'DEV_C3rt!f1c4t3f0rTDE#TA#Teachers1#~')
GO 

--Now restore the Database
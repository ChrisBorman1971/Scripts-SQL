-- FindRecoveryModel.sql     rm     23/03/15
--
-- Find the recovery model for all databases

use master
go

select name,CONVERT(varchar(20),DATABASEPROPERTYEX(name,'status')),recovery_model_desc from sys.databases 
go

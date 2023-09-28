-- FindOrphanedDistributedTransaction.sql    rm    03/06/16
--
-- An SSIS process is hanging and shows that it is being blocked by SPID -2
-- This is a known issue fixed by setting ValidateExternalMetadata to FALSE
--
-- http://dba.stackexchange.com/questions/47693/ssis-package-blocks-itself-if-uses-truncate 


SELECT l.resource_type
      ,l.resource_subtype
      ,l.resource_database_id
      ,d.name
      ,l.resource_description
      ,l.resource_associated_entity_id
      ,l.resource_lock_partition
      ,l.request_mode
      ,l.request_type
      ,l.request_status
      ,l.request_reference_count
      ,l.request_lifetime
      ,l.request_session_id
      ,l.request_exec_context_id
      ,l.request_request_id
      ,l.request_owner_type
      ,l.request_owner_id
      ,l.request_owner_guid
      ,l.request_owner_lockspace_id
      ,l.lock_owner_address
  FROM PBR_Staging_2016_2017.sys.dm_tran_locks l
  INNER JOIN sysdatabases d
  ON l.resource_database_id = d.dbid
  where l.request_session_id = -2;
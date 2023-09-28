-- FindLockingObjects.sql    rm    25/02/15
--
--

-- Find the blocking process
sp_who2

-- kill it off
kill 77

-- Oh no, it's still rolling back

-- Find the locks it is holding
sp_lock 77


-- Find the object name from objid in the sp_locks
select object_name(64)
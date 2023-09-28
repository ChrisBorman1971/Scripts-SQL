-- ExtendedEventWaitTypes.sql    rm    12/08/15

SELECT
    [map_key]
	,[map_value]
FROM sys.dm_xe_map_values
WHERE [name] = N'wait_types'
--    AND [map_value] = N'WRITE_COMPLETION';
GO
SELECT @@VERSION AS [SQL Version],
cpu_count AS [Logical CPUs], 
hyperthread_ratio AS [Logical vs Physical Cores Ratio], 
physical_memory_kb/1024 AS [Physical Memory(MB)], 
virtual_memory_kb/1024 AS [Virtual Memory(MB)],
committed_kb/1024 AS [Committed Memory(MB)],
committed_target_kb/1024 AS [Committed Target Memory(MB)],
max_workers_count AS [Max Workers Count], 
sqlserver_start_time AS [SQL Server Start Time],
socket_count AS [Socket Count],
cores_per_socket AS [Cores],
numa_node_count AS [Numa Nodes]
FROM sys.dm_os_sys_info 
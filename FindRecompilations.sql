-- FindRecompilations.sql      rm     29/03/16
--
-- From Pinal Dave, find top n statements in the plan cache

SELECT TOP 20
	qs.plan_generation_num,
	qs.execution_count,
	DB_NAME(st.dbid) AS DbName,
	st.objectid,
	st.TEXT
FROM sys.dm_exec_query_stats qs
  CROSS APPLY sys.dm_exec_sql_text(sql_handle) AS st
    ORDER BY plan_generation_num DESC
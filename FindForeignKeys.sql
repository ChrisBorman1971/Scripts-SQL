-- FindForeignKeys.sql    rm     04/08/15
--
--


SELECT [TABLE_CATALOG]
      ,[TABLE_SCHEMA]
      ,[TABLE_NAME]
   FROM [OHPSG_TDS].[INFORMATION_SCHEMA].[TABLES]
  where table_type = 'BASE TABLE'
  and table_name like '%_STAGING'
  order by table_schema, table_name 


  SELECT C.TABLE_CATALOG [PKTABLE_QUALIFIER],
       C.TABLE_SCHEMA [PKTABLE_OWNER],
       C.TABLE_NAME [PKTABLE_NAME],
       KCU.COLUMN_NAME [PKCOLUMN_NAME],
       C2.TABLE_CATALOG [FKTABLE_QUALIFIER],
       C2.TABLE_SCHEMA [FKTABLE_OWNER],
       C2.TABLE_NAME [FKTABLE_NAME],
       KCU2.COLUMN_NAME [FKCOLUMN_NAME],
       RC.UPDATE_RULE,
       RC.DELETE_RULE,
       C.CONSTRAINT_NAME [FK_NAME],
       C2.CONSTRAINT_NAME [PK_NAME],
       CAST(7 AS SMALLINT) [DEFERRABILITY]
FROM   INFORMATION_SCHEMA.TABLE_CONSTRAINTS C
       INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE KCU
         ON C.CONSTRAINT_SCHEMA = KCU.CONSTRAINT_SCHEMA
            AND C.CONSTRAINT_NAME = KCU.CONSTRAINT_NAME
       INNER JOIN INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS RC
         ON C.CONSTRAINT_SCHEMA = RC.CONSTRAINT_SCHEMA
            AND C.CONSTRAINT_NAME = RC.CONSTRAINT_NAME
       INNER JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS C2
         ON RC.UNIQUE_CONSTRAINT_SCHEMA = C2.CONSTRAINT_SCHEMA
            AND RC.UNIQUE_CONSTRAINT_NAME = C2.CONSTRAINT_NAME
       INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE KCU2
         ON C2.CONSTRAINT_SCHEMA = KCU2.CONSTRAINT_SCHEMA
            AND C2.CONSTRAINT_NAME = KCU2.CONSTRAINT_NAME
            AND KCU.ORDINAL_POSITION = KCU2.ORDINAL_POSITION
WHERE  C.CONSTRAINT_TYPE = 'FOREIGN KEY'

SELECT OBJECT_NAME(a.parent_object_id) AS [FK.parent_table_name]
		,b.NAME AS [FK.parent_column_name]
		,OBJECT_NAME(a.referenced_object_id) AS [FK.referenced_table_name]
		,c.NAME AS [FK.referenced_column_name]
		,OBJECT_NAME(a.constraint_object_id) AS [FK.constraint_name]
		,d.create_date AS [FK.create_date]
	FROM sys.foreign_key_columns a
	INNER JOIN sys.columns b
		ON a.parent_object_id = b.[object_id]
			AND a.parent_column_id = b.column_id
	INNER JOIN sys.columns c
		ON a.referenced_object_id = c.[object_id]
			AND a.referenced_column_id = c.column_id
	INNER JOIN sys.foreign_keys d
		ON a.constraint_object_id = d.[object_id]
--	WHERE OBJECT_NAME(a.parent_object_id) = 'OHPSG_TDS'
	ORDER BY 1
		,2
		,4
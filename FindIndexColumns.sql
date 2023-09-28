-- FindIndexColumns.sql       rm     19/08/15
--
-- Return all indexes and their columns in a database 
--
-- For a particular object just use EXEC sys.sp_helpindex @objname = N'User' 

SELECT 
     TableName = t.name,
     IndexName = ind.name,
     IndexId = ind.index_id,
     ColumnId = ic.index_column_id,
     ColumnName = col.name,
     ind.*,
     ic.*,
     col.* 
FROM 
     sys.indexes ind 
INNER JOIN 
     sys.index_columns ic ON  ind.object_id = ic.object_id and ind.index_id = ic.index_id 
INNER JOIN 
     sys.columns col ON ic.object_id = col.object_id and ic.column_id = col.column_id 
INNER JOIN 
     sys.tables t ON ind.object_id = t.object_id 
WHERE 
     ind.is_primary_key = 0 
     AND ind.is_unique = 0 
     AND ind.is_unique_constraint = 0 
     AND t.is_ms_shipped = 0 
ORDER BY 
     t.name, ind.name, ind.index_id, ic.index_column_id 



SELECT OBJECT_SCHEMA_NAME(T.[object_id],DB_ID()) AS [Schema],  
  T.[name] AS [table_name], I.[name] AS [index_name], AC.[name] AS [column_name],  
  I.[type_desc], I.[is_unique], I.[data_space_id], I.[ignore_dup_key], I.[is_primary_key], 
  I.[is_unique_constraint], I.[fill_factor],    I.[is_padded], I.[is_disabled], I.[is_hypothetical], 
  I.[allow_row_locks], I.[allow_page_locks], IC.[is_descending_key], IC.[is_included_column] 
FROM sys.[tables] AS T  
  INNER JOIN sys.[indexes] I ON T.[object_id] = I.[object_id]  
  INNER JOIN sys.[index_columns] IC ON I.[object_id] = IC.[object_id] 
  INNER JOIN sys.[all_columns] AC ON T.[object_id] = AC.[object_id] AND IC.[column_id] = AC.[column_id] 
WHERE T.[is_ms_shipped] = 0 AND I.[type_desc] <> 'HEAP' 
ORDER BY T.[name], I.[index_id], IC.[key_ordinal]
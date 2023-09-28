DECLARE @TableName nvarchar(255)

DECLARE MyTableCursor Cursor
FOR 
SELECT t.TABLE_SCHEMA + '.' + TABLE_NAME FROM INFORMATION_SCHEMA.TABLES t WHERE TABLE_NAME <> 'sysdiagrams' ORDER BY TABLE_NAME 
OPEN MyTableCursor

FETCH NEXT FROM MyTableCursor INTO @TableName
WHILE @@FETCH_STATUS = 0
    BEGIN
    EXEC ScriptCreateTableKeys @TableName

    FETCH NEXT FROM MyTableCursor INTO @TableName
END
CLOSE MyTableCursor
DEALLOCATE MyTableCursor


DECLARE @TableName nvarchar(255)
DECLARE MyTableCursor Cursor
FOR 
SELECT t.TABLE_SCHEMA + '.' + TABLE_NAME FROM INFORMATION_SCHEMA.TABLES t WHERE TABLE_NAME <> 'sysdiagrams' ORDER BY TABLE_NAME 
OPEN MyTableCursor

FETCH NEXT FROM MyTableCursor INTO @TableName
WHILE @@FETCH_STATUS = 0
    BEGIN
     EXEC ScriptDropTableKeys @TableName

    FETCH NEXT FROM MyTableCursor INTO @TableName
END
CLOSE MyTableCursor
DEALLOCATE MyTableCursor
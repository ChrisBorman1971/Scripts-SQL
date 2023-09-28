DECLARE
	@TableName NVARCHAR(4000) ,
	@TableSchemaName NVARCHAR(4000) ,
	@ColumnName NVARCHAR(4000) ,
	@CharacterMaxLen NVARCHAR(4000) ,
	@CollationName NVARCHAR(4000) ,
	@IsNullable NVARCHAR(4000) ,
	@DataType NVARCHAR(4000) ,
	@SQLText NVARCHAR(4000) ,
	@OldCollationName NVARCHAR(4000);
 
SET @CollationName = 'Latin1_General_CI_AS';
 
DECLARE MyTableCursor CURSOR
FOR
	SELECT
		name
	FROM
		sys.tables;
OPEN MyTableCursor;
FETCH NEXT FROM MyTableCursor INTO @TableName;
WHILE @@FETCH_STATUS = 0
	BEGIN
    
		DECLARE MyColumnCursor CURSOR
		FOR
			SELECT
				TABLE_SCHEMA ,
				COLUMN_NAME ,
				DATA_TYPE ,
				CHARACTER_MAXIMUM_LENGTH ,
				IS_NULLABLE ,
				COLLATION_NAME
			FROM
				INFORMATION_SCHEMA.COLUMNS
			WHERE
				TABLE_NAME = @TableName
				AND (
						DATA_TYPE LIKE '%char%'
						OR DATA_TYPE LIKE '%text%'
					)
				AND COLLATION_NAME <> @CollationName
			ORDER BY
				ORDINAL_POSITION; 
    
		OPEN MyColumnCursor;
 
		FETCH NEXT FROM MyColumnCursor 
        INTO @TableSchemaName, @ColumnName, @DataType, @CharacterMaxLen, @IsNullable, @OldCollationName;
		WHILE @@FETCH_STATUS = 0
			BEGIN
            
				SET @SQLText = 'ALTER TABLE [' + @TableSchemaName + '].[' + @TableName + '] ALTER COLUMN ['
					+ @ColumnName + '] ' + @DataType + CASE	WHEN (
																	@DataType = 'text'
																	OR @DataType = 'ntext'
																	) THEN ' '
															ELSE '(' + CASE	WHEN @CharacterMaxLen = -1 THEN 'MAX'
																			ELSE @CharacterMaxLen
																		END + ') '
														END + 'COLLATE ' + @CollationName + ' '
					+ CASE	WHEN @IsNullable = 'NO' THEN 'NOT NULL'
							ELSE 'NULL'
						END;
            
				PRINT @SQLText; 
 
				FETCH NEXT FROM MyColumnCursor 
        INTO @TableSchemaName, @ColumnName, @DataType, @CharacterMaxLen, @IsNullable, @OldCollationName;
			END;
		CLOSE MyColumnCursor;
		DEALLOCATE MyColumnCursor;
 
		FETCH NEXT FROM MyTableCursor INTO @TableName;
	END;
CLOSE MyTableCursor;

DEALLOCATE MyTableCursor;
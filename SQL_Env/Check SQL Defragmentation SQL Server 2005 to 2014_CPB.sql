Create table #ProdVer
	(
		ProductVersion varchar(255) Not NULL
	)		
Insert into #ProdVer
	(ProductVersion)
	(select left(cast(SERVERPROPERTY('productversion') as varchar),2))
Go

-- Convert SQL Server version to an integer
Declare @version int
If (select left(cast(SERVERPROPERTY('productversion') as varchar),2)) like '9%'
	Begin
		Set @version = 9
	End
Else
	Begin
		Set @version = (SELECT CONVERT(int, ProductVersion) from #ProdVer)
	End


If @version > 8 and @version <= 10
	BEGIN
		SET DEADLOCK_PRIORITY -10
		set nocount on
		set lock_timeout 100

		DECLARE		
			@nRows			INT,
			@ErrorNumber	INT,
			@ErrorMessage	NVARCHAR(3072),
			@ErrorSeverity	INT,
			@ErrorState		INT,
			@ErrorLine		INT,
			@ErrorProcedure NVARCHAR(126);
	
			BEGIN TRY
			DECLARE @RowLimit			INT		
			DECLARE @PageCount			INT
			DECLARE @MinimumPageCount	INT
			DECLARE @DatabaseName   	sysname

			SET @RowLimit = 50
			SET @PageCount = 1000
			SET @DatabaseName = '%'
			SET @MinimumPageCount = 1000

			-- Create a temp table to hold the fragmentation info

			IF isnull(object_id(N'tempdb..#FragList'),0)<> 0 
			BEGIN
				DROP TABLE #FragList
			END
			CREATE TABLE #FragList 
				(
					IndexName			sysname,		
					DBName				sysname,
					OwnerName			sysname null,
					TableName			sysname,
					PartitionNumber		INT,
					AllocUnitTypeDesc	nvarchar(60),
					Type				NVARCHAR(50),
					TypeEnum			TINYINT,
					Disabled			BIT,
					AvgFragmentation	REAL,
					PageCount			BIGINT
				)


			-- Create a temp table to hold a list of the online, not read only database dbids

			IF isnull(object_id(N'tempdb..#DBList'),0)<> 0 
			BEGIN
				DROP TABLE #DBList
			END
			CREATE TABLE #DBList 
				(
					row INT IDENTITY,
					dbid INT
				)

			INSERT INTO #DBList (dbid)
				select	database_id as dbid from sys.databases  
				where	user_access = 0 
					and name like  @DatabaseName 
					and has_dbaccess(name) <> 0
					and state = 0 
					and is_auto_close_on = 0
					and is_read_only = 0
			SET	@nRows = @@rowcount
	
			-- Build the object and property list.  Don't use all of this but might want to sometime

			DECLARE @sql	nvarchar(4000)
			DECLARE @database_id int
			DECLARE @n int
			SET		@n = 1
			WHILE	@n <= @nRows
			BEGIN
				SELECT @database_id = dbid FROM #DBList WHERE row = @n
				IF @database_id is null
					BREAK
				SET @sql = N'use ' + quotename(db_name(@database_id))
						+ N' INSERT INTO #FragList
						SELECT
						 si.name                          AS IndexName, 
						 DB_NAME(ips.database_id)         AS DBName,
						 sc.name                          AS ownername,
						 OBJECT_NAME(ips.object_id)       AS TableName,
						 ips.partition_number             AS PartitionNumber,
						 ips.alloc_unit_type_desc         AS AllocUnitTypeDesc,  
						 ips.index_type_desc              AS Type,
						 si.type                          AS TypeEnum,
						 si.is_disabled                   AS Disabled,
						 ips.avg_fragmentation_in_percent AS AvgFragmentation,
						 ips.page_count                   AS PageCount
						FROM
						  sys.dm_db_index_physical_stats('+ '    ' + convert(nvarchar(10), @database_id) + N',
							   NULL,   
							   NULL,  
							   NULL,  
							   NULL) ips 
							 LEFT OUTER JOIN sys.indexes si ON ips.object_id = si.object_id 
											AND ips.index_id = si.index_id
							 LEFT OUTER JOIN sys.objects so ON so.object_id = si.object_id  
							 LEFT OUTER JOIN sys.schemas sc on sc.schema_id = so.schema_id
							WHERE 
							 ips.page_count >= ' + convert(nvarchar(10), @MinimumPageCount) + '
							 and si.type <> 0  -- Do not show heaps.
						   ORDER BY 
						   AvgFragmentation DESC' 
  
				BEGIN TRY
  					EXEC(@sql)
				END TRY
				BEGIN CATCH
					SELECT
						@ErrorNumber = ERROR_NUMBER(),
						@ErrorSeverity = ERROR_SEVERITY(),
						@ErrorState = ERROR_STATE(),
						@ErrorLine = ERROR_LINE(),
						@ErrorProcedure = ISNULL(ERROR_PROCEDURE(), '-');

					SELECT 
						@ErrorMessage = N'Error %d, Level %d, State %d, Procedure %s, 
									Line %d, Message: '+ ERROR_MESSAGE();
            
					IF @ErrorNumber != 1205 and @ErrorNumber != 1222
						BEGIN
							SET lock_timeout -1
							IF @ErrorSeverity < 18                
								RAISERROR(@ErrorMessage, @ErrorSeverity, 1, @ErrorNumber, @ErrorSeverity, @ErrorState, @ErrorProcedure,@ErrorLine)
							ELSE
								RAISERROR(@ErrorMessage, @ErrorSeverity, 1, @ErrorNumber, @ErrorSeverity, @ErrorState, @ErrorProcedure,@ErrorLine) WITH LOG
						END
				END CATCH
				SET @n = @n + 1
			END

			-- Select just the runnable sql and the AvgFragmentation for reference from the temp table
			-- This rebuilds the indexes with frag greater than 4%

			SELECT N'ALTER INDEX [' + IndexName + N'] ON [' + DBName + N'].[' + OwnerName + N'].[' + TableName + N'] REBUILD' as [Run Me], AvgFragmentation 
			FROM 
				#FragList 
			WHERE
				AvgFragmentation > 4 
			ORDER BY
				DBName, OwnerName, TableName,
				AvgFragmentation DESC


			DROP TABLE #FragList;
			DROP TABLE #DBList;

			END TRY
			BEGIN CATCH
				SELECT
					@ErrorNumber = ERROR_NUMBER(),
					@ErrorSeverity = ERROR_SEVERITY(),
					@ErrorState = ERROR_STATE(),
					@ErrorLine = ERROR_LINE(),
					@ErrorProcedure = ISNULL(ERROR_PROCEDURE(), '-');

				SELECT @ErrorMessage = N'Error %d, Level %d, State %d, Procedure %s, Line %d, Message: '+ ERROR_MESSAGE();
				IF @ErrorNumber != 1205 and @ErrorNumber != 1222
				BEGIN
					set lock_timeout -1
					if @ErrorSeverity > 18
						RAISERROR(@ErrorMessage, @ErrorSeverity, 1, @ErrorNumber, @ErrorSeverity, @ErrorState, @ErrorProcedure,@ErrorLine) WITH LOG;
					else
						RAISERROR(@ErrorMessage, @ErrorSeverity, 1, @ErrorNumber, @ErrorSeverity, @ErrorState, @ErrorProcedure,@ErrorLine);
				END
			END CATCH

			set lock_timeout -1

	END
Else 
	BEGIN
		If @version >= 11
			SET DEADLOCK_PRIORITY -10
			set nocount on
			set lock_timeout 100

			DECLARE		
				@n1Rows1		INT,
				@FragRows1	INT,	
				@ErrorNumber1	INT,
				@ErrorMessage1	NVARCHAR(3072),
				@ErrorSeverity1	INT,
				@ErrorState1	INT,
				@ErrorLine1	INT,
				@ErrorProcedure1 NVARCHAR(126);
	

			BEGIN TRY

			DECLARE
				@RowLimit1		INT,		
				@PageCount1		INT,
				@MinimumPageCount1	INT,
				@DatabaseName1		sysname

    				SET @RowLimit1 = 50
    				SET @PageCount1 = 1000
    				SET @DatabaseName1 = '%'
				SET @MinimumPageCount1 = 1000
 
			-- Create a temp table to hold the fragmentation info

			IF isnull(object_id(N'tempdb..#FragList'),0)<> 0 
			BEGIN
				DROP TABLE #FragList
			END

			CREATE TABLE #FragList1 (
						IndexName				sysname,		
						DBName					sysname,
						OwnerName				sysname null,
						TableName				sysname,
						PartitionNumber				INT,
						AllocUnitTypeDesc			nvarchar(60),
						Type					NVARCHAR(50),
						TypeEnum				TINYINT,
						Disabled				BIT,
						AvgFragmentation			REAL,
						PageCount				BIGINT
			)


			-- Create a temp table to hold a list of the online, not read only database dbids

			IF isnull(object_id(N'tempdb..#DBList'),0)<> 0 
			BEGIN
				DROP TABLE #DBList1
			END

			CREATE TABLE #DBList1 (
					row INT IDENTITY,
					dbid INT
				)

				INSERT INTO  #DBList1 (dbid)
					select d.database_id as dbid from sys.databases d
					left join sys.dm_hadr_database_replica_states drs on d.database_id=drs.database_id
					left join sys.dm_hadr_availability_replica_states ars on drs.replica_id=ars.replica_id
						where d.user_access = 0 
						and d.name like  @DatabaseName1 
						and has_dbaccess(d.name) <> 0
						and d.state = 0 and d.is_auto_close_on = 0
						and (ars.role is null or ars.role=1) --SECONDARY
						and d.is_read_only = 0
					SET	@n1Rows1 = @@rowcount


			-- Build the object and property list.  Don't use all of this but might want to sometime
	
			DECLARE @sq1l	nvarchar(4000)
			DECLARE @database_id1 int
			DECLARE @n1 int
			SET		@n1 = 1
			WHILE	@n1 <= @n1Rows1
			BEGIN
				SELECT @database_id1 = dbid FROM #DBList1 WHERE row = @n1
				IF @database_id1 is null
					BREAK
				SET @sq1l = N'use ' + quotename(db_name(@database_id1))
						+ N' INSERT INTO #FragList1
						SELECT TOP ' + convert(nvarchar(10), @RowLimit1)  + N'  si.name AS IndexName, 
							DB_NAME(ips.database_id)         AS DBName,
							sc.name                          AS ownername,
							OBJECT_NAME(ips.object_id)       AS TableName,
							ips.partition_number             AS PartitionNumber,
							ips.alloc_unit_type_desc         AS AllocUnitTypeDesc,  
							ips.index_type_desc              AS Type,
							si.type                          AS TypeEnum,
							si.is_disabled                   AS Disabled,
							ips.avg_fragmentation_in_percent AS AvgFragmentation,
							ips.page_count                   AS PageCount
						FROM
							sys.dm_db_index_physical_stats('
						+ '    ' + convert(nvarchar(10), @database_id1) + N',
								NULL,   
								NULL,  
								NULL,  
								NULL) ips 
								LEFT OUTER JOIN sys.indexes si ON ips.object_id = si.object_id 
											AND ips.index_id = si.index_id
								LEFT OUTER JOIN sys.objects so ON so.object_id = si.object_id  
								LEFT OUTER JOIN sys.schemas sc on sc.schema_id = so.schema_id
							WHERE 
								ips.page_count >= ' + convert(nvarchar(10), @MinimumPageCount1) + '
								and si.type <> 0  -- Do not show heaps.
							ORDER BY 
							AvgFragmentation DESC' 
  
				BEGIN TRY
					EXEC(@sq1l)
				END TRY
				BEGIN CATCH
					SELECT
						@ErrorNumber1 = ERROR_NUMBER(),
						@ErrorSeverity1 = ERROR_SEVERITY(),
						@ErrorState1 = ERROR_STATE(),
						@ErrorLine1 = ERROR_LINE(),
						@ErrorProcedure1 = ISNULL(ERROR_PROCEDURE(), '-');

					SELECT 
						@ErrorMessage1 = N'Error %d, Level %d, State %d, Procedure %s, 
									Line %d, Message: '+ ERROR_MESSAGE();
            
					IF @ErrorNumber1 != 1205 and @ErrorNumber1 != 1222
						BEGIN
							SET lock_timeout -1
							IF @ErrorSeverity1 < 18                
								RAISERROR(@ErrorMessage1, @ErrorSeverity1, 1, @ErrorNumber1, @ErrorSeverity1, @ErrorState1, @ErrorProcedure1,@ErrorLine1)
							ELSE
								RAISERROR(@ErrorMessage1, @ErrorSeverity1, 1, @ErrorNumber1, @ErrorSeverity1, @ErrorState1, @ErrorProcedure1,@ErrorLine1) WITH LOG
						END
				END CATCH
				SET @FragRows1 = @@rowcount
				SET @n1 = @n1 + 1
			END

			-- Select just the runnable sql and the AvgFragmentation for reference from the temp table
			-- This rebuilds the indexes with frag greater than 4%

			SELECT N'ALTER INDEX [' + IndexName + N'] ON [' + DBName + N'].[' + OwnerName + N'].[' + TableName + N'] REBUILD' as [Run Me], AvgFragmentation 

			FROM 
				#FragList1
			WHERE
				AvgFragmentation > 4 
			ORDER BY
				DBName, OwnerName, TableName,
				AvgFragmentation DESC

				DROP TABLE #FragList1;
				DROP TABLE #DBList1;

			END TRY
			BEGIN CATCH
				SELECT
					@ErrorNumber1 = ERROR_NUMBER(),
					@ErrorSeverity1 = ERROR_SEVERITY(),
					@ErrorState1 = ERROR_STATE(),
					@ErrorLine1 = ERROR_LINE(),
					@ErrorProcedure1 = ISNULL(ERROR_PROCEDURE(), '-');

				SELECT @ErrorMessage1 = N'Error %d, Level %d, State %d, Procedure %s, Line %d, Message: '+ ERROR_MESSAGE();
				IF @ErrorNumber1 != 1205 and @ErrorNumber1 != 1222
				BEGIN
					set lock_timeout -1
					if @ErrorSeverity1 > 18
						RAISERROR(@ErrorMessage1, @ErrorSeverity1, 1, @ErrorNumber1, @ErrorSeverity1, @ErrorState1, @ErrorProcedure1,@ErrorLine1) WITH LOG;
					else
						RAISERROR(@ErrorMessage1, @ErrorSeverity1, 1, @ErrorNumber1, @ErrorSeverity1, @ErrorState1, @ErrorProcedure1,@ErrorLine1);
				END
			END CATCH

			set lock_timeout -1
	END;
	
Drop Table #ProdVer;



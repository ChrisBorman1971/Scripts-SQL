SET NOCOUNT ON
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (select 1 from sys.tables where name = 'ViewRowCounts')
DROP TABLE dbo.ViewRowCounts

CREATE TABLE [dbo].[ViewRowCounts](
	[SchemaName] [nchar](10) NULL,
	[ViewName] [nchar](50) NULL,
	[TotalRowCount] [int] NULL
) ON [PRIMARY]
GO
declare @sql nvarchar(max) = ''
SET NOCOUNT ON
select @sql = @sql + ' INSERT INTO dbo. ViewRowCounts select ' + 
    '''' + TABLE_SCHEMA + ''' as SchemaName, ' + 
    '''' + TABLE_NAME + ''' as ViewName, ' + 
    '(select count(*) from ' + TABLE_NAME + ') as [TotalRowCount]' + 
    char(13) + char(10) 
from INFORMATION_SCHEMA.VIEWS

DECLARE @ParmDefinition     NVARCHAR(MAX);-- remove leading "union all"
--set @sql = right(@sql, len(@sql)-len('union all '))

--print @sql    -- to check what's going to be executed
--INSERT into dbo.ViewRowCounts execute ('execute ' + @sql)

exec sp_executesql @sql, @ParmDefinition
SELECT * FROM dbo.ViewRowCounts
DROP TABLE dbo.ViewRowCounts

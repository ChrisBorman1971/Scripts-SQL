-- FindDiskUsageByTables.sql     rm    04/09/15
--
-- was DiskUsageByTopTables.sql
-- is also GetDiskUsageByTables.sql
--
-- You asked: How can I get a report similar to the Standard SS report
-- But ordered another way?
--
-- And we said:

CREATE TABLE ##TableSizes 
 (name sysname, 
  rows varchar(16), 
  reserved varchar(16), 
  data varchar(16), 
  index_size varchar(16),
  unused varchar(16)) 

INSERT ##TableSizes 
  EXEC sp_MSforeachtable @command1= "EXEC sp_spaceused '?'" 

update ##TableSizes set	
  Reserved = replace(reserved,'kb',''),
  index_size = replace(index_size,'kb',''),
  data = replace(data,'kb',''),
  unused = replace(unused,'kb','')

CREATE TABLE ##TableSizes2 
 (name sysname,
  rows bigint, 
  reserved bigint,
  data bigint,
  index_size bigint,
  unused bigint) 

INSERT INTO ##TableSizes2 
  select * from  ##TableSizes

SELECT TOP (1000) 
  name AS [Table Name],
  rows AS [# Records], 
  reserved AS [Reserved (Kb)],
  data AS [Data (Kb)],
  index_size AS [Indexes (Kb)],
  unused AS [Unused (Kb)] 
FROM ##TableSizes2 
ORDER BY reserved desc

drop table ##TableSizes
drop table ##TableSizes2
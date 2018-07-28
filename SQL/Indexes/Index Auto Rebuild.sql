---Auto rebuild or reorganize Indexes based on Fragmentation

----------------------------

--Step 1
	--#Create Table
USE Prod 
CREATE TABLE  --drop table
##FragIndexes
(
	DatabaseName		SYSNAME NULL
	,SchemaName		SYSNAME NULL
	,TableName			SYSNAME NULL
	,IndexName			SYSNAME NULL
	,[Fragmentation%]	FLOAT NULL
	,record_count		INT NULL
	,page_count			INT NULL
)
---------------------------

--Step 2
	--Insert Index Info into Table
INSERT INTO ##FragIndexes

SELECT
 DB_NAME(DB_ID()) AS DatabaseName
 ,ss.name AS SchemaName
 ,OBJECT_NAME (s.object_id) AS TableName
 ,i.name AS IndexName
 ,s.avg_fragmentation_in_percent AS [Fragmentation%]
 ,s.record_count
 ,s.page_count
FROM sys.dm_db_index_physical_stats(db_id(),NULL, NULL, NULL, 'SAMPLED') s
INNER JOIN sys.indexes i ON s.[object_id] = i.[object_id]
	AND s.index_id = i.index_id
	and i.[name] is not null
INNER JOIN sys.objects o ON s.object_id = o.object_id
INNER JOIN sys.schemas ss ON ss.[schema_id] = o.[schema_id]
	--and ss.[name] = 'dbo'
WHERE s.database_id = DB_ID()
--AND s.record_count > 0
AND s.page_count > 500

------------------------
--Step 3 Check table out
--/*
select *
from ##FragIndexes

--*/
-----------------

--Step 4
	--Build Query String based on the fragmentation of indexes to rebuild or reorganize
DECLARE @TableIndexes NVARCHAR(MAX)
SET @TableIndexes = ''
SELECT
 @TableIndexes = @TableIndexes +
CASE
 WHEN [Fragmentation%] > 35
   THEN CHAR(10) + 'ALTER INDEX ' + QUOTENAME(IndexName) + ' ON '
      + QUOTENAME(SchemaName) + '.'
      + QUOTENAME(TableName) + ' REBUILD;'
 WHEN [Fragmentation%] > 5
    THEN CHAR(10) + 'ALTER INDEX ' + QUOTENAME(IndexName) + ' ON '
    + QUOTENAME(SchemaName) + '.'
    + QUOTENAME(TableName) + ' REORGANIZE;'
END
FROM ##FragIndexes
WHERE [Fragmentation%] > 5
----------------

--Step 5
	
	--Set a length for the query and to be used in large data warehouses
DECLARE @StartOffset INT
DECLARE @Length INT
SET @StartOffset = 0
SET @Length = 4000
WHILE (@StartOffset < LEN(@TableIndexes))
BEGIN
 PRINT SUBSTRING(@TableIndexes, @StartOffset, @Length)
 SET @StartOffset = @StartOffset + @Length
END
PRINT SUBSTRING(@TableIndexes, @StartOffset, @Length)
-----------------------

--Select @TableIndexes


--Step 6

	--Execute Index Query
EXECUTE sp_executesql @TableIndexes
----------------------

--Step 7
	--Clean up
DROP TABLE ##FragIndexes



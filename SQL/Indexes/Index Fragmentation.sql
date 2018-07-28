USE Prod --database choice
Select
		dbschemas.[name] as [Schema],
		dbtables.[name] as [Table],
		dbindexes.[name] as [Index],
		indexstats.avg_fragmentation_in_percent,
		indexstats.page_count
from sys.dm_db_index_physical_stats (DB_ID(), NULL,NULL,NULL,NULL) as indexstats
join sys.tables dbtables on dbtables.[object_id] = indexstats.[object_id]
join sys.schemas dbschemas on dbtables.[schema_id] = dbschemas.[schema_id]
	--and dbschemas.[name] = 'dbo'
join sys.indexes as dbindexes on dbindexes.[object_id] = indexstats.[object_id]
	and indexstats.index_id = dbindexes.index_id
	and dbindexes.[name] is not null
where indexstats.database_id = DB_ID()
	and indexstats.page_count > 500
order by indexstats.avg_fragmentation_in_percent desc
SELECT 
		DB_NAME(DB_ID()) AS DatabaseName,
		ss.name AS SchemaName,
		T.name AS [TABLE NAME], 
		I.rows AS [ROWCOUNT] 

FROM   sys.tables AS T 
INNER JOIN sys.sysindexes AS I ON T.object_id = I.id 
	AND I.indid < 2 
INNER JOIN sys.objects o ON t.object_id = o.object_id
INNER JOIN sys.schemas ss ON ss.[schema_id] = o.[schema_id]
	and ss.[name] = 'dbo'
ORDER  BY I.rows DESC 
SELECT 
		T.name AS [TABLE NAME], 
		I.rows AS [ROWCOUNT] 
FROM   sys.tables AS T 
INNER JOIN sys.sysindexes AS I ON T.object_id = I.id 
	AND I.indid < 2 

ORDER  BY I.rows DESC 
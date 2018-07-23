--https://github.com/Microsoft/sql-server-samples/releases/tag/adventureworks

--Find where the backed up database is located after downloading from MIcrosoft Github
--Run below query and write down the Logical Names
restore FILELISTONLY
FROM Disk = 'E:\Test Database\AdventureWorks2016.bak'
GO

Declare @DataLogicalName varchar(50) = 'AdventureWorks2016_Data' --from logical name
Declare @LogLogicalName varchar(50) = 'AdventureWorks2016_Log' --from logical name

RESTORE DATABASE AdventureWorks2016  
FROM DISK = 'E:\Test Database\AdventureWorks2016.bak'  
WITH MOVE @DataLogicalName TO 'E:\Microsoft SQL Server 2016\MSSQL13.SQLEXPRESS\MSSQL\Backup\AdventureWorks2016_Data.mdf',  
MOVE @LogLogicalName TO 'E:\Microsoft SQL Server 2016\MSSQL13.SQLEXPRESS\MSSQL\Backup\AdventureWorks2016_Log.ldf' 
library(RODBC)

odbcChannel <- odbcConnect("[ODBC Connection Name]")

#Option 2  - Pull Query
Query <- sqlQuery(odbcChannel, "select top 100 * from [database].schema.[table]")
Query
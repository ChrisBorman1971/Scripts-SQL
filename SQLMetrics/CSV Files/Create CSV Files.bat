sqlcmd -S localhost -d AdventureWorksDW2008R2 -i "C:\Scripts\BufferPoolUsageByDB.sql" -o "1.csv"  -s"," -w 7000
sqlcmd -S localhost -d AdventureWorksDW2008R2 -i "C:\Scripts\CheckBlockingQueries.sql" -o "2.csv"  -s"," -w 7000
sqlcmd -S localhost -d AdventureWorksDW2008R2 -i "C:\Scripts\CheckIndexFragmentation.sql" -o "3.csv"  -s"," -w 7000
sqlcmd -S localhost -d AdventureWorksDW2008R2 -i "C:\Scripts\CPUUsageByDB.sql" -o "4.csv"  -s"," -w 7000
sqlcmd -S localhost -d AdventureWorksDW2008R2 -i "C:\Scripts\DiskIOByDatabase.sq"l -o "5.csv"  -s"," -w 7000
sqlcmd -S localhost -d AdventureWorksDW2008R2 -i "C:\Scripts\DiskSpaceByDatabase.sql" -o "6.csv"  -s"," -w 7000
sqlcmd -S localhost -d AdventureWorksDW2008R2 -i "C:\Scripts\FixedDrivesOnServer.sql" -o "7.csv"  -s"," -w 7000
sqlcmd -S localhost -d AdventureWorksDW2008R2 -i "C:\Scripts\GetDBSizes.sql" -o "8.csv"  -s"," -w 7000
sqlcmd -S localhost -d AdventureWorksDW2008R2 -i "C:\Scripts\HardwareInfo.sql" -o "9.csv"  -s"," -w 7000
sqlcmd -S localhost -d AdventureWorksDW2008R2 -i "C:\Scripts\LastBackupByDatabase.sql" -o "10.csv"  -s"," -w 7000
sqlcmd -S localhost -d AdventureWorksDW2008R2 -i "C:\Scripts\OverallLatency.sql" -o "11.csv"  -s"," -w 7000
sqlcmd -S localhost -d AdventureWorksDW2008R2 -i "C:\Scripts\QueriesAcrossInstance.sql" -o "12.csv"  -s"," -w 7000
sqlcmd -S localhost -d AdventureWorksDW2008R2 -i "C:\Scripts\ServerCPUUtilization.sql" -o "13.csv"  -s"," -w 7000
sqlcmd -S localhost -d AdventureWorksDW2008R2 -i "C:\Scripts\ServerMemory.sql" -o "14.csv"  -s"," -w 7000
sqlcmd -S localhost -d AdventureWorksDW2008R2 -i "C:\Scripts\SPsByCPU.sql" -o "15.csv"  -s"," -w 7000
sqlcmd -S localhost -d AdventureWorksDW2008R2 -i "C:\Scripts\SQLConnections.sql" -o "16.csv"  -s"," -w 7000
sqlcmd -S localhost -d AdventureWorksDW2008R2 -i "C:\Scripts\TableRowCounts.sql" -o "17.csv"  -s"," -w 7000
sqlcmd -S localhost -d AdventureWorksDW2008R2 -i "C:\Scripts\ViewRowCounts.sql" -o "18.csv"  -s"," -w 7000
sqlcmd -S localhost -d AdventureWorksDW2008R2 -i "C:\Scripts\TableViewDataTypes.sql" -o "19.csv"  -s"," -w 7000
sqlcmd -S localhost -d AdventureWorksDW2008R2 -i "C:\Scripts\ServerInfo.sql" -o "20.csv"  -s"," -w 7000

findstr /v /c:"---" "c:\scripts\csv files\1.csv" > "c:\scripts\csv files\BufferPoolUsage.csv"
del "c:\scripts\csv files\1.csv" 

findstr /v /c:"---" "c:\scripts\csv files\2.csv" > "c:\scripts\csv files\CheckBlockingQueries.csv"
del "c:\scripts\csv files\2.csv" 

findstr /v /c:"---" "c:\scripts\csv files\3.csv" > "c:\scripts\csv files\CheckIndexFragmentation.csv" 
del "c:\scripts\csv files\3.csv" 

findstr /v /c:"---" "c:\scripts\csv files\4.csv" > "c:\scripts\csv files\CPUUsageByDB.csv" 
del "c:\scripts\csv files\4.csv" 

findstr /v /c:"---" "c:\scripts\csv files\5.csv" > "c:\scripts\csv files\DiskIOByDatabase.csv"
del "c:\scripts\csv files\5.csv" 

findstr /v /c:"---" "c:\scripts\csv files\6.csv" > "c:\scripts\csv files\DiskSpaceByDatabase.csv" 
del "c:\scripts\csv files\6.csv" 

findstr /v /c:"---" "c:\scripts\csv files\7.csv" > "c:\scripts\csv files\FixedDrivesOnServer.csv" 
del "c:\scripts\csv files\7.csv" 

findstr /v /c:"---" "c:\scripts\csv files\8.csv" > "c:\scripts\csvcsv files\GetDBSizes.csv" 
del "c:\scripts\csv files\8.csv" 

findstr /v /c:"---" "c:\scripts\csv files\9.csv" > "c:\scripts\csv files\HardwareInfo.csv" 
del "c:\scripts\csv files\9.csv" 

findstr /v /c:"---" "c:\scripts\csv files\10.csv" > "c:\scripts\csv files\LastBackupByDatabase.csv" 
del "c:\scripts\csv files\10.csv" 

findstr /v /c:"---" "c:\scripts\csv files\11.csv" > "c:\scripts\csv files\OverallLatency.csv" 
del "c:\scripts\csv files\11.csv" 

findstr /v /c:"---" "c:\scripts\csv files\12.csv" > "c:\scripts\csv files\QueriesAcrossInstance.csv" 
del "c:\scripts\csv files\12.csv" 

findstr /v /c:"---" "c:\scripts\csv files\13.csv" > "c:\scripts\csv files\ServerCPUUtilization.csv" 
del "c:\scripts\csv files\13.csv" 

findstr /v /c:"---" "c:\scripts\csv files\14.csv" > "c:\scripts\csv files\ServerMemory.csv" 
del "c:\scripts\csv files\14.csv" 

findstr /v /c:"---" "c:\scripts\csv files\15.csv" > "c:\scripts\csv files\SPsByCPU.csv" 
del "c:\scripts\csv files\15.csv" 

findstr /v /c:"---" "c:\scripts\csv files\16.csv" > "c:\scripts\csv files\SQLConnections.csv" 
del "c:\scripts\csv files\16.csv" 

findstr /v /c:"---" "c:\scripts\csv files\17.csv" > "c:\scripts\csv files\TableRowCounts.csv" 
del "c:\scripts\csv files\17.csv" 


findstr /v /c:"---" "c:\scripts\csv files\18.csv" > "c:\scripts\csv files\ViewRowCounts.csv" 
del "c:\scripts\csv files\18.csv" 


findstr /v /c:"---" "c:\scripts\csv files\19.csv" > "c:\scripts\csv files\TableViewDataTypes.csv" 
del "c:\scripts\csv files\19.csv" 


findstr /v /c:"---" "c:\scripts\csv files\20.csv" > "c:\scripts\csv files\ServerInfo.csv" 
del "c:\scripts\csv files\20.csv" 










\

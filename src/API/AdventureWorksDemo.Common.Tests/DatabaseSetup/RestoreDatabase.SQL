
USE [master];
RESTORE DATABASE [$TARGET_DB_NAME] FROM DISK = N'/var/opt/mssql/backup/$BackupFileName' WITH  FILE = 1,  
      MOVE N'AdventureWorks2022' TO N'/var/opt/mssql/data/$TARGET_DB_NAME.mdf',  
      MOVE N'AdventureWorks2022_Log' TO N'/var/opt/mssql/data/$TARGET_DB_NAME_log.ldf',  
      NOUNLOAD,  
      STATS = 5
      ;

USE [master];
RESTORE DATABASE [$TARGET_DB_NAME] FROM DISK = N'/var/opt/mssql/backup/$BackupFileName' WITH  FILE = 1,  
      MOVE N'AdventureWorksLT2022_Data' TO N'/var/opt/mssql/data/"$TARGET_DB_NAME".mdf',  
      MOVE N'AdventureWorksLT2022_Log' TO N'/var/opt/mssql/data/"$TARGET_DB_NAME"_log.ldf',  
      NOUNLOAD,  
      STATS = 5
      ;
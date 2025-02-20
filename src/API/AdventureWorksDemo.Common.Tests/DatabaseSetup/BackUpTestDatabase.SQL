BACKUP DATABASE [$TARGET_DB_NAME] TO  DISK = N'/var/opt/mssql/backup/$BackupFileName' WITH NOFORMAT, INIT,  
										NAME = N'AdventureWorks-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

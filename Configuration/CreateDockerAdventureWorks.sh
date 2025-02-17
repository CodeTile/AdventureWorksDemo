#!/bin/bash
# 

SA_PASSWORD="<MyStrongPassword0987>"
CONTAINER_NAME=sqladventureworks
LOCAL_BACKUP_FOLDER="$(PWD)/backup"
TARGET_DB_NAME="AdventureWorks"

mkdir $LOCAL_BACKUP_FOLDER

clear

   echo "Download AdventureWorks Lite backup file"
   curl -L -o $LOCAL_BACKUP_FOLDER/AdventureWorks.bak 'https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorks2022.bak'

echo "pull"
docker pull mcr.microsoft.com/mssql/server
###
echo "Delete existing containters"
docker stop $CONTAINER_NAME || true && docker rm $CONTAINER_NAME || true
###
echo "Create & Start container"
docker run -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=$SA_PASSWORD" \
   -e 'TZ= Europe/London' \
   -p 1433:1433 --name $CONTAINER_NAME --hostname $CONTAINER_NAME \
   --mount type=bind,source=$LOCAL_BACKUP_FOLDER,target=/var/opt/mssql/backup \
   -d \
   mcr.microsoft.com/mssql/server
###
 echo  "

Open up SSMS and connect to your newly created database server.


/*
 ---------------------------------------------------------------
   Server name    : localhost,1433
   Authentication : SQL server Authentication
   Login          : SA
   Password       : "$SA_PASSWORD"
 ---------------------------------------------------------------
 

Open a new query window and restore the database using the query below
 ---------------------------------------------------------------
*/
USE [master]
	RESTORE DATABASE AdventureWorks 
		FROM  DISK = N'/var/opt/mssql/backup/AdventureWorks.bak' WITH  FILE = 1,  
		MOVE N'AdventureWorks2022' TO N'/var/opt/mssql/data/AdventureWorks.mdf',  
		MOVE N'AdventureWorks2022_log' TO N'/var/opt/mssql/data/AdventureWorks_log.ldf', 
		NOUNLOAD,  
		REPLACE,  
		STATS = 5


GO

 ---------------------------------------------------------------
 
 "
#   
read -p "Press enter to close"   

/*

	This script is to be used to select data for the test database

	Run this scipt to :-
		Step A:  Restore the database
		Step B:  Delete data that are not the first 7 customers with less than 10 salesDetails records per order.
	Manual steps in SSMS
		Step 1: Script the database data only.
		Step 2: Replace data inserts in the script 'PrepareTalbesForTestingAdventureWorks.SQL' with the output of step 1.
*/


USE [master]
ALTER DATABASE [AdventureWorks] SET  SINGLE_USER WITH ROLLBACK IMMEDIATE
GO
USE [master]
GO
/****** Object:  Database [AdventureWorks]    Script Date: 07/05/2024 16:39:18 ******/
DROP DATABASE [AdventureWorks]

USE [master]
RESTORE DATABASE [AdventureWorks] FROM DISK = N'/var/opt/mssql/backup/AdventureWorks.bak' WITH  FILE = 1,
      MOVE N'AdventureWorks2022' TO N'/var/opt/mssql/data/AdventureWorks.mdf',
      MOVE N'AdventureWorks2022_Log' TO N'/var/opt/mssql/data/AdventureWorks_log.ldf',
      NOUNLOAD,
      STATS = 5

GO

print 'Find Customers to keep';
declare @Customers as table(customerId int);
insert  Into @Customers
	select top 7  max(CustomerID) CustomerId
	
	from [AdventureWorks].[SalesLT].[SalesOrderDetail] [d]
	Inner Join [AdventureWorks].[SalesLT].[SalesOrderHeader] [h] on h.SalesOrderID= d.SalesOrderID
	GROUP by d.SalesOrderID
	Having count([d].salesOrderDetailId) <10

-- -- --
PRINT 'Delete From [AdventureWorks].[SalesLT].[SalesOrderHeader]';
DELETE  
	-- select *
	from [AdventureWorks].[SalesLT].[SalesOrderHeader] where CustomerID not in (select CustomerId from @Customers);
-- -- --
--------PRINT 'Delete From [AdventureWorks].[SalesLT].[SalesOrderDetail]';
--------DELETE  
--------	-- select *
--------	from [AdventureWorks].[SalesLT].[SalesOrderDetail] where SalesOrderID not in (select SalesOrderID from [AdventureWorks].[SalesLT].[SalesOrderHeader]);
-- -- --
PRINT 'Delete From [AdventureWorks].[SalesLT].[CustomerAddress]';
DELETE  
	-- select *
	from [AdventureWorks].[SalesLT].[CustomerAddress] where CustomerID not in (select CustomerId from @Customers);
-- -- --
PRINT 'Delete From [AdventureWorks].[SalesLT].[Address]';
DELETE 
	-- select *
	from [AdventureWorks].[SalesLT].[Customer] where CustomerID not in (select CustomerId from @Customers);
-- -- --
PRINT 'Delete From [AdventureWorks].[SalesLT].[Customer]';
DELETE
	-- select *
	from [AdventureWorks].[SalesLT].[Address] where AddressID not in (select AddressID from [AdventureWorks].[SalesLT].[CustomerAddress])
-- -- --
PRINT 'Delete From [AdventureWorks].[SalesLT].[Product]';
DELETE
	-- select *
	FROM [AdventureWorks].[SalesLT].[Product] where productId in 
	(select top 99 percent productId from [AdventureWorks].[SalesLT].[Product] where ProductId not in (select ProductId from [AdventureWorks].[SalesLT].[SalesOrderDetail]) order by ProductId)


-- -- --
PRINT 'Delete From [AdventureWorks].[SalesLT].[ProductModelProductDescription]';
DELETE
	-- select *
	FROM [AdventureWorks].[SalesLT].[ProductModelProductDescription] where productModelId Not in (select productModelId from [AdventureWorks].[SalesLT].[Product] )
																		   or [Culture] not in ('en','fr');
-- -- --
PRINT 'Delete From [AdventureWorks].[SalesLT].[ProductDescription]';
DELETE
	-- select *
	FROM [AdventureWorks].[SalesLT].[ProductDescription] where [ProductDescriptionID] Not in (select [ProductDescriptionID] from [AdventureWorks].[SalesLT].[ProductModelProductDescription] )
-- -- --
PRINT 'Delete From [AdventureWorks].[SalesLT].[ProductModel]';
DELETE
	-- select *
	FROM [AdventureWorks].[SalesLT].[ProductModel] where productModelId Not in (select productModelId from [AdventureWorks].[SalesLT].[Product] )
-- -- --
PRINT 'Delete From [AdventureWorks].[SalesLT].[ProductCategory]';
DELETE
	-- select *
	FROM [AdventureWorks].[SalesLT].[ProductCategory] where ProductCategoryID Not in (select ProductCategoryID from [AdventureWorks].[SalesLT].[Product] )
														   AND  ParentProductCategoryID = null

GO

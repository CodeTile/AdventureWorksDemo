

--USE [master]
--ALTER DATABASE [AdventureWorks] SET  SINGLE_USER WITH ROLLBACK IMMEDIATE
--GO
--USE [master]];
--RESTORE DATABASE [AdventureWorks] FROM DISK = N'/var/opt/mssql/backup/adventureworks.bak' WITH  FILE = 1,
--      MOVE N'AdventureWorks2022' TO N'/var/opt/mssql/data/"$TARGET_DB_NAME".mdf',
--      MOVE N'AdventureWorks2022_Log' TO N'/var/opt/mssql/data/"$TARGET_DB_NAME"_log.ldf',
--      NOUNLOAD,
--      STATS = 5
--      ];
--	  go
--Use [AdventureWorks]

--================================================================================================================
--================================================================================================================
--================================================================================================================

use [$TARGET_DB_NAME];
GO
PRINT '
*****************************************
    Delete all records in database
*****************************************'
GO
DISABLE TRIGGER ALL ON HumanResources.Employee;
DISABLE TRIGGER ALL ON Purchasing.Vendor;
GO

-- Disable all the constraint in database

DECLARE @sql nvarchar(max) = N'';

;WITH x AS 
(
  SELECT DISTINCT obj = 
      QUOTENAME(OBJECT_SCHEMA_NAME(parent_object_id)) + '.' 
    + QUOTENAME(OBJECT_NAME(parent_object_id)) 
  FROM sys.foreign_keys
)
SELECT @sql += N'ALTER TABLE ' + obj + N' NOCHECK CONSTRAINT ALL;
' FROM x;

EXEC sys.sp_executesql @sql;
GO

use [$TARGET_DB_NAME];
GO
-- -----
DELETE FROM [Sales].[SalesOrderHeader];
DELETE FROM [Sales].[Customer];
DELETE FROM [Production].[ProductModelProductDescriptionCulture];
DELETE FROM [Purchasing].[ProductVendor];
DELETE FROM [HumanResources].[EmployeeDepartmentHistory];
DELETE FROM [Person].[BusinessEntityAddress];
DELETE FROM [Person].[BusinessEntityContact];
 GO
DELETE FROM [Person].[PersonPhone];
 GO
DELETE FROM [Production].[ProductDocument];
DELETE FROM [Production].[ProductInventory];
DELETE FROM [Production].[ProductModelIllustration];
DELETE FROM [Sales].[CountryRegionCurrency];
DELETE FROM [Purchasing].[PurchaseOrderDetail];
DELETE FROM [Production].[WorkOrderRouting];
DELETE FROM [Production].[ProductProductPhoto];
DELETE FROM [Production].[WorkOrder];
DELETE FROM [Sales].[PersonCreditCard];
DELETE FROM [Sales].[SalesOrderDetail];
DELETE FROM [Sales].[SalesOrderHeaderSalesReason];
 GO
DELETE FROM [Sales].[SalesTerritoryHistory];
GO
DELETE FROM [Sales].[SpecialOfferProduct];
GO
DELETE FROM [Sales].[Store];
DELETE FROM [Sales].[ShoppingCartItem];
 GO
DELETE FROM [Sales].[SalesTaxRate];
DELETE FROM [Sales].[SalesPersonQuotaHistory];
 GO
DELETE FROM [Sales].[SalesPerson];
DELETE FROM [Sales].[CurrencyRate];
DELETE FROM [Production].[ProductReview];
 GO
DELETE FROM [Production].[TransactionHistory];
 GO
DELETE FROM [Production].[ProductCostHistory];
 GO
DELETE FROM [Production].[ProductListPriceHistory];
 GO
DELETE FROM [Production].[Document];
 GO
DELETE FROM [Person].[Address];
DELETE FROM [Person].[StateProvince];
DELETE FROM [Sales].[SalesTerritory];
 GO
DELETE FROM [Person].[EmailAddress];
 GO
DELETE FROM [Person].[Password];
 GO
DELETE FROM [HumanResources].[EmployeePayHistory];
 GO
DELETE FROM [HumanResources].[JobCandidate];
DELETE FROM [HumanResources].[Shift];
DELETE FROM [dbo].[AWBuildVersion];
DELETE FROM [dbo].[DatabaseLog];
DELETE FROM [dbo].[ErrorLog];
DELETE FROM [HumanResources].[Department];
 GO
DELETE FROM [Person].[AddressType];
DELETE FROM [Person].[ContactType];
DELETE FROM [Person].[CountryRegion];
DELETE FROM [Production].[Illustration];
 GO
DELETE FROM [Production].[Location];
 GO
DELETE FROM [Production].[Culture];
 GO
DELETE FROM [Person].[PhoneNumberType];
 GO
DELETE FROM [Production].[ProductDescription];
 GO
DELETE FROM [Production].[TransactionHistoryArchive];
 GO
DELETE FROM [Production].[ProductPhoto];
 GO
DELETE FROM [Production].[ScrapReason];
DELETE FROM [Sales].[CreditCard];
 GO
DELETE FROM [Sales].[Currency];
DELETE FROM [Sales].[SalesReason];
 GO
DELETE FROM [Sales].[SpecialOffer];
 GO

DELETE FROM [Production].[BillOfMaterials];
 GO
DELETE FROM [Purchasing].[PurchaseOrderHeader];
 GO
DELETE FROM [HumanResources].[Employee];
GO
DELETE FROM [Person].[Person];
GO
DELETE FROM [Purchasing].[Vendor];
GO
DELETE FROM [Person].[BusinessEntity];
GO
DELETE FROM [Purchasing].[ShipMethod];
DELETE FROM [Production].[Product];
DELETE FROM [Production].[ProductSubcategory];
DELETE FROM [Production].[ProductCategory];
DELETE FROM [Production].[ProductModel];
DELETE FROM [Production].[UnitMeasure];
GO




-------

DECLARE @sql nvarchar(max) = N'';

;WITH x AS 
(
  SELECT DISTINCT obj = 
      QUOTENAME(OBJECT_SCHEMA_NAME(parent_object_id)) + '.' 
    + QUOTENAME(OBJECT_NAME(parent_object_id)) 
  FROM sys.foreign_keys
)
SELECT @sql += N'ALTER TABLE ' + obj + N' WITH CHECK CHECK CONSTRAINT ALL;
' FROM x;

EXEC sys.sp_executesql @sql;

GO

Enable TRIGGER ALL ON Purchasing.Vendor;
Enable TRIGGER ALL ON HumanResources.Employee;

GO
--================================================================================================================
--================================================================================================================
--================================================================================================================

PRINT '---------------------------
   Insert records into database.
---------------------------'
SET IDENTITY_INSERT [Person].[AddressType] ON ;
Insert INTO [Person].[AddressType] ([AddressTypeID],[Name],[rowguid],[ModifiedDate])
					VALUES    (1,'Billing',					'00000001-0000-0000-0000-000000000000','1 May 2007')
							, (2,'Home',					'00000002-0000-0000-0000-000000000000','1 May 2007')
							, (3,'Main Office',				'00000003-0000-0000-0000-000000000000','1 May 2007')
							, (4,'Primary',					'00000004-0000-0000-0000-000000000000','1 May 2007')
							, (5,'Shipping',				'00000005-0000-0000-0000-000000000000','1 May 2007')
							, (6,'Archive',					'00000006-0000-0000-0000-000000000000','1 May 2007')
							, (7,'For Delete Tests Only',	'00000006-dddd-0000-0000-000000000000','1 May 2007');
SET IDENTITY_INSERT [Person].[AddressType] OFF;
DBCC CHECKIDENT ('Person.AddressType', RESEED, 5000);
-------------------------------------------------------------------



SET IDENTITY_INSERT [Person].[ContactType] ON ;
INSERT INTO [Person].[ContactType] ([ContactTypeID] ,[Name] ,[ModifiedDate])
			VALUES    (1,'Owner',				 '1 May 2007')
					, (2,'Sales Bod',			 '1 May 2007')
					, (3,'Marketing Bod',		 '1 May 2007')
					, (4,'Apprentice',			 '1 May 2007')
					, (5,'Shop Manager',		 '1 May 2007')
					, (6,'Time Lord',			 '1 May 2007')
					, (7,'For Delete Tests Only','1 May 2007')

SET IDENTITY_INSERT [Person].[ContactType] OFF;
DBCC CHECKIDENT ('Person.[ContactType]', RESEED, 5000);
-------------------------------------------------------------------


INSERT INTO [Person].[CountryRegion] ([CountryRegionCode] ,[Name] ,[ModifiedDate])
			VALUES    ('GB','Great Britan',			 '1 May 2007')
					, ('FO','Taiwan',				 '1 May 2007')
					, ('MZ','Mozambique',			 '1 May 2007')
					, ('LC','Saint Lucia',			 '1 May 2007')
					, ('TK','Tokelau',				 '1 May 2007')
					, ('AU','Australia',			 '1 May 2007')
					, ('DD','For Delete Tests Only' ,'1 May 2007')

-------------------------------------------------------------------


SET IDENTITY_INSERT [Person].[PhoneNumberType] ON ;
INSERT INTO [Person].[PhoneNumberType] ([PhoneNumberTypeID] ,[Name] ,[ModifiedDate])
			VALUES    (1,'Mobile',			     '1 May 2007')
					, (2,'Home',				 '1 May 2007')
					, (3,'Office',				 '1 May 2007')
					, (4,'Space Station',		 '1 May 2007')
					, (5,'Den',				     '1 May 2007')
					, (6,'Shed',			     '1 May 2007')
					, (7,'For Delete Tests Only','1 May 2007')

SET IDENTITY_INSERT [Person].[PhoneNumberType] OFF;
DBCC CHECKIDENT ('Person.[PhoneNumberType]', RESEED, 5000);
-------------------------------------------------------------------

INSERT INTO [Production].[Culture] (CultureID ,[Name] ,[ModifiedDate])
			VALUES    ('',  'Invariant',			'1 May 2007')
					, ('ar','Arabic',				'1 May 2007')
					, ('en','English',			    '1 May 2007')
					, ('es','Spanish',			    '1 May 2007')
					, ('fr','French',				'1 May 2007')
					, ('he','Hebrew',			    '1 May 2007')
					, ('dd','For Delete Tests Only','1 May 2007')
-------------------------------------------------------------------
SET IDENTITY_INSERT [Production].[ProductDescription] ON
--
INSERT [Production].[ProductDescription] ([ProductDescriptionID], [Description], [rowguid], [ModifiedDate])
																			   VALUES (1, N'Suitable for any type of riding, on or off-road. Fits any budget. Smooth-shifting with a comfortable ride.', N'8e6746e5-ad97-46e2-bd24-fcea075c3b52', CAST(N'2007-06-01T00:00:00.000' AS DateTime))
                                                                                    , (2, N'This bike delivers a high-level of performance on a budget. It is responsive and maneuverable, and offers peace-of-mind when you decide to go off-road.', N'7b1c4e90-85e2-4792-b47b-e0c424e2ec94', CAST(N'2007-06-01T00:00:00.000' AS DateTime))
                                                                                    , (3, N'Serious back-country riding. Perfect for all levels of competition. Uses the same HL Frame as the Mountain-100.', N'130709e6-8512-49b9-9f62-1f5c99152056', CAST(N'2008-03-11T10:32:17.973' AS DateTime))
                                                                                    , (4, N'Entry level adult bike]; offers a comfortable ride cross-country or down the block. Quick-release hubs and rims.', N'f5ff5ffd-cb7c-4ad6-bbc9-4d250bb6e98d', CAST(N'2007-06-01T00:00:00.000' AS DateTime))
                                                                                    , (555, N'All-occasion value bike with our basic comfort and safety features. Offers wider, more stable tires for a ride around town or weekend trip.', N'741eae59-5e59-4dbc-9086-2633392c2582', CAST(N'2007-06-01T00:00:00.000' AS DateTime))
                                                                                    , (666, N'The plush custom saddle keeps you riding all day,  and there''s plenty of space to add panniers and bike bags to the newly-redesigned carrier.  This bike has stability when fully-loaded.', N'ddc955b2-843e-49ce-8f7b-54870f6135eb', CAST(N'2007-06-01T00:00:00.000' AS DateTime))
                                                                                    , (777, N'For Delete Tests Only', N'9cfed570-180a-44ea-8233-55116a0ddcb9', CAST(N'2007-06-01T00:00:00.000' AS DateTime))
--GO
SET IDENTITY_INSERT [Production].[ProductDescription] OFF

DBCC CHECKIDENT ('[Production].[ProductDescription]', RESEED, 5000);
------------------------------------------------------------------------------------

SET IDENTITY_INSERT [Production].[ProductCategory] ON
GO
INSERT [Production].[ProductCategory]
    ([ProductCategoryID], [Name], [rowguid], [ModifiedDate])
VALUES
    (1, N'Bikes', N'cfbda25c-df71-47a7-b81b-64ee161aa37c', CAST(N'2002-06-01T00:00:00.000' AS DateTime)),
    (2, N'Components', N'c657828d-d808-4aba-91a3-af2ce02300e9', CAST(N'2002-06-01T00:00:00.000' AS DateTime)),
    (3, N'Clothing', N'10a7c342-ca82-48d4-8a38-46a2eb089b74', CAST(N'2002-06-01T00:00:00.000' AS DateTime)),
    (4, N'Accessories', N'2be3be36-d9a2-4eee-b593-ed895d97c2a6', CAST(N'2002-06-01T00:00:00.000' AS DateTime)),
    (5, N'Mountain Bikes', N'2d364ade-264a-433c-b092-4fcbf3804e01', CAST(N'2002-06-01T00:00:00.000' AS DateTime)),
    (6, N'Road Bikes', N'000310c0-bcc8-42c4-b0c3-45ae611af06b', CAST(N'2002-06-01T00:00:00.000' AS DateTime)),
    (7, N'For Delete Tests Only', N'02c5061d-ecdc-4274-b5f1-e91d76bc3f37', CAST(N'2002-06-01T00:00:00.000' AS DateTime));


GO
SET IDENTITY_INSERT [Production].[ProductCategory] OFF

DBCC CHECKIDENT ('[Production].[ProductCategory]', RESEED, 5000);
------------------------------------------------------------------------------------


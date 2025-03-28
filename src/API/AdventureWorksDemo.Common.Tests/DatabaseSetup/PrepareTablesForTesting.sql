
set nocount on
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

--use [$TARGET_DB_NAME];
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
DELETE FROM [Person].[CountryRegion];
delete from [Person].[StateProvince] ;
DELETE FROM [Sales].[SalesTerritory]
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

GO

INSERT INTO [Person].[CountryRegion] ([CountryRegionCode] ,[Name] ,[ModifiedDate])
			VALUES    ('GB','Great Britan',			 '1 May 2007')
					, ('FR','France',			 	 '1 May 2007')
					, ('DE','Germany',			     '1 May 2007')
					, ('CA','Canada',				 '1 May 2007')
					, ('TK','Tokelau',				 '1 May 2007')
					, ('AU','Australia',			 '1 May 2007')
					, ('DD','For Delete Tests Only' ,'1 May 2007')

-------------------------------------------------------------------
GO
SET IDENTITY_INSERT [Sales].[SalesTerritory] ON ;
INSERT INTO [Sales].[SalesTerritory]
           ([TerritoryID],	[Name]  ,[CountryRegionCode]    ,[Group]  ,[SalesYTD]  ,[SalesLastYear] ,[CostYTD] ,[CostLastYear]  ,[rowguid]  ,[ModifiedDate])
     VALUES
		(1,	'Canada',			'CA',	'North Canada',	6771829.14,	5693988.86,	0.00,	0.00,	'06B4AF8A-1639-476E-9266-110461D66B00',	'Apr 30 2008 12:00AM'),
		(2,	'France',			'FR',	'Europe',		4772398.31,	2396539.76,	0.00,	0.00,	'BF806804-9B4C-4B07-9D19-706F2E689552',	'Apr 30 2008 12:00AM'),
		(3,	'Germany',			'DE',	'Europe',		3805202.35,	1307949.79,	0.00,	0.00,	'6D2450DB-8159-414F-A917-E73EE91C38A9',	'Apr 30 2008 12:00AM'),
		(4,	'Australia',		'AU',	'Pacific',		5977814.92,	2278548.98,	0.00,	0.00,	'602E612E-DFE9-41D9-B894-27E489747885',	'Apr 30 2008 12:00AM'),
		(5,	'United Kingdom',	'GB',	'Europe',		5012905.37,	1635823.40,	0.00,	0.00,	'05FC7E1F-2DEA-414E-9ECD-09D150516FB5',	'Apr 30 2008 12:00AM'),
		(6,	'Tokelau',			'TK',	'Pacific',		4325344.37,	2344344.40,	0.00,	0.00,	'05FC7E1F-2DEA-414E-9ECD-222222222222',	'Apr 30 2008 12:00AM'),
		(7,	'Delete Orphan',	'DD',	'Delete Tests',       0.00,	      0.00,	0.00,	0.00,	'05FC7E1F-2DEA-414E-9ECD-111111111111',	'Apr 30 2008 12:00AM')
		;

SET IDENTITY_INSERT [Sales].[SalesTerritory] OFF;
DBCC CHECKIDENT ('[Sales].[SalesTerritory]', RESEED, 5000);
GO
-------------------------------------------------------------------


SET IDENTITY_INSERT [Person].[StateProvince] ON ;


INSERT INTO [Person].[StateProvince]
           (StateProvinceID
		   ,[StateProvinceCode]
           ,[CountryRegionCode]
           ,[IsOnlyStateProvinceFlag]
           ,[Name]
           ,[TerritoryID]
           ,[rowguid]
           ,[ModifiedDate])
     VALUES
            (1,	'AB ','CA','0','Alberta',			'1','298C2880-AB1C-4982-A5AD-A36EB4BA0D34','Feb  8 2014 10:17AM'),
			(2,	'BC ','CA','0','British Columbia',	'1','D27FCC6E-BB99-438B-BA86-285CEEB2FA53','Feb  8 2014 10:17AM'),
			(3,	'BY ','DE','0','Bayern',			'3','D54E5000-A0DA-46D1-86B0-B8FE16C9F781','Feb  8 2014 10:17AM'),
			(4,	'ENG','GB','1','England',			'5','3E3CB3F8-44B9-44D9-A1C3-CBFB11E0A7DA','Feb  8 2014 10:17AM'),
			(5,	'FM ','AU','1','Australia',		    '4','3202DA35-AED4-40E2-9EC4-27C17F420170','Feb  8 2014 10:17AM'),
			(6, 'HE ','DE','0','Hessen',			'5','834FC3DF-B60D-4F94-95BD-AEF8A9FB74E8','Feb  8 2014 10:17AM'),
			(7, 'DD ','DD','0','Delete Test',		'7','33333333-2222-1111-0000-AEF8A9FB74E8','Feb  8 2014 10:17AM')

SET IDENTITY_INSERT [Person].[StateProvince] OFF;
DBCC CHECKIDENT ('[Person].[StateProvince]', RESEED, 5000);
GO
-------------------------------------------------------------------

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
GO
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
GO

SET IDENTITY_INSERT [Person].[Address] ON
INSERT INTO [Person].[Address]
           ( [AddressID]
		   ,[AddressLine1]
           ,[AddressLine2]
           ,[City]
           ,[StateProvinceID]
           ,[PostalCode]
           ,[SpatialLocation]
           ,[rowguid]
           ,[ModifiedDate])
     VALUES
 ( 1 , '568, avenue de l´ Union Centrale'	, NULL,		'Paris'			, 1	, '75009'	, 0xE6100000010CB29379698576484080D3196A34B00240, '2D53A7FC-8017-412D-A591-B10BAC54F9B7', 'Dec 21 2013 10:09AM')
,( 2 , 'Charlottenstr 844'					, NULL,		'Ingolstadt'	, 3	, '85049'	, 0xE6100000010C79066342C6694840E2315709E9B72640, 'DF254102-23C7-4820-AE4A-6A9F0668C8BA', 'Aug 15 2013 12:00AM')
,( 3 , '9093 Gilardy Dr.'					, NULL,		'Milton Keynes'	, 4	, 'MK8 8ZD' , 0xE6100000010CD94C1C1F15FE4940047C4899A541E7BF, '513BF254-97B8-433B-B467-3079487A2BD4', 'Jun 23 2014 12:00AM')
,( 4 , 'Celler Weg 504'						, NULL,		'Poing'			, 3	, '66041'	, 0xE6100000010C00000000000000000000000000000000, '70764525-A746-4F90-B7BF-DD71D6DE2BC9', 'Oct 19 2012 12:00AM')
,( 5 , '3985 Dolores Way'					, NULL,		'Perth'			, 5	, '6006'	, 0xE6100000010C7EEC03B2ACEE3FC0965FFABC6BF75C40, '9A804484-17AF-4360-B83B-330CC89634AB', 'Jan 17 2014 12:00AM')
,( 6 , 'Skywalker House'					, 'Hoth',	'Sky Town'		, 2	, 'WA3'		, 0xE6100000010CF5586E1185CD4940D17D33328402D9BF, 'A9121E78-13EA-476B-BDA4-6C6F654E0D55', 'Dec  1 2013 12:00AM')
,( 7 , 'Delete Orphan'						, NULL,		'Wakanda'		, 7	, 'WA3'		, 0xE6100000010C682356A0785F48405B59264AFD410540, 'A9121E78-DDDD-DDDD-BDA4-6C6F654ECD55', 'Dec  1 2013 12:00AM')


SET IDENTITY_INSERT [Person].[Address] OFF

DBCC CHECKIDENT ('[Person].[Address]', RESEED, 5000);


Feature: ProductCategoryServiceAddTests


System tests for the ProductCategoryService
Testing the methods AddAsync


Background:
	Given The service to test is 'AdventureWorksDemo.Data.Services.IProductCategoryService'
	And I don't reset the database after the scenario
Scenario: AddAsyncNoParent
	Given I reset the database after the scenario
	When I populate the model 'AdventureWorksDemo.Data.Models.ProductCategoryModel'
		| Name     | ParentProductCategoryId | Rowguid                              |
		| PingPong |                         | 00000000-1111-0000-0000-000000000002 |
	And I call the method 'AddAsync' with the parameter values
		| Key   | Value     | TypeName                                            |
		| model | {{model}} | AdventureWorksDemo.Data.Models.ProductCategoryModel |
	Then the result is of type
		| Expected                                            |
		| AdventureWorksDemo.Data.Models.ProductCategoryModel |
	And the result is
		| ProductCategoryId | ParentProductCategoryId | Name     | ModifiedDate          | Rowguid                              |
		| 1001              |                         | PingPong | 5/24/2024 12:34:56 PM | 00000000-1111-0000-0000-000000000002 |
	And the table 'SalesLT.ProductCategory' filtered by 'ProductCategoryId > 40' contains
		| ProductCategoryId | ParentProductCategoryId | Name             | ModifiedDate          | Rowguid                              |
		| 41                | 4                       | Tires and Tubes  | 6/1/2002 12:00:00 AM  | 3c17c9ae-e906-48b4-bdd3-60e28d47dcdf |
		| 42                |                         | Record to Delete | 6/1/2005 12:00:00 AM  | 3c17c9ae-e906-48b4-bdd3-000000000001 |
		| 1001              |                         | PingPong         | 5/24/2024 12:34:56 PM | 00000000-1111-0000-0000-000000000002 |

Scenario: AddAsyncParent
	Given I reset the database after the scenario
	When I populate the model 'AdventureWorksDemo.Data.Models.ProductCategoryModel'
		| Name     | ParentProductCategoryId | Rowguid                              |
		| PingPong | 42                      | 00000000-1111-0000-0000-000000000002 |
	And I call the method 'AddAsync' with the parameter values
		| Key   | Value     | TypeName                                            |
		| model | {{model}} | AdventureWorksDemo.Data.Models.ProductCategoryModel |
	Then the result is of type
		| Expected                                            |
		| AdventureWorksDemo.Data.Models.ProductCategoryModel |
	And the result is
		| ProductCategoryId | ParentProductCategoryId | Name     | ModifiedDate          | Rowguid                              |
		| 1001              | 42                      | PingPong | 5/24/2024 12:34:56 PM | 00000000-1111-0000-0000-000000000002 |
	And the table 'SalesLT.ProductCategory' filtered by 'ProductCategoryId > 40' contains
		| ProductCategoryId | ParentProductCategoryId | Name             | ModifiedDate          | Rowguid                              |
		| 41                | 4                       | Tires and Tubes  | 6/1/2002 12:00:00 AM  | 3c17c9ae-e906-48b4-bdd3-60e28d47dcdf |
		| 42                |                         | Record to Delete | 6/1/2005 12:00:00 AM  | 3c17c9ae-e906-48b4-bdd3-000000000001 |
		| 1001              | 42                      | PingPong         | 5/24/2024 12:34:56 PM | 00000000-1111-0000-0000-000000000002 |
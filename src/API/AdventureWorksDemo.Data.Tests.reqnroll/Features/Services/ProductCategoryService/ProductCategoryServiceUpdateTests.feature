Feature: ProductCategoryServiceUpdateTests

System tests for the ProductCategoryService
Testing the methods UpdateAsync


Background:
	Given The service to test is 'AdventureWorksDemo.Data.Services.IProductCategoryService'
	And I don't reset the database after the scenario

Scenario: Update01
	Given I reset the database after the scenario
	When I populate the model 'AdventureWorksDemo.Data.Models.ProductCategoryModel'
		| ProductCategoryId | Name      |
		| 41                | Ping Pong |
	And I call the method 'UpdateAsync' with the parameter values
		| Key   | Value     | TypeName                                            |
		| model | {{model}} | AdventureWorksDemo.Data.Models.ProductCategoryModel |
	Then the result is of type
		| Expected                                            |
		| AdventureWorksDemo.Data.Models.ProductCategoryModel |
	And the result is
		| ProductCategoryId | ParentProductCategoryId | Name      | ModifiedDate          | Rowguid                              |
		| 41                |                         | Ping Pong | 5/24/2024 12:34:56 PM | 3c17c9ae-e906-48b4-bdd3-60e28d47dcdf |
	And the table 'SalesLT.ProductCategory' filtered by 'ProductCategoryId > 40' contains
		| ProductCategoryId | ParentProductCategoryId | Name             | ModifiedDate          | Rowguid                              |
		| 41                |                         | Ping Pong        | 5/24/2024 12:34:56 PM | 3c17c9ae-e906-48b4-bdd3-60e28d47dcdf |
		| 42                |                         | Record to Delete | 6/1/2005 12:00:00 AM  | 3c17c9ae-e906-48b4-bdd3-000000000001 |
Scenario: Update02
	Given I reset the database after the scenario
	When I populate the model 'AdventureWorksDemo.Data.Models.ProductCategoryModel'
		| ProductCategoryId | Name      | ParentProductCategoryId |
		| 41                | Ping Pong | 42                      |
	And I call the method 'UpdateAsync' with the parameter values
		| Key   | Value     | TypeName                                            |
		| model | {{model}} | AdventureWorksDemo.Data.Models.ProductCategoryModel |
	Then the result is of type
		| Expected                                            |
		| AdventureWorksDemo.Data.Models.ProductCategoryModel |
	And the result is
		| ProductCategoryId | ParentProductCategoryId | Name      | ModifiedDate          | Rowguid                              |
		| 41                | 42                      | Ping Pong | 5/24/2024 12:34:56 PM | 3c17c9ae-e906-48b4-bdd3-60e28d47dcdf |
	And the table 'SalesLT.ProductCategory' filtered by 'ProductCategoryId > 40' contains
		| ProductCategoryId | ParentProductCategoryId | Name             | ModifiedDate          | Rowguid                              |
		| 41                | 42                      | Ping Pong        | 5/24/2024 12:34:56 PM | 3c17c9ae-e906-48b4-bdd3-60e28d47dcdf |
		| 42                |                         | Record to Delete | 6/1/2005 12:00:00 AM  | 3c17c9ae-e906-48b4-bdd3-000000000001 |
Scenario: UpdateNoChange
	Given I don't reset the database after the scenario
	When I populate the model 'AdventureWorksDemo.Data.Models.ProductCategoryModel'
		| ProductCategoryId | ParentProductCategoryId | Name            | 
		| 41                | 4                       | Tires and Tubes | 
	And I call the method 'UpdateAsync' with the parameter values
		| Key   | Value     | TypeName                                            |
		| model | {{model}} | AdventureWorksDemo.Data.Models.ProductCategoryModel |
	Then the result is of type
		| Expected                                            |
		| AdventureWorksDemo.Data.Models.ProductCategoryModel |
	And the result is
		| ProductCategoryId | ParentProductCategoryId | Name            | ModifiedDate          | Rowguid                              |
		| 41                | 4                       | Tires and Tubes | 6/1/2002 12:00:00 AM | 3c17c9ae-e906-48b4-bdd3-60e28d47dcdf |
	And the table 'SalesLT.ProductCategory' filtered by 'ProductCategoryId > 40' contains
		| ProductCategoryId | ParentProductCategoryId | Name             | ModifiedDate         | Rowguid                              |
		| 41                | 4                       | Tires and Tubes  | 6/1/2002 12:00:00 AM | 3c17c9ae-e906-48b4-bdd3-60e28d47dcdf |
		| 42                |                         | Record to Delete | 6/1/2005 12:00:00 AM | 3c17c9ae-e906-48b4-bdd3-000000000001 |
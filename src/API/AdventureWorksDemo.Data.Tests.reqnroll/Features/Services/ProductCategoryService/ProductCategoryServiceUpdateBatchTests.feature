Feature: ProductCategoryServiceUpdateBatchTests
System tests for the ProductCategoryService
Testing the methods UpdateAsync with a list of ProductCategoryModel


Background:
	Given The service to test is 'AdventureWorksDemo.Data.Services.IProductCategoryService'
	And I reset the database after the scenario

Scenario: UpdateBatchAsync01
	Given the table 'SalesLT.ProductCategory' filtered by 'ProductCategoryId > 40' contains
		| ProductCategoryId | ParentProductCategoryId | Name             | ModifiedDate         | Rowguid                              |
		| 41                | 4                       | Tires and Tubes  | 6/1/2002 12:00:00 AM | 3c17c9ae-e906-48b4-bdd3-60e28d47dcdf |
		| 42                |                         | Record to Delete | 6/1/2005 12:00:00 AM | 3c17c9ae-e906-48b4-bdd3-000000000001 |
	When I populate a list of the model 'AdventureWorksDemo.Data.Models.ProductCategoryModel'
		| ProductCategoryId | Name        | ParentProductCategoryId |
		| 41                | Ping Pong   | 3                       |
		| 42                | Donald Duck | 12                      |
	And I call the method 'UpdateAsync' with the parameter values
		| Key    | Value      | TypeName                                                         |
		| models | {{models}} | IEnumerable<AdventureWorksDemo.Data.Models.ProductCategoryModel> |
	Then the result is of type
		| Expected                                                                                                                                 |
		| AdventureWorksDemo.Data.Models.ServiceResult<System.Collections.Generic.IEnumerable<AdventureWorksDemo.Data.Models.ProductCategoryModel> |
	And the result is
		| IsFailure | IsSuccess | Message |
		| False     | True      |         |
	And the results property 'Value' contains
		| ProductCategoryId | ParentProductCategoryId | Name        | ModifiedDate          | Rowguid                              |
		| 41                | 3                       | Ping Pong   | 5/24/2024 12:34:56 PM | 3c17c9ae-e906-48b4-bdd3-60e28d47dcdf |
		| 42                | 12                      | Donald Duck | 5/24/2024 12:34:56 PM | 3c17c9ae-e906-48b4-bdd3-000000000001 |
	And the table 'SalesLT.ProductCategory' filtered by 'ProductCategoryId > 40' contains
		| ProductCategoryId | ParentProductCategoryId | Name        | ModifiedDate          | Rowguid                              |
		| 41                | 3                       | Ping Pong   | 5/24/2024 12:34:56 PM | 3c17c9ae-e906-48b4-bdd3-60e28d47dcdf |
		| 42                | 12                      | Donald Duck | 5/24/2024 12:34:56 PM | 3c17c9ae-e906-48b4-bdd3-000000000001 |

Scenario: UpdateBatchAsync02
	Given I don't reset the database after the scenario
	When I populate a list of the model 'AdventureWorksDemo.Data.Models.ProductCategoryModel'
		| ProductCategoryId | Name | ParentProductCategoryId |
	And I call the method 'UpdateAsync' with the parameter values
		| Key    | Value      | TypeName                                                         |
		| models | {{models}} | IEnumerable<AdventureWorksDemo.Data.Models.ProductCategoryModel> |
	Then the result is of type
		| Expected                                                                                                                                 |
		| AdventureWorksDemo.Data.Models.ServiceResult<System.Collections.Generic.IEnumerable<AdventureWorksDemo.Data.Models.ProductCategoryModel> |
	And the result is
		| IsFailure | IsSuccess | Message |
		| True      | False     |   Please select some records to update!       |
	And the results property 'Value' contains
		| ProductCategoryId | ParentProductCategoryId | Name | ModifiedDate | Rowguid |
	And the table 'SalesLT.ProductCategory' filtered by 'ProductCategoryId > 40' contains
		| ProductCategoryId | ParentProductCategoryId | Name             | ModifiedDate         | Rowguid                              |
		| 41                | 4                       | Tires and Tubes  | 6/1/2002 12:00:00 AM | 3c17c9ae-e906-48b4-bdd3-60e28d47dcdf |
		| 42                |                         | Record to Delete | 6/1/2005 12:00:00 AM | 3c17c9ae-e906-48b4-bdd3-000000000001 |

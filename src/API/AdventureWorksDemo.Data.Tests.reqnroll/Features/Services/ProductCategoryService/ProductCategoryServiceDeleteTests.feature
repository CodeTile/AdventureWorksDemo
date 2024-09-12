Feature: ProductCategoryServiceDeleteTests

System tests for the ProductCategoryService
Testing the methods DeleteAsync


Background:
	Given The service to test is 'AdventureWorksDemo.Data.Services.IProductCategoryService'
	And I don't reset the database after the scenario

Scenario: DeleteAsync1234


	When I call the method 'DeleteAsync' with the parameter values
		| Key               | Value | TypeName | ModifiedDate         |
		| productCategoryId | 1234  | int      | 21 Apr 2024 12:34:56 |
	Then the result is of type
		| Expected                                                     |
		| AdventureWorksDemo.Data.Models.ServiceResult<System.Boolean> |
	And the result is
		| IsException | IsFailure | IsSuccess | Message |
		| False       | true      | false     |         |
	
	And the ServiceResult is of type 'System.Boolean' with the value
		| Expected |
		| False    |
	And the table 'SalesLT.ProductCategory' filtered by 'ProductCategoryId > 40' contains
		| ProductCategoryId | ParentProductCategoryId | Name             | ModifiedDate         | Rowguid                              |
		| 41                | 4                       | Tires and Tubes  | 6/1/2002 12:00:00 AM | 3c17c9ae-e906-48b4-bdd3-60e28d47dcdf |
		| 42                |                         | Record to Delete | 6/1/2005 12:00:00 AM | 3c17c9ae-e906-48b4-bdd3-000000000001 |

	

	
Scenario: DeleteAsync42
	Given I reset the database after the scenario
	When I call the method 'DeleteAsync' with the parameter values
		| Key               | Value | TypeName |
		| productCategoryId | 42    | int      |
	Then the result is of type
		| Expected                                                     |
		| AdventureWorksDemo.Data.Models.ServiceResult<System.Boolean> |
	And the result is
		| IsException | IsFailure | IsSuccess | Message |
		| False       | False     | True      |         |
	And the ServiceResult is of type 'System.Boolean' with the value
		| Expected |
		| True     |
	Then the table 'SalesLT.ProductCategory' filtered by 'ProductCategoryId > 40' contains
		| ProductCategoryId | ParentProductCategoryId | Name            | ModifiedDate         | Rowguid                              |
		| 41                | 4                       | Tires and Tubes | 6/1/2002 12:00:00 AM | 3c17c9ae-e906-48b4-bdd3-60e28d47dcdf |

	

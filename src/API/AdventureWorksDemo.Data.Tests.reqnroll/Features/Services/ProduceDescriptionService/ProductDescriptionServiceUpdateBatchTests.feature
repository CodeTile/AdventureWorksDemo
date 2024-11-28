Feature: ProductDescriptionServiceUpdateBatchTests
System tests for the ProductDescriptionService
Testing the methods UpdateBatchAsync


Background:
	Given The service to test is 'AdventureWorksDemo.Data.Services.IProductDescriptionService'
	And I reset the database after the scenario

Scenario: UpdateBatchAsync01
	Given the table 'SalesLT.ProductDescription' filtered by 'ProductDescriptionId > 40' contains
		| ProductDescriptionId | ParentProductDescriptionId | Description            | ModifiedDate         | Rowguid                              |
		| 41                | 4                       | Tires and Tubes  | 6/1/2002 12:00:00 AM | 3c17c9ae-e906-48b4-bdd3-60e28d47dcdf |
		| 42                |                         | Record to Delete | 6/1/2005 12:00:00 AM | 3c17c9ae-e906-48b4-bdd3-000000000001 |
	When I populate a list of the model 'AdventureWorksDemo.Data.Models.ProductDescriptionModel'
		| ProductDescriptionId | Description       | ParentProductDescriptionId |
		| 41                | Ping Pong   | 3                       |
		| 42                | Donald Duck | 12                      |
	And I call the method 'UpdateBatchAsync' with the parameter values
		| Key    | Value      | TypeName                                                         |
		| models | {{models}} | IEnumerable<AdventureWorksDemo.Data.Models.ProductDescriptionModel> |
	Then the result is of type
		| Expected                                                                                                                                 |
		| AdventureWorksDemo.Data.Models.ServiceResult<System.Collections.Generic.IEnumerable<AdventureWorksDemo.Data.Models.ProductDescriptionModel> |
	And the result is
		| IsFailure | IsSuccess | Message |
		| False     | True      |         |
	And the results property 'Value' contains
		| ProductDescriptionId | ModifiedDate         | Rowguid                              | Description         |
	And the table 'SalesLT.ProductDescription' filtered by 'ProductDescriptionId > 40' contains
		| ProductDescriptionId | ModifiedDate         | Rowguid                              | Description         |

Scenario: UpdateBatchAsync02
	Given I don't reset the database after the scenario
	When I populate a list of the model 'AdventureWorksDemo.Data.Models.ProductDescriptionModel'
		| ProductDescriptionId | Description| ParentProductDescriptionId |
	And I call the method 'UpdateBatchAsync' with the parameter values
		| Key    | Value      | TypeName                                                         |
		| models | {{models}} | IEnumerable<AdventureWorksDemo.Data.Models.ProductDescriptionModel> |
	Then the result is of type
		| Expected                                                                                                                                 |
		| AdventureWorksDemo.Data.Models.ServiceResult<System.Collections.Generic.IEnumerable<AdventureWorksDemo.Data.Models.ProductDescriptionModel> |
	And the result is
		| IsFailure | IsSuccess | Message |
		| True      | False     |   Please select some records to update!       |
	And the results property 'Value' contains
		| ProductDescriptionId | ParentProductDescriptionId | Description| ModifiedDate | Rowguid |
	And the table 'SalesLT.ProductDescription' filtered by 'ProductDescriptionId > 40' contains
		| ProductDescriptionId | ModifiedDate         | Rowguid                              | Description         |

Feature: ProductCategoryServiceUpdateTests

System tests for the ProductCategoryService
Testing the methods UpdateAsync


Background:
	Given The service to test is 'AdventureWorksDemo.Data.Services.IProductCategoryService'
	And I reset the database after the scenario

Scenario: Update01
	Given the table 'SalesLT.ProductCategory' filtered by 'ProductCategoryId > 40' contains
		| ProductCategoryId | ParentProductCategoryId | Name             | ModifiedDate         | Rowguid                              |
		| 41                | 4                       | Tires and Tubes  | 6/1/2002 12:00:00 AM | 3c17c9ae-e906-48b4-bdd3-60e28d47dcdf |
		| 42                |                         | Record to Delete | 6/1/2005 12:00:00 AM | 3c17c9ae-e906-48b4-bdd3-000000000001 |
	When I populate the model 'AdventureWorksDemo.Data.Models.ProductCategoryModel'
		| ProductCategoryId | Name      | ParentProductCategoryId |
		| 41                | Ping Pong |                         |
	And I call the method 'UpdateAsync' with the parameter values
		| Key   | Value     | TypeName                                            |
		| model | {{model}} | AdventureWorksDemo.Data.Models.ProductCategoryModel |
	Then the result is of type
		| Expected                                                                                          |
		| AdventureWorksDemo.Data.Models.ServiceResult<AdventureWorksDemo.Data.Models.ProductCategoryModel> |
	And the result is
		| IsFailure | IsSuccess | Message |
		| False     | True      |         |
	And the results property 'Value' contains
		| ProductCategoryId | ParentProductCategoryId | Name      | ModifiedDate          | Rowguid                              |
		| 41                |                         | Ping Pong | 5/24/2024 12:34:56 PM | 3c17c9ae-e906-48b4-bdd3-60e28d47dcdf |
	And the table 'SalesLT.ProductCategory' filtered by 'ProductCategoryId > 40' contains
		| ProductCategoryId | ParentProductCategoryId | Name             | ModifiedDate          | Rowguid                              |
		| 41                |                         | Ping Pong        | 5/24/2024 12:34:56 PM | 3c17c9ae-e906-48b4-bdd3-60e28d47dcdf |
		| 42                |                         | Record to Delete | 6/1/2005 12:00:00 AM  | 3c17c9ae-e906-48b4-bdd3-000000000001 |

Scenario: Update02
	Given the table 'SalesLT.ProductCategory' filtered by 'ProductCategoryId > 40' contains
		| ProductCategoryId | ParentProductCategoryId | Name             | ModifiedDate         | Rowguid                              |
		| 41                | 4                       | Tires and Tubes  | 6/1/2002 12:00:00 AM | 3c17c9ae-e906-48b4-bdd3-60e28d47dcdf |
		| 42                |                         | Record to Delete | 6/1/2005 12:00:00 AM | 3c17c9ae-e906-48b4-bdd3-000000000001 |
	When I populate the model 'AdventureWorksDemo.Data.Models.ProductCategoryModel'
		| ProductCategoryId | Name      | ParentProductCategoryId |
		| 41                | Ping Pong | 42                      |
	And I call the method 'UpdateAsync' with the parameter values
		| Key   | Value     | TypeName                                            |
		| model | {{model}} | AdventureWorksDemo.Data.Models.ProductCategoryModel |
	Then the result is of type
		| Expected                                                                                          |
		| AdventureWorksDemo.Data.Models.ServiceResult<AdventureWorksDemo.Data.Models.ProductCategoryModel> |
	And the result is
		| IsFailure | IsSuccess | Message |
		| False     | True      |         |
	And the results property 'Value' contains
		| ProductCategoryId | ParentProductCategoryId | Name      | ModifiedDate          | Rowguid                              |
		| 41                | 42                      | Ping Pong | 5/24/2024 12:34:56 PM | 3c17c9ae-e906-48b4-bdd3-60e28d47dcdf |
	And the table 'SalesLT.ProductCategory' filtered by 'ProductCategoryId > 40' contains
		| ProductCategoryId | ParentProductCategoryId | Name             | ModifiedDate          | Rowguid                              |
		| 41                | 42                      | Ping Pong        | 5/24/2024 12:34:56 PM | 3c17c9ae-e906-48b4-bdd3-60e28d47dcdf |
		| 42                |                         | Record to Delete | 6/1/2005 12:00:00 AM  | 3c17c9ae-e906-48b4-bdd3-000000000001 |
Scenario: Update03
	Given the table 'SalesLT.ProductCategory' filtered by 'ProductCategoryId > 40' contains
		| ProductCategoryId | ParentProductCategoryId | Name             | ModifiedDate         | Rowguid                              |
		| 41                | 4                       | Tires and Tubes  | 6/1/2002 12:00:00 AM | 3c17c9ae-e906-48b4-bdd3-60e28d47dcdf |
		| 42                |                         | Record to Delete | 6/1/2005 12:00:00 AM | 3c17c9ae-e906-48b4-bdd3-000000000001 |
	When I populate the model 'AdventureWorksDemo.Data.Models.ProductCategoryModel'
		| ProductCategoryId | Name            | ParentProductCategoryId |
		| 41                | Tires and Tubes | 42                      |
	And I call the method 'UpdateAsync' with the parameter values
		| Key   | Value     | TypeName                                            |
		| model | {{model}} | AdventureWorksDemo.Data.Models.ProductCategoryModel |
	Then the result is of type
		| Expected                                                                                          |
		| AdventureWorksDemo.Data.Models.ServiceResult<AdventureWorksDemo.Data.Models.ProductCategoryModel> |
	And the result is
		| IsFailure | IsSuccess | Message |
		| False     | True      |         |
	And the results property 'Value' contains
		| ProductCategoryId | ParentProductCategoryId | Name            | ModifiedDate          | Rowguid                              |
		| 41                | 42                      | Tires and Tubes | 5/24/2024 12:34:56 PM | 3c17c9ae-e906-48b4-bdd3-60e28d47dcdf |
	And the table 'SalesLT.ProductCategory' filtered by 'ProductCategoryId > 40' contains
		| ProductCategoryId | ParentProductCategoryId | Name             | ModifiedDate          | Rowguid                              |
		| 41                | 42                      | Tires and Tubes  | 5/24/2024 12:34:56 PM | 3c17c9ae-e906-48b4-bdd3-60e28d47dcdf |
		| 42                |                         | Record to Delete | 6/1/2005 12:00:00 AM  | 3c17c9ae-e906-48b4-bdd3-000000000001 |

		
Scenario: UpdateInvalidName
	Given the table 'SalesLT.ProductCategory' filtered by 'ProductCategoryId > 40' contains
		| ProductCategoryId | ParentProductCategoryId | Name             | ModifiedDate         | Rowguid                              |
		| 41                | 4                       | Tires and Tubes  | 6/1/2002 12:00:00 AM | 3c17c9ae-e906-48b4-bdd3-60e28d47dcdf |
		| 42                |                         | Record to Delete | 6/1/2005 12:00:00 AM | 3c17c9ae-e906-48b4-bdd3-000000000001 |
	When I populate the model 'AdventureWorksDemo.Data.Models.ProductCategoryModel'
		| ProductCategoryId | Name | ParentProductCategoryId |
		| 41                | Hi   | 42                      |
	And I call the method 'UpdateAsync' with the parameter values
		| Key   | Value     | TypeName                                            |
		| model | {{model}} | AdventureWorksDemo.Data.Models.ProductCategoryModel |
	Then the result is of type
		| Expected                                                                                          |
		| AdventureWorksDemo.Data.Models.ServiceResult<AdventureWorksDemo.Data.Models.ProductCategoryModel> |
	And the result is
		| IsFailure | IsSuccess |
		| True      | False     |
	And the results property 'Message' contains
		| Expected                                                              |
		| 'Name' must be between 3 and 50 characters. You entered 2 characters. |
	And the results property 'Value' contains
		| ProductCategoryId | ParentProductCategoryId | Name | ModifiedDate          | Rowguid                              |
		| 41                | 42                      | Hi   | 6/1/2002 12:00:00 AM | 3c17c9ae-e906-48b4-bdd3-60e28d47dcdf |
	And the table 'SalesLT.ProductCategory' filtered by 'ProductCategoryId > 40' contains
		| ProductCategoryId | ParentProductCategoryId | Name             | ModifiedDate          | Rowguid                              |
		| 41                | 4                       | Tires and Tubes  | 6/1/2002 12:00:00 AM | 3c17c9ae-e906-48b4-bdd3-60e28d47dcdf |
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
		| Expected                                                                                          |
		| AdventureWorksDemo.Data.Models.ServiceResult<AdventureWorksDemo.Data.Models.ProductCategoryModel> |
	And the result is
		| IsFailure | IsSuccess | Message                     |
		| False     | True      | Record is already uptodate! |
	And the results property 'Value' contains
		| ProductCategoryId | ParentProductCategoryId | Name            | ModifiedDate         | Rowguid                              |
		| 41                | 4                       | Tires and Tubes | 6/1/2002 12:00:00 AM | 3c17c9ae-e906-48b4-bdd3-60e28d47dcdf |
	And the table 'SalesLT.ProductCategory' filtered by 'ProductCategoryId > 40' contains
		| ProductCategoryId | ParentProductCategoryId | Name             | ModifiedDate         | Rowguid                              |
		| 41                | 4                       | Tires and Tubes  | 6/1/2002 12:00:00 AM | 3c17c9ae-e906-48b4-bdd3-60e28d47dcdf |
		| 42                |                         | Record to Delete | 6/1/2005 12:00:00 AM | 3c17c9ae-e906-48b4-bdd3-000000000001 |

Scenario: UpdateUnknownRecord
	Given I don't reset the database after the scenario
	When I populate the model 'AdventureWorksDemo.Data.Models.ProductCategoryModel'
		| ProductCategoryId | ParentProductCategoryId | Name                |
		| 1234              | 4                       | UpdateUnknownRecord |
	And I call the method 'UpdateAsync' with the parameter values
		| Key   | Value     | TypeName                                            |
		| model | {{model}} | AdventureWorksDemo.Data.Models.ProductCategoryModel |
	Then the result is of type
		| Expected                                                                                          |
		| AdventureWorksDemo.Data.Models.ServiceResult<AdventureWorksDemo.Data.Models.ProductCategoryModel> |
		
	And the result is
		| IsFailure | IsSuccess | Message                            |
		| True      | False     | Unable to locate record to update! |

	And the results property 'Value' contains
		| ProductCategoryId | ParentProductCategoryId | Name                | ModifiedDate         | Rowguid                              |
		| 1234              | 4                       | UpdateUnknownRecord | 1/1/0001 12:00:00 AM | 00000000-0000-0000-0000-000000000000 |
	And the table 'SalesLT.ProductCategory' filtered by 'ProductCategoryId > 40' contains
		| ProductCategoryId | ParentProductCategoryId | Name             | ModifiedDate         | Rowguid                              |
		| 41                | 4                       | Tires and Tubes  | 6/1/2002 12:00:00 AM | 3c17c9ae-e906-48b4-bdd3-60e28d47dcdf |
		| 42                |                         | Record to Delete | 6/1/2005 12:00:00 AM | 3c17c9ae-e906-48b4-bdd3-000000000001 |
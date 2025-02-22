﻿Feature: ProductCategoryServiceAddTests


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
		| Expected                                                                                          |
		| AdventureWorksDemo.Data.Models.ServiceResult<AdventureWorksDemo.Data.Models.ProductCategoryModel> |
	And the result is
		| IsFailure | IsSuccess | Message |
		| False     | True      |         |
	And the results property 'Value' contains
		| ProductCategoryId | ParentProductCategoryId | Name     | ModifiedDate          | Rowguid                              |
		| 5001              |                         | PingPong | 5/24/2024 12:34:56 PM | 00000000-1111-0000-0000-000000000002 |
	And the table 'SalesLT.ProductCategory' filtered by 'ProductCategoryId > 40' contains
		| ProductCategoryId | ParentProductCategoryId | Name             | ModifiedDate          | Rowguid                              |
		| 41                | 4                       | Tires and Tubes  | 6/1/2002 12:00:00 AM  | 3c17c9ae-e906-48b4-bdd3-60e28d47dcdf |
		| 42                |                         | Record to Delete | 6/1/2005 12:00:00 AM  | 3c17c9ae-e906-48b4-bdd3-000000000001 |
		| 5001              |                         | PingPong         | 5/24/2024 12:34:56 PM | 00000000-1111-0000-0000-000000000002 |
		
Scenario: AddAsyncNoParentShortName
	Given I reset the database after the scenario
	When I populate the model 'AdventureWorksDemo.Data.Models.ProductCategoryModel'
		| Name | ParentProductCategoryId | Rowguid                              |
		| Hi   |                         | 00000000-1111-0000-0000-000000000002 |
	And I call the method 'AddAsync' with the parameter values
		| Key   | Value     | TypeName                                            |
		| model | {{model}} | AdventureWorksDemo.Data.Models.ProductCategoryModel |
	Then the result is of type
		| Expected                                                                                          |
		| AdventureWorksDemo.Data.Models.ServiceResult<AdventureWorksDemo.Data.Models.ProductCategoryModel> |
	And the result is
		| IsFailure | IsSuccess | Message                                                               |
		| True      | False     | 'Name' must be between 3 and 50 characters. You entered 2 characters. |

	And the results property 'Value' contains
		| ProductCategoryId | ParentProductCategoryId | Name | ModifiedDate         | Rowguid                              |
		| 0                 |                         | Hi   | 1/1/0001 12:00:00 AM | 00000000-1111-0000-0000-000000000002 |

	And the table 'SalesLT.ProductCategory' filtered by 'ProductCategoryId > 40' contains
		| ProductCategoryId | ParentProductCategoryId | Name             | ModifiedDate         | Rowguid                              |
		| 41                | 4                       | Tires and Tubes  | 6/1/2002 12:00:00 AM | 3c17c9ae-e906-48b4-bdd3-60e28d47dcdf |
		| 42                |                         | Record to Delete | 6/1/2005 12:00:00 AM | 3c17c9ae-e906-48b4-bdd3-000000000001 |
		
Scenario: AddAsyncParent
	Given I reset the database after the scenario
	When I populate the model 'AdventureWorksDemo.Data.Models.ProductCategoryModel'
		| Name     | ParentProductCategoryId | Rowguid                              |
		| PingPong | 42                      | 00000000-1111-0000-0000-000000000002 |
	And I call the method 'AddAsync' with the parameter values
		| Key   | Value     | TypeName                                            |
		| model | {{model}} | AdventureWorksDemo.Data.Models.ProductCategoryModel |
	Then the result is of type
		| Expected                                                                                          |
		| AdventureWorksDemo.Data.Models.ServiceResult<AdventureWorksDemo.Data.Models.ProductCategoryModel> |
	And the result is
		| IsFailure | IsSuccess | Message |
		| False     | True      |         |
	And the results property 'Value' contains
		| ProductCategoryId | ParentProductCategoryId | Name     | ModifiedDate          | Rowguid                              |
		| 5001              | 42                      | PingPong | 5/24/2024 12:34:56 PM | 00000000-1111-0000-0000-000000000002 |
	And the table 'SalesLT.ProductCategory' filtered by 'ProductCategoryId > 40' contains
		| ProductCategoryId | ParentProductCategoryId | Name             | ModifiedDate          | Rowguid                              |
		| 41                | 4                       | Tires and Tubes  | 6/1/2002 12:00:00 AM  | 3c17c9ae-e906-48b4-bdd3-60e28d47dcdf |
		| 42                |                         | Record to Delete | 6/1/2005 12:00:00 AM  | 3c17c9ae-e906-48b4-bdd3-000000000001 |
		| 5001              | 42                      | PingPong         | 5/24/2024 12:34:56 PM | 00000000-1111-0000-0000-000000000002 |
		
Scenario: AddAsyncParentShortName
	Given I reset the database after the scenario
	When I populate the model 'AdventureWorksDemo.Data.Models.ProductCategoryModel'
		| Name | ParentProductCategoryId | Rowguid                              |
		| Hi   | 42                      | 00000000-1111-0000-0000-000000000002 |
	And I call the method 'AddAsync' with the parameter values
		| Key   | Value     | TypeName                                            |
		| model | {{model}} | AdventureWorksDemo.Data.Models.ProductCategoryModel |
	Then the result is of type
		| Expected                                                                                          |
		| AdventureWorksDemo.Data.Models.ServiceResult<AdventureWorksDemo.Data.Models.ProductCategoryModel> |
	And the result is
		| IsFailure | IsSuccess | Message                                                               |
		| True      | False     | 'Name' must be between 3 and 50 characters. You entered 2 characters. |

	And the results property 'Value' contains
		| ProductCategoryId | ParentProductCategoryId | Name | ModifiedDate         | Rowguid                              |
		| 0                 | 42                      | Hi   | 1/1/0001 12:00:00 AM | 00000000-1111-0000-0000-000000000002 |
	And the table 'SalesLT.ProductCategory' filtered by 'ProductCategoryId > 40' contains
		| ProductCategoryId | ParentProductCategoryId | Name             | ModifiedDate         | Rowguid                              |
		| 41                | 4                       | Tires and Tubes  | 6/1/2002 12:00:00 AM | 3c17c9ae-e906-48b4-bdd3-60e28d47dcdf |
		| 42                |                         | Record to Delete | 6/1/2005 12:00:00 AM | 3c17c9ae-e906-48b4-bdd3-000000000001 |

Scenario: AddBatchAsync
	Given I reset the database after the scenario
	When I populate a list of the model 'AdventureWorksDemo.Data.Models.ProductCategoryModel'
		| Name  | ParentProductCategoryId | Rowguid                              |
		| How   | 4                       | 00000000-1111-1111-0000-000000000001 |
		| Now   | 5                       | 00000000-1111-1111-0000-000000000002 |
		| Brown | 41                      | 00000000-1111-1111-0000-000000000003 |
		| Cow   |                         | 00000000-1111-1111-0000-000000000004 |
	And I call the method 'AddBatchAsync' with the parameter values
		| Key   | Value             | TypeName                                                                                    |
		| model | {{ListOfObjects}} | System.Collections.Generic.IEnumerable<AdventureWorksDemo.Data.Models.ProductCategoryModel> |
	Then the result is of type
		| Expected                                                                                                                                 |
		| AdventureWorksDemo.Data.Models.ServiceResult<System.Collections.Generic.IEnumerable<AdventureWorksDemo.Data.Models.ProductCategoryModel> |
	And the result is
		| IsFailure | IsSuccess | Message |
		| false     | true      |         |
	
	And the results property 'Value' contains
		| ProductCategoryId | ParentProductCategoryId | Name  | ModifiedDate          | Rowguid                              |
		| 5001              | 4                       | How   | 5/24/2024 12:34:56 PM | 00000000-1111-1111-0000-000000000001 |
		| 5002              | 5                       | Now   | 5/24/2024 12:34:56 PM | 00000000-1111-1111-0000-000000000002 |
		| 5003              | 41                      | Brown | 5/24/2024 12:34:56 PM | 00000000-1111-1111-0000-000000000003 |
		| 5004              |                         | Cow   | 5/24/2024 12:34:56 PM | 00000000-1111-1111-0000-000000000004 |
    
	And the table 'SalesLT.ProductCategory' filtered by 'ProductCategoryId > 40' contains
		| ProductCategoryId | ParentProductCategoryId | Name             | ModifiedDate          | Rowguid                              |
		| 41                | 4                       | Tires and Tubes  | 6/1/2002 12:00:00 AM  | 3c17c9ae-e906-48b4-bdd3-60e28d47dcdf |
		| 42                |                         | Record to Delete | 6/1/2005 12:00:00 AM  | 3c17c9ae-e906-48b4-bdd3-000000000001 |
		| 5001              | 4                       | How              | 5/24/2024 12:34:56 PM | 00000000-1111-1111-0000-000000000001 |
		| 5002              | 5                       | Now              | 5/24/2024 12:34:56 PM | 00000000-1111-1111-0000-000000000002 |
		| 5003              | 41                      | Brown            | 5/24/2024 12:34:56 PM | 00000000-1111-1111-0000-000000000003 |
		| 5004              |                         | Cow              | 5/24/2024 12:34:56 PM | 00000000-1111-1111-0000-000000000004 |
		
Scenario: AddBatchAsync2ShortName
	Given I reset the database after the scenario
	When I populate a list of the model 'AdventureWorksDemo.Data.Models.ProductCategoryModel'
		| Name  | ParentProductCategoryId | Rowguid                              |
		| Hi    | 4                       | 00000000-1111-1111-0000-000000000001 |
		| Now   | 5                       | 00000000-1111-1111-0000-000000000002 |
		| Brown | 41                      | 00000000-1111-1111-0000-000000000003 |
		| It    |                         | 00000000-1111-1111-0000-000000000004 |
	And I call the method 'AddBatchAsync' with the parameter values
		| Key   | Value             | TypeName                                                                                    |
		| model | {{ListOfObjects}} | System.Collections.Generic.IEnumerable<AdventureWorksDemo.Data.Models.ProductCategoryModel> |
	Then the result is of type
		| Expected                                                                                                                                 |
		| AdventureWorksDemo.Data.Models.ServiceResult<System.Collections.Generic.IEnumerable<AdventureWorksDemo.Data.Models.ProductCategoryModel> |
	And the result is
		| IsFailure | IsSuccess |
		| True      | False     |
	And the results property 'Message' contains
		| Expected                                                              |
		| 'Name' must be between 3 and 50 characters. You entered 2 characters. |
		| 'Name' must be between 3 and 50 characters. You entered 2 characters. |
	And the results property 'Value' contains
		| ProductCategoryId | ParentProductCategoryId | Name  | ModifiedDate         | Rowguid                              |
		| 0                 | 4                       | Hi    | 1/1/0001 12:00:00 AM | 00000000-1111-1111-0000-000000000001 |
		| 0                 | 5                       | Now   | 1/1/0001 12:00:00 AM | 00000000-1111-1111-0000-000000000002 |
		| 0                 | 41                      | Brown | 1/1/0001 12:00:00 AM | 00000000-1111-1111-0000-000000000003 |
		| 0                 |                         | It    | 1/1/0001 12:00:00 AM | 00000000-1111-1111-0000-000000000004 |
    
	And the table 'SalesLT.ProductCategory' filtered by 'ProductCategoryId > 40' contains
		| ProductCategoryId | ParentProductCategoryId | Name             | ModifiedDate         | Rowguid                              |
		| 41                | 4                       | Tires and Tubes  | 6/1/2002 12:00:00 AM | 3c17c9ae-e906-48b4-bdd3-60e28d47dcdf |
		| 42                |                         | Record to Delete | 6/1/2005 12:00:00 AM | 3c17c9ae-e906-48b4-bdd3-000000000001 |

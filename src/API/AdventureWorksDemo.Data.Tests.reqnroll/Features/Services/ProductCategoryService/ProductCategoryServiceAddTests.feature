Feature: ProductCategoryServiceAddTests


System tests for the ProductCategoryService
Testing the methods AddAsync


Background:
	Given The service to test is 'AdventureWorksDemo.Data.Services.IProductCategoryService'
	And I don't reset the database after the scenario
			
Scenario: AddAsyncShortName
	When I populate the model 'AdventureWorksDemo.Data.Models.ProductCategoryModel'
		| Name | Rowguid                              |
		| Hi   | 00000000-1111-0000-0000-000000000002 |
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
		| ProductCategoryId | Name | ModifiedDate         | Rowguid                              |
		| 0                 | Hi   | 1/1/0001 12:00:00 AM | 00000000-1111-0000-0000-000000000002 |

	And the table 'Production.ProductCategory' filtered by 'ProductCategoryId > 5' contains
		| ProductCategoryId | Name                  | ModifiedDate         | Rowguid                              |
		| 6                 | Road Bikes            | 6/1/2002 12:00:00 AM | 000310c0-bcc8-42c4-b0c3-45ae611af06b |
		| 7                 | For Delete Tests Only | 6/1/2002 12:00:00 AM | 02c5061d-ecdc-4274-b5f1-e91d76bc3f37 |
		
Scenario: AddAsync
	Given I reset the database after the scenario
	When I populate the model 'AdventureWorksDemo.Data.Models.ProductCategoryModel'
		| Name     | Rowguid                              |
		| PingPong | 00000000-1111-0000-0000-000000000002 |
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
		| ProductCategoryId | Name     | ModifiedDate          | Rowguid                              |
		| 5001              | PingPong | 5/24/2024 12:34:56 PM | 00000000-1111-0000-0000-000000000002 |
	And the table 'Production.ProductCategory' filtered by 'ProductCategoryId > 5' contains
		| ProductCategoryId | Name                  | ModifiedDate          | Rowguid                              |
		| 6                 | Road Bikes            | 6/1/2002 12:00:00 AM  | 000310c0-bcc8-42c4-b0c3-45ae611af06b |
		| 7                 | For Delete Tests Only | 6/1/2002 12:00:00 AM  | 02c5061d-ecdc-4274-b5f1-e91d76bc3f37 |
		| 5001              | PingPong              | 5/24/2024 12:34:56 PM | 00000000-1111-0000-0000-000000000002 |

Scenario: AddBatchAsync
	Given I reset the database after the scenario
	When I populate a list of the model 'AdventureWorksDemo.Data.Models.ProductCategoryModel'
		| Name  | Rowguid                              |
		| How   | 00000000-1111-1111-0000-000000000001 |
		| Now   | 00000000-1111-1111-0000-000000000002 |
		| Brown | 00000000-1111-1111-0000-000000000003 |
		| Cow   | 00000000-1111-1111-0000-000000000004 |
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
		| ProductCategoryId | Name  | ModifiedDate          | Rowguid                              |
		| 5001              | How   | 5/24/2024 12:34:56 PM | 00000000-1111-1111-0000-000000000001 |
		| 5002              | Now   | 5/24/2024 12:34:56 PM | 00000000-1111-1111-0000-000000000002 |
		| 5003              | Brown | 5/24/2024 12:34:56 PM | 00000000-1111-1111-0000-000000000003 |
		| 5004              | Cow   | 5/24/2024 12:34:56 PM | 00000000-1111-1111-0000-000000000004 |
    
	And the table 'Production.ProductCategory' filtered by 'ProductCategoryId > 5' contains
		| ProductCategoryId | Name                  | ModifiedDate          | Rowguid                              |
		| 6                 | Road Bikes            | 6/1/2002 12:00:00 AM  | 000310c0-bcc8-42c4-b0c3-45ae611af06b |
		| 7                 | For Delete Tests Only | 6/1/2002 12:00:00 AM  | 02c5061d-ecdc-4274-b5f1-e91d76bc3f37 |
		| 5001              | How                   | 5/24/2024 12:34:56 PM | 00000000-1111-1111-0000-000000000001 |
		| 5002              | Now                   | 5/24/2024 12:34:56 PM | 00000000-1111-1111-0000-000000000002 |
		| 5003              | Brown                 | 5/24/2024 12:34:56 PM | 00000000-1111-1111-0000-000000000003 |
		| 5004              | Cow                   | 5/24/2024 12:34:56 PM | 00000000-1111-1111-0000-000000000004 |
		
Scenario: AddBatchAsync2ShortName
	When I populate a list of the model 'AdventureWorksDemo.Data.Models.ProductCategoryModel'
		| Name  | Rowguid                              |
		| Hi    | 00000000-1111-1111-0000-000000000001 |
		| Now   | 00000000-1111-1111-0000-000000000002 |
		| Brown | 00000000-1111-1111-0000-000000000003 |
		| It    | 00000000-1111-1111-0000-000000000004 |
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
		| ProductCategoryId | Name  | ModifiedDate         | Rowguid                              |
		| 0                 | Hi    | 1/1/0001 12:00:00 AM | 00000000-1111-1111-0000-000000000001 |
		| 0                 | Now   | 1/1/0001 12:00:00 AM | 00000000-1111-1111-0000-000000000002 |
		| 0                 | Brown | 1/1/0001 12:00:00 AM | 00000000-1111-1111-0000-000000000003 |
		| 0                 | It    | 1/1/0001 12:00:00 AM | 00000000-1111-1111-0000-000000000004 |
    
	And the table 'Production.ProductCategory' filtered by 'ProductCategoryId > 5' contains
		| ProductCategoryId | Name                  | ModifiedDate         | Rowguid                              |
		| 6                 | Road Bikes            | 6/1/2002 12:00:00 AM | 000310c0-bcc8-42c4-b0c3-45ae611af06b |
		| 7                 | For Delete Tests Only | 6/1/2002 12:00:00 AM | 02c5061d-ecdc-4274-b5f1-e91d76bc3f37 |

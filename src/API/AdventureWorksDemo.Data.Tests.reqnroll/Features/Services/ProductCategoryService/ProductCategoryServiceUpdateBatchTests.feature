Feature: ProductCategoryServiceUpdateBatchTests
System tests for the ProductCategoryService
Testing the methods UpdateAsync with a list of ProductCategoryModel


Background:
	Given The service to test is 'AdventureWorksDemo.Data.Services.IProductCategoryService'
	And I reset the database after the scenario

Scenario: UpdateBatchAsync01
	Given the table 'Production.ProductCategory' filtered by 'ProductCategoryId > 5' contains
		| ProductCategoryId | Name                  | ModifiedDate         | Rowguid                              |
		| 6                 | Road Bikes            | 6/1/2002 12:00:00 AM | 000310c0-bcc8-42c4-b0c3-45ae611af06b |
		| 7                 | For Delete Tests Only | 6/1/2002 12:00:00 AM | 02c5061d-ecdc-4274-b5f1-e91d76bc3f37 |
	When I populate a list of the model 'AdventureWorksDemo.Data.Models.ProductCategoryModel'
		| ProductCategoryId | Name        |
		| 6                 | Ping Pong   |
		| 7                 | Donald Duck |
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
		| ProductCategoryId | Name        | ModifiedDate          | Rowguid                              |
		| 6                 | Ping Pong   | 5/24/2024 12:34:56 PM | 000310c0-bcc8-42c4-b0c3-45ae611af06b |
		| 7                 | Donald Duck | 5/24/2024 12:34:56 PM | 02c5061d-ecdc-4274-b5f1-e91d76bc3f37 |
	And the table 'Production.ProductCategory' contains
		| ProductCategoryId | Name           | ModifiedDate          | Rowguid                              |
		| 1                 | Bikes          | 6/1/2002 12:00:00 AM  | cfbda25c-df71-47a7-b81b-64ee161aa37c |
		| 2                 | Components     | 6/1/2002 12:00:00 AM  | c657828d-d808-4aba-91a3-af2ce02300e9 |
		| 3                 | Clothing       | 6/1/2002 12:00:00 AM  | 10a7c342-ca82-48d4-8a38-46a2eb089b74 |
		| 4                 | Accessories    | 6/1/2002 12:00:00 AM  | 2be3be36-d9a2-4eee-b593-ed895d97c2a6 |
		| 5                 | Mountain Bikes | 6/1/2002 12:00:00 AM  | 2d364ade-264a-433c-b092-4fcbf3804e01 |
		| 6                 | Ping Pong      | 5/24/2024 12:34:56 PM | 000310c0-bcc8-42c4-b0c3-45ae611af06b |
		| 7                 | Donald Duck    | 5/24/2024 12:34:56 PM | 02c5061d-ecdc-4274-b5f1-e91d76bc3f37 |

Scenario: UpdateBatchAsyncNoRecords
	Given I don't reset the database after the scenario
	When I populate a list of the model 'AdventureWorksDemo.Data.Models.ProductCategoryModel'
		| ProductCategoryId | Name |
	And I call the method 'UpdateAsync' with the parameter values
		| Key    | Value      | TypeName                                                         |
		| models | {{models}} | IEnumerable<AdventureWorksDemo.Data.Models.ProductCategoryModel> |
	Then the result is of type
		| Expected                                                                                                                                 |
		| AdventureWorksDemo.Data.Models.ServiceResult<System.Collections.Generic.IEnumerable<AdventureWorksDemo.Data.Models.ProductCategoryModel> |
	And the result is
		| IsFailure | IsSuccess | Message                               |
		| True      | False     | Please select some records to update! |
	And the results property 'Value' contains
		| ProductCategoryId | Name | ModifiedDate | Rowguid |
	And the table 'Production.ProductCategory' contains
		| ProductCategoryId | Name                  | ModifiedDate         | Rowguid                              |
		| 1                 | Bikes                 | 6/1/2002 12:00:00 AM | cfbda25c-df71-47a7-b81b-64ee161aa37c |
		| 2                 | Components            | 6/1/2002 12:00:00 AM | c657828d-d808-4aba-91a3-af2ce02300e9 |
		| 3                 | Clothing              | 6/1/2002 12:00:00 AM | 10a7c342-ca82-48d4-8a38-46a2eb089b74 |
		| 4                 | Accessories           | 6/1/2002 12:00:00 AM | 2be3be36-d9a2-4eee-b593-ed895d97c2a6 |
		| 5                 | Mountain Bikes        | 6/1/2002 12:00:00 AM | 2d364ade-264a-433c-b092-4fcbf3804e01 |
		| 6                 | Road Bikes            | 6/1/2002 12:00:00 AM | 000310c0-bcc8-42c4-b0c3-45ae611af06b |
		| 7                 | For Delete Tests Only | 6/1/2002 12:00:00 AM | 02c5061d-ecdc-4274-b5f1-e91d76bc3f37 |

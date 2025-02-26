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
		| IsFailure | IsSuccess | Message                          |
		| True      | False     | Unable to find record to delete! |
	
	And the table 'Production.ProductCategory' contains
		| ProductCategoryId | Name                  | ModifiedDate         | Rowguid                              |
		| 1                 | Bikes                 | 6/1/2002 12:00:00 AM | cfbda25c-df71-47a7-b81b-64ee161aa37c |
		| 2                 | Components            | 6/1/2002 12:00:00 AM | c657828d-d808-4aba-91a3-af2ce02300e9 |
		| 3                 | Clothing              | 6/1/2002 12:00:00 AM | 10a7c342-ca82-48d4-8a38-46a2eb089b74 |
		| 4                 | Accessories           | 6/1/2002 12:00:00 AM | 2be3be36-d9a2-4eee-b593-ed895d97c2a6 |
		| 5                 | Mountain Bikes        | 6/1/2002 12:00:00 AM | 2d364ade-264a-433c-b092-4fcbf3804e01 |
		| 6                 | Road Bikes            | 6/1/2002 12:00:00 AM | 000310c0-bcc8-42c4-b0c3-45ae611af06b |
		| 7                 | For Delete Tests Only | 6/1/2002 12:00:00 AM | 02c5061d-ecdc-4274-b5f1-e91d76bc3f37 |
	
Scenario: DeleteAsync7
	Given I reset the database after the scenario
	When I call the method 'DeleteAsync' with the parameter values
		| Key               | Value | TypeName |
		| productCategoryId | 7     | int      |
	Then the result is of type
		| Expected                                                     |
		| AdventureWorksDemo.Data.Models.ServiceResult<System.Boolean> |
	And the result is
		| IsFailure | IsSuccess | Message |
		| False     | True      |         |
	Then the table 'Production.ProductCategory' contains
		| ProductCategoryId | Name           | ModifiedDate         | Rowguid                              |
		| 1                 | Bikes          | 6/1/2002 12:00:00 AM | cfbda25c-df71-47a7-b81b-64ee161aa37c |
		| 2                 | Components     | 6/1/2002 12:00:00 AM | c657828d-d808-4aba-91a3-af2ce02300e9 |
		| 3                 | Clothing       | 6/1/2002 12:00:00 AM | 10a7c342-ca82-48d4-8a38-46a2eb089b74 |
		| 4                 | Accessories    | 6/1/2002 12:00:00 AM | 2be3be36-d9a2-4eee-b593-ed895d97c2a6 |
		| 5                 | Mountain Bikes | 6/1/2002 12:00:00 AM | 2d364ade-264a-433c-b092-4fcbf3804e01 |
		| 6                 | Road Bikes     | 6/1/2002 12:00:00 AM | 000310c0-bcc8-42c4-b0c3-45ae611af06b |

	

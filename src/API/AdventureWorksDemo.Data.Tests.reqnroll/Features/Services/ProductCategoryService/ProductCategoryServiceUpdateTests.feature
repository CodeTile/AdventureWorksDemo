Feature: ProductCategoryServiceUpdateTests

System tests for the ProductCategoryService
Testing the methods UpdateAsync


Background:
	Given The service to test is 'AdventureWorksDemo.Data.Services.IProductCategoryService'
	And I reset the database after the scenario

Scenario: UpdateAsync
	Given the table 'Production.ProductCategory' filtered by 'ProductCategoryId > 5' contains
		| ProductCategoryId | ModifiedDate         | Name                  | Rowguid                              |
		| 6                 | 6/1/2002 12:00:00 AM | Road Bikes            | 000310c0-bcc8-42c4-b0c3-45ae611af06b |
		| 7                 | 6/1/2002 12:00:00 AM | For Delete Tests Only | 02c5061d-ecdc-4274-b5f1-e91d76bc3f37 |
	When I populate the model 'AdventureWorksDemo.Data.Models.ProductCategoryModel'
		| ProductCategoryId | Name              |
		| 6                 | How Now Brown Cow |
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
		| ProductCategoryId | ModifiedDate          | Name              | Rowguid                              |
		| 6                 | 5/24/2024 12:34:56 PM | How Now Brown Cow | 000310c0-bcc8-42c4-b0c3-45ae611af06b |

	And the table 'Production.ProductCategory' filtered by 'ProductCategoryId > 5' contains
		| ProductCategoryId | ModifiedDate          | Name                  | Rowguid                              |
		| 6                 | 5/24/2024 12:34:56 PM | How Now Brown Cow     | 000310c0-bcc8-42c4-b0c3-45ae611af06b |
		| 7                 | 6/1/2002 12:00:00 AM  | For Delete Tests Only | 02c5061d-ecdc-4274-b5f1-e91d76bc3f37 |
				
Scenario: UpdateNoChange
	Given I don't reset the database after the scenario
	When I populate the model 'AdventureWorksDemo.Data.Models.ProductCategoryModel'
		| ProductCategoryId | ModifiedDate         | Name                  | Rowguid                              |
		| 7                 | 6/1/2002 12:00:00 AM | For Delete Tests Only | 02c5061d-ecdc-4274-b5f1-e91d76bc3f37 |
	And I call the method 'UpdateAsync' with the parameter values
		| Key   | Value     | TypeName                                            |
		| model | {{model}} | AdventureWorksDemo.Data.Models.ProductCategoryModel |
	Then the result is of type
		| Expected                                                                                          |
		| AdventureWorksDemo.Data.Models.ServiceResult<AdventureWorksDemo.Data.Models.ProductCategoryModel> |
	And the result is
		| IsFailure | IsSuccess | Message                       |
		| False     | True      | Record is already up to date! |
	And the results property 'Value' contains
		| ProductCategoryId | ModifiedDate         | Name                  | Rowguid                              |
		| 7                 | 6/1/2002 12:00:00 AM | For Delete Tests Only | 02c5061d-ecdc-4274-b5f1-e91d76bc3f37 |
	And the table 'Production.ProductCategory' filtered by 'ProductCategoryId > 5' contains
		| ProductCategoryId | ModifiedDate         | Name                  | Rowguid                              |
		| 6                 | 6/1/2002 12:00:00 AM | Road Bikes            | 000310c0-bcc8-42c4-b0c3-45ae611af06b |
		| 7                 | 6/1/2002 12:00:00 AM | For Delete Tests Only | 02c5061d-ecdc-4274-b5f1-e91d76bc3f37 |
		
Scenario: UpdateShortName
	Given I don't reset the database after the scenario
	And the table 'Production.ProductCategory' filtered by 'ProductCategoryId > 5' contains
		| ProductCategoryId | ModifiedDate         | Name                  | Rowguid                              |
		| 6                 | 6/1/2002 12:00:00 AM | Road Bikes            | 000310c0-bcc8-42c4-b0c3-45ae611af06b |
		| 7                 | 6/1/2002 12:00:00 AM | For Delete Tests Only | 02c5061d-ecdc-4274-b5f1-e91d76bc3f37 |
	When I populate the model 'AdventureWorksDemo.Data.Models.ProductCategoryModel'
		| ProductCategoryId | Name |
		| 6                 | Hi   |
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
		| ProductCategoryId | Name | ModifiedDate         | Rowguid                              |
		| 6                 | Hi   | 6/1/2002 12:00:00 AM | 000310c0-bcc8-42c4-b0c3-45ae611af06b |

	And the table 'Production.ProductCategory' filtered by 'ProductCategoryId > 5' contains
		| ProductCategoryId | ModifiedDate         | Name                  | Rowguid                              |
		| 6                 | 6/1/2002 12:00:00 AM | Road Bikes            | 000310c0-bcc8-42c4-b0c3-45ae611af06b |
		| 7                 | 6/1/2002 12:00:00 AM | For Delete Tests Only | 02c5061d-ecdc-4274-b5f1-e91d76bc3f37 |

Scenario: UpdateUnknownRecord
	Given I don't reset the database after the scenario
	When I populate the model 'AdventureWorksDemo.Data.Models.ProductCategoryModel'
		| ProductCategoryId | Name                |
		| 1234              | UpdateUnknownRecord |
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
		| ProductCategoryId | ModifiedDate         | Name                | Rowguid                              |
		| 1234              | 1/1/0001 12:00:00 AM | UpdateUnknownRecord | 00000000-0000-0000-0000-000000000000 |

	And the table 'Production.ProductCategory' contains
		| ProductCategoryId | ModifiedDate         | Name                  | Rowguid                              |
		| 1                 | 6/1/2002 12:00:00 AM | Bikes                 | cfbda25c-df71-47a7-b81b-64ee161aa37c |
		| 2                 | 6/1/2002 12:00:00 AM | Components            | c657828d-d808-4aba-91a3-af2ce02300e9 |
		| 3                 | 6/1/2002 12:00:00 AM | Clothing              | 10a7c342-ca82-48d4-8a38-46a2eb089b74 |
		| 4                 | 6/1/2002 12:00:00 AM | Accessories           | 2be3be36-d9a2-4eee-b593-ed895d97c2a6 |
		| 5                 | 6/1/2002 12:00:00 AM | Mountain Bikes        | 2d364ade-264a-433c-b092-4fcbf3804e01 |
		| 6                 | 6/1/2002 12:00:00 AM | Road Bikes            | 000310c0-bcc8-42c4-b0c3-45ae611af06b |
		| 7                 | 6/1/2002 12:00:00 AM | For Delete Tests Only | 02c5061d-ecdc-4274-b5f1-e91d76bc3f37 |

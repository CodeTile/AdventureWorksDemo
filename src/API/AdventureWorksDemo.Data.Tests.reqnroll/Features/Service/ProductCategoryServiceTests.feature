Feature: ProductCategoryServiceTests

A short summary of the feature
Background:
	Given The service to test is 'AdventureWorksDemo.Data.Services.IProductCategoryService'
Scenario: FindAsync01
	When I call the method 'FindAsync' with the parameter values
		| Key               | Value | TypeName |
		| productCategoryId | 1     | int      |
	Then the result is of type
		| Expected                                            |
		| AdventureWorksDemo.Data.Models.ProductCategoryModel |
	And the result is
		| ModifiedDate         | Name  | ParentProductCategoryId | ProductCategoryId | Rowguid                              |
		| 6/1/2002 12:00:00 AM | Bikes |                         | 1                 | cfbda25c-df71-47a7-b81b-64ee161aa37c |
Scenario: FindAsync04
	When I call the method 'FindAsync' with the parameter values
		| Key               | Value | TypeName |
		| productCategoryId | 4     | int      |
	Then the result is of type
		| Expected                                            |
		| AdventureWorksDemo.Data.Models.ProductCategoryModel |
	And the result is
		| ModifiedDate         | Name        | ParentProductCategoryId | ProductCategoryId | Rowguid                              |
		| 6/1/2002 12:00:00 AM | Accessories |                         | 4                 | 2be3be36-d9a2-4eee-b593-ed895d97c2a6 |
		
Scenario: FindAsync1234
	When I call the method 'FindAsync' with the parameter values
		| Key               | Value | TypeName |
		| productCategoryId | 1234  | int      |

	Then the result is of type
		| Expected                                            |
		| AdventureWorksDemo.Data.Models.ProductCategoryModel |
	And the result is null
		
Scenario: FindAllAsync_1_5
	When I populate the model 'AdventureWorksDemo.Data.Paging.PagingFilter'
		| PageNumber | PageSize |
		| 1          | 5        |
	And I call the method 'FindAllAsync' with the parameter values
		| Key           | Value     | TypeName                                    |
		| pageingFilter | {{model}} | AdventureWorksDemo.Data.Paging.PagingFilter |
	Then the result is of type
		| Expected                                                                                      |
		| AdventureWorksDemo.Data.Paging.PagedList<AdventureWorksDemo.Data.Models.ProductCategoryModel> |
	And the results are
		| ModifiedDate         | Name           | ParentProductCategoryId | ProductCategoryId | Rowguid                              |
		| 6/1/2002 12:00:00 AM | Accessories    |                         | 4                 | 2be3be36-d9a2-4eee-b593-ed895d97c2a6 |
		| 6/1/2002 12:00:00 AM | Bikes          |                         | 1                 | cfbda25c-df71-47a7-b81b-64ee161aa37c |
		| 6/1/2002 12:00:00 AM | Components     |                         | 2                 | c657828d-d808-4aba-91a3-af2ce02300e9 |
		| 6/1/2002 12:00:00 AM | Clothing       |                         | 3                 | 10a7c342-ca82-48d4-8a38-46a2eb089b74 |
		| 6/1/2002 12:00:00 AM | Mountain Bikes | 1                       | 5                 | 2d364ade-264a-433c-b092-4fcbf3804e01 |


	
Scenario: FindAllAsync_2_5
	When I populate the model 'AdventureWorksDemo.Data.Paging.PagingFilter'
		| PageNumber | PageSize |
		| 1          | 5        |
	And I call the method 'FindAllAsync' with the parameter values
		| Key           | Value     | TypeName                                    |
		| pageingFilter | {{model}} | AdventureWorksDemo.Data.Paging.PagingFilter |
	Then the result is of type
		| Expected                                                                                      |
		| AdventureWorksDemo.Data.Paging.PagedList<AdventureWorksDemo.Data.Models.ProductCategoryModel> |
	And the results are
		| ModifiedDate         | Name           | ParentProductCategoryId | ProductCategoryId | Rowguid                              |
		| 6/1/2002 12:00:00 AM | Accessories    |                         | 4                 | 2be3be36-d9a2-4eee-b593-ed895d97c2a6 |
		| 6/1/2002 12:00:00 AM | Bikes          |                         | 1                 | cfbda25c-df71-47a7-b81b-64ee161aa37c |
		| 6/1/2002 12:00:00 AM | Components     |                         | 2                 | c657828d-d808-4aba-91a3-af2ce02300e9 |
		| 6/1/2002 12:00:00 AM | Clothing       |                         | 3                 | 10a7c342-ca82-48d4-8a38-46a2eb089b74 |
		| 6/1/2002 12:00:00 AM | Mountain Bikes | 1                       | 5                 | 2d364ade-264a-433c-b092-4fcbf3804e01 |



Scenario: FindAllAsync_1234_5
	When I populate the model 'AdventureWorksDemo.Data.Paging.PagingFilter'
		| PageNumber | PageSize |
		| 1234       | 5        |
	And I call the method 'FindAllAsync' with the parameter values
		| Key           | Value     | TypeName                                    |
		| pageingFilter | {{model}} | AdventureWorksDemo.Data.Paging.PagingFilter |
	Then the result is of type
		| Expected                                                                                      |
		| AdventureWorksDemo.Data.Paging.PagedList<AdventureWorksDemo.Data.Models.ProductCategoryModel> |
	And the results are
		| ModifiedDate | Name | ParentProductCategoryId | ProductCategoryId | Rowguid |


Scenario: FindAllAsync_0_5
	When I populate the model 'AdventureWorksDemo.Data.Paging.PagingFilter'
		| PageNumber | PageSize |
		| 0          | 5        |
	And I call the method 'FindAllAsync' with the parameter values
		| Key           | Value     | TypeName                                    |
		| pageingFilter | {{model}} | AdventureWorksDemo.Data.Paging.PagingFilter |
	Then the result is of type
		| Expected                           |
		| System.ArgumentOutOfRangeException |
	And the exception message is
		| Expected            |
		| Parameter pageNumber must be positive (Parameter 'pageNumber') |

Scenario: FindAllAsync_0_0
	When I populate the model 'AdventureWorksDemo.Data.Paging.PagingFilter'
		| PageNumber | PageSize |
		| 0          | 0        |
	And I call the method 'FindAllAsync' with the parameter values
		| Key           | Value     | TypeName                                    |
		| pageingFilter | {{model}} | AdventureWorksDemo.Data.Paging.PagingFilter |
	Then the result is of type
		| Expected                           |
		| System.ArgumentOutOfRangeException |
	And the exception message is
		| Expected            |
		| Parameter pageNumber must be positive (Parameter 'pageNumber') |
Scenario: FindAllAsync_5_0
	When I populate the model 'AdventureWorksDemo.Data.Paging.PagingFilter'
		| PageNumber | PageSize |
		| 5          | 0        |
	And I call the method 'FindAllAsync' with the parameter values
		| Key           | Value     | TypeName                                    |
		| pageingFilter | {{model}} | AdventureWorksDemo.Data.Paging.PagingFilter |
	Then the result is of type
		| Expected                           |
		| System.ArgumentOutOfRangeException |
	And the exception message is
		| Expected            |
		| Parameter pageSize must be positive (Parameter 'pageSize') |

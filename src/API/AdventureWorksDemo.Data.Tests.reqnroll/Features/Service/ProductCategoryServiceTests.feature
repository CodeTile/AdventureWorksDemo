Feature: ProductCategoryServiceTests

System tests for the ProductCategoryService

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
	And the PagedList values are
		| TotalPages | TotalCount | PageSize | CurrentPage | Count | Capacity |
		| 9          | 41         | 5        | 1           | 5     | 5        |
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
		| 2          | 5        |
	And I call the method 'FindAllAsync' with the parameter values
		| Key           | Value     | TypeName                                    |
		| pageingFilter | {{model}} | AdventureWorksDemo.Data.Paging.PagingFilter |
	Then the result is of type
		| Expected                                                                                      |
		| AdventureWorksDemo.Data.Paging.PagedList<AdventureWorksDemo.Data.Models.ProductCategoryModel> |
	And the PagedList values are
		| TotalPages | TotalCount | PageSize | CurrentPage | Count | Capacity |
		| 9          | 41         | 5        | 2           | 5     | 5        |
	And the results are
		| ModifiedDate         | Name            | ParentProductCategoryId | ProductCategoryId | Rowguid                              |
		| 6/1/2002 12:00:00 AM | Road Bikes      | 1                       | 6                 | 000310c0-bcc8-42c4-b0c3-45ae611af06b |
		| 6/1/2002 12:00:00 AM | Touring Bikes   | 1                       | 7                 | 02c5061d-ecdc-4274-b5f1-e91d76bc3f37 |
		| 6/1/2002 12:00:00 AM | Handlebars      | 2                       | 8                 | 3ef2c725-7135-4c85-9ae6-ae9a3bdd9283 |
		| 6/1/2002 12:00:00 AM | Bottom Brackets | 2                       | 9                 | a9e54089-8a1e-4cf5-8646-e3801f685934 |
		| 6/1/2002 12:00:00 AM | Brakes          | 2                       | 10                | d43ba4a3-ef0d-426b-90eb-4be4547dd30c |
		
Scenario: FindAllAsync_2_8
	When I populate the model 'AdventureWorksDemo.Data.Paging.PagingFilter'
		| PageNumber | PageSize |
		| 2          | 8        |
	And I call the method 'FindAllAsync' with the parameter values
		| Key           | Value     | TypeName                                    |
		| pageingFilter | {{model}} | AdventureWorksDemo.Data.Paging.PagingFilter |
	Then the result is of type
		| Expected                                                                                      |
		| AdventureWorksDemo.Data.Paging.PagedList<AdventureWorksDemo.Data.Models.ProductCategoryModel> |
	And the PagedList values are
		| TotalPages | TotalCount | PageSize | CurrentPage | Count | Capacity |
		| 6          | 41         | 8        | 2           | 8     | 8        |
	And the results are
		| ModifiedDate         | Name            | ParentProductCategoryId | ProductCategoryId | Rowguid                              |
		| 6/1/2002 12:00:00 AM | Bottom Brackets | 2                       | 9                 | a9e54089-8a1e-4cf5-8646-e3801f685934 |
		| 6/1/2002 12:00:00 AM | Brakes          | 2                       | 10                | d43ba4a3-ef0d-426b-90eb-4be4547dd30c |
		| 6/1/2002 12:00:00 AM | Chains          | 2                       | 11                | e93a7231-f16c-4b0f-8c41-c73fdec62da0 |
		| 6/1/2002 12:00:00 AM | Cranksets       | 2                       | 12                | 4f644521-422b-4f19-974a-e3df6102567e |
		| 6/1/2002 12:00:00 AM | Derailleurs     | 2                       | 13                | 1830d70c-aa2a-40c0-a271-5ba86f38f8bf |
		| 6/1/2002 12:00:00 AM | Forks           | 2                       | 14                | b5f9ba42-b69b-4fdd-b2ec-57fb7b42e3cf |
		| 6/1/2002 12:00:00 AM | Headsets        | 2                       | 15                | 7c782bbe-5a16-495a-aa50-10afe5a84af2 |
		| 6/1/2002 12:00:00 AM | Mountain Frames | 2                       | 16                | 61b21b65-e16a-4be7-9300-4d8e9db861be |

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
	And the PagedList values are
		| TotalPages | TotalCount | PageSize | CurrentPage | Count | Capacity |
		| 9          | 41         | 5        | 1234        | 0     | 0        |
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
		| Expected                                                       |
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
		| Expected                                                       |
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
		| Expected                                                   |
		| Parameter pageSize must be positive (Parameter 'pageSize') |

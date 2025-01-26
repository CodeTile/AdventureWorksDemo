Feature: ProductCategoryServiceFindTests

System tests for the ProductCategoryService
Testing the methods FindAsync and FindAllAsync


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
		| TotalPages | TotalCount | PageSize | CurrentPage | 
		| 9          | 42         | 5        | 1           | 
	And the results are
		| ModifiedDate         | Name           | ParentProductCategoryId | ProductCategoryId | Rowguid                              |
		| 6/1/2002 12:00:00 AM | Accessories    |                         | 4                 | 2be3be36-d9a2-4eee-b593-ed895d97c2a6 |
		| 6/1/2002 12:00:00 AM | Bikes          |                         | 1                 | cfbda25c-df71-47a7-b81b-64ee161aa37c |
		| 6/1/2002 12:00:00 AM | Components     |                         | 2                 | c657828d-d808-4aba-91a3-af2ce02300e9 |
		| 6/1/2002 12:00:00 AM | Clothing       |                         | 3                 | 10a7c342-ca82-48d4-8a38-46a2eb089b74 |
		| 6/1/2002 12:00:00 AM | Mountain Bikes | 1                       | 5                 | 2d364ade-264a-433c-b092-4fcbf3804e01 |
		
Scenario: FindAllAsync_1_500
	When I populate the model 'AdventureWorksDemo.Data.Paging.PagingFilter'
		| PageNumber | PageSize |
		| 1          | 500      |
	And I call the method 'FindAllAsync' with the parameter values
		| Key           | Value     | TypeName                                    |
		| pageingFilter | {{model}} | AdventureWorksDemo.Data.Paging.PagingFilter |
	Then the result is of type
		| Expected                                                                                      |
		| AdventureWorksDemo.Data.Paging.PagedList<AdventureWorksDemo.Data.Models.ProductCategoryModel> |
	And the PagedList values are
		| TotalPages | TotalCount | PageSize | CurrentPage | 
		| 1          | 42         | 100      | 1           | 
	And the results are
		| ProductCategoryId | ParentProductCategoryId | Name              | ModifiedDate         | Rowguid                              |
		| 1                 |                         | Bikes             | 6/1/2002 12:00:00 AM | cfbda25c-df71-47a7-b81b-64ee161aa37c |
		| 2                 |                         | Components        | 6/1/2002 12:00:00 AM | c657828d-d808-4aba-91a3-af2ce02300e9 |
		| 3                 |                         | Clothing          | 6/1/2002 12:00:00 AM | 10a7c342-ca82-48d4-8a38-46a2eb089b74 |
		| 4                 |                         | Accessories       | 6/1/2002 12:00:00 AM | 2be3be36-d9a2-4eee-b593-ed895d97c2a6 |
		| 5                 | 1                       | Mountain Bikes    | 6/1/2002 12:00:00 AM | 2d364ade-264a-433c-b092-4fcbf3804e01 |
		| 6                 | 1                       | Road Bikes        | 6/1/2002 12:00:00 AM | 000310c0-bcc8-42c4-b0c3-45ae611af06b |
		| 7                 | 1                       | Touring Bikes     | 6/1/2002 12:00:00 AM | 02c5061d-ecdc-4274-b5f1-e91d76bc3f37 |
		| 8                 | 2                       | Handlebars        | 6/1/2002 12:00:00 AM | 3ef2c725-7135-4c85-9ae6-ae9a3bdd9283 |
		| 9                 | 2                       | Bottom Brackets   | 6/1/2002 12:00:00 AM | a9e54089-8a1e-4cf5-8646-e3801f685934 |
		| 10                | 2                       | Brakes            | 6/1/2002 12:00:00 AM | d43ba4a3-ef0d-426b-90eb-4be4547dd30c |
		| 11                | 2                       | Chains            | 6/1/2002 12:00:00 AM | e93a7231-f16c-4b0f-8c41-c73fdec62da0 |
		| 12                | 2                       | Cranksets         | 6/1/2002 12:00:00 AM | 4f644521-422b-4f19-974a-e3df6102567e |
		| 13                | 2                       | Derailleurs       | 6/1/2002 12:00:00 AM | 1830d70c-aa2a-40c0-a271-5ba86f38f8bf |
		| 14                | 2                       | Forks             | 6/1/2002 12:00:00 AM | b5f9ba42-b69b-4fdd-b2ec-57fb7b42e3cf |
		| 15                | 2                       | Headsets          | 6/1/2002 12:00:00 AM | 7c782bbe-5a16-495a-aa50-10afe5a84af2 |
		| 16                | 2                       | Mountain Frames   | 6/1/2002 12:00:00 AM | 61b21b65-e16a-4be7-9300-4d8e9db861be |
		| 17                | 2                       | Pedals            | 6/1/2002 12:00:00 AM | 6d24ac07-7a84-4849-864a-865a14125bc9 |
		| 18                | 2                       | Road Frames       | 6/1/2002 12:00:00 AM | 5515f857-075b-4f9a-87b7-43b4997077b3 |
		| 19                | 2                       | Saddles           | 6/1/2002 12:00:00 AM | 049fffa3-9d30-46df-82f7-f20730ec02b3 |
		| 20                | 2                       | Touring Frames    | 6/1/2002 12:00:00 AM | d2e3f1a8-56c4-4f36-b29d-5659fc0d2789 |
		| 21                | 2                       | Wheels            | 6/1/2002 12:00:00 AM | 43521287-4b0b-438e-b80e-d82d9ad7c9f0 |
		| 22                | 3                       | Bib-Shorts        | 6/1/2002 12:00:00 AM | 67b58d2b-5798-4a90-8c6c-5ddacf057171 |
		| 23                | 3                       | Caps              | 6/1/2002 12:00:00 AM | 430dd6a8-a755-4b23-bb05-52520107da5f |
		| 24                | 3                       | Gloves            | 6/1/2002 12:00:00 AM | 92d5657b-0032-4e49-bad5-41a441a70942 |
		| 25                | 3                       | Jerseys           | 6/1/2002 12:00:00 AM | 09e91437-ba4f-4b1a-8215-74184fd95db8 |
		| 26                | 3                       | Shorts            | 6/1/2002 12:00:00 AM | 1a5ba5b3-03c3-457c-b11e-4fa85ede87da |
		| 27                | 3                       | Socks             | 6/1/2002 12:00:00 AM | 701019c3-09fe-4949-8386-c6ce686474e5 |
		| 28                | 3                       | Tights            | 6/1/2002 12:00:00 AM | 5deb3e55-9897-4416-b18a-515e970bc2d1 |
		| 29                | 3                       | Vests             | 6/1/2002 12:00:00 AM | 9ad7fe93-5ba0-4736-b578-ff80a2071297 |
		| 30                | 4                       | Bike Racks        | 6/1/2002 12:00:00 AM | 4624b5ce-66d6-496b-9201-c053df3556cc |
		| 31                | 4                       | Bike Stands       | 6/1/2002 12:00:00 AM | 43b445c8-b820-424e-a1d5-90d81da0b46f |
		| 32                | 4                       | Bottles and Cages | 6/1/2002 12:00:00 AM | 9b7dff41-9fa3-4776-8def-2c9a48c8b779 |
		| 33                | 4                       | Cleaners          | 6/1/2002 12:00:00 AM | 9ad3bcf0-244d-4ec4-a6a0-fb701351c6a3 |
		| 34                | 4                       | Fenders           | 6/1/2002 12:00:00 AM | 1697f8a2-0a08-4883-b7dd-d19117b4e9a7 |
		| 35                | 4                       | Helmets           | 6/1/2002 12:00:00 AM | f5e07a33-c9e0-439c-b5f3-9f25fb65becc |
		| 36                | 4                       | Hydration Packs   | 6/1/2002 12:00:00 AM | 646a8906-fc87-4267-a443-9c6d791e6693 |
		| 37                | 4                       | Lights            | 6/1/2002 12:00:00 AM | 954178ba-624f-42db-95f6-ca035f36d130 |
		| 38                | 4                       | Locks             | 6/1/2002 12:00:00 AM | 19646983-3fa0-4773-9a0c-f34c49df9bc8 |
		| 39                | 4                       | Panniers          | 6/1/2002 12:00:00 AM | 3002a5d5-fec3-464b-bef3-e0f81d35f431 |
		| 40                | 4                       | Pumps             | 6/1/2002 12:00:00 AM | fe4d46f2-c87c-48c5-a4a1-3f55712d80b1 |
		| 41                | 4                       | Tires and Tubes   | 6/1/2002 12:00:00 AM | 3c17c9ae-e906-48b4-bdd3-60e28d47dcdf |
		| 42                |                         | Record to Delete  | 6/1/2005 12:00:00 AM | 3c17c9ae-e906-48b4-bdd3-000000000001 |
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
		| TotalPages | TotalCount | PageSize | CurrentPage | 
		| 9          | 42         | 5        | 2           | 
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
		| TotalPages | TotalCount | PageSize | CurrentPage | 
		| 6          | 42         | 8        | 2           | 
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
		| TotalPages | TotalCount | PageSize | CurrentPage | 
		| 9          | 42         | 5        | 1234        |
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
		| Expected                                                                                      |
		| AdventureWorksDemo.Data.Paging.PagedList<AdventureWorksDemo.Data.Models.ProductCategoryModel> |

	And the PagedList values are
		| TotalPages | TotalCount | PageSize | CurrentPage |
		| 9          | 42         | 5        | 1           |
	And the results are
		| ModifiedDate         | Name           | ParentProductCategoryId | ProductCategoryId | Rowguid                              |
		| 6/1/2002 12:00:00 AM | Bikes          |                         | 1                 | cfbda25c-df71-47a7-b81b-64ee161aa37c |
		| 6/1/2002 12:00:00 AM | Components     |                         | 2                 | c657828d-d808-4aba-91a3-af2ce02300e9 |
		| 6/1/2002 12:00:00 AM | Clothing       |                         | 3                 | 10a7c342-ca82-48d4-8a38-46a2eb089b74 |
		| 6/1/2002 12:00:00 AM | Accessories    |                         | 4                 | 2be3be36-d9a2-4eee-b593-ed895d97c2a6 |
		| 6/1/2002 12:00:00 AM | Mountain Bikes | 1                       | 5                 | 2d364ade-264a-433c-b092-4fcbf3804e01 |

Scenario: FindAllAsync_0_0
	When I populate the model 'AdventureWorksDemo.Data.Paging.PagingFilter'
		| PageNumber | PageSize |
		| 0          | 0        |
	And I call the method 'FindAllAsync' with the parameter values
		| Key           | Value     | TypeName                                    |
		| pageingFilter | {{model}} | AdventureWorksDemo.Data.Paging.PagingFilter |
	Then the result is of type
		| Expected                                                                                      |
		| AdventureWorksDemo.Data.Paging.PagedList<AdventureWorksDemo.Data.Models.ProductCategoryModel> |

	And the PagedList values are
		| TotalPages | TotalCount | PageSize | CurrentPage |
		| 2          | 42         | 25       | 1           |
	And the results are
		| ModifiedDate         | Name            | ParentProductCategoryId | ProductCategoryId | Rowguid                              |
		| 6/1/2002 12:00:00 AM | Bikes           |                         | 1                 | cfbda25c-df71-47a7-b81b-64ee161aa37c |
		| 6/1/2002 12:00:00 AM | Components      |                         | 2                 | c657828d-d808-4aba-91a3-af2ce02300e9 |
		| 6/1/2002 12:00:00 AM | Clothing        |                         | 3                 | 10a7c342-ca82-48d4-8a38-46a2eb089b74 |
		| 6/1/2002 12:00:00 AM | Accessories     |                         | 4                 | 2be3be36-d9a2-4eee-b593-ed895d97c2a6 |
		| 6/1/2002 12:00:00 AM | Mountain Bikes  | 1                       | 5                 | 2d364ade-264a-433c-b092-4fcbf3804e01 |
		| 6/1/2002 12:00:00 AM | Road Bikes      | 1                       | 6                 | 000310c0-bcc8-42c4-b0c3-45ae611af06b |
		| 6/1/2002 12:00:00 AM | Touring Bikes   | 1                       | 7                 | 02c5061d-ecdc-4274-b5f1-e91d76bc3f37 |
		| 6/1/2002 12:00:00 AM | Handlebars      | 2                       | 8                 | 3ef2c725-7135-4c85-9ae6-ae9a3bdd9283 |
		| 6/1/2002 12:00:00 AM | Bottom Brackets | 2                       | 9                 | a9e54089-8a1e-4cf5-8646-e3801f685934 |
		| 6/1/2002 12:00:00 AM | Brakes          | 2                       | 10                | d43ba4a3-ef0d-426b-90eb-4be4547dd30c |
		| 6/1/2002 12:00:00 AM | Chains          | 2                       | 11                | e93a7231-f16c-4b0f-8c41-c73fdec62da0 |
		| 6/1/2002 12:00:00 AM | Cranksets       | 2                       | 12                | 4f644521-422b-4f19-974a-e3df6102567e |
		| 6/1/2002 12:00:00 AM | Derailleurs     | 2                       | 13                | 1830d70c-aa2a-40c0-a271-5ba86f38f8bf |
		| 6/1/2002 12:00:00 AM | Forks           | 2                       | 14                | b5f9ba42-b69b-4fdd-b2ec-57fb7b42e3cf |
		| 6/1/2002 12:00:00 AM | Headsets        | 2                       | 15                | 7c782bbe-5a16-495a-aa50-10afe5a84af2 |
		| 6/1/2002 12:00:00 AM | Mountain Frames | 2                       | 16                | 61b21b65-e16a-4be7-9300-4d8e9db861be |
		| 6/1/2002 12:00:00 AM | Pedals          | 2                       | 17                | 6d24ac07-7a84-4849-864a-865a14125bc9 |
		| 6/1/2002 12:00:00 AM | Road Frames     | 2                       | 18                | 5515f857-075b-4f9a-87b7-43b4997077b3 |
		| 6/1/2002 12:00:00 AM | Saddles         | 2                       | 19                | 049fffa3-9d30-46df-82f7-f20730ec02b3 |
		| 6/1/2002 12:00:00 AM | Touring Frames  | 2                       | 20                | d2e3f1a8-56c4-4f36-b29d-5659fc0d2789 |
		| 6/1/2002 12:00:00 AM | Wheels          | 2                       | 21                | 43521287-4b0b-438e-b80e-d82d9ad7c9f0 |
		| 6/1/2002 12:00:00 AM | Bib-Shorts      | 3                       | 22                | 67b58d2b-5798-4a90-8c6c-5ddacf057171 |
		| 6/1/2002 12:00:00 AM | Caps            | 3                       | 23                | 430dd6a8-a755-4b23-bb05-52520107da5f |
		| 6/1/2002 12:00:00 AM | Gloves          | 3                       | 24                | 92d5657b-0032-4e49-bad5-41a441a70942 |
		| 6/1/2002 12:00:00 AM | Jerseys         | 3                       | 25                | 09e91437-ba4f-4b1a-8215-74184fd95db8 |

Scenario: FindAllAsync_5_0
	When I populate the model 'AdventureWorksDemo.Data.Paging.PagingFilter'
		| PageNumber | PageSize |
		| 5          | 0        |
	And I call the method 'FindAllAsync' with the parameter values
		| Key           | Value     | TypeName                                    |
		| pageingFilter | {{model}} | AdventureWorksDemo.Data.Paging.PagingFilter |
	Then the result is of type
		| Expected                                                                                      |
		| AdventureWorksDemo.Data.Paging.PagedList<AdventureWorksDemo.Data.Models.ProductCategoryModel> |

	And the PagedList values are
		| TotalPages | TotalCount | PageSize | CurrentPage |
		| 2          | 42         | 25       | 5           |
	And the results are
		| ModifiedDate | Name | ParentProductCategoryId | ProductCategoryId | Rowguid |

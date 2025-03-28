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
		| ProductCategoryId | ModifiedDate         | Name  | Rowguid                              |
		| 1                 | 6/1/2002 12:00:00 AM | Bikes | cfbda25c-df71-47a7-b81b-64ee161aa37c |

Scenario: FindAsync04
	When I call the method 'FindAsync' with the parameter values
		| Key               | Value | TypeName |
		| productCategoryId | 4     | int      |
	Then the result is of type
		| Expected                                            |
		| AdventureWorksDemo.Data.Models.ProductCategoryModel |
	And the result is
		| ProductCategoryId | ModifiedDate         | Name        | Rowguid                              |
		| 4                 | 6/1/2002 12:00:00 AM | Accessories | 2be3be36-d9a2-4eee-b593-ed895d97c2a6 |
	
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
		| 2          | 7          | 5        | 0           |
	And the sorted results are
		| ProductCategoryId | ModifiedDate         | Name           | Rowguid                              |
		| 1                 | 6/1/2002 12:00:00 AM | Bikes          | cfbda25c-df71-47a7-b81b-64ee161aa37c |
		| 2                 | 6/1/2002 12:00:00 AM | Components     | c657828d-d808-4aba-91a3-af2ce02300e9 |
		| 3                 | 6/1/2002 12:00:00 AM | Clothing       | 10a7c342-ca82-48d4-8a38-46a2eb089b74 |
		| 4                 | 6/1/2002 12:00:00 AM | Accessories    | 2be3be36-d9a2-4eee-b593-ed895d97c2a6 |
		| 5                 | 6/1/2002 12:00:00 AM | Mountain Bikes | 2d364ade-264a-433c-b092-4fcbf3804e01 |

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
		| 1          | 7          | 25       | 0           |
	And the sorted results are
		| ProductCategoryId | ModifiedDate         | Name                  | Rowguid                              |
		| 1                 | 6/1/2002 12:00:00 AM | Bikes                 | cfbda25c-df71-47a7-b81b-64ee161aa37c |
		| 2                 | 6/1/2002 12:00:00 AM | Components            | c657828d-d808-4aba-91a3-af2ce02300e9 |
		| 3                 | 6/1/2002 12:00:00 AM | Clothing              | 10a7c342-ca82-48d4-8a38-46a2eb089b74 |
		| 4                 | 6/1/2002 12:00:00 AM | Accessories           | 2be3be36-d9a2-4eee-b593-ed895d97c2a6 |
		| 5                 | 6/1/2002 12:00:00 AM | Mountain Bikes        | 2d364ade-264a-433c-b092-4fcbf3804e01 |
		| 6                 | 6/1/2002 12:00:00 AM | Road Bikes            | 000310c0-bcc8-42c4-b0c3-45ae611af06b |
		| 7                 | 6/1/2002 12:00:00 AM | For Delete Tests Only | 02c5061d-ecdc-4274-b5f1-e91d76bc3f37 |

		
Scenario: FindAllAsync_0_500
	When I populate the model 'AdventureWorksDemo.Data.Paging.PagingFilter'
		| PageNumber | PageSize |
		| 0          | 500      |
	And I call the method 'FindAllAsync' with the parameter values
		| Key           | Value     | TypeName                                    |
		| pageingFilter | {{model}} | AdventureWorksDemo.Data.Paging.PagingFilter |
	Then the result is of type
		| Expected                                                                                      |
		| AdventureWorksDemo.Data.Paging.PagedList<AdventureWorksDemo.Data.Models.ProductCategoryModel> |
	And the PagedList values are
		| TotalPages | TotalCount | PageSize | CurrentPage |
		| 1          | 7          | 100      | 0           |
	And the sorted results are
		| ProductCategoryId | ModifiedDate         | Name                  | Rowguid                              |
		| 1                 | 6/1/2002 12:00:00 AM | Bikes                 | cfbda25c-df71-47a7-b81b-64ee161aa37c |
		| 2                 | 6/1/2002 12:00:00 AM | Components            | c657828d-d808-4aba-91a3-af2ce02300e9 |
		| 3                 | 6/1/2002 12:00:00 AM | Clothing              | 10a7c342-ca82-48d4-8a38-46a2eb089b74 |
		| 4                 | 6/1/2002 12:00:00 AM | Accessories           | 2be3be36-d9a2-4eee-b593-ed895d97c2a6 |
		| 5                 | 6/1/2002 12:00:00 AM | Mountain Bikes        | 2d364ade-264a-433c-b092-4fcbf3804e01 |
		| 6                 | 6/1/2002 12:00:00 AM | Road Bikes            | 000310c0-bcc8-42c4-b0c3-45ae611af06b |
		| 7                 | 6/1/2002 12:00:00 AM | For Delete Tests Only | 02c5061d-ecdc-4274-b5f1-e91d76bc3f37 |


Scenario: FindAllAsync_0_500_Sort_ProductCategoryId
	When I populate the model 'AdventureWorksDemo.Data.Paging.PagingFilter'
		| PageNumber | PageSize | Sorting           |
		| 0          | 500      | ProductCategoryId |
	And I call the method 'FindAllAsync' with the parameter values
		| Key           | Value     | TypeName                                    |
		| pageingFilter | {{model}} | AdventureWorksDemo.Data.Paging.PagingFilter |
	Then the result is of type
		| Expected                                                                                      |
		| AdventureWorksDemo.Data.Paging.PagedList<AdventureWorksDemo.Data.Models.ProductCategoryModel> |
	And the PagedList values are
		| TotalPages | TotalCount | PageSize | CurrentPage |
		| 1          | 7          | 100      | 0           |
	And the sorted results are
		| ProductCategoryId | ModifiedDate         | Name                  | Rowguid                              |
		| 1                 | 6/1/2002 12:00:00 AM | Bikes                 | cfbda25c-df71-47a7-b81b-64ee161aa37c |
		| 2                 | 6/1/2002 12:00:00 AM | Components            | c657828d-d808-4aba-91a3-af2ce02300e9 |
		| 3                 | 6/1/2002 12:00:00 AM | Clothing              | 10a7c342-ca82-48d4-8a38-46a2eb089b74 |
		| 4                 | 6/1/2002 12:00:00 AM | Accessories           | 2be3be36-d9a2-4eee-b593-ed895d97c2a6 |
		| 5                 | 6/1/2002 12:00:00 AM | Mountain Bikes        | 2d364ade-264a-433c-b092-4fcbf3804e01 |
		| 6                 | 6/1/2002 12:00:00 AM | Road Bikes            | 000310c0-bcc8-42c4-b0c3-45ae611af06b |
		| 7                 | 6/1/2002 12:00:00 AM | For Delete Tests Only | 02c5061d-ecdc-4274-b5f1-e91d76bc3f37 |

		
Scenario: FindAllAsync_0_500_Sort_ProductCategoryIdDesc
	When I populate the model 'AdventureWorksDemo.Data.Paging.PagingFilter'
		| PageNumber | PageSize | Sorting                |
		| 0          | 500      | ProductCategoryId DESC |
	And I call the method 'FindAllAsync' with the parameter values
		| Key           | Value     | TypeName                                    |
		| pageingFilter | {{model}} | AdventureWorksDemo.Data.Paging.PagingFilter |
	Then the result is of type
		| Expected                                                                                      |
		| AdventureWorksDemo.Data.Paging.PagedList<AdventureWorksDemo.Data.Models.ProductCategoryModel> |
	And the PagedList values are
		| TotalPages | TotalCount | PageSize | CurrentPage |
		| 1          | 7          | 100      | 0           |
	And the sorted results are
		| ProductCategoryId | ModifiedDate         | Name                  | Rowguid                              |
		| 7                 | 6/1/2002 12:00:00 AM | For Delete Tests Only | 02c5061d-ecdc-4274-b5f1-e91d76bc3f37 |
		| 6                 | 6/1/2002 12:00:00 AM | Road Bikes            | 000310c0-bcc8-42c4-b0c3-45ae611af06b |
		| 5                 | 6/1/2002 12:00:00 AM | Mountain Bikes        | 2d364ade-264a-433c-b092-4fcbf3804e01 |
		| 4                 | 6/1/2002 12:00:00 AM | Accessories           | 2be3be36-d9a2-4eee-b593-ed895d97c2a6 |
		| 3                 | 6/1/2002 12:00:00 AM | Clothing              | 10a7c342-ca82-48d4-8a38-46a2eb089b74 |
		| 2                 | 6/1/2002 12:00:00 AM | Components            | c657828d-d808-4aba-91a3-af2ce02300e9 |
		| 1                 | 6/1/2002 12:00:00 AM | Bikes                 | cfbda25c-df71-47a7-b81b-64ee161aa37c |

		
Scenario: FindAllAsync_0_500_Sort_ProductCategoryIdASC
	When I populate the model 'AdventureWorksDemo.Data.Paging.PagingFilter'
		| PageNumber | PageSize | Sorting               |
		| 0          | 500      | ProductCategoryId ASC |
	And I call the method 'FindAllAsync' with the parameter values
		| Key           | Value     | TypeName                                    |
		| pageingFilter | {{model}} | AdventureWorksDemo.Data.Paging.PagingFilter |
	Then the result is of type
		| Expected                                                                                      |
		| AdventureWorksDemo.Data.Paging.PagedList<AdventureWorksDemo.Data.Models.ProductCategoryModel> |
	And the PagedList values are
		| TotalPages | TotalCount | PageSize | CurrentPage |
		| 1          | 7          | 100      | 0           |
	And the sorted results are
		| ProductCategoryId | ModifiedDate         | Name                  | Rowguid                              |
		| 1                 | 6/1/2002 12:00:00 AM | Bikes                 | cfbda25c-df71-47a7-b81b-64ee161aa37c |
		| 2                 | 6/1/2002 12:00:00 AM | Components            | c657828d-d808-4aba-91a3-af2ce02300e9 |
		| 3                 | 6/1/2002 12:00:00 AM | Clothing              | 10a7c342-ca82-48d4-8a38-46a2eb089b74 |
		| 4                 | 6/1/2002 12:00:00 AM | Accessories           | 2be3be36-d9a2-4eee-b593-ed895d97c2a6 |
		| 5                 | 6/1/2002 12:00:00 AM | Mountain Bikes        | 2d364ade-264a-433c-b092-4fcbf3804e01 |
		| 6                 | 6/1/2002 12:00:00 AM | Road Bikes            | 000310c0-bcc8-42c4-b0c3-45ae611af06b |
		| 7                 | 6/1/2002 12:00:00 AM | For Delete Tests Only | 02c5061d-ecdc-4274-b5f1-e91d76bc3f37 |
	
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
		| 2          | 7          | 5        | 1           |
	And the sorted results are
		| ProductCategoryId | ModifiedDate         | Name                  | Rowguid                              |
		| 6                 | 6/1/2002 12:00:00 AM | Road Bikes            | 000310c0-bcc8-42c4-b0c3-45ae611af06b |
		| 7                 | 6/1/2002 12:00:00 AM | For Delete Tests Only | 02c5061d-ecdc-4274-b5f1-e91d76bc3f37 |

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
		| 2          | 7          | 5        | 1           |
	And the sorted results are
		| ProductCategoryId | ModifiedDate         | Name                  | Rowguid                              |
		| 6                 | 6/1/2002 12:00:00 AM | Road Bikes            | 000310c0-bcc8-42c4-b0c3-45ae611af06b |
		| 7                 | 6/1/2002 12:00:00 AM | For Delete Tests Only | 02c5061d-ecdc-4274-b5f1-e91d76bc3f37 |

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
		| 1          | 7          | 8        | 0           |
	And the sorted results are
		| ProductCategoryId | ModifiedDate         | Name                  | Rowguid                              |
		| 1                 | 6/1/2002 12:00:00 AM | Bikes                 | cfbda25c-df71-47a7-b81b-64ee161aa37c |
		| 2                 | 6/1/2002 12:00:00 AM | Components            | c657828d-d808-4aba-91a3-af2ce02300e9 |
		| 3                 | 6/1/2002 12:00:00 AM | Clothing              | 10a7c342-ca82-48d4-8a38-46a2eb089b74 |
		| 4                 | 6/1/2002 12:00:00 AM | Accessories           | 2be3be36-d9a2-4eee-b593-ed895d97c2a6 |
		| 5                 | 6/1/2002 12:00:00 AM | Mountain Bikes        | 2d364ade-264a-433c-b092-4fcbf3804e01 |
		| 6                 | 6/1/2002 12:00:00 AM | Road Bikes            | 000310c0-bcc8-42c4-b0c3-45ae611af06b |
		| 7                 | 6/1/2002 12:00:00 AM | For Delete Tests Only | 02c5061d-ecdc-4274-b5f1-e91d76bc3f37 |

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
		| 2          | 7          | 5        | 1           |
	And the sorted results are
		| ProductCategoryId | ModifiedDate         | Name                  | Rowguid                              |
		| 6                 | 6/1/2002 12:00:00 AM | Road Bikes            | 000310c0-bcc8-42c4-b0c3-45ae611af06b |
		| 7                 | 6/1/2002 12:00:00 AM | For Delete Tests Only | 02c5061d-ecdc-4274-b5f1-e91d76bc3f37 |

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
		| 1          | 7          | 25       | 0           |
	And the sorted results are
		| ProductCategoryId | ModifiedDate         | Name                  | Rowguid                              |
		| 1                 | 6/1/2002 12:00:00 AM | Bikes                 | cfbda25c-df71-47a7-b81b-64ee161aa37c |
		| 2                 | 6/1/2002 12:00:00 AM | Components            | c657828d-d808-4aba-91a3-af2ce02300e9 |
		| 3                 | 6/1/2002 12:00:00 AM | Clothing              | 10a7c342-ca82-48d4-8a38-46a2eb089b74 |
		| 4                 | 6/1/2002 12:00:00 AM | Accessories           | 2be3be36-d9a2-4eee-b593-ed895d97c2a6 |
		| 5                 | 6/1/2002 12:00:00 AM | Mountain Bikes        | 2d364ade-264a-433c-b092-4fcbf3804e01 |
		| 6                 | 6/1/2002 12:00:00 AM | Road Bikes            | 000310c0-bcc8-42c4-b0c3-45ae611af06b |
		| 7                 | 6/1/2002 12:00:00 AM | For Delete Tests Only | 02c5061d-ecdc-4274-b5f1-e91d76bc3f37 |


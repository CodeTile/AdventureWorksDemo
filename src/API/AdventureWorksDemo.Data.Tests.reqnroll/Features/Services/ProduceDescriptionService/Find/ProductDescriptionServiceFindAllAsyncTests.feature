Feature: ProductDescriptionServiceFindAllAsyncTests

System tests for the ProductDescriptionService
Testing the methods FindAllAsync

Background:
	Given The service to test is 'AdventureWorksDemo.Data.Services.IProductDescriptionService'

Scenario: FindAllAsync_0_0
	When I populate the model 'AdventureWorksDemo.Data.Paging.PagingFilter'
		| PageNumber | PageSize |
		| 0          | 0        |
	And I call the method 'FindAllAsync' with the parameter values
		| Key           | Value     | TypeName                                    |
		| pageingFilter | {{model}} | AdventureWorksDemo.Data.Paging.PagingFilter |
	Then the result is of type
		| Expected                                                                                         |
		| AdventureWorksDemo.Data.Paging.PagedList<AdventureWorksDemo.Data.Models.ProductDescriptionModel> |

	And the PagedList values are
		| TotalPages | TotalCount | PageSize | CurrentPage |
		| 1          | 7          | 25       | 0           |
	And the sorted results are
		| ProductDescriptionId | ModifiedDate              | Rowguid                              | Description                                                                                                                                                                               |
		| 1                    | 6/1/2007 12:00:00 AM      | 8e6746e5-ad97-46e2-bd24-fcea075c3b52 | Suitable for any type of riding, on or off-road. Fits any budget. Smooth-shifting with a comfortable ride.                                                                                |
		| 2                    | 6/1/2007 12:00:00 AM      | 7b1c4e90-85e2-4792-b47b-e0c424e2ec94 | This bike delivers a high-level of performance on a budget. It is responsive and maneuverable, and offers peace-of-mind when you decide to go off-road.                                   |
		| 3                    | 3/11/2008 10:32:17.973 AM | 130709e6-8512-49b9-9f62-1f5c99152056 | Serious back-country riding. Perfect for all levels of competition. Uses the same HL Frame as the Mountain-100.                                                                           |
		| 4                    | 6/1/2007 12:00:00 AM      | f5ff5ffd-cb7c-4ad6-bbc9-4d250bb6e98d | Entry level adult bike]; offers a comfortable ride cross-country or down the block. Quick-release hubs and rims.                                                                          |
		| 555                  | 6/1/2007 12:00:00 AM      | 741eae59-5e59-4dbc-9086-2633392c2582 | All-occasion value bike with our basic comfort and safety features. Offers wider, more stable tires for a ride around town or weekend trip.                                               |
		| 666                  | 6/1/2007 12:00:00 AM      | ddc955b2-843e-49ce-8f7b-54870f6135eb | The plush custom saddle keeps you riding all day,  and there's plenty of space to add panniers and bike bags to the newly-redesigned carrier.  This bike has stability when fully-loaded. |
		| 777                  | 6/1/2007 12:00:00 AM      | 9cfed570-180a-44ea-8233-55116a0ddcb9 | For Delete Tests Only                                                                                                                                                                     |


Scenario: FindAllAsync_0_5
	When I populate the model 'AdventureWorksDemo.Data.Paging.PagingFilter'
		| PageNumber | PageSize |
		| 0          | 5        |
	And I call the method 'FindAllAsync' with the parameter values
		| Key           | Value     | TypeName                                    |
		| pageingFilter | {{model}} | AdventureWorksDemo.Data.Paging.PagingFilter |
	Then the result is of type
		| Expected                                                                                         |
		| AdventureWorksDemo.Data.Paging.PagedList<AdventureWorksDemo.Data.Models.ProductDescriptionModel> |
	And the PagedList values are
		| TotalPages | TotalCount | PageSize | CurrentPage |
		| 2          | 7          | 5        | 0           |
	And the sorted results are
		| ProductDescriptionId | ModifiedDate              | Rowguid                              | Description                                                                                                                                             |
		| 1                    | 6/1/2007 12:00:00 AM      | 8e6746e5-ad97-46e2-bd24-fcea075c3b52 | Suitable for any type of riding, on or off-road. Fits any budget. Smooth-shifting with a comfortable ride.                                              |
		| 2                    | 6/1/2007 12:00:00 AM      | 7b1c4e90-85e2-4792-b47b-e0c424e2ec94 | This bike delivers a high-level of performance on a budget. It is responsive and maneuverable, and offers peace-of-mind when you decide to go off-road. |
		| 3                    | 3/11/2008 10:32:17.973 AM | 130709e6-8512-49b9-9f62-1f5c99152056 | Serious back-country riding. Perfect for all levels of competition. Uses the same HL Frame as the Mountain-100.                                         |
		| 4                    | 6/1/2007 12:00:00 AM      | f5ff5ffd-cb7c-4ad6-bbc9-4d250bb6e98d | Entry level adult bike]; offers a comfortable ride cross-country or down the block. Quick-release hubs and rims.                                        |
		| 555                  | 6/1/2007 12:00:00 AM      | 741eae59-5e59-4dbc-9086-2633392c2582 | All-occasion value bike with our basic comfort and safety features. Offers wider, more stable tires for a ride around town or weekend trip.             |
		
Scenario: FindAllAsync_0_500
	When I populate the model 'AdventureWorksDemo.Data.Paging.PagingFilter'
		| PageNumber | PageSize |
		| 0          | 500      |
	And I call the method 'FindAllAsync' with the parameter values
		| Key           | Value     | TypeName                                    |
		| pageingFilter | {{model}} | AdventureWorksDemo.Data.Paging.PagingFilter |
	Then the result is of type
		| Expected                                                                                         |
		| AdventureWorksDemo.Data.Paging.PagedList<AdventureWorksDemo.Data.Models.ProductDescriptionModel> |
	And the PagedList values are
		| TotalPages | TotalCount | PageSize | CurrentPage |
		| 1          | 7          | 100      | 0           |
		
	And the sorted results are
		| ProductDescriptionId | ModifiedDate              | Rowguid                              | Description                                                                                                                                                                               |
		| 1                    | 6/1/2007 12:00:00 AM      | 8e6746e5-ad97-46e2-bd24-fcea075c3b52 | Suitable for any type of riding, on or off-road. Fits any budget. Smooth-shifting with a comfortable ride.                                                                                |
		| 2                    | 6/1/2007 12:00:00 AM      | 7b1c4e90-85e2-4792-b47b-e0c424e2ec94 | This bike delivers a high-level of performance on a budget. It is responsive and maneuverable, and offers peace-of-mind when you decide to go off-road.                                   |
		| 3                    | 3/11/2008 10:32:17.973 AM | 130709e6-8512-49b9-9f62-1f5c99152056 | Serious back-country riding. Perfect for all levels of competition. Uses the same HL Frame as the Mountain-100.                                                                           |
		| 4                    | 6/1/2007 12:00:00 AM      | f5ff5ffd-cb7c-4ad6-bbc9-4d250bb6e98d | Entry level adult bike]; offers a comfortable ride cross-country or down the block. Quick-release hubs and rims.                                                                          |
		| 555                  | 6/1/2007 12:00:00 AM      | 741eae59-5e59-4dbc-9086-2633392c2582 | All-occasion value bike with our basic comfort and safety features. Offers wider, more stable tires for a ride around town or weekend trip.                                               |
		| 666                  | 6/1/2007 12:00:00 AM      | ddc955b2-843e-49ce-8f7b-54870f6135eb | The plush custom saddle keeps you riding all day,  and there's plenty of space to add panniers and bike bags to the newly-redesigned carrier.  This bike has stability when fully-loaded. |
		| 777                  | 6/1/2007 12:00:00 AM      | 9cfed570-180a-44ea-8233-55116a0ddcb9 | For Delete Tests Only                                                                                                                                                                     |
   
Scenario: FindAllAsync_1_5
	When I populate the model 'AdventureWorksDemo.Data.Paging.PagingFilter'
		| PageNumber | PageSize |
		| 1          | 5        |
	And I call the method 'FindAllAsync' with the parameter values
		| Key           | Value     | TypeName                                    |
		| pageingFilter | {{model}} | AdventureWorksDemo.Data.Paging.PagingFilter |
	Then the result is of type
		| Expected                                                                                         |
		| AdventureWorksDemo.Data.Paging.PagedList<AdventureWorksDemo.Data.Models.ProductDescriptionModel> |
	And the PagedList values are
		| TotalPages | TotalCount | PageSize | CurrentPage |
		| 2          | 7          | 5        | 1           |
	And the sorted results are
		| ProductDescriptionId | ModifiedDate         | Rowguid                              | Description                                                                                                                                                                               |
		| 666                  | 6/1/2007 12:00:00 AM | ddc955b2-843e-49ce-8f7b-54870f6135eb | The plush custom saddle keeps you riding all day,  and there's plenty of space to add panniers and bike bags to the newly-redesigned carrier.  This bike has stability when fully-loaded. |
		| 777                  | 6/1/2007 12:00:00 AM | 9cfed570-180a-44ea-8233-55116a0ddcb9 | For Delete Tests Only                                                                                                                                                                     |


Scenario: FindAllAsync_1_500
	When I populate the model 'AdventureWorksDemo.Data.Paging.PagingFilter'
		| PageNumber | PageSize |
		| 1          | 500      |
	And I call the method 'FindAllAsync' with the parameter values
		| Key           | Value     | TypeName                                    |
		| pageingFilter | {{model}} | AdventureWorksDemo.Data.Paging.PagingFilter |
	Then the result is of type
		| Expected                                                                                         |
		| AdventureWorksDemo.Data.Paging.PagedList<AdventureWorksDemo.Data.Models.ProductDescriptionModel> |
	And the PagedList values are
		| TotalPages | TotalCount | PageSize | CurrentPage |
		| 1          | 7          | 100      | 0           |
	And the sorted results are
		| ProductDescriptionId | ModifiedDate              | Rowguid                              | Description                                                                                                                                                                               |
		| 1                    | 6/1/2007 12:00:00 AM      | 8e6746e5-ad97-46e2-bd24-fcea075c3b52 | Suitable for any type of riding, on or off-road. Fits any budget. Smooth-shifting with a comfortable ride.                                                                                |
		| 2                    | 6/1/2007 12:00:00 AM      | 7b1c4e90-85e2-4792-b47b-e0c424e2ec94 | This bike delivers a high-level of performance on a budget. It is responsive and maneuverable, and offers peace-of-mind when you decide to go off-road.                                   |
		| 3                    | 3/11/2008 10:32:17.973 AM | 130709e6-8512-49b9-9f62-1f5c99152056 | Serious back-country riding. Perfect for all levels of competition. Uses the same HL Frame as the Mountain-100.                                                                           |
		| 4                    | 6/1/2007 12:00:00 AM      | f5ff5ffd-cb7c-4ad6-bbc9-4d250bb6e98d | Entry level adult bike]; offers a comfortable ride cross-country or down the block. Quick-release hubs and rims.                                                                          |
		| 555                  | 6/1/2007 12:00:00 AM      | 741eae59-5e59-4dbc-9086-2633392c2582 | All-occasion value bike with our basic comfort and safety features. Offers wider, more stable tires for a ride around town or weekend trip.                                               |
		| 666                  | 6/1/2007 12:00:00 AM      | ddc955b2-843e-49ce-8f7b-54870f6135eb | The plush custom saddle keeps you riding all day,  and there's plenty of space to add panniers and bike bags to the newly-redesigned carrier.  This bike has stability when fully-loaded. |
		| 777                  | 6/1/2007 12:00:00 AM      | 9cfed570-180a-44ea-8233-55116a0ddcb9 | For Delete Tests Only                                                                                                                                                                     |
		
Scenario: FindAllAsync_1234_5
	When I populate the model 'AdventureWorksDemo.Data.Paging.PagingFilter'
		| PageNumber | PageSize |
		| 1234       | 5        |
	And I call the method 'FindAllAsync' with the parameter values
		| Key           | Value     | TypeName                                    |
		| pageingFilter | {{model}} | AdventureWorksDemo.Data.Paging.PagingFilter |
	Then the result is of type
		| Expected                                                                                         |
		| AdventureWorksDemo.Data.Paging.PagedList<AdventureWorksDemo.Data.Models.ProductDescriptionModel> |
	And the PagedList values are
		| TotalPages | TotalCount | PageSize | CurrentPage |
		| 2          | 7          | 5        | 1           |
	And the sorted results are
		| ProductDescriptionId | ModifiedDate         | Rowguid                              | Description                                                                                                                                                                               |
		| 666                  | 6/1/2007 12:00:00 AM | ddc955b2-843e-49ce-8f7b-54870f6135eb | The plush custom saddle keeps you riding all day,  and there's plenty of space to add panniers and bike bags to the newly-redesigned carrier.  This bike has stability when fully-loaded. |
		| 777                  | 6/1/2007 12:00:00 AM | 9cfed570-180a-44ea-8233-55116a0ddcb9 | For Delete Tests Only                                                                                                                                                                     |


Scenario: FindAllAsync_2_5
	When I populate the model 'AdventureWorksDemo.Data.Paging.PagingFilter'
		| PageNumber | PageSize |
		| 2          | 5        |
	And I call the method 'FindAllAsync' with the parameter values
		| Key           | Value     | TypeName                                    |
		| pageingFilter | {{model}} | AdventureWorksDemo.Data.Paging.PagingFilter |
	Then the result is of type
		| Expected                                                                                         |
		| AdventureWorksDemo.Data.Paging.PagedList<AdventureWorksDemo.Data.Models.ProductDescriptionModel> |
	And the PagedList values are
		| TotalPages | TotalCount | PageSize | CurrentPage |
		| 2          | 7          | 5        | 1           |
	And the sorted results are
		| ProductDescriptionId | ModifiedDate         | Rowguid                              | Description                                                                                                                                                                               |
		| 666                  | 6/1/2007 12:00:00 AM | ddc955b2-843e-49ce-8f7b-54870f6135eb | The plush custom saddle keeps you riding all day,  and there's plenty of space to add panniers and bike bags to the newly-redesigned carrier.  This bike has stability when fully-loaded. |
		| 777                  | 6/1/2007 12:00:00 AM | 9cfed570-180a-44ea-8233-55116a0ddcb9 | For Delete Tests Only                                                                                                                                                                     |

Scenario: FindAllAsync_2_8
	When I populate the model 'AdventureWorksDemo.Data.Paging.PagingFilter'
		| PageNumber | PageSize |
		| 2          | 8        |
	And I call the method 'FindAllAsync' with the parameter values
		| Key           | Value     | TypeName                                    |
		| pageingFilter | {{model}} | AdventureWorksDemo.Data.Paging.PagingFilter |
	Then the result is of type
		| Expected                                                                                         |
		| AdventureWorksDemo.Data.Paging.PagedList<AdventureWorksDemo.Data.Models.ProductDescriptionModel> |
	And the PagedList values are
		| TotalPages | TotalCount | PageSize | CurrentPage |
		| 1          | 7          | 8        | 0           |
	And the sorted results are
		| ProductDescriptionId | ModifiedDate              | Rowguid                              | Description                                                                                                                                                                               |
		| 1                    | 6/1/2007 12:00:00 AM      | 8e6746e5-ad97-46e2-bd24-fcea075c3b52 | Suitable for any type of riding, on or off-road. Fits any budget. Smooth-shifting with a comfortable ride.                                                                                |
		| 2                    | 6/1/2007 12:00:00 AM      | 7b1c4e90-85e2-4792-b47b-e0c424e2ec94 | This bike delivers a high-level of performance on a budget. It is responsive and maneuverable, and offers peace-of-mind when you decide to go off-road.                                   |
		| 3                    | 3/11/2008 10:32:17.973 AM | 130709e6-8512-49b9-9f62-1f5c99152056 | Serious back-country riding. Perfect for all levels of competition. Uses the same HL Frame as the Mountain-100.                                                                           |
		| 4                    | 6/1/2007 12:00:00 AM      | f5ff5ffd-cb7c-4ad6-bbc9-4d250bb6e98d | Entry level adult bike]; offers a comfortable ride cross-country or down the block. Quick-release hubs and rims.                                                                          |
		| 555                  | 6/1/2007 12:00:00 AM      | 741eae59-5e59-4dbc-9086-2633392c2582 | All-occasion value bike with our basic comfort and safety features. Offers wider, more stable tires for a ride around town or weekend trip.                                               |
		| 666                  | 6/1/2007 12:00:00 AM      | ddc955b2-843e-49ce-8f7b-54870f6135eb | The plush custom saddle keeps you riding all day,  and there's plenty of space to add panniers and bike bags to the newly-redesigned carrier.  This bike has stability when fully-loaded. |
		| 777                  | 6/1/2007 12:00:00 AM      | 9cfed570-180a-44ea-8233-55116a0ddcb9 | For Delete Tests Only                                                                                                                                                                     |

Scenario: FindAllAsync_20_20
	When I populate the model 'AdventureWorksDemo.Data.Paging.PagingFilter'
		| PageNumber | PageSize |
		| 2          | 8        |
	And I call the method 'FindAllAsync' with the parameter values
		| Key           | Value     | TypeName                                    |
		| pageingFilter | {{model}} | AdventureWorksDemo.Data.Paging.PagingFilter |
	Then the result is of type
		| Expected                                                                                         |
		| AdventureWorksDemo.Data.Paging.PagedList<AdventureWorksDemo.Data.Models.ProductDescriptionModel> |
	And the PagedList values are
		| TotalPages | TotalCount | PageSize | CurrentPage |
		| 1          | 7          | 8        | 0           |

	And the sorted results are
		| ProductDescriptionId | ModifiedDate              | Rowguid                              | Description                                                                                                                                                                               |
		| 1                    | 6/1/2007 12:00:00 AM      | 8e6746e5-ad97-46e2-bd24-fcea075c3b52 | Suitable for any type of riding, on or off-road. Fits any budget. Smooth-shifting with a comfortable ride.                                                                                |
		| 2                    | 6/1/2007 12:00:00 AM      | 7b1c4e90-85e2-4792-b47b-e0c424e2ec94 | This bike delivers a high-level of performance on a budget. It is responsive and maneuverable, and offers peace-of-mind when you decide to go off-road.                                   |
		| 3                    | 3/11/2008 10:32:17.973 AM | 130709e6-8512-49b9-9f62-1f5c99152056 | Serious back-country riding. Perfect for all levels of competition. Uses the same HL Frame as the Mountain-100.                                                                           |
		| 4                    | 6/1/2007 12:00:00 AM      | f5ff5ffd-cb7c-4ad6-bbc9-4d250bb6e98d | Entry level adult bike]; offers a comfortable ride cross-country or down the block. Quick-release hubs and rims.                                                                          |
		| 555                  | 6/1/2007 12:00:00 AM      | 741eae59-5e59-4dbc-9086-2633392c2582 | All-occasion value bike with our basic comfort and safety features. Offers wider, more stable tires for a ride around town or weekend trip.                                               |
		| 666                  | 6/1/2007 12:00:00 AM      | ddc955b2-843e-49ce-8f7b-54870f6135eb | The plush custom saddle keeps you riding all day,  and there's plenty of space to add panniers and bike bags to the newly-redesigned carrier.  This bike has stability when fully-loaded. |
		| 777                  | 6/1/2007 12:00:00 AM      | 9cfed570-180a-44ea-8233-55116a0ddcb9 | For Delete Tests Only                                                                                                                                                                     |

Scenario: FindAllAsync_7_5
	When I populate the model 'AdventureWorksDemo.Data.Paging.PagingFilter'
		| PageNumber | PageSize |
		| 7          | 5        |
	And I call the method 'FindAllAsync' with the parameter values
		| Key           | Value     | TypeName                                    |
		| pageingFilter | {{model}} | AdventureWorksDemo.Data.Paging.PagingFilter |
	Then the result is of type
		| Expected                                                                                         |
		| AdventureWorksDemo.Data.Paging.PagedList<AdventureWorksDemo.Data.Models.ProductDescriptionModel> |
	And the PagedList values are
		| TotalPages | TotalCount | PageSize | CurrentPage |
		| 2          | 7          | 5        | 1           |
	And the sorted results are
		| ProductDescriptionId | ModifiedDate         | Rowguid                              | Description                                                                                                                                                                               |
		| 666                  | 6/1/2007 12:00:00 AM | ddc955b2-843e-49ce-8f7b-54870f6135eb | The plush custom saddle keeps you riding all day,  and there's plenty of space to add panniers and bike bags to the newly-redesigned carrier.  This bike has stability when fully-loaded. |
		| 777                  | 6/1/2007 12:00:00 AM | 9cfed570-180a-44ea-8233-55116a0ddcb9 | For Delete Tests Only                                                                                                                                                                     |
   
Scenario: FindAllAsync_8_5
	When I populate the model 'AdventureWorksDemo.Data.Paging.PagingFilter'
		| PageNumber | PageSize |
		| 8          | 5        |
	And I call the method 'FindAllAsync' with the parameter values
		| Key           | Value     | TypeName                                    |
		| pageingFilter | {{model}} | AdventureWorksDemo.Data.Paging.PagingFilter |
	Then the result is of type
		| Expected                                                                                         |
		| AdventureWorksDemo.Data.Paging.PagedList<AdventureWorksDemo.Data.Models.ProductDescriptionModel> |
	And the PagedList values are
		| TotalPages | TotalCount | PageSize | CurrentPage |
		| 2          | 7          | 5        | 1           |
	And the sorted results are
		| ProductDescriptionId | ModifiedDate         | Rowguid                              | Description                                                                                                                                                                               |
		| 666                  | 6/1/2007 12:00:00 AM | ddc955b2-843e-49ce-8f7b-54870f6135eb | The plush custom saddle keeps you riding all day,  and there's plenty of space to add panniers and bike bags to the newly-redesigned carrier.  This bike has stability when fully-loaded. |
		| 777                  | 6/1/2007 12:00:00 AM | 9cfed570-180a-44ea-8233-55116a0ddcb9 | For Delete Tests Only                                                                                                                                                                     |
   
Scenario: FindAllAsync_5_0
	When I populate the model 'AdventureWorksDemo.Data.Paging.PagingFilter'
		| PageNumber | PageSize |
		| 5          | 0        |
	And I call the method 'FindAllAsync' with the parameter values
		| Key           | Value     | TypeName                                    |
		| pageingFilter | {{model}} | AdventureWorksDemo.Data.Paging.PagingFilter |
	Then the result is of type
		| Expected                                                                                         |
		| AdventureWorksDemo.Data.Paging.PagedList<AdventureWorksDemo.Data.Models.ProductDescriptionModel> |
	And the PagedList values are
		| TotalPages | TotalCount | PageSize | CurrentPage |
		| 1          | 7          | 25       | 0           |

	And the sorted results are
		| ProductDescriptionId | ModifiedDate              | Rowguid                              | Description                                                                                                                                                                               |
		| 1                    | 6/1/2007 12:00:00 AM      | 8e6746e5-ad97-46e2-bd24-fcea075c3b52 | Suitable for any type of riding, on or off-road. Fits any budget. Smooth-shifting with a comfortable ride.                                                                                |
		| 2                    | 6/1/2007 12:00:00 AM      | 7b1c4e90-85e2-4792-b47b-e0c424e2ec94 | This bike delivers a high-level of performance on a budget. It is responsive and maneuverable, and offers peace-of-mind when you decide to go off-road.                                   |
		| 3                    | 3/11/2008 10:32:17.973 AM | 130709e6-8512-49b9-9f62-1f5c99152056 | Serious back-country riding. Perfect for all levels of competition. Uses the same HL Frame as the Mountain-100.                                                                           |
		| 4                    | 6/1/2007 12:00:00 AM      | f5ff5ffd-cb7c-4ad6-bbc9-4d250bb6e98d | Entry level adult bike]; offers a comfortable ride cross-country or down the block. Quick-release hubs and rims.                                                                          |
		| 555                  | 6/1/2007 12:00:00 AM      | 741eae59-5e59-4dbc-9086-2633392c2582 | All-occasion value bike with our basic comfort and safety features. Offers wider, more stable tires for a ride around town or weekend trip.                                               |
		| 666                  | 6/1/2007 12:00:00 AM      | ddc955b2-843e-49ce-8f7b-54870f6135eb | The plush custom saddle keeps you riding all day,  and there's plenty of space to add panniers and bike bags to the newly-redesigned carrier.  This bike has stability when fully-loaded. |
		| 777                  | 6/1/2007 12:00:00 AM      | 9cfed570-180a-44ea-8233-55116a0ddcb9 | For Delete Tests Only                                                                                                                                                                     |

	
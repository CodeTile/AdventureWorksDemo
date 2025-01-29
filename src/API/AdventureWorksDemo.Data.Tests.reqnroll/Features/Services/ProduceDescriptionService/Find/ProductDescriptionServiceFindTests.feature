Feature: ProductDescriptionServiceFindTests

System tests for the ProductDescriptionService
Testing the methods FindAsync and FindAllAsync


Background:
	Given The service to test is 'AdventureWorksDemo.Data.Services.IProductDescriptionService'

Scenario: FindAsync1234
	When I call the method 'FindAsync' with the parameter values
		| Key                  | Value | TypeName |
		| ProductDescriptionId | 1234  | int      |

	Then the result is of type
		| Expected                                               |
		| AdventureWorksDemo.Data.Models.ProductDescriptionModel |
	And the result is null

Scenario: FindAsync209
	When I call the method 'FindAsync' with the parameter values
		| Key                  | Value | TypeName |
		| ProductDescriptionId | 209   | int      |
	Then the result is of type
		| Expected                                               |
		| AdventureWorksDemo.Data.Models.ProductDescriptionModel |
	And the result is
		| ProductDescriptionId | ModifiedDate         | Rowguid                              | Description                                                                                                     |
		| 209                  | 6/1/2007 12:00:00 AM | f5ff5ffd-cb7c-4ad6-bbc9-4d250bb6e98d | Entry level adult bike; offers a comfortable ride cross-country or down the block. Quick-release hubs and rims. |
	
Scenario: FindAsync513
	When I call the method 'FindAsync' with the parameter values
		| Key                  | Value | TypeName |
		| ProductDescriptionId | 513   | int      |
	Then the result is of type
		| Expected                                               |
		| AdventureWorksDemo.Data.Models.ProductDescriptionModel |
	And the result is
		| ProductDescriptionId | ModifiedDate         | Rowguid                              | Description                                                                                                                                 |
		| 513                  | 6/1/2007 12:00:00 AM | 741eae59-5e59-4dbc-9086-2633392c2582 | All-occasion value bike with our basic comfort and safety features. Offers wider, more stable tires for a ride around town or weekend trip. |
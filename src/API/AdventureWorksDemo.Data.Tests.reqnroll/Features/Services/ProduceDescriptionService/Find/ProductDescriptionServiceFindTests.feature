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

Scenario: FindAsync3
	When I call the method 'FindAsync' with the parameter values
		| Key                  | Value | TypeName |
		| ProductDescriptionId | 3     | int      |
	Then the result is of type
		| Expected                                               |
		| AdventureWorksDemo.Data.Models.ProductDescriptionModel |
	And the result is
		| ProductDescriptionId | ModifiedDate              | Rowguid                              | Description                                                                                                     |
		| 3                    | 3/11/2008 10:32:17.973 AM | 130709e6-8512-49b9-9f62-1f5c99152056 | Serious back-country riding. Perfect for all levels of competition. Uses the same HL Frame as the Mountain-100. |

Scenario: FindAsync555
	When I call the method 'FindAsync' with the parameter values
		| Key                  | Value | TypeName |
		| ProductDescriptionId | 555   | int      |
	Then the result is of type
		| Expected                                               |
		| AdventureWorksDemo.Data.Models.ProductDescriptionModel |
	And the result is
		| ProductDescriptionId | ModifiedDate         | Rowguid                              | Description                                                                                                                                 |
		| 555                  | 6/1/2007 12:00:00 AM | 741eae59-5e59-4dbc-9086-2633392c2582 | All-occasion value bike with our basic comfort and safety features. Offers wider, more stable tires for a ride around town or weekend trip. |
	
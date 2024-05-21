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
		
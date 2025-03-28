Feature: ProductDescriptionServiceUpdateTests

System tests for the ProductDescriptionService
Testing the methods UpdateAsync


Background:
	Given The service to test is 'AdventureWorksDemo.Data.Services.IProductDescriptionService'
	And I reset the database after the scenario

Scenario: Update666
	Given the table 'Production.ProductDescription' filtered by 'ProductDescriptionId > 555' contains
		| ProductDescriptionId | ModifiedDate         | Rowguid                              | Description                                                                                                                                                                               |
		| 666                  | 6/1/2007 12:00:00 AM | ddc955b2-843e-49ce-8f7b-54870f6135eb | The plush custom saddle keeps you riding all day,  and there's plenty of space to add panniers and bike bags to the newly-redesigned carrier.  This bike has stability when fully-loaded. |
		| 777                  | 6/1/2007 12:00:00 AM | 9cfed570-180a-44ea-8233-55116a0ddcb9 | For Delete Tests Only                                                                                                                                                                     |
	When I populate the model 'AdventureWorksDemo.Data.Models.ProductDescriptionModel'
		| ProductDescriptionId | Description |
		| 666                  | Ping Pong   |
	And I call the method 'UpdateAsync' with the parameter values
		| Key   | Value     | TypeName                                               |
		| model | {{model}} | AdventureWorksDemo.Data.Models.ProductDescriptionModel |
	Then the result is of type
		| Expected                                                                                             |
		| AdventureWorksDemo.Data.Models.ServiceResult<AdventureWorksDemo.Data.Models.ProductDescriptionModel> |
	And the result is
		| IsFailure | IsSuccess | Message |
		| False     | True      |         |
	And the results property 'Value' contains
		| ProductDescriptionId | ModifiedDate          | Rowguid                              | Description |
		| 666                  | 5/24/2024 12:34:56 PM | ddc955b2-843e-49ce-8f7b-54870f6135eb | Ping Pong   |

	And the table 'Production.ProductDescription' filtered by 'ProductDescriptionId > 555 ' contains
		| ProductDescriptionId | ModifiedDate          | Rowguid                              | Description           |
		| 666                  | 5/24/2024 12:34:56 PM | ddc955b2-843e-49ce-8f7b-54870f6135eb | Ping Pong             |
		| 777                  | 6/1/2007 12:00:00 AM  | 9cfed570-180a-44ea-8233-55116a0ddcb9 | For Delete Tests Only |

		
Scenario: Update666ShortName
	Given the table 'Production.ProductDescription' filtered by 'ProductDescriptionId > 555' contains
		| ProductDescriptionId | ModifiedDate         | Rowguid                              | Description                                                                                                                                                                               |
		| 666                  | 6/1/2007 12:00:00 AM | ddc955b2-843e-49ce-8f7b-54870f6135eb | The plush custom saddle keeps you riding all day,  and there's plenty of space to add panniers and bike bags to the newly-redesigned carrier.  This bike has stability when fully-loaded. |
		| 777                  | 6/1/2007 12:00:00 AM | 9cfed570-180a-44ea-8233-55116a0ddcb9 | For Delete Tests Only                                                                                                                                                                     |

	When I populate the model 'AdventureWorksDemo.Data.Models.ProductDescriptionModel'
		| ProductDescriptionId | Description |
		| 666                  | Hi          |
	And I call the method 'UpdateAsync' with the parameter values
		| Key   | Value     | TypeName                                               |
		| model | {{model}} | AdventureWorksDemo.Data.Models.ProductDescriptionModel |
	Then the result is of type
		| Expected                                                                                             |
		| AdventureWorksDemo.Data.Models.ServiceResult<AdventureWorksDemo.Data.Models.ProductDescriptionModel> |
	And the result is
		| IsFailure | IsSuccess |
		| True      | False     |
	And the results property 'Message' contains
		| Expected                                                                      |
		| 'Description' must be between 3 and 400 characters. You entered 2 characters. |
	And the results property 'Value' contains
		| ProductDescriptionId | ModifiedDate         | Rowguid                              | Description |
		| 666                  | 6/1/2007 12:00:00 AM | ddc955b2-843e-49ce-8f7b-54870f6135eb | Hi          |
	And the table 'Production.ProductDescription' filtered by 'ProductDescriptionId > 555' contains
		| ProductDescriptionId | ModifiedDate         | Rowguid                              | Description                                                                                                                                                                               |
		| 666                  | 6/1/2007 12:00:00 AM | ddc955b2-843e-49ce-8f7b-54870f6135eb | The plush custom saddle keeps you riding all day,  and there's plenty of space to add panniers and bike bags to the newly-redesigned carrier.  This bike has stability when fully-loaded. |
		| 777                  | 6/1/2007 12:00:00 AM | 9cfed570-180a-44ea-8233-55116a0ddcb9 | For Delete Tests Only                                                                                                                                                                     |
		
Scenario: Update777LongName
	Given the table 'Production.ProductDescription' filtered by 'ProductDescriptionId > 555' contains
		| ProductDescriptionId | ModifiedDate         | Rowguid                              | Description                                                                                                                                                                               |
		| 666                  | 6/1/2007 12:00:00 AM | ddc955b2-843e-49ce-8f7b-54870f6135eb | The plush custom saddle keeps you riding all day,  and there's plenty of space to add panniers and bike bags to the newly-redesigned carrier.  This bike has stability when fully-loaded. |
		| 777                  | 6/1/2007 12:00:00 AM | 9cfed570-180a-44ea-8233-55116a0ddcb9 | For Delete Tests Only                                                                                                                                                                     |
	When I populate the model 'AdventureWorksDemo.Data.Models.ProductDescriptionModel'
		| ProductDescriptionId | Description   |
		| 777                  | {{Pad:x:401}} |
	And I call the method 'UpdateAsync' with the parameter values
		| Key   | Value     | TypeName                                               |
		| model | {{model}} | AdventureWorksDemo.Data.Models.ProductDescriptionModel |
	Then the result is of type
		| Expected                                                                                             |
		| AdventureWorksDemo.Data.Models.ServiceResult<AdventureWorksDemo.Data.Models.ProductDescriptionModel> |
	And the result is
		| IsFailure | IsSuccess | Message                                                                         |
		| True      | False     | 'Description' must be between 3 and 400 characters. You entered 401 characters. |
	And the results property 'Value' contains
		| ProductDescriptionId | ModifiedDate         | Rowguid                              | Description   |
		| 777                  | 6/1/2007 12:00:00 AM | 9cfed570-180a-44ea-8233-55116a0ddcb9 | {{Pad:x:401}} |
	And the table 'Production.ProductDescription' filtered by 'ProductDescriptionId > 555' contains
		| ProductDescriptionId | ModifiedDate         | Rowguid                              | Description                                                                                                                                                                               |
		| 666                  | 6/1/2007 12:00:00 AM | ddc955b2-843e-49ce-8f7b-54870f6135eb | The plush custom saddle keeps you riding all day,  and there's plenty of space to add panniers and bike bags to the newly-redesigned carrier.  This bike has stability when fully-loaded. |
		| 777                  | 6/1/2007 12:00:00 AM | 9cfed570-180a-44ea-8233-55116a0ddcb9 | For Delete Tests Only                                                                                                                                                                     |


Scenario: Update777NoChange
	Given I don't reset the database after the scenario
	When I populate the model 'AdventureWorksDemo.Data.Models.ProductDescriptionModel'
		| ProductDescriptionId | Description                    |
		| 777                  | Orphan record to deletion test |
	And I call the method 'UpdateAsync' with the parameter values
		| Key   | Value     | TypeName                                               |
		| model | {{model}} | AdventureWorksDemo.Data.Models.ProductDescriptionModel |
	Then the result is of type
		| Expected                                                                                             |
		| AdventureWorksDemo.Data.Models.ServiceResult<AdventureWorksDemo.Data.Models.ProductDescriptionModel> |
	And the result is
		| IsFailure | IsSuccess | Message |
		| False     | True      |         |
	And the results property 'Value' contains
		| ProductDescriptionId | ModifiedDate          | Rowguid                              | Description                    |
		| 777                  | 5/24/2024 12:34:56 PM | 9cfed570-180a-44ea-8233-55116a0ddcb9 | Orphan record to deletion test |
	And the table 'Production.ProductDescription' filtered by 'ProductDescriptionId > 555' contains
		| ProductDescriptionId | ModifiedDate          | Rowguid                              | Description                                                                                                                                                                               |
		| 666                  | 6/1/2007 12:00:00 AM  | ddc955b2-843e-49ce-8f7b-54870f6135eb | The plush custom saddle keeps you riding all day,  and there's plenty of space to add panniers and bike bags to the newly-redesigned carrier.  This bike has stability when fully-loaded. |
		| 777                  | 5/24/2024 12:34:56 PM | 9cfed570-180a-44ea-8233-55116a0ddcb9 | Orphan record to deletion test                                                                                                                                                            |

Scenario: UpdateUnknownRecord
	Given I don't reset the database after the scenario
	When I populate the model 'AdventureWorksDemo.Data.Models.ProductDescriptionModel'
		| ProductDescriptionId | Description         |
		| 1234                 | UpdateUnknownRecord |
	And I call the method 'UpdateAsync' with the parameter values
		| Key   | Value     | TypeName                                               |
		| model | {{model}} | AdventureWorksDemo.Data.Models.ProductDescriptionModel |
	Then the result is of type
		| Expected                                                                                             |
		| AdventureWorksDemo.Data.Models.ServiceResult<AdventureWorksDemo.Data.Models.ProductDescriptionModel> |
		
	And the result is
		| IsFailure | IsSuccess | Message                            |
		| True      | False     | Unable to locate record to update! |

	And the results property 'Value' contains
		| ProductDescriptionId | ModifiedDate         | Rowguid                              | Description         |
		| 1234                 | 1/1/0001 12:00:00 AM | 00000000-0000-0000-0000-000000000000 | UpdateUnknownRecord |
	And the table 'Production.ProductDescription' filtered by 'ProductDescriptionId > 555' contains
		| ProductDescriptionId | ModifiedDate         | Rowguid                              | Description                                                                                                                                                                               |
		| 666                  | 6/1/2007 12:00:00 AM | ddc955b2-843e-49ce-8f7b-54870f6135eb | The plush custom saddle keeps you riding all day,  and there's plenty of space to add panniers and bike bags to the newly-redesigned carrier.  This bike has stability when fully-loaded. |
		| 777                  | 6/1/2007 12:00:00 AM | 9cfed570-180a-44ea-8233-55116a0ddcb9 | For Delete Tests Only                                                                                                                                                                     |

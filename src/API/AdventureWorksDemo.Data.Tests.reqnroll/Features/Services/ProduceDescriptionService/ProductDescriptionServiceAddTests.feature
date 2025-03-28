﻿Feature: ProductDescriptionServiceAddTests


System tests for the ProductDescriptionService
Testing the methods AddAsync


Background:
	Given The service to test is 'AdventureWorksDemo.Data.Services.IProductDescriptionService'
	And I don't reset the database after the scenario

Scenario: AddAsync
	Given I reset the database after the scenario
	When I populate the model 'AdventureWorksDemo.Data.Models.ProductDescriptionModel'
		| Description | Rowguid                              |
		| PingPong    | 00000000-1111-0000-0000-000000000002 |
	And I call the method 'AddAsync' with the parameter values
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
		| 5001                 | 5/24/2024 12:34:56 PM | 00000000-1111-0000-0000-000000000002 | PingPong    |
	And the table 'Production.ProductDescription' filtered by 'ProductDescriptionId > 4' contains
		| ProductDescriptionId | ModifiedDate          | Rowguid                              | Description                                                                                                                                                                               |
		| 555                  | 6/1/2007 12:00:00 AM  | 741eae59-5e59-4dbc-9086-2633392c2582 | All-occasion value bike with our basic comfort and safety features. Offers wider, more stable tires for a ride around town or weekend trip.                                               |
		| 666                  | 6/1/2007 12:00:00 AM  | ddc955b2-843e-49ce-8f7b-54870f6135eb | The plush custom saddle keeps you riding all day,  and there's plenty of space to add panniers and bike bags to the newly-redesigned carrier.  This bike has stability when fully-loaded. |
		| 777                  | 6/1/2007 12:00:00 AM  | 9cfed570-180a-44ea-8233-55116a0ddcb9 | For Delete Tests Only                                                                                                                                                                     |
		| 5001                 | 5/24/2024 12:34:56 PM | 00000000-1111-0000-0000-000000000002 | PingPong                                                                                                                                                                                  |


		
		
Scenario: AddAsyncShortName
	Given I reset the database after the scenario
	When I populate the model 'AdventureWorksDemo.Data.Models.ProductDescriptionModel'
		| Description      | Rowguid                              |
		| {{PadRight:X:2}} | 00000000-1111-0000-0000-000000000002 |
	And I call the method 'AddAsync' with the parameter values
		| Key   | Value     | TypeName                                               |
		| model | {{model}} | AdventureWorksDemo.Data.Models.ProductDescriptionModel |
	Then the result is of type
		| Expected                                                                                             |
		| AdventureWorksDemo.Data.Models.ServiceResult<AdventureWorksDemo.Data.Models.ProductDescriptionModel> |
	And the result is
		| IsFailure | IsSuccess | Message                                                                       |
		| True      | False     | 'Description' must be between 3 and 400 characters. You entered 2 characters. |

	And the results property 'Value' contains
		| ProductDescriptionId | ModifiedDate         | Rowguid                              | Description |
		| 0                    | 1/1/0001 12:00:00 AM | 00000000-1111-0000-0000-000000000002 | XX          |

	And the table 'Production.ProductDescription' filtered by 'ProductDescriptionId > 4' contains
		| ProductDescriptionId | ModifiedDate         | Rowguid                              | Description                                                                                                                                                                               |
		| 555                  | 6/1/2007 12:00:00 AM | 741eae59-5e59-4dbc-9086-2633392c2582 | All-occasion value bike with our basic comfort and safety features. Offers wider, more stable tires for a ride around town or weekend trip.                                               |
		| 666                  | 6/1/2007 12:00:00 AM | ddc955b2-843e-49ce-8f7b-54870f6135eb | The plush custom saddle keeps you riding all day,  and there's plenty of space to add panniers and bike bags to the newly-redesigned carrier.  This bike has stability when fully-loaded. |
		| 777                  | 6/1/2007 12:00:00 AM | 9cfed570-180a-44ea-8233-55116a0ddcb9 | For Delete Tests Only                                                                                                                                                                     |
		
		
Scenario: AddAsyncLongName
	Given I reset the database after the scenario
	When I populate the model 'AdventureWorksDemo.Data.Models.ProductDescriptionModel'
		| Description        | Rowguid                              |
		| {{PadRight:X:401}} | 00000000-1111-0000-0000-000000000002 |
	And I call the method 'AddAsync' with the parameter values
		| Key   | Value     | TypeName                                               |
		| model | {{model}} | AdventureWorksDemo.Data.Models.ProductDescriptionModel |
	Then the result is of type
		| Expected                                                                                             |
		| AdventureWorksDemo.Data.Models.ServiceResult<AdventureWorksDemo.Data.Models.ProductDescriptionModel> |
	And the result is
		| IsFailure | IsSuccess | Message                                                                         |
		| True      | False     | 'Description' must be between 3 and 400 characters. You entered 401 characters. |

	Then the results property 'Value' contains
		| ProductDescriptionId | ModifiedDate         | Rowguid                              | Description        |
		| 0                    | 1/1/0001 12:00:00 AM | 00000000-1111-0000-0000-000000000002 | {{PadRight:X:401}} |

	And the table 'Production.ProductDescription' filtered by 'ProductDescriptionId > 4' contains
		| ProductDescriptionId | ModifiedDate         | Rowguid                              | Description                                                                                                                                                                               |
		| 555                  | 6/1/2007 12:00:00 AM | 741eae59-5e59-4dbc-9086-2633392c2582 | All-occasion value bike with our basic comfort and safety features. Offers wider, more stable tires for a ride around town or weekend trip.                                               |
		| 666                  | 6/1/2007 12:00:00 AM | ddc955b2-843e-49ce-8f7b-54870f6135eb | The plush custom saddle keeps you riding all day,  and there's plenty of space to add panniers and bike bags to the newly-redesigned carrier.  This bike has stability when fully-loaded. |
		| 777                  | 6/1/2007 12:00:00 AM | 9cfed570-180a-44ea-8233-55116a0ddcb9 | For Delete Tests Only                                                                                                                                                                     |


Scenario: AddBatchAsync
	Given I reset the database after the scenario
	When I populate a list of the model 'AdventureWorksDemo.Data.Models.ProductDescriptionModel'
		| Description | Rowguid                              |
		| How         | 00000000-1111-1111-0000-000000000001 |
		| Now         | 00000000-1111-1111-0000-000000000002 |
		| Brown       | 00000000-1111-1111-0000-000000000003 |
		| Cow         | 00000000-1111-1111-0000-000000000004 |
	And I call the method 'AddBatchAsync' with the parameter values
		| Key   | Value             | TypeName                                                                                       |
		| model | {{ListOfObjects}} | System.Collections.Generic.IEnumerable<AdventureWorksDemo.Data.Models.ProductDescriptionModel> |
	Then the result is of type
		| Expected                                                                                                                                    |
		| AdventureWorksDemo.Data.Models.ServiceResult<System.Collections.Generic.IEnumerable<AdventureWorksDemo.Data.Models.ProductDescriptionModel> |
	And the result is
		| IsFailure | IsSuccess | Message |
		| false     | true      |         |
	
	And the results property 'Value' contains
		| ProductDescriptionId | ModifiedDate          | Rowguid                              | Description |
		| 5001                 | 5/24/2024 12:34:56 PM | 00000000-1111-1111-0000-000000000001 | How         |
		| 5002                 | 5/24/2024 12:34:56 PM | 00000000-1111-1111-0000-000000000002 | Now         |
		| 5003                 | 5/24/2024 12:34:56 PM | 00000000-1111-1111-0000-000000000003 | Brown       |
		| 5004                 | 5/24/2024 12:34:56 PM | 00000000-1111-1111-0000-000000000004 | Cow         |


	And the table 'Production.ProductDescription' filtered by 'ProductDescriptionId > 4' contains
		| ProductDescriptionId | ModifiedDate          | Rowguid                              | Description                                                                                                                                                                               |
		| 555                  | 6/1/2007 12:00:00 AM  | 741eae59-5e59-4dbc-9086-2633392c2582 | All-occasion value bike with our basic comfort and safety features. Offers wider, more stable tires for a ride around town or weekend trip.                                               |
		| 666                  | 6/1/2007 12:00:00 AM  | ddc955b2-843e-49ce-8f7b-54870f6135eb | The plush custom saddle keeps you riding all day,  and there's plenty of space to add panniers and bike bags to the newly-redesigned carrier.  This bike has stability when fully-loaded. |
		| 777                  | 6/1/2007 12:00:00 AM  | 9cfed570-180a-44ea-8233-55116a0ddcb9 | For Delete Tests Only                                                                                                                                                                     |
		| 5001                 | 5/24/2024 12:34:56 PM | 00000000-1111-1111-0000-000000000001 | How                                                                                                                                                                                       |
		| 5002                 | 5/24/2024 12:34:56 PM | 00000000-1111-1111-0000-000000000002 | Now                                                                                                                                                                                       |
		| 5003                 | 5/24/2024 12:34:56 PM | 00000000-1111-1111-0000-000000000003 | Brown                                                                                                                                                                                     |
		| 5004                 | 5/24/2024 12:34:56 PM | 00000000-1111-1111-0000-000000000004 | Cow                                                                                                                                                                                       |

Scenario: AddBatchAsync2ShortName
	Given I reset the database after the scenario
	When I populate a list of the model 'AdventureWorksDemo.Data.Models.ProductDescriptionModel'
		| Description | Rowguid                              |
		| Hi          | 00000000-1111-1111-0000-000000000001 |
		| Now         | 00000000-1111-1111-0000-000000000002 |
		| Brown       | 00000000-1111-1111-0000-000000000003 |
		| It          | 00000000-1111-1111-0000-000000000004 |
	And I call the method 'AddBatchAsync' with the parameter values
		| Key   | Value             | TypeName                                                                                       |
		| model | {{ListOfObjects}} | System.Collections.Generic.IEnumerable<AdventureWorksDemo.Data.Models.ProductDescriptionModel> |
	Then the result is of type
		| Expected                                                                                                                                    |
		| AdventureWorksDemo.Data.Models.ServiceResult<System.Collections.Generic.IEnumerable<AdventureWorksDemo.Data.Models.ProductDescriptionModel> |
	And the result is
		| IsFailure | IsSuccess |
		| True      | False     |
	And the results property 'Message' contains
		| Expected                                                                      |
		| 'Description' must be between 3 and 400 characters. You entered 2 characters. |
		| 'Description' must be between 3 and 400 characters. You entered 2 characters. |

	And the results property 'Value' contains
		| ProductDescriptionId | ModifiedDate         | Rowguid                              | Description |
		| 0                    | 1/1/0001 12:00:00 AM | 00000000-1111-1111-0000-000000000001 | Hi          |
		| 0                    | 1/1/0001 12:00:00 AM | 00000000-1111-1111-0000-000000000002 | Now         |
		| 0                    | 1/1/0001 12:00:00 AM | 00000000-1111-1111-0000-000000000003 | Brown       |
		| 0                    | 1/1/0001 12:00:00 AM | 00000000-1111-1111-0000-000000000004 | It          |

	And the table 'Production.ProductDescription' filtered by 'ProductDescriptionId > 4' contains
		| ProductDescriptionId | ModifiedDate         | Rowguid                              | Description                                                                                                                                                                               |
		| 555                  | 6/1/2007 12:00:00 AM | 741eae59-5e59-4dbc-9086-2633392c2582 | All-occasion value bike with our basic comfort and safety features. Offers wider, more stable tires for a ride around town or weekend trip.                                               |
		| 666                  | 6/1/2007 12:00:00 AM | ddc955b2-843e-49ce-8f7b-54870f6135eb | The plush custom saddle keeps you riding all day,  and there's plenty of space to add panniers and bike bags to the newly-redesigned carrier.  This bike has stability when fully-loaded. |
		| 777                  | 6/1/2007 12:00:00 AM | 9cfed570-180a-44ea-8233-55116a0ddcb9 | For Delete Tests Only                                                                                                                                                                     |

Scenario: AddBatchAsync2LongName
	Given I reset the database after the scenario
	When I populate a list of the model 'AdventureWorksDemo.Data.Models.ProductDescriptionModel'
		| Description         | Rowguid                              |
		| Foo                 | 00000000-1111-1111-0000-000000000001 |
		| Fighters            | 00000000-1111-1111-0000-000000000002 |
		| {{PadRight:X:1234}} | 00000000-1111-1111-0000-000000000003 |
		| Les Contamines      | 00000000-1111-1111-0000-000000000004 |
	And I call the method 'AddBatchAsync' with the parameter values
		| Key   | Value             | TypeName                                                                                       |
		| model | {{ListOfObjects}} | System.Collections.Generic.IEnumerable<AdventureWorksDemo.Data.Models.ProductDescriptionModel> |
	Then the result is of type
		| Expected                                                                                                                                    |
		| AdventureWorksDemo.Data.Models.ServiceResult<System.Collections.Generic.IEnumerable<AdventureWorksDemo.Data.Models.ProductDescriptionModel> |
	And the result is
		| IsFailure | IsSuccess |
		| True      | False     |
	And the results property 'Message' contains
		| Expected                                                                         |
		| 'Description' must be between 3 and 400 characters. You entered 1234 characters. |
	And the results property 'Value' contains
		| ProductDescriptionId | ModifiedDate         | Rowguid                              | Description         |
		| 0                    | 1/1/0001 12:00:00 AM | 00000000-1111-1111-0000-000000000001 | Foo                 |
		| 0                    | 1/1/0001 12:00:00 AM | 00000000-1111-1111-0000-000000000002 | Fighters            |
		| 0                    | 1/1/0001 12:00:00 AM | 00000000-1111-1111-0000-000000000003 | {{PadRight:X:1234}} |
		| 0                    | 1/1/0001 12:00:00 AM | 00000000-1111-1111-0000-000000000004 | Les Contamines      |

	And the table 'Production.ProductDescription' filtered by 'ProductDescriptionId > 4' contains
		| ProductDescriptionId | ModifiedDate         | Rowguid                              | Description                                                                                                                                                                               |
		| 555                  | 6/1/2007 12:00:00 AM | 741eae59-5e59-4dbc-9086-2633392c2582 | All-occasion value bike with our basic comfort and safety features. Offers wider, more stable tires for a ride around town or weekend trip.                                               |
		| 666                  | 6/1/2007 12:00:00 AM | ddc955b2-843e-49ce-8f7b-54870f6135eb | The plush custom saddle keeps you riding all day,  and there's plenty of space to add panniers and bike bags to the newly-redesigned carrier.  This bike has stability when fully-loaded. |
		| 777                  | 6/1/2007 12:00:00 AM | 9cfed570-180a-44ea-8233-55116a0ddcb9 | For Delete Tests Only                                                                                                                                                                     |

Feature: ProductDescriptionServiceUpdateBatchTests
System tests for the ProductDescriptionService
Testing the methods UpdateAsync with a list of ProductDescriptionModel


Background:
	Given The service to test is 'AdventureWorksDemo.Data.Services.IProductDescriptionService'
	And I reset the database after the scenario

Scenario: UpdateBatchAsync01
	Given the table 'SalesLT.ProductDescription' filtered by 'ProductDescriptionId > 1599' contains
		| ProductDescriptionId | ModifiedDate         | Rowguid                              | Description                                                                                                                                                                                                                                                                   |
		| 1600                 | 6/1/2020 12:00:00 AM | 4aae6d4f-1111-4f32-99de-bb3b1b13f1ef | Orphan record to deletion test                                                                                                                                                                                                                                                |
		| 1605                 | 6/1/2007 12:00:00 AM | 9cfed570-180a-44ea-8233-55116a0ddcb9 | Chaque cadre est fabriqu� artisanalement dans notre atelier de Bordeaux afin d'obtenir le diam�tre et l'�paisseur adapt�s � un v�lo tout-terrain de premier choix. Le cadre en aluminium soud� � chaud pr�sente un tube d'un plus grand diam�tre, afin d'absorber les bosses. |

	When I populate a list of the model 'AdventureWorksDemo.Data.Models.ProductDescriptionModel'
		| ProductDescriptionId | Description   |
		| 1600                 | Ping Pong     |
		| 1605                 | {{Pad:X:123}} |
	And I call the method 'UpdateAsync' with the parameter values
		| Key    | Value      | TypeName                                                            |
		| models | {{models}} | IEnumerable<AdventureWorksDemo.Data.Models.ProductDescriptionModel> |
	Then the result is of type
		| Expected                                                                                                                                    |
		| AdventureWorksDemo.Data.Models.ServiceResult<System.Collections.Generic.IEnumerable<AdventureWorksDemo.Data.Models.ProductDescriptionModel> |
	And the result is
		| IsFailure | IsSuccess | Message |
		| False     | True      |         |
	And the results property 'Value' contains
		| ProductDescriptionId | ModifiedDate          | Rowguid                              | Description   |
		| 1600                 | 5/24/2024 12:34:56 PM | 4aae6d4f-1111-4f32-99de-bb3b1b13f1ef | Ping Pong     |
		| 1605                 | 5/24/2024 12:34:56 PM | 9cfed570-180a-44ea-8233-55116a0ddcb9 | {{Pad:X:123}} |

	And the table 'SalesLT.ProductDescription' filtered by 'ProductDescriptionId > 1599' contains
		| ProductDescriptionId | ModifiedDate          | Rowguid                              | Description   |
		| 1600                 | 5/24/2024 12:34:56 PM | 4aae6d4f-1111-4f32-99de-bb3b1b13f1ef | Ping Pong     |
		| 1605                 | 5/24/2024 12:34:56 PM | 9cfed570-180a-44ea-8233-55116a0ddcb9 | {{Pad:X:123}} |

Scenario: UpdateBatchAsynNoRecords
	Given I don't reset the database after the scenario
	When I populate a list of the model 'AdventureWorksDemo.Data.Models.ProductDescriptionModel'
		| ProductDescriptionId | Description |
	And I call the method 'UpdateAsync' with the parameter values
		| Key    | Value      | TypeName                                                            |
		| models | {{models}} | IEnumerable<AdventureWorksDemo.Data.Models.ProductDescriptionModel> |
	Then the result is of type
		| Expected                                                                                                                                    |
		| AdventureWorksDemo.Data.Models.ServiceResult<System.Collections.Generic.IEnumerable<AdventureWorksDemo.Data.Models.ProductDescriptionModel> |
	And the result is
		| IsFailure | IsSuccess | Message                               |
		| True      | False     | Please select some records to update! |
	And the results property 'Value' contains
		| ProductDescriptionId | ModifiedDate | Rowguid | Description |


		
Scenario: UpdateBatchAsyncOneBadRecord
	Given I don't reset the database after the scenario
	When I populate a list of the model 'AdventureWorksDemo.Data.Models.ProductDescriptionModel'
		| ProductDescriptionId | Description   |
		| 1599                 | {{Pad:X:123}} |
		| 1600                 | A             |
	And I call the method 'UpdateAsync' with the parameter values
		| Key    | Value      | TypeName                                                            |
		| models | {{models}} | IEnumerable<AdventureWorksDemo.Data.Models.ProductDescriptionModel> |
	Then the result is of type
		| Expected                                                                                                                                    |
		| AdventureWorksDemo.Data.Models.ServiceResult<System.Collections.Generic.IEnumerable<AdventureWorksDemo.Data.Models.ProductDescriptionModel> |
	And the result is
		| IsFailure | IsSuccess | Message                                                                       |
		| True      | False     | 'Description' must be between 3 and 400 characters. You entered 1 characters. |
	And the results property 'Value' contains
		| ProductDescriptionId | ModifiedDate         | Rowguid                              | Description   |
		| 1599                 | 1/1/0001 12:00:00 AM | 00000000-0000-0000-0000-000000000000 | {{Pad:X:123}} |
		| 1600                 | 1/1/0001 12:00:00 AM | 00000000-0000-0000-0000-000000000000 | A             |

	And the table 'SalesLT.ProductDescription' filtered by 'ProductDescriptionId > 1599' contains
		| ProductDescriptionId | ModifiedDate         | Rowguid                              | Description                                                                                                                                                                                                                                                                   |
		| 1600                 | 6/1/2020 12:00:00 AM | 4aae6d4f-1111-4f32-99de-bb3b1b13f1ef | Orphan record to deletion test                                                                                                                                                                                                                                                |
		| 1605                 | 6/1/2007 12:00:00 AM | 9cfed570-180a-44ea-8233-55116a0ddcb9 | Chaque cadre est fabriqu� artisanalement dans notre atelier de Bordeaux afin d'obtenir le diam�tre et l'�paisseur adapt�s � un v�lo tout-terrain de premier choix. Le cadre en aluminium soud� � chaud pr�sente un tube d'un plus grand diam�tre, afin d'absorber les bosses. |


Feature: ProductDescriptionServiceUpdateTests

System tests for the ProductDescriptionService
Testing the methods UpdateAsync


Background:
	Given The service to test is 'AdventureWorksDemo.Data.Services.IProductDescriptionService'
	And I reset the database after the scenario

Scenario: Update01
	Given the table 'SalesLT.ProductDescription' filtered by 'ProductDescriptionId > 1599' contains
		| ProductDescriptionId | ModifiedDate         | Rowguid                              | Description                                                                                                                                                                                                                                                                   |
		| 1600                 | 6/1/2020 12:00:00 AM | 4aae6d4f-1111-4f32-99de-bb3b1b13f1ef | Orphan record to deletion test                                                                                                                                                                                                                                                |
		| 1605                 | 6/1/2007 12:00:00 AM | 9cfed570-180a-44ea-8233-55116a0ddcb9 | Chaque cadre est fabriqu� artisanalement dans notre atelier de Bordeaux afin d'obtenir le diam�tre et l'�paisseur adapt�s � un v�lo tout-terrain de premier choix. Le cadre en aluminium soud� � chaud pr�sente un tube d'un plus grand diam�tre, afin d'absorber les bosses. |

	When I populate the model 'AdventureWorksDemo.Data.Models.ProductDescriptionModel'
		| ProductDescriptionId | Description |
		| 1605                 | Ping Pong   |
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
		| 1605                 | 5/24/2024 12:34:56 PM | 9cfed570-180a-44ea-8233-55116a0ddcb9 | Ping Pong   |

	And the table 'SalesLT.ProductDescription' filtered by 'ProductDescriptionId > 1599' contains
		| ProductDescriptionId | ModifiedDate          | Rowguid                              | Description                    |
		| 1600                 | 6/1/2020 12:00:00 AM  | 4aae6d4f-1111-4f32-99de-bb3b1b13f1ef | Orphan record to deletion test |
		| 1605                 | 5/24/2024 12:34:56 PM | 9cfed570-180a-44ea-8233-55116a0ddcb9 | Ping Pong                      |

		
Scenario: UpdateShortName
	Given the table 'SalesLT.ProductDescription' filtered by 'ProductDescriptionId > 1599' contains
		| ProductDescriptionId | ModifiedDate         | Rowguid                              | Description                                                                                                                                                                                                                                                                   |
		| 1600                 | 6/1/2020 12:00:00 AM | 4aae6d4f-1111-4f32-99de-bb3b1b13f1ef | Orphan record to deletion test                                                                                                                                                                                                                                                |
		| 1605                 | 6/1/2007 12:00:00 AM | 9cfed570-180a-44ea-8233-55116a0ddcb9 | Chaque cadre est fabriqu� artisanalement dans notre atelier de Bordeaux afin d'obtenir le diam�tre et l'�paisseur adapt�s � un v�lo tout-terrain de premier choix. Le cadre en aluminium soud� � chaud pr�sente un tube d'un plus grand diam�tre, afin d'absorber les bosses. |

	When I populate the model 'AdventureWorksDemo.Data.Models.ProductDescriptionModel'
		| ProductDescriptionId | Description |
		| 1600                 | Hi          |
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
		| 1600                 | 6/1/2020 12:00:00 AM | 4aae6d4f-1111-4f32-99de-bb3b1b13f1ef | Hi          |
	And the table 'SalesLT.ProductDescription' filtered by 'ProductDescriptionId > 1599' contains
		| ProductDescriptionId | ModifiedDate         | Rowguid                              | Description                                                                                                                                                                                                                                                                   |
		| 1600                 | 6/1/2020 12:00:00 AM | 4aae6d4f-1111-4f32-99de-bb3b1b13f1ef | Orphan record to deletion test                                                                                                                                                                                                                                                |
		| 1605                 | 6/1/2007 12:00:00 AM | 9cfed570-180a-44ea-8233-55116a0ddcb9 | Chaque cadre est fabriqu� artisanalement dans notre atelier de Bordeaux afin d'obtenir le diam�tre et l'�paisseur adapt�s � un v�lo tout-terrain de premier choix. Le cadre en aluminium soud� � chaud pr�sente un tube d'un plus grand diam�tre, afin d'absorber les bosses. |
		
Scenario: UpdateLongName
	Given the table 'SalesLT.ProductDescription' filtered by 'ProductDescriptionId > 1599' contains
		| ProductDescriptionId | ModifiedDate         | Rowguid                              | Description                                                                                                                                                                                                                                                                   |
		| 1600                 | 6/1/2020 12:00:00 AM | 4aae6d4f-1111-4f32-99de-bb3b1b13f1ef | Orphan record to deletion test                                                                                                                                                                                                                                                |
		| 1605                 | 6/1/2007 12:00:00 AM | 9cfed570-180a-44ea-8233-55116a0ddcb9 | Chaque cadre est fabriqu� artisanalement dans notre atelier de Bordeaux afin d'obtenir le diam�tre et l'�paisseur adapt�s � un v�lo tout-terrain de premier choix. Le cadre en aluminium soud� � chaud pr�sente un tube d'un plus grand diam�tre, afin d'absorber les bosses. |

	When I populate the model 'AdventureWorksDemo.Data.Models.ProductDescriptionModel'
		| ProductDescriptionId | Description   |
		| 1600                 | {{Pad:x:401}} |
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
		| 1600                 | 6/1/2020 12:00:00 AM | 4aae6d4f-1111-4f32-99de-bb3b1b13f1ef | {{Pad:x:401}} |
	And the table 'SalesLT.ProductDescription' filtered by 'ProductDescriptionId > 1599' contains
		| ProductDescriptionId | ModifiedDate         | Rowguid                              | Description                                                                                                                                                                                                                                                                   |
		| 1600                 | 6/1/2020 12:00:00 AM | 4aae6d4f-1111-4f32-99de-bb3b1b13f1ef | Orphan record to deletion test                                                                                                                                                                                                                                                |
		| 1605                 | 6/1/2007 12:00:00 AM | 9cfed570-180a-44ea-8233-55116a0ddcb9 | Chaque cadre est fabriqu� artisanalement dans notre atelier de Bordeaux afin d'obtenir le diam�tre et l'�paisseur adapt�s � un v�lo tout-terrain de premier choix. Le cadre en aluminium soud� � chaud pr�sente un tube d'un plus grand diam�tre, afin d'absorber les bosses. |

Scenario: UpdateNoChange
	Given I don't reset the database after the scenario
	When I populate the model 'AdventureWorksDemo.Data.Models.ProductDescriptionModel'
		| ProductDescriptionId | Description                    |
		| 1600                 | Orphan record to deletion test |
	And I call the method 'UpdateAsync' with the parameter values
		| Key   | Value     | TypeName                                               |
		| model | {{model}} | AdventureWorksDemo.Data.Models.ProductDescriptionModel |
	Then the result is of type
		| Expected                                                                                             |
		| AdventureWorksDemo.Data.Models.ServiceResult<AdventureWorksDemo.Data.Models.ProductDescriptionModel> |
	And the result is
		| IsFailure | IsSuccess | Message                       |
		| False     | True      | Record is already up to date! |
	And the results property 'Value' contains
		| ProductDescriptionId | ModifiedDate         | Rowguid                              | Description                    |
		| 1600                 | 6/1/2020 12:00:00 AM | 4aae6d4f-1111-4f32-99de-bb3b1b13f1ef | Orphan record to deletion test |

	And the table 'SalesLT.ProductDescription' filtered by 'ProductDescriptionId > 1599' contains
		| ProductDescriptionId | ModifiedDate         | Rowguid                              | Description                                                                                                                                                                                                                                                                   |
		| 1600                 | 6/1/2020 12:00:00 AM | 4aae6d4f-1111-4f32-99de-bb3b1b13f1ef | Orphan record to deletion test                                                                                                                                                                                                                                                |
		| 1605                 | 6/1/2007 12:00:00 AM | 9cfed570-180a-44ea-8233-55116a0ddcb9 | Chaque cadre est fabriqu� artisanalement dans notre atelier de Bordeaux afin d'obtenir le diam�tre et l'�paisseur adapt�s � un v�lo tout-terrain de premier choix. Le cadre en aluminium soud� � chaud pr�sente un tube d'un plus grand diam�tre, afin d'absorber les bosses. |

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
	And the table 'SalesLT.ProductDescription' filtered by 'ProductDescriptionId > 1599' contains
		| ProductDescriptionId | ModifiedDate         | Rowguid                              | Description                                                                                                                                                                                                                                                                   |
		| 1600                 | 6/1/2020 12:00:00 AM | 4aae6d4f-1111-4f32-99de-bb3b1b13f1ef | Orphan record to deletion test                                                                                                                                                                                                                                                |
		| 1605                 | 6/1/2007 12:00:00 AM | 9cfed570-180a-44ea-8233-55116a0ddcb9 | Chaque cadre est fabriqu� artisanalement dans notre atelier de Bordeaux afin d'obtenir le diam�tre et l'�paisseur adapt�s � un v�lo tout-terrain de premier choix. Le cadre en aluminium soud� � chaud pr�sente un tube d'un plus grand diam�tre, afin d'absorber les bosses. |

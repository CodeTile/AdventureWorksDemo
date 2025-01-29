Feature: ProductDescriptionServiceFindAllAsyncSortingTests

System tests for the ProductDescriptionService
Testing the methods FindAllAsync with sorting

Background:
	Given The service to test is 'AdventureWorksDemo.Data.Services.IProductDescriptionService'

Scenario: FindAllAsync_0_5_Description3TimesTheSameDefault

	When I populate the model 'AdventureWorksDemo.Data.Paging.PagingFilter'
		| PageNumber | PageSize | Sorting     |
		| 0          | 5        | Description |
	And I call the method 'FindAllAsync' with the parameter values
		| Key           | Value     | TypeName                                    |
		| pageingFilter | {{model}} | AdventureWorksDemo.Data.Paging.PagingFilter |
	Then the result is of type
		| Expected                                                                                         |
		| AdventureWorksDemo.Data.Paging.PagedList<AdventureWorksDemo.Data.Models.ProductDescriptionModel> |
	And the PagedList values are
		| TotalPages | TotalCount | PageSize | CurrentPage |
		| 8          | 37         | 5        | 0           |
	And the sorted results are
		| ProductDescriptionId | ModifiedDate         | Rowguid                              | Description                                                                                                                                                                                                                                                                   |
		| 1487                 | 6/1/2007 12:00:00 AM | 5c1dab3a-4b31-4d9d-a14f-3cb61949b79b | Adapt� � tous les usages, sur route ou tout-terrain. Pour toutes les bourses. Changement de braquet en douceur et conduite confortable.                                                                                                                                       |
		| 513                  | 6/1/2007 12:00:00 AM | 741eae59-5e59-4dbc-9086-2633392c2582 | All-occasion value bike with our basic comfort and safety features. Offers wider, more stable tires for a ride around town or weekend trip.                                                                                                                                   |
		| 627                  | 6/1/2007 12:00:00 AM | ebf2f0a4-89f2-4d31-be48-d8fd278f3024 | All-weather brake pads; provides superior stopping by applying more surface to the rim.                                                                                                                                                                                       |
		| 1488                 | 6/1/2007 12:00:00 AM | 79065ec8-2080-4120-a4ea-bfa7ea1f1f9d | Ce v�lo offre un excellent rapport qualit�-prix. Vif et facile � man�uvrer, il se conduit en toute tranquillit� sur les chemins et les sentiers.                                                                                                                              |
		| 1605                 | 6/1/2007 12:00:00 AM | 9cfed570-180a-44ea-8233-55116a0ddcb9 | Chaque cadre est fabriqu� artisanalement dans notre atelier de Bordeaux afin d'obtenir le diam�tre et l'�paisseur adapt�s � un v�lo tout-terrain de premier choix. Le cadre en aluminium soud� � chaud pr�sente un tube d'un plus grand diam�tre, afin d'absorber les bosses. |
    
	Given I clear the previous results
	When I update the model 'AdventureWorksDemo.Data.Paging.PagingFilter'
		| PageNumber | PageSize | Sorting     |
		| 0          | 5        | Description |
	And I call the method 'FindAllAsync' with the parameter values
		| Key           | Value     | TypeName                                    |
		| pageingFilter | {{model}} | AdventureWorksDemo.Data.Paging.PagingFilter |
	Then the result is of type
		| Expected                                                                                         |
		| AdventureWorksDemo.Data.Paging.PagedList<AdventureWorksDemo.Data.Models.ProductDescriptionModel> |
	And the PagedList values are
		| TotalPages | TotalCount | PageSize | CurrentPage |
		| 8          | 37         | 5        | 0           |
	And the sorted results are
		| ProductDescriptionId | ModifiedDate         | Rowguid                              | Description                                                                                                                                                                                                                                                                   |
		| 1487                 | 6/1/2007 12:00:00 AM | 5c1dab3a-4b31-4d9d-a14f-3cb61949b79b | Adapt� � tous les usages, sur route ou tout-terrain. Pour toutes les bourses. Changement de braquet en douceur et conduite confortable.                                                                                                                                       |
		| 513                  | 6/1/2007 12:00:00 AM | 741eae59-5e59-4dbc-9086-2633392c2582 | All-occasion value bike with our basic comfort and safety features. Offers wider, more stable tires for a ride around town or weekend trip.                                                                                                                                   |
		| 627                  | 6/1/2007 12:00:00 AM | ebf2f0a4-89f2-4d31-be48-d8fd278f3024 | All-weather brake pads; provides superior stopping by applying more surface to the rim.                                                                                                                                                                                       |
		| 1488                 | 6/1/2007 12:00:00 AM | 79065ec8-2080-4120-a4ea-bfa7ea1f1f9d | Ce v�lo offre un excellent rapport qualit�-prix. Vif et facile � man�uvrer, il se conduit en toute tranquillit� sur les chemins et les sentiers.                                                                                                                              |
		| 1605                 | 6/1/2007 12:00:00 AM | 9cfed570-180a-44ea-8233-55116a0ddcb9 | Chaque cadre est fabriqu� artisanalement dans notre atelier de Bordeaux afin d'obtenir le diam�tre et l'�paisseur adapt�s � un v�lo tout-terrain de premier choix. Le cadre en aluminium soud� � chaud pr�sente un tube d'un plus grand diam�tre, afin d'absorber les bosses. |

	Given I clear the previous results
	When I update the model 'AdventureWorksDemo.Data.Paging.PagingFilter'
		| PageNumber | PageSize | Sorting     |
		| 0          | 5        | Description |
	And I call the method 'FindAllAsync' with the parameter values
		| Key           | Value     | TypeName                                    |
		| pageingFilter | {{model}} | AdventureWorksDemo.Data.Paging.PagingFilter |
	Then the result is of type
		| Expected                                                                                         |
		| AdventureWorksDemo.Data.Paging.PagedList<AdventureWorksDemo.Data.Models.ProductDescriptionModel> |
	And the PagedList values are
		| TotalPages | TotalCount | PageSize | CurrentPage |
		| 8          | 37         | 5        | 0           |
	And the sorted results are
		| ProductDescriptionId | ModifiedDate         | Rowguid                              | Description                                                                                                                                                                                                                                                                   |
		| 1487                 | 6/1/2007 12:00:00 AM | 5c1dab3a-4b31-4d9d-a14f-3cb61949b79b | Adapt� � tous les usages, sur route ou tout-terrain. Pour toutes les bourses. Changement de braquet en douceur et conduite confortable.                                                                                                                                       |
		| 513                  | 6/1/2007 12:00:00 AM | 741eae59-5e59-4dbc-9086-2633392c2582 | All-occasion value bike with our basic comfort and safety features. Offers wider, more stable tires for a ride around town or weekend trip.                                                                                                                                   |
		| 627                  | 6/1/2007 12:00:00 AM | ebf2f0a4-89f2-4d31-be48-d8fd278f3024 | All-weather brake pads; provides superior stopping by applying more surface to the rim.                                                                                                                                                                                       |
		| 1488                 | 6/1/2007 12:00:00 AM | 79065ec8-2080-4120-a4ea-bfa7ea1f1f9d | Ce v�lo offre un excellent rapport qualit�-prix. Vif et facile � man�uvrer, il se conduit en toute tranquillit� sur les chemins et les sentiers.                                                                                                                              |
		| 1605                 | 6/1/2007 12:00:00 AM | 9cfed570-180a-44ea-8233-55116a0ddcb9 | Chaque cadre est fabriqu� artisanalement dans notre atelier de Bordeaux afin d'obtenir le diam�tre et l'�paisseur adapt�s � un v�lo tout-terrain de premier choix. Le cadre en aluminium soud� � chaud pr�sente un tube d'un plus grand diam�tre, afin d'absorber les bosses. |

Scenario: FindAllAsync_0_5_Description3TimesTheSameAscending

	When I populate the model 'AdventureWorksDemo.Data.Paging.PagingFilter'
		| PageNumber | PageSize | Sorting         |
		| 0          | 5        | Description ASC |
	And I call the method 'FindAllAsync' with the parameter values
		| Key           | Value     | TypeName                                    |
		| pageingFilter | {{model}} | AdventureWorksDemo.Data.Paging.PagingFilter |
	Then the result is of type
		| Expected                                                                                         |
		| AdventureWorksDemo.Data.Paging.PagedList<AdventureWorksDemo.Data.Models.ProductDescriptionModel> |
	And the PagedList values are
		| TotalPages | TotalCount | PageSize | CurrentPage |
		| 8          | 37         | 5        | 0           |
	And the sorted results are
		| ProductDescriptionId | ModifiedDate         | Rowguid                              | Description                                                                                                                                                                                                                                                                   |
		| 1487                 | 6/1/2007 12:00:00 AM | 5c1dab3a-4b31-4d9d-a14f-3cb61949b79b | Adapt� � tous les usages, sur route ou tout-terrain. Pour toutes les bourses. Changement de braquet en douceur et conduite confortable.                                                                                                                                       |
		| 513                  | 6/1/2007 12:00:00 AM | 741eae59-5e59-4dbc-9086-2633392c2582 | All-occasion value bike with our basic comfort and safety features. Offers wider, more stable tires for a ride around town or weekend trip.                                                                                                                                   |
		| 627                  | 6/1/2007 12:00:00 AM | ebf2f0a4-89f2-4d31-be48-d8fd278f3024 | All-weather brake pads; provides superior stopping by applying more surface to the rim.                                                                                                                                                                                       |
		| 1488                 | 6/1/2007 12:00:00 AM | 79065ec8-2080-4120-a4ea-bfa7ea1f1f9d | Ce v�lo offre un excellent rapport qualit�-prix. Vif et facile � man�uvrer, il se conduit en toute tranquillit� sur les chemins et les sentiers.                                                                                                                              |
		| 1605                 | 6/1/2007 12:00:00 AM | 9cfed570-180a-44ea-8233-55116a0ddcb9 | Chaque cadre est fabriqu� artisanalement dans notre atelier de Bordeaux afin d'obtenir le diam�tre et l'�paisseur adapt�s � un v�lo tout-terrain de premier choix. Le cadre en aluminium soud� � chaud pr�sente un tube d'un plus grand diam�tre, afin d'absorber les bosses. |
    
	Given I clear the previous results
	When I update the model 'AdventureWorksDemo.Data.Paging.PagingFilter'
		| PageNumber | PageSize | Sorting         |
		| 0          | 5        | Description ASC |
	And I call the method 'FindAllAsync' with the parameter values
		| Key           | Value     | TypeName                                    |
		| pageingFilter | {{model}} | AdventureWorksDemo.Data.Paging.PagingFilter |
	Then the result is of type
		| Expected                                                                                         |
		| AdventureWorksDemo.Data.Paging.PagedList<AdventureWorksDemo.Data.Models.ProductDescriptionModel> |
	And the PagedList values are
		| TotalPages | TotalCount | PageSize | CurrentPage |
		| 8          | 37         | 5        | 0           |
	And the sorted results are
		| ProductDescriptionId | ModifiedDate         | Rowguid                              | Description                                                                                                                                                                                                                                                                   |
		| 1487                 | 6/1/2007 12:00:00 AM | 5c1dab3a-4b31-4d9d-a14f-3cb61949b79b | Adapt� � tous les usages, sur route ou tout-terrain. Pour toutes les bourses. Changement de braquet en douceur et conduite confortable.                                                                                                                                       |
		| 513                  | 6/1/2007 12:00:00 AM | 741eae59-5e59-4dbc-9086-2633392c2582 | All-occasion value bike with our basic comfort and safety features. Offers wider, more stable tires for a ride around town or weekend trip.                                                                                                                                   |
		| 627                  | 6/1/2007 12:00:00 AM | ebf2f0a4-89f2-4d31-be48-d8fd278f3024 | All-weather brake pads; provides superior stopping by applying more surface to the rim.                                                                                                                                                                                       |
		| 1488                 | 6/1/2007 12:00:00 AM | 79065ec8-2080-4120-a4ea-bfa7ea1f1f9d | Ce v�lo offre un excellent rapport qualit�-prix. Vif et facile � man�uvrer, il se conduit en toute tranquillit� sur les chemins et les sentiers.                                                                                                                              |
		| 1605                 | 6/1/2007 12:00:00 AM | 9cfed570-180a-44ea-8233-55116a0ddcb9 | Chaque cadre est fabriqu� artisanalement dans notre atelier de Bordeaux afin d'obtenir le diam�tre et l'�paisseur adapt�s � un v�lo tout-terrain de premier choix. Le cadre en aluminium soud� � chaud pr�sente un tube d'un plus grand diam�tre, afin d'absorber les bosses. |

	Given I clear the previous results
	When I update the model 'AdventureWorksDemo.Data.Paging.PagingFilter'
		| PageNumber | PageSize | Sorting         |
		| 0          | 5        | Description ASC |
	And I call the method 'FindAllAsync' with the parameter values
		| Key           | Value     | TypeName                                    |
		| pageingFilter | {{model}} | AdventureWorksDemo.Data.Paging.PagingFilter |
	Then the result is of type
		| Expected                                                                                         |
		| AdventureWorksDemo.Data.Paging.PagedList<AdventureWorksDemo.Data.Models.ProductDescriptionModel> |
	And the PagedList values are
		| TotalPages | TotalCount | PageSize | CurrentPage |
		| 8          | 37         | 5        | 0           |
	And the sorted results are
		| ProductDescriptionId | ModifiedDate         | Rowguid                              | Description                                                                                                                                                                                                                                                                   |
		| 1487                 | 6/1/2007 12:00:00 AM | 5c1dab3a-4b31-4d9d-a14f-3cb61949b79b | Adapt� � tous les usages, sur route ou tout-terrain. Pour toutes les bourses. Changement de braquet en douceur et conduite confortable.                                                                                                                                       |
		| 513                  | 6/1/2007 12:00:00 AM | 741eae59-5e59-4dbc-9086-2633392c2582 | All-occasion value bike with our basic comfort and safety features. Offers wider, more stable tires for a ride around town or weekend trip.                                                                                                                                   |
		| 627                  | 6/1/2007 12:00:00 AM | ebf2f0a4-89f2-4d31-be48-d8fd278f3024 | All-weather brake pads; provides superior stopping by applying more surface to the rim.                                                                                                                                                                                       |
		| 1488                 | 6/1/2007 12:00:00 AM | 79065ec8-2080-4120-a4ea-bfa7ea1f1f9d | Ce v�lo offre un excellent rapport qualit�-prix. Vif et facile � man�uvrer, il se conduit en toute tranquillit� sur les chemins et les sentiers.                                                                                                                              |
		| 1605                 | 6/1/2007 12:00:00 AM | 9cfed570-180a-44ea-8233-55116a0ddcb9 | Chaque cadre est fabriqu� artisanalement dans notre atelier de Bordeaux afin d'obtenir le diam�tre et l'�paisseur adapt�s � un v�lo tout-terrain de premier choix. Le cadre en aluminium soud� � chaud pr�sente un tube d'un plus grand diam�tre, afin d'absorber les bosses. |

Scenario: FindAllAsync_0_5_Description3TimesTheSameDescending

	When I populate the model 'AdventureWorksDemo.Data.Paging.PagingFilter'
		| PageNumber | PageSize | Sorting          |
		| 0          | 5        | Description Desc |
	And I call the method 'FindAllAsync' with the parameter values
		| Key           | Value     | TypeName                                    |
		| pageingFilter | {{model}} | AdventureWorksDemo.Data.Paging.PagingFilter |
	Then the result is of type
		| Expected                                                                                         |
		| AdventureWorksDemo.Data.Paging.PagedList<AdventureWorksDemo.Data.Models.ProductDescriptionModel> |
	And the PagedList values are
		| TotalPages | TotalCount | PageSize | CurrentPage |
		| 8          | 37         | 5        | 0           |
	And the sorted results are
		| ProductDescriptionId | ModifiedDate         | Rowguid                              | Description                                                                                                                                                                                                                              |
		| 630                  | 6/1/2007 12:00:00 AM | 28c4682c-38b2-4b61-a2ae-bcac7c7ce29b | Wide-link design.                                                                                                                                                                                                                        |
		| 1504                 | 6/1/2007 12:00:00 AM | e3bac4a6-220c-4e5e-8261-51e08906c0e8 | Voyagez confortablement et avec �l�gance. Confort et s�curit� maximum. Large �ventail de vitesses pour gravir toutes les c�tes. Sa fabrication en alliage d'aluminium haute technologie est synonyme de robustesse, sans ajout de poids. |
		| 1502                 | 6/1/2007 12:00:00 AM | e5288050-bc5b-45cc-8849-c7d4af2fe2b6 | V�lo de qualit� pour tous usages, dot� d'un bon niveau de confort et de s�curit�. Pr�sente des pneus plus larges et plus stables pour les sorties en ville ou les randonn�es du week-end.                                                |
		| 1493                 | 6/1/2007 12:00:00 AM | 7943455f-3fbe-44c0-9ac2-7ee642d3944b | V�lo d'adulte d'entr�e de gamme�; permet une conduite confortable en ville ou sur les chemins de campagne. Moyeux et rayons � blocage rapide.                                                                                            |
		| 1211                 | 6/1/2007 12:00:00 AM | 12f60253-f8e1-4f76-8142-6232396b8f17 | Unisex long-sleeve AWC logo microfiber cycling jersey                                                                                                                                                                                    |
    
	Given I clear the previous results
	When I update the model 'AdventureWorksDemo.Data.Paging.PagingFilter'
		| PageNumber | PageSize | Sorting          |
		| 0          | 5        | Description desc |
	And I call the method 'FindAllAsync' with the parameter values
		| Key           | Value     | TypeName                                    |
		| pageingFilter | {{model}} | AdventureWorksDemo.Data.Paging.PagingFilter |
	Then the result is of type
		| Expected                                                                                         |
		| AdventureWorksDemo.Data.Paging.PagedList<AdventureWorksDemo.Data.Models.ProductDescriptionModel> |
	And the PagedList values are
		| TotalPages | TotalCount | PageSize | CurrentPage |
		| 8          | 37         | 5        | 0           |
	And the sorted results are
		| ProductDescriptionId | ModifiedDate         | Rowguid                              | Description                                                                                                                                                                                                                                                                   |
		| 630                  | 6/1/2007 12:00:00 AM | 28c4682c-38b2-4b61-a2ae-bcac7c7ce29b | Wide-link design.                                                                                                                                                                                                                        |
		| 1504                 | 6/1/2007 12:00:00 AM | e3bac4a6-220c-4e5e-8261-51e08906c0e8 | Voyagez confortablement et avec �l�gance. Confort et s�curit� maximum. Large �ventail de vitesses pour gravir toutes les c�tes. Sa fabrication en alliage d'aluminium haute technologie est synonyme de robustesse, sans ajout de poids. |
		| 1502                 | 6/1/2007 12:00:00 AM | e5288050-bc5b-45cc-8849-c7d4af2fe2b6 | V�lo de qualit� pour tous usages, dot� d'un bon niveau de confort et de s�curit�. Pr�sente des pneus plus larges et plus stables pour les sorties en ville ou les randonn�es du week-end.                                                |
		| 1493                 | 6/1/2007 12:00:00 AM | 7943455f-3fbe-44c0-9ac2-7ee642d3944b | V�lo d'adulte d'entr�e de gamme�; permet une conduite confortable en ville ou sur les chemins de campagne. Moyeux et rayons � blocage rapide.                                                                                            |
		| 1211                 | 6/1/2007 12:00:00 AM | 12f60253-f8e1-4f76-8142-6232396b8f17 | Unisex long-sleeve AWC logo microfiber cycling jersey                                                                                                                                                                                    |

	Given I clear the previous results
	When I update the model 'AdventureWorksDemo.Data.Paging.PagingFilter'
		| PageNumber | PageSize | Sorting          |
		| 0          | 5        | Description DESC |
	And I call the method 'FindAllAsync' with the parameter values
		| Key           | Value     | TypeName                                    |
		| pageingFilter | {{model}} | AdventureWorksDemo.Data.Paging.PagingFilter |
	Then the result is of type
		| Expected                                                                                         |
		| AdventureWorksDemo.Data.Paging.PagedList<AdventureWorksDemo.Data.Models.ProductDescriptionModel> |
	And the PagedList values are
		| TotalPages | TotalCount | PageSize | CurrentPage |
		| 8          | 37         | 5        | 0           |
	And the sorted results are
		| ProductDescriptionId | ModifiedDate         | Rowguid                              | Description                                                                                                                                                                                                                                                                   |
		| 630                  | 6/1/2007 12:00:00 AM | 28c4682c-38b2-4b61-a2ae-bcac7c7ce29b | Wide-link design.                                                                                                                                                                                                                        |
		| 1504                 | 6/1/2007 12:00:00 AM | e3bac4a6-220c-4e5e-8261-51e08906c0e8 | Voyagez confortablement et avec �l�gance. Confort et s�curit� maximum. Large �ventail de vitesses pour gravir toutes les c�tes. Sa fabrication en alliage d'aluminium haute technologie est synonyme de robustesse, sans ajout de poids. |
		| 1502                 | 6/1/2007 12:00:00 AM | e5288050-bc5b-45cc-8849-c7d4af2fe2b6 | V�lo de qualit� pour tous usages, dot� d'un bon niveau de confort et de s�curit�. Pr�sente des pneus plus larges et plus stables pour les sorties en ville ou les randonn�es du week-end.                                                |
		| 1493                 | 6/1/2007 12:00:00 AM | 7943455f-3fbe-44c0-9ac2-7ee642d3944b | V�lo d'adulte d'entr�e de gamme�; permet une conduite confortable en ville ou sur les chemins de campagne. Moyeux et rayons � blocage rapide.                                                                                            |
		| 1211                 | 6/1/2007 12:00:00 AM | 12f60253-f8e1-4f76-8142-6232396b8f17 | Unisex long-sleeve AWC logo microfiber cycling jersey                                                                                                                                                                                    |

Scenario: FindAllAsync_0_5_Description7TimesAlternatingDirection

	When I populate the model 'AdventureWorksDemo.Data.Paging.PagingFilter'
		| PageNumber | PageSize | Sorting          |
		| 0          | 5        | Description  |
	And I call the method 'FindAllAsync' with the parameter values
		| Key           | Value     | TypeName                                    |
		| pageingFilter | {{model}} | AdventureWorksDemo.Data.Paging.PagingFilter |
	Then the result is of type
		| Expected                                                                                         |
		| AdventureWorksDemo.Data.Paging.PagedList<AdventureWorksDemo.Data.Models.ProductDescriptionModel> |
	And the PagedList values are
		| TotalPages | TotalCount | PageSize | CurrentPage |
		| 8          | 37         | 5        | 0           |
	And the sorted results are
		| ProductDescriptionId | ModifiedDate         | Rowguid                              | Description                                                                                                                                                                                                                              |
		| 1487                 | 6/1/2007 12:00:00 AM | 5c1dab3a-4b31-4d9d-a14f-3cb61949b79b | Adapt� � tous les usages, sur route ou tout-terrain. Pour toutes les bourses. Changement de braquet en douceur et conduite confortable.                                                                                                                                       |
		| 513                  | 6/1/2007 12:00:00 AM | 741eae59-5e59-4dbc-9086-2633392c2582 | All-occasion value bike with our basic comfort and safety features. Offers wider, more stable tires for a ride around town or weekend trip.                                                                                                                                   |
		| 627                  | 6/1/2007 12:00:00 AM | ebf2f0a4-89f2-4d31-be48-d8fd278f3024 | All-weather brake pads; provides superior stopping by applying more surface to the rim.                                                                                                                                                                                       |
		| 1488                 | 6/1/2007 12:00:00 AM | 79065ec8-2080-4120-a4ea-bfa7ea1f1f9d | Ce v�lo offre un excellent rapport qualit�-prix. Vif et facile � man�uvrer, il se conduit en toute tranquillit� sur les chemins et les sentiers.                                                                                                                              |
		| 1605                 | 6/1/2007 12:00:00 AM | 9cfed570-180a-44ea-8233-55116a0ddcb9 | Chaque cadre est fabriqu� artisanalement dans notre atelier de Bordeaux afin d'obtenir le diam�tre et l'�paisseur adapt�s � un v�lo tout-terrain de premier choix. Le cadre en aluminium soud� � chaud pr�sente un tube d'un plus grand diam�tre, afin d'absorber les bosses. |

	Given I clear the previous results
	When I update the model 'AdventureWorksDemo.Data.Paging.PagingFilter'
		| PageNumber | PageSize | Sorting          |
		| 0          | 5        | Description Desc |
	And I call the method 'FindAllAsync' with the parameter values
		| Key           | Value     | TypeName                                    |
		| pageingFilter | {{model}} | AdventureWorksDemo.Data.Paging.PagingFilter |
	Then the result is of type
		| Expected                                                                                         |
		| AdventureWorksDemo.Data.Paging.PagedList<AdventureWorksDemo.Data.Models.ProductDescriptionModel> |
	And the PagedList values are
		| TotalPages | TotalCount | PageSize | CurrentPage |
		| 8          | 37         | 5        | 0           |
	And the sorted results are
		| ProductDescriptionId | ModifiedDate         | Rowguid                              | Description                                                                                                                                                                                                                                                                   |
		| 630                  | 6/1/2007 12:00:00 AM | 28c4682c-38b2-4b61-a2ae-bcac7c7ce29b | Wide-link design.                                                                                                                                                                                                                        |
		| 1504                 | 6/1/2007 12:00:00 AM | e3bac4a6-220c-4e5e-8261-51e08906c0e8 | Voyagez confortablement et avec �l�gance. Confort et s�curit� maximum. Large �ventail de vitesses pour gravir toutes les c�tes. Sa fabrication en alliage d'aluminium haute technologie est synonyme de robustesse, sans ajout de poids. |
		| 1502                 | 6/1/2007 12:00:00 AM | e5288050-bc5b-45cc-8849-c7d4af2fe2b6 | V�lo de qualit� pour tous usages, dot� d'un bon niveau de confort et de s�curit�. Pr�sente des pneus plus larges et plus stables pour les sorties en ville ou les randonn�es du week-end.                                                |
		| 1493                 | 6/1/2007 12:00:00 AM | 7943455f-3fbe-44c0-9ac2-7ee642d3944b | V�lo d'adulte d'entr�e de gamme�; permet une conduite confortable en ville ou sur les chemins de campagne. Moyeux et rayons � blocage rapide.                                                                                            |
		| 1211                 | 6/1/2007 12:00:00 AM | 12f60253-f8e1-4f76-8142-6232396b8f17 | Unisex long-sleeve AWC logo microfiber cycling jersey                                                                                                                                                                                    |

	Given I clear the previous results
	When I update the model 'AdventureWorksDemo.Data.Paging.PagingFilter'
		| PageNumber | PageSize | Sorting          |
		| 0          | 5        | Description  |
	And I call the method 'FindAllAsync' with the parameter values
		| Key           | Value     | TypeName                                    |
		| pageingFilter | {{model}} | AdventureWorksDemo.Data.Paging.PagingFilter |
	Then the result is of type
		| Expected                                                                                         |
		| AdventureWorksDemo.Data.Paging.PagedList<AdventureWorksDemo.Data.Models.ProductDescriptionModel> |
	And the PagedList values are
		| TotalPages | TotalCount | PageSize | CurrentPage |
		| 8          | 37         | 5        | 0           |
	And the sorted results are
		| ProductDescriptionId | ModifiedDate         | Rowguid                              | Description                                                                                                                                                                                                                                                                   |
		| 1487                 | 6/1/2007 12:00:00 AM | 5c1dab3a-4b31-4d9d-a14f-3cb61949b79b | Adapt� � tous les usages, sur route ou tout-terrain. Pour toutes les bourses. Changement de braquet en douceur et conduite confortable.                                                                                                                                       |
		| 513                  | 6/1/2007 12:00:00 AM | 741eae59-5e59-4dbc-9086-2633392c2582 | All-occasion value bike with our basic comfort and safety features. Offers wider, more stable tires for a ride around town or weekend trip.                                                                                                                                   |
		| 627                  | 6/1/2007 12:00:00 AM | ebf2f0a4-89f2-4d31-be48-d8fd278f3024 | All-weather brake pads; provides superior stopping by applying more surface to the rim.                                                                                                                                                                                       |
		| 1488                 | 6/1/2007 12:00:00 AM | 79065ec8-2080-4120-a4ea-bfa7ea1f1f9d | Ce v�lo offre un excellent rapport qualit�-prix. Vif et facile � man�uvrer, il se conduit en toute tranquillit� sur les chemins et les sentiers.                                                                                                                              |
		| 1605                 | 6/1/2007 12:00:00 AM | 9cfed570-180a-44ea-8233-55116a0ddcb9 | Chaque cadre est fabriqu� artisanalement dans notre atelier de Bordeaux afin d'obtenir le diam�tre et l'�paisseur adapt�s � un v�lo tout-terrain de premier choix. Le cadre en aluminium soud� � chaud pr�sente un tube d'un plus grand diam�tre, afin d'absorber les bosses. |

	Given I clear the previous results
	When I update the model 'AdventureWorksDemo.Data.Paging.PagingFilter'
		| PageNumber | PageSize | Sorting          |
		| 0          | 5        | Description Desc |
	And I call the method 'FindAllAsync' with the parameter values
		| Key           | Value     | TypeName                                    |
		| pageingFilter | {{model}} | AdventureWorksDemo.Data.Paging.PagingFilter |
	Then the result is of type
		| Expected                                                                                         |
		| AdventureWorksDemo.Data.Paging.PagedList<AdventureWorksDemo.Data.Models.ProductDescriptionModel> |
	And the PagedList values are
		| TotalPages | TotalCount | PageSize | CurrentPage |
		| 8          | 37         | 5        | 0           |
	And the sorted results are
		| ProductDescriptionId | ModifiedDate         | Rowguid                              | Description                                                                                                                                                                                                                                                                   |
		| 630                  | 6/1/2007 12:00:00 AM | 28c4682c-38b2-4b61-a2ae-bcac7c7ce29b | Wide-link design.                                                                                                                                                                                                                        |
		| 1504                 | 6/1/2007 12:00:00 AM | e3bac4a6-220c-4e5e-8261-51e08906c0e8 | Voyagez confortablement et avec �l�gance. Confort et s�curit� maximum. Large �ventail de vitesses pour gravir toutes les c�tes. Sa fabrication en alliage d'aluminium haute technologie est synonyme de robustesse, sans ajout de poids. |
		| 1502                 | 6/1/2007 12:00:00 AM | e5288050-bc5b-45cc-8849-c7d4af2fe2b6 | V�lo de qualit� pour tous usages, dot� d'un bon niveau de confort et de s�curit�. Pr�sente des pneus plus larges et plus stables pour les sorties en ville ou les randonn�es du week-end.                                                |
		| 1493                 | 6/1/2007 12:00:00 AM | 7943455f-3fbe-44c0-9ac2-7ee642d3944b | V�lo d'adulte d'entr�e de gamme�; permet une conduite confortable en ville ou sur les chemins de campagne. Moyeux et rayons � blocage rapide.                                                                                            |
		| 1211                 | 6/1/2007 12:00:00 AM | 12f60253-f8e1-4f76-8142-6232396b8f17 | Unisex long-sleeve AWC logo microfiber cycling jersey                                                                                                                                                                                    |

	Given I clear the previous results
	When I update the model 'AdventureWorksDemo.Data.Paging.PagingFilter'
		| PageNumber | PageSize | Sorting          |
		| 0          | 5        | Description  |
	And I call the method 'FindAllAsync' with the parameter values
		| Key           | Value     | TypeName                                    |
		| pageingFilter | {{model}} | AdventureWorksDemo.Data.Paging.PagingFilter |
	Then the result is of type
		| Expected                                                                                         |
		| AdventureWorksDemo.Data.Paging.PagedList<AdventureWorksDemo.Data.Models.ProductDescriptionModel> |
	And the PagedList values are
		| TotalPages | TotalCount | PageSize | CurrentPage |
		| 8          | 37         | 5        | 0           |
	And the sorted results are
		| ProductDescriptionId | ModifiedDate         | Rowguid                              | Description                                                                                                                                                                                                                                                                   |
		| 1487                 | 6/1/2007 12:00:00 AM | 5c1dab3a-4b31-4d9d-a14f-3cb61949b79b | Adapt� � tous les usages, sur route ou tout-terrain. Pour toutes les bourses. Changement de braquet en douceur et conduite confortable.                                                                                                                                       |
		| 513                  | 6/1/2007 12:00:00 AM | 741eae59-5e59-4dbc-9086-2633392c2582 | All-occasion value bike with our basic comfort and safety features. Offers wider, more stable tires for a ride around town or weekend trip.                                                                                                                                   |
		| 627                  | 6/1/2007 12:00:00 AM | ebf2f0a4-89f2-4d31-be48-d8fd278f3024 | All-weather brake pads; provides superior stopping by applying more surface to the rim.                                                                                                                                                                                       |
		| 1488                 | 6/1/2007 12:00:00 AM | 79065ec8-2080-4120-a4ea-bfa7ea1f1f9d | Ce v�lo offre un excellent rapport qualit�-prix. Vif et facile � man�uvrer, il se conduit en toute tranquillit� sur les chemins et les sentiers.                                                                                                                              |
		| 1605                 | 6/1/2007 12:00:00 AM | 9cfed570-180a-44ea-8233-55116a0ddcb9 | Chaque cadre est fabriqu� artisanalement dans notre atelier de Bordeaux afin d'obtenir le diam�tre et l'�paisseur adapt�s � un v�lo tout-terrain de premier choix. Le cadre en aluminium soud� � chaud pr�sente un tube d'un plus grand diam�tre, afin d'absorber les bosses. |

	Given I clear the previous results
	When I update the model 'AdventureWorksDemo.Data.Paging.PagingFilter'
		| PageNumber | PageSize | Sorting          |
		| 0          | 5        | Description Desc |
	And I call the method 'FindAllAsync' with the parameter values
		| Key           | Value     | TypeName                                    |
		| pageingFilter | {{model}} | AdventureWorksDemo.Data.Paging.PagingFilter |
	Then the result is of type
		| Expected                                                                                         |
		| AdventureWorksDemo.Data.Paging.PagedList<AdventureWorksDemo.Data.Models.ProductDescriptionModel> |
	And the PagedList values are
		| TotalPages | TotalCount | PageSize | CurrentPage |
		| 8          | 37         | 5        | 0           |
	And the sorted results are
		| ProductDescriptionId | ModifiedDate         | Rowguid                              | Description                                                                                                                                                                                                                                                                   |
		| 630                  | 6/1/2007 12:00:00 AM | 28c4682c-38b2-4b61-a2ae-bcac7c7ce29b | Wide-link design.                                                                                                                                                                                                                        |
		| 1504                 | 6/1/2007 12:00:00 AM | e3bac4a6-220c-4e5e-8261-51e08906c0e8 | Voyagez confortablement et avec �l�gance. Confort et s�curit� maximum. Large �ventail de vitesses pour gravir toutes les c�tes. Sa fabrication en alliage d'aluminium haute technologie est synonyme de robustesse, sans ajout de poids. |
		| 1502                 | 6/1/2007 12:00:00 AM | e5288050-bc5b-45cc-8849-c7d4af2fe2b6 | V�lo de qualit� pour tous usages, dot� d'un bon niveau de confort et de s�curit�. Pr�sente des pneus plus larges et plus stables pour les sorties en ville ou les randonn�es du week-end.                                                |
		| 1493                 | 6/1/2007 12:00:00 AM | 7943455f-3fbe-44c0-9ac2-7ee642d3944b | V�lo d'adulte d'entr�e de gamme�; permet une conduite confortable en ville ou sur les chemins de campagne. Moyeux et rayons � blocage rapide.                                                                                            |
		| 1211                 | 6/1/2007 12:00:00 AM | 12f60253-f8e1-4f76-8142-6232396b8f17 | Unisex long-sleeve AWC logo microfiber cycling jersey                                                                                                                                                                                    |

	Given I clear the previous results
	When I update the model 'AdventureWorksDemo.Data.Paging.PagingFilter'
		| PageNumber | PageSize | Sorting          |
		| 0          | 5        | Description  |
	And I call the method 'FindAllAsync' with the parameter values
		| Key           | Value     | TypeName                                    |
		| pageingFilter | {{model}} | AdventureWorksDemo.Data.Paging.PagingFilter |
	Then the result is of type
		| Expected                                                                                         |
		| AdventureWorksDemo.Data.Paging.PagedList<AdventureWorksDemo.Data.Models.ProductDescriptionModel> |
	And the PagedList values are
		| TotalPages | TotalCount | PageSize | CurrentPage |
		| 8          | 37         | 5        | 0           |
	And the sorted results are
		| ProductDescriptionId | ModifiedDate         | Rowguid                              | Description                                                                                                                                                                                                                                                                   |
		| 1487                 | 6/1/2007 12:00:00 AM | 5c1dab3a-4b31-4d9d-a14f-3cb61949b79b | Adapt� � tous les usages, sur route ou tout-terrain. Pour toutes les bourses. Changement de braquet en douceur et conduite confortable.                                                                                                                                       |
		| 513                  | 6/1/2007 12:00:00 AM | 741eae59-5e59-4dbc-9086-2633392c2582 | All-occasion value bike with our basic comfort and safety features. Offers wider, more stable tires for a ride around town or weekend trip.                                                                                                                                   |
		| 627                  | 6/1/2007 12:00:00 AM | ebf2f0a4-89f2-4d31-be48-d8fd278f3024 | All-weather brake pads; provides superior stopping by applying more surface to the rim.                                                                                                                                                                                       |
		| 1488                 | 6/1/2007 12:00:00 AM | 79065ec8-2080-4120-a4ea-bfa7ea1f1f9d | Ce v�lo offre un excellent rapport qualit�-prix. Vif et facile � man�uvrer, il se conduit en toute tranquillit� sur les chemins et les sentiers.                                                                                                                              |
		| 1605                 | 6/1/2007 12:00:00 AM | 9cfed570-180a-44ea-8233-55116a0ddcb9 | Chaque cadre est fabriqu� artisanalement dans notre atelier de Bordeaux afin d'obtenir le diam�tre et l'�paisseur adapt�s � un v�lo tout-terrain de premier choix. Le cadre en aluminium soud� � chaud pr�sente un tube d'un plus grand diam�tre, afin d'absorber les bosses. |

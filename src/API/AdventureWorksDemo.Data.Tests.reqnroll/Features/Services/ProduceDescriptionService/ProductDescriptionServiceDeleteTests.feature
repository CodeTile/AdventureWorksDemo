Feature: ProductDescriptionServiceDeleteTests

System tests for the ProductDescriptionService
Testing the methods DeleteAsync


Background:
	Given The service to test is 'AdventureWorksDemo.Data.Services.IProductDescriptionService'
	And I don't reset the database after the scenario

Scenario: DeleteAsync12345

	When I call the method 'DeleteAsync' with the parameter values
		| Key                  | Value | TypeName | ModifiedDate         |
		| ProductDescriptionId | 12345 | int      | 21 Apr 2024 12:34:56 |
	Then the result is of type
		| Expected                                                     |
		| AdventureWorksDemo.Data.Models.ServiceResult<System.Boolean> |
	And the result is
		| IsFailure | IsSuccess | Message                          |
		| True      | False     | Unable to find record to delete! |

	
	And the ServiceResult is of type 'System.Boolean' with the value
		| Expected |
		| False    |
	And the table 'SalesLT.ProductDescription' filtered by 'ProductDescriptionId > 1500' contains
		| ProductDescriptionId | ModifiedDate         | Rowguid                              | Description                                                                                                                                                                                                                                                                   |
		| 1502                 | 6/1/2007 12:00:00 AM | e5288050-bc5b-45cc-8849-c7d4af2fe2b6 | V�lo de qualit� pour tous usages, dot� d'un bon niveau de confort et de s�curit�. Pr�sente des pneus plus larges et plus stables pour les sorties en ville ou les randonn�es du week-end.                                                                                     |
		| 1503                 | 6/1/2007 12:00:00 AM | 28b132c3-108c-412d-9918-a8c9297dfb73 | La selle rembourr�e offre un confort optimal. Le porte-bagages nouvellement remani� offre diverses possibilit�s d'ajout de paniers ou de sacoches. Ce v�lo reste parfaitement stable une fois charg�.                                                                         |
		| 1504                 | 6/1/2007 12:00:00 AM | e3bac4a6-220c-4e5e-8261-51e08906c0e8 | Voyagez confortablement et avec �l�gance. Confort et s�curit� maximum. Large �ventail de vitesses pour gravir toutes les c�tes. Sa fabrication en alliage d'aluminium haute technologie est synonyme de robustesse, sans ajout de poids.                                      |
		| 1509                 | 6/1/2007 12:00:00 AM | 5ed8186a-6049-42b1-b1b0-3b1f899c538b | Patins de freinage pour tous les temps�; freinage renforc� par l'application d'une plus grande surface sur la jante.                                                                                                                                                          |
		| 1510                 | 6/1/2007 12:00:00 AM | 64723c0c-09d5-497d-83a3-4561818a8f1c | Conception liaison large.                                                                                                                                                                                                                                                     |
		| 1517                 | 6/1/2007 12:00:00 AM | f3cd990a-b70d-43c8-a075-934a3e98b5aa | Dot� du m�me alliage en aluminium que notre cadre HL haut de gamme, le ML poss�de un tube l�ger dont le diam�tre est pr�vu pour offrir une r�sistance optimale. Version femmes.                                                                                               |
		| 1537                 | 6/1/2007 12:00:00 AM | 6a60e7f6-a5cd-4e7b-8612-9340e46bf66d | P�dales automatiques l�g�res et robustes avec tension r�glable.                                                                                                                                                                                                               |
		| 1571                 | 6/1/2007 12:00:00 AM | e95e1259-b822-40ee-aa86-7de9f9e0f0ea | Le cadre LL en aluminium offre une conduite confortable, une excellente absorption des bosses pour un tr�s bon rapport qualit�-prix.                                                                                                                                          |
		| 1587                 | 6/1/2007 12:00:00 AM | e11a3c2a-b074-48f9-8226-16d65c2f91c2 | Cuissards r�sistants � l'usure pour utilisation intensive, doubl�s � l'int�rieur en Spandex, sans couture, peau de chamois anti-bact�rie pour un meilleur confort.                                                                                                            |
		| 1594                 | 6/1/2007 12:00:00 AM | fb2a5474-9d83-4a9b-bbbd-8ffc9036866e | Maillot manches courtes classique et anti-transpiration avec contr�le de l'humidit�, fermeture avant � glissi�re et 3�poches arri�re.                                                                                                                                         |
		| 1596                 | 6/1/2007 12:00:00 AM | 31d4905c-d37c-4128-bcff-4a35da9c1bb7 | Fin, l�ger et r�sistant avec des poignets qui restent en place.                                                                                                                                                                                                               |
		| 1598                 | 6/1/2007 12:00:00 AM | fb627d1b-2933-4fbe-a6a4-bf69f2814ec2 | Style classique avec une visi�re relevable�; taille unique.                                                                                                                                                                                                                   |
		| 1599                 | 6/1/2007 12:00:00 AM | 4aae6d4f-8320-4f32-99de-bb3b1b13f1ef | Maillot de cycliste en microfibre avec le logo de l'�quipe AWV, manches longues, unisexe.                                                                                                                                                                                     |
		| 1600                 | 6/1/2020 12:00:00 AM | 4aae6d4f-1111-4f32-99de-bb3b1b13f1ef | Orphan record to deletion test                                                                                                                                                                                                                                                |
		| 1605                 | 6/1/2007 12:00:00 AM | 9cfed570-180a-44ea-8233-55116a0ddcb9 | Chaque cadre est fabriqu� artisanalement dans notre atelier de Bordeaux afin d'obtenir le diam�tre et l'�paisseur adapt�s � un v�lo tout-terrain de premier choix. Le cadre en aluminium soud� � chaud pr�sente un tube d'un plus grand diam�tre, afin d'absorber les bosses. |

	

	
Scenario: DeleteAsync1504
	Given I reset the database after the scenario
	When I call the method 'DeleteAsync' with the parameter values
		| Key                  | Value | TypeName |
		| ProductDescriptionId | 1504  | int      |
	Then the result is of type
		| Expected                                                     |
		| AdventureWorksDemo.Data.Models.ServiceResult<System.Boolean> |
	And the result is
		| IsFailure | IsSuccess | Message                                           |
		| True      | False     | Unable to delete, record is referenced elsewhere! |

	And the ServiceResult is of type 'System.Boolean' with the value
		| Expected |
		| False    |
	Then the table 'SalesLT.ProductDescription' filtered by 'ProductDescriptionId > 1500' contains
		| ProductDescriptionId | ModifiedDate         | Rowguid                              | Description                                                                                                                                                                                                                                                                   |
		| 1502                 | 6/1/2007 12:00:00 AM | e5288050-bc5b-45cc-8849-c7d4af2fe2b6 | V�lo de qualit� pour tous usages, dot� d'un bon niveau de confort et de s�curit�. Pr�sente des pneus plus larges et plus stables pour les sorties en ville ou les randonn�es du week-end.                                                                                     |
		| 1503                 | 6/1/2007 12:00:00 AM | 28b132c3-108c-412d-9918-a8c9297dfb73 | La selle rembourr�e offre un confort optimal. Le porte-bagages nouvellement remani� offre diverses possibilit�s d'ajout de paniers ou de sacoches. Ce v�lo reste parfaitement stable une fois charg�.                                                                         |
		| 1504                 | 6/1/2007 12:00:00 AM | e3bac4a6-220c-4e5e-8261-51e08906c0e8 | Voyagez confortablement et avec �l�gance. Confort et s�curit� maximum. Large �ventail de vitesses pour gravir toutes les c�tes. Sa fabrication en alliage d'aluminium haute technologie est synonyme de robustesse, sans ajout de poids.                                      |
		| 1509                 | 6/1/2007 12:00:00 AM | 5ed8186a-6049-42b1-b1b0-3b1f899c538b | Patins de freinage pour tous les temps�; freinage renforc� par l'application d'une plus grande surface sur la jante.                                                                                                                                                          |
		| 1510                 | 6/1/2007 12:00:00 AM | 64723c0c-09d5-497d-83a3-4561818a8f1c | Conception liaison large.                                                                                                                                                                                                                                                     |
		| 1517                 | 6/1/2007 12:00:00 AM | f3cd990a-b70d-43c8-a075-934a3e98b5aa | Dot� du m�me alliage en aluminium que notre cadre HL haut de gamme, le ML poss�de un tube l�ger dont le diam�tre est pr�vu pour offrir une r�sistance optimale. Version femmes.                                                                                               |
		| 1537                 | 6/1/2007 12:00:00 AM | 6a60e7f6-a5cd-4e7b-8612-9340e46bf66d | P�dales automatiques l�g�res et robustes avec tension r�glable.                                                                                                                                                                                                               |
		| 1571                 | 6/1/2007 12:00:00 AM | e95e1259-b822-40ee-aa86-7de9f9e0f0ea | Le cadre LL en aluminium offre une conduite confortable, une excellente absorption des bosses pour un tr�s bon rapport qualit�-prix.                                                                                                                                          |
		| 1587                 | 6/1/2007 12:00:00 AM | e11a3c2a-b074-48f9-8226-16d65c2f91c2 | Cuissards r�sistants � l'usure pour utilisation intensive, doubl�s � l'int�rieur en Spandex, sans couture, peau de chamois anti-bact�rie pour un meilleur confort.                                                                                                            |
		| 1594                 | 6/1/2007 12:00:00 AM | fb2a5474-9d83-4a9b-bbbd-8ffc9036866e | Maillot manches courtes classique et anti-transpiration avec contr�le de l'humidit�, fermeture avant � glissi�re et 3�poches arri�re.                                                                                                                                         |
		| 1596                 | 6/1/2007 12:00:00 AM | 31d4905c-d37c-4128-bcff-4a35da9c1bb7 | Fin, l�ger et r�sistant avec des poignets qui restent en place.                                                                                                                                                                                                               |
		| 1598                 | 6/1/2007 12:00:00 AM | fb627d1b-2933-4fbe-a6a4-bf69f2814ec2 | Style classique avec une visi�re relevable�; taille unique.                                                                                                                                                                                                                   |
		| 1599                 | 6/1/2007 12:00:00 AM | 4aae6d4f-8320-4f32-99de-bb3b1b13f1ef | Maillot de cycliste en microfibre avec le logo de l'�quipe AWV, manches longues, unisexe.                                                                                                                                                                                     |
		| 1605                 | 6/1/2007 12:00:00 AM | 9cfed570-180a-44ea-8233-55116a0ddcb9 | Chaque cadre est fabriqu� artisanalement dans notre atelier de Bordeaux afin d'obtenir le diam�tre et l'�paisseur adapt�s � un v�lo tout-terrain de premier choix. Le cadre en aluminium soud� � chaud pr�sente un tube d'un plus grand diam�tre, afin d'absorber les bosses. |
		| 1600                 | 6/1/2020 12:00:00 AM | 4aae6d4f-1111-4f32-99de-bb3b1b13f1ef | Orphan record to deletion test                                                                                                                                                                                                                                                |

	
Scenario: DeleteAsync1600
	Given I reset the database after the scenario
	When I call the method 'DeleteAsync' with the parameter values
		| Key                  | Value | TypeName |
		| ProductDescriptionId | 1600  | int      |
	Then the result is of type
		| Expected                                                     |
		| AdventureWorksDemo.Data.Models.ServiceResult<System.Boolean> |
	And the result is
		| IsFailure | IsSuccess | Message |
		| False     | True      |         |
	And the ServiceResult is of type 'System.Boolean' with the value
		| Expected |
		| True     |
	Then the table 'SalesLT.ProductDescription' filtered by 'ProductDescriptionId > 1500' contains
		| ProductDescriptionId | ModifiedDate         | Rowguid                              | Description                                                                                                                                                                                                                                                                   |
		| 1502                 | 6/1/2007 12:00:00 AM | e5288050-bc5b-45cc-8849-c7d4af2fe2b6 | V�lo de qualit� pour tous usages, dot� d'un bon niveau de confort et de s�curit�. Pr�sente des pneus plus larges et plus stables pour les sorties en ville ou les randonn�es du week-end.                                                                                     |
		| 1503                 | 6/1/2007 12:00:00 AM | 28b132c3-108c-412d-9918-a8c9297dfb73 | La selle rembourr�e offre un confort optimal. Le porte-bagages nouvellement remani� offre diverses possibilit�s d'ajout de paniers ou de sacoches. Ce v�lo reste parfaitement stable une fois charg�.                                                                         |
		| 1504                 | 6/1/2007 12:00:00 AM | e3bac4a6-220c-4e5e-8261-51e08906c0e8 | Voyagez confortablement et avec �l�gance. Confort et s�curit� maximum. Large �ventail de vitesses pour gravir toutes les c�tes. Sa fabrication en alliage d'aluminium haute technologie est synonyme de robustesse, sans ajout de poids.                                      |
		| 1509                 | 6/1/2007 12:00:00 AM | 5ed8186a-6049-42b1-b1b0-3b1f899c538b | Patins de freinage pour tous les temps�; freinage renforc� par l'application d'une plus grande surface sur la jante.                                                                                                                                                          |
		| 1510                 | 6/1/2007 12:00:00 AM | 64723c0c-09d5-497d-83a3-4561818a8f1c | Conception liaison large.                                                                                                                                                                                                                                                     |
		| 1517                 | 6/1/2007 12:00:00 AM | f3cd990a-b70d-43c8-a075-934a3e98b5aa | Dot� du m�me alliage en aluminium que notre cadre HL haut de gamme, le ML poss�de un tube l�ger dont le diam�tre est pr�vu pour offrir une r�sistance optimale. Version femmes.                                                                                               |
		| 1537                 | 6/1/2007 12:00:00 AM | 6a60e7f6-a5cd-4e7b-8612-9340e46bf66d | P�dales automatiques l�g�res et robustes avec tension r�glable.                                                                                                                                                                                                               |
		| 1571                 | 6/1/2007 12:00:00 AM | e95e1259-b822-40ee-aa86-7de9f9e0f0ea | Le cadre LL en aluminium offre une conduite confortable, une excellente absorption des bosses pour un tr�s bon rapport qualit�-prix.                                                                                                                                          |
		| 1587                 | 6/1/2007 12:00:00 AM | e11a3c2a-b074-48f9-8226-16d65c2f91c2 | Cuissards r�sistants � l'usure pour utilisation intensive, doubl�s � l'int�rieur en Spandex, sans couture, peau de chamois anti-bact�rie pour un meilleur confort.                                                                                                            |
		| 1594                 | 6/1/2007 12:00:00 AM | fb2a5474-9d83-4a9b-bbbd-8ffc9036866e | Maillot manches courtes classique et anti-transpiration avec contr�le de l'humidit�, fermeture avant � glissi�re et 3�poches arri�re.                                                                                                                                         |
		| 1596                 | 6/1/2007 12:00:00 AM | 31d4905c-d37c-4128-bcff-4a35da9c1bb7 | Fin, l�ger et r�sistant avec des poignets qui restent en place.                                                                                                                                                                                                               |
		| 1598                 | 6/1/2007 12:00:00 AM | fb627d1b-2933-4fbe-a6a4-bf69f2814ec2 | Style classique avec une visi�re relevable�; taille unique.                                                                                                                                                                                                                   |
		| 1599                 | 6/1/2007 12:00:00 AM | 4aae6d4f-8320-4f32-99de-bb3b1b13f1ef | Maillot de cycliste en microfibre avec le logo de l'�quipe AWV, manches longues, unisexe.                                                                                                                                                                                     |
		| 1605                 | 6/1/2007 12:00:00 AM | 9cfed570-180a-44ea-8233-55116a0ddcb9 | Chaque cadre est fabriqu� artisanalement dans notre atelier de Bordeaux afin d'obtenir le diam�tre et l'�paisseur adapt�s � un v�lo tout-terrain de premier choix. Le cadre en aluminium soud� � chaud pr�sente un tube d'un plus grand diam�tre, afin d'absorber les bosses. |

	

Feature: ProductDescriptionServiceFindAllAsyncTests

System tests for the ProductDescriptionService
Testing the methods FindAllAsync

Background:
	Given The service to test is 'AdventureWorksDemo.Data.Services.IProductDescriptionService'

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
		| 8          | 37         | 5        | 0           |
	And the sorted results are
		| ProductDescriptionId | ModifiedDate              | Rowguid                              | Description                                                                                                                                             |
		| 8                    | 6/1/2007 12:00:00 AM      | 8e6746e5-ad97-46e2-bd24-fcea075c3b52 | Suitable for any type of riding, on or off-road. Fits any budget. Smooth-shifting with a comfortable ride.                                              |
		| 64                   | 6/1/2007 12:00:00 AM      | 7b1c4e90-85e2-4792-b47b-e0c424e2ec94 | This bike delivers a high-level of performance on a budget. It is responsive and maneuverable, and offers peace-of-mind when you decide to go off-road. |
		| 128                  | 3/11/2008 10:32:17.973 AM | 130709e6-8512-49b9-9f62-1f5c99152056 | Serious back-country riding. Perfect for all levels of competition. Uses the same HL Frame as the Mountain-100.                                         |
		| 209                  | 6/1/2007 12:00:00 AM      | f5ff5ffd-cb7c-4ad6-bbc9-4d250bb6e98d | Entry level adult bike; offers a comfortable ride cross-country or down the block. Quick-release hubs and rims.                                         |
		| 513                  | 6/1/2007 12:00:00 AM      | 741eae59-5e59-4dbc-9086-2633392c2582 | All-occasion value bike with our basic comfort and safety features. Offers wider, more stable tires for a ride around town or weekend trip.             |

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
		| 8          | 37         | 5        | 1           |
	And the sorted results are
		| ProductDescriptionId | ModifiedDate         | Rowguid                              | Description                                                                                                                                                                                                                   |
		| 554                  | 6/1/2007 12:00:00 AM | ddc955b2-843e-49ce-8f7b-54870f6135eb | The plush custom saddle keeps you riding all day,  and there's plenty of space to add panniers and bike bags to the newly-redesigned carrier.  This bike has stability when fully-loaded.                                     |
		| 594                  | 6/1/2007 12:00:00 AM | 32b82c92-e545-4da0-a175-0be710b482fe | Travel in style and comfort. Designed for maximum comfort and safety. Wide gear range takes on all hills. High-tech aluminum alloy construction provides durability without added weight.                                     |
		| 627                  | 6/1/2007 12:00:00 AM | ebf2f0a4-89f2-4d31-be48-d8fd278f3024 | All-weather brake pads; provides superior stopping by applying more surface to the rim.                                                                                                                                       |
		| 630                  | 6/1/2007 12:00:00 AM | 28c4682c-38b2-4b61-a2ae-bcac7c7ce29b | Wide-link design.                                                                                                                                                                                                             |
		| 647                  | 6/1/2007 12:00:00 AM | 7ad9e29f-16cf-4db0-b073-cc62d501b61a | Each frame is hand-crafted in our Bothell facility to the optimum diameter and wall-thickness required of a premium mountain frame. The heat-treated welded aluminum frame has a larger diameter tube that absorbs the bumps. |

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
		| 1          | 37         | 100      | 0           |
	And the sorted results are
		| ProductDescriptionId | ModifiedDate              | Rowguid                              | Description                                                                                                                                                                                                                                                                   |
		| 8                    | 6/1/2007 12:00:00 AM      | 8e6746e5-ad97-46e2-bd24-fcea075c3b52 | Suitable for any type of riding, on or off-road. Fits any budget. Smooth-shifting with a comfortable ride.                                                                                                                                                                    |
		| 64                   | 6/1/2007 12:00:00 AM      | 7b1c4e90-85e2-4792-b47b-e0c424e2ec94 | This bike delivers a high-level of performance on a budget. It is responsive and maneuverable, and offers peace-of-mind when you decide to go off-road.                                                                                                                       |
		| 128                  | 3/11/2008 10:32:17.973 AM | 130709e6-8512-49b9-9f62-1f5c99152056 | Serious back-country riding. Perfect for all levels of competition. Uses the same HL Frame as the Mountain-100.                                                                                                                                                               |
		| 209                  | 6/1/2007 12:00:00 AM      | f5ff5ffd-cb7c-4ad6-bbc9-4d250bb6e98d | Entry level adult bike; offers a comfortable ride cross-country or down the block. Quick-release hubs and rims.                                                                                                                                                               |
		| 513                  | 6/1/2007 12:00:00 AM      | 741eae59-5e59-4dbc-9086-2633392c2582 | All-occasion value bike with our basic comfort and safety features. Offers wider, more stable tires for a ride around town or weekend trip.                                                                                                                                   |
		| 554                  | 6/1/2007 12:00:00 AM      | ddc955b2-843e-49ce-8f7b-54870f6135eb | The plush custom saddle keeps you riding all day,  and there's plenty of space to add panniers and bike bags to the newly-redesigned carrier.  This bike has stability when fully-loaded.                                                                                     |
		| 594                  | 6/1/2007 12:00:00 AM      | 32b82c92-e545-4da0-a175-0be710b482fe | Travel in style and comfort. Designed for maximum comfort and safety. Wide gear range takes on all hills. High-tech aluminum alloy construction provides durability without added weight.                                                                                     |
		| 627                  | 6/1/2007 12:00:00 AM      | ebf2f0a4-89f2-4d31-be48-d8fd278f3024 | All-weather brake pads; provides superior stopping by applying more surface to the rim.                                                                                                                                                                                       |
		| 630                  | 6/1/2007 12:00:00 AM      | 28c4682c-38b2-4b61-a2ae-bcac7c7ce29b | Wide-link design.                                                                                                                                                                                                                                                             |
		| 647                  | 6/1/2007 12:00:00 AM      | 7ad9e29f-16cf-4db0-b073-cc62d501b61a | Each frame is hand-crafted in our Bothell facility to the optimum diameter and wall-thickness required of a premium mountain frame. The heat-treated welded aluminum frame has a larger diameter tube that absorbs the bumps.                                                 |
		| 661                  | 6/1/2007 12:00:00 AM      | d61c9d54-22c3-4563-a418-0b9dc7e03850 | Made from the same aluminum alloy as our top-of-the line HL frame, the ML features a lightweight down-tube milled to the perfect diameter for optimal strength. Women's version.                                                                                              |
		| 848                  | 6/1/2007 12:00:00 AM      | 03acbb19-749a-48a1-b77e-5d2a48e8dc3a | Lightweight, durable, clipless pedal with adjustable tension.                                                                                                                                                                                                                 |
		| 1020                 | 6/1/2007 12:00:00 AM      | f4c70a6b-bbe8-4774-9d75-393d3f315e9b | The LL Frame provides a safe comfortable ride, while offering superior bump absorption in a value-priced aluminum frame.                                                                                                                                                      |
		| 1196                 | 6/1/2007 12:00:00 AM      | c65bee64-4dba-47ec-91cd-31356ba379e1 | Heavy duty, abrasion-resistant shorts feature seamless, lycra inner shorts with anti-bacterial chamois for comfort.                                                                                                                                                           |
		| 1205                 | 6/1/2007 12:00:00 AM      | 58d86ede-0519-4263-a264-a2b5b01a6c7b | Short sleeve classic breathable jersey with superior moisture control, front zipper, and 3 back pockets.                                                                                                                                                                      |
		| 1208                 | 6/1/2007 12:00:00 AM      | 9f436663-525d-4cc2-85ba-47d20bcea0ec | Thin, lightweight and durable with cuffs that stay up.                                                                                                                                                                                                                        |
		| 1210                 | 6/1/2007 12:00:00 AM      | 66f84b21-1a43-49d3-8883-09cdb77fffef | Traditional style with a flip-up brim; one-size fits all.                                                                                                                                                                                                                     |
		| 1211                 | 6/1/2007 12:00:00 AM      | 12f60253-f8e1-4f76-8142-6232396b8f17 | Unisex long-sleeve AWC logo microfiber cycling jersey                                                                                                                                                                                                                         |
		| 1487                 | 6/1/2007 12:00:00 AM      | 5c1dab3a-4b31-4d9d-a14f-3cb61949b79b | Adapt� � tous les usages, sur route ou tout-terrain. Pour toutes les bourses. Changement de braquet en douceur et conduite confortable.                                                                                                                                       |
		| 1488                 | 6/1/2007 12:00:00 AM      | 79065ec8-2080-4120-a4ea-bfa7ea1f1f9d | Ce v�lo offre un excellent rapport qualit�-prix. Vif et facile � man�uvrer, il se conduit en toute tranquillit� sur les chemins et les sentiers.                                                                                                                              |
		| 1490                 | 3/11/2008 10:32:17.973 AM | 2b6fa2a7-4815-47b6-a6bc-d6aec23b85cc | Conduite sur terrains tr�s accident�s. Id�al pour tous les niveaux de comp�tition. Utilise le m�me cadre HL que le Montain-100.                                                                                                                                               |
		| 1493                 | 6/1/2007 12:00:00 AM      | 7943455f-3fbe-44c0-9ac2-7ee642d3944b | V�lo d'adulte d'entr�e de gamme�; permet une conduite confortable en ville ou sur les chemins de campagne. Moyeux et rayons � blocage rapide.                                                                                                                                 |
		| 1502                 | 6/1/2007 12:00:00 AM      | e5288050-bc5b-45cc-8849-c7d4af2fe2b6 | V�lo de qualit� pour tous usages, dot� d'un bon niveau de confort et de s�curit�. Pr�sente des pneus plus larges et plus stables pour les sorties en ville ou les randonn�es du week-end.                                                                                     |
		| 1503                 | 6/1/2007 12:00:00 AM      | 28b132c3-108c-412d-9918-a8c9297dfb73 | La selle rembourr�e offre un confort optimal. Le porte-bagages nouvellement remani� offre diverses possibilit�s d'ajout de paniers ou de sacoches. Ce v�lo reste parfaitement stable une fois charg�.                                                                         |
		| 1504                 | 6/1/2007 12:00:00 AM      | e3bac4a6-220c-4e5e-8261-51e08906c0e8 | Voyagez confortablement et avec �l�gance. Confort et s�curit� maximum. Large �ventail de vitesses pour gravir toutes les c�tes. Sa fabrication en alliage d'aluminium haute technologie est synonyme de robustesse, sans ajout de poids.                                      |
		| 1509                 | 6/1/2007 12:00:00 AM      | 5ed8186a-6049-42b1-b1b0-3b1f899c538b | Patins de freinage pour tous les temps�; freinage renforc� par l'application d'une plus grande surface sur la jante.                                                                                                                                                          |
		| 1510                 | 6/1/2007 12:00:00 AM      | 64723c0c-09d5-497d-83a3-4561818a8f1c | Conception liaison large.                                                                                                                                                                                                                                                     |
		| 1517                 | 6/1/2007 12:00:00 AM      | f3cd990a-b70d-43c8-a075-934a3e98b5aa | Dot� du m�me alliage en aluminium que notre cadre HL haut de gamme, le ML poss�de un tube l�ger dont le diam�tre est pr�vu pour offrir une r�sistance optimale. Version femmes.                                                                                               |
		| 1537                 | 6/1/2007 12:00:00 AM      | 6a60e7f6-a5cd-4e7b-8612-9340e46bf66d | P�dales automatiques l�g�res et robustes avec tension r�glable.                                                                                                                                                                                                               |
		| 1571                 | 6/1/2007 12:00:00 AM      | e95e1259-b822-40ee-aa86-7de9f9e0f0ea | Le cadre LL en aluminium offre une conduite confortable, une excellente absorption des bosses pour un tr�s bon rapport qualit�-prix.                                                                                                                                          |
		| 1587                 | 6/1/2007 12:00:00 AM      | e11a3c2a-b074-48f9-8226-16d65c2f91c2 | Cuissards r�sistants � l'usure pour utilisation intensive, doubl�s � l'int�rieur en Spandex, sans couture, peau de chamois anti-bact�rie pour un meilleur confort.                                                                                                            |
		| 1594                 | 6/1/2007 12:00:00 AM      | fb2a5474-9d83-4a9b-bbbd-8ffc9036866e | Maillot manches courtes classique et anti-transpiration avec contr�le de l'humidit�, fermeture avant � glissi�re et 3�poches arri�re.                                                                                                                                         |
		| 1596                 | 6/1/2007 12:00:00 AM      | 31d4905c-d37c-4128-bcff-4a35da9c1bb7 | Fin, l�ger et r�sistant avec des poignets qui restent en place.                                                                                                                                                                                                               |
		| 1598                 | 6/1/2007 12:00:00 AM      | fb627d1b-2933-4fbe-a6a4-bf69f2814ec2 | Style classique avec une visi�re relevable�; taille unique.                                                                                                                                                                                                                   |
		| 1599                 | 6/1/2007 12:00:00 AM      | 4aae6d4f-8320-4f32-99de-bb3b1b13f1ef | Maillot de cycliste en microfibre avec le logo de l'�quipe AWV, manches longues, unisexe.                                                                                                                                                                                     |
		| 1600                 | 6/1/2020 12:00:00 AM      | 4aae6d4f-1111-4f32-99de-bb3b1b13f1ef | Orphan record to deletion test                                                                                                                                                                                                                                                |
		| 1605                 | 6/1/2007 12:00:00 AM      | 9cfed570-180a-44ea-8233-55116a0ddcb9 | Chaque cadre est fabriqu� artisanalement dans notre atelier de Bordeaux afin d'obtenir le diam�tre et l'�paisseur adapt�s � un v�lo tout-terrain de premier choix. Le cadre en aluminium soud� � chaud pr�sente un tube d'un plus grand diam�tre, afin d'absorber les bosses. |


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
		| 1          | 37         | 100      | 0           |
	And the sorted results are
		| ProductDescriptionId | ModifiedDate              | Rowguid                              | Description                                                                                                                                                                                                                                                                   |
		| 8                    | 6/1/2007 12:00:00 AM      | 8e6746e5-ad97-46e2-bd24-fcea075c3b52 | Suitable for any type of riding, on or off-road. Fits any budget. Smooth-shifting with a comfortable ride.                                                                                                                                                                    |
		| 64                   | 6/1/2007 12:00:00 AM      | 7b1c4e90-85e2-4792-b47b-e0c424e2ec94 | This bike delivers a high-level of performance on a budget. It is responsive and maneuverable, and offers peace-of-mind when you decide to go off-road.                                                                                                                       |
		| 128                  | 3/11/2008 10:32:17.973 AM | 130709e6-8512-49b9-9f62-1f5c99152056 | Serious back-country riding. Perfect for all levels of competition. Uses the same HL Frame as the Mountain-100.                                                                                                                                                               |
		| 209                  | 6/1/2007 12:00:00 AM      | f5ff5ffd-cb7c-4ad6-bbc9-4d250bb6e98d | Entry level adult bike; offers a comfortable ride cross-country or down the block. Quick-release hubs and rims.                                                                                                                                                               |
		| 513                  | 6/1/2007 12:00:00 AM      | 741eae59-5e59-4dbc-9086-2633392c2582 | All-occasion value bike with our basic comfort and safety features. Offers wider, more stable tires for a ride around town or weekend trip.                                                                                                                                   |
		| 554                  | 6/1/2007 12:00:00 AM      | ddc955b2-843e-49ce-8f7b-54870f6135eb | The plush custom saddle keeps you riding all day,  and there's plenty of space to add panniers and bike bags to the newly-redesigned carrier.  This bike has stability when fully-loaded.                                                                                     |
		| 594                  | 6/1/2007 12:00:00 AM      | 32b82c92-e545-4da0-a175-0be710b482fe | Travel in style and comfort. Designed for maximum comfort and safety. Wide gear range takes on all hills. High-tech aluminum alloy construction provides durability without added weight.                                                                                     |
		| 627                  | 6/1/2007 12:00:00 AM      | ebf2f0a4-89f2-4d31-be48-d8fd278f3024 | All-weather brake pads; provides superior stopping by applying more surface to the rim.                                                                                                                                                                                       |
		| 630                  | 6/1/2007 12:00:00 AM      | 28c4682c-38b2-4b61-a2ae-bcac7c7ce29b | Wide-link design.                                                                                                                                                                                                                                                             |
		| 647                  | 6/1/2007 12:00:00 AM      | 7ad9e29f-16cf-4db0-b073-cc62d501b61a | Each frame is hand-crafted in our Bothell facility to the optimum diameter and wall-thickness required of a premium mountain frame. The heat-treated welded aluminum frame has a larger diameter tube that absorbs the bumps.                                                 |
		| 661                  | 6/1/2007 12:00:00 AM      | d61c9d54-22c3-4563-a418-0b9dc7e03850 | Made from the same aluminum alloy as our top-of-the line HL frame, the ML features a lightweight down-tube milled to the perfect diameter for optimal strength. Women's version.                                                                                              |
		| 848                  | 6/1/2007 12:00:00 AM      | 03acbb19-749a-48a1-b77e-5d2a48e8dc3a | Lightweight, durable, clipless pedal with adjustable tension.                                                                                                                                                                                                                 |
		| 1020                 | 6/1/2007 12:00:00 AM      | f4c70a6b-bbe8-4774-9d75-393d3f315e9b | The LL Frame provides a safe comfortable ride, while offering superior bump absorption in a value-priced aluminum frame.                                                                                                                                                      |
		| 1196                 | 6/1/2007 12:00:00 AM      | c65bee64-4dba-47ec-91cd-31356ba379e1 | Heavy duty, abrasion-resistant shorts feature seamless, lycra inner shorts with anti-bacterial chamois for comfort.                                                                                                                                                           |
		| 1205                 | 6/1/2007 12:00:00 AM      | 58d86ede-0519-4263-a264-a2b5b01a6c7b | Short sleeve classic breathable jersey with superior moisture control, front zipper, and 3 back pockets.                                                                                                                                                                      |
		| 1208                 | 6/1/2007 12:00:00 AM      | 9f436663-525d-4cc2-85ba-47d20bcea0ec | Thin, lightweight and durable with cuffs that stay up.                                                                                                                                                                                                                        |
		| 1210                 | 6/1/2007 12:00:00 AM      | 66f84b21-1a43-49d3-8883-09cdb77fffef | Traditional style with a flip-up brim; one-size fits all.                                                                                                                                                                                                                     |
		| 1211                 | 6/1/2007 12:00:00 AM      | 12f60253-f8e1-4f76-8142-6232396b8f17 | Unisex long-sleeve AWC logo microfiber cycling jersey                                                                                                                                                                                                                         |
		| 1487                 | 6/1/2007 12:00:00 AM      | 5c1dab3a-4b31-4d9d-a14f-3cb61949b79b | Adapt� � tous les usages, sur route ou tout-terrain. Pour toutes les bourses. Changement de braquet en douceur et conduite confortable.                                                                                                                                       |
		| 1488                 | 6/1/2007 12:00:00 AM      | 79065ec8-2080-4120-a4ea-bfa7ea1f1f9d | Ce v�lo offre un excellent rapport qualit�-prix. Vif et facile � man�uvrer, il se conduit en toute tranquillit� sur les chemins et les sentiers.                                                                                                                              |
		| 1490                 | 3/11/2008 10:32:17.973 AM | 2b6fa2a7-4815-47b6-a6bc-d6aec23b85cc | Conduite sur terrains tr�s accident�s. Id�al pour tous les niveaux de comp�tition. Utilise le m�me cadre HL que le Montain-100.                                                                                                                                               |
		| 1493                 | 6/1/2007 12:00:00 AM      | 7943455f-3fbe-44c0-9ac2-7ee642d3944b | V�lo d'adulte d'entr�e de gamme�; permet une conduite confortable en ville ou sur les chemins de campagne. Moyeux et rayons � blocage rapide.                                                                                                                                 |
		| 1502                 | 6/1/2007 12:00:00 AM      | e5288050-bc5b-45cc-8849-c7d4af2fe2b6 | V�lo de qualit� pour tous usages, dot� d'un bon niveau de confort et de s�curit�. Pr�sente des pneus plus larges et plus stables pour les sorties en ville ou les randonn�es du week-end.                                                                                     |
		| 1503                 | 6/1/2007 12:00:00 AM      | 28b132c3-108c-412d-9918-a8c9297dfb73 | La selle rembourr�e offre un confort optimal. Le porte-bagages nouvellement remani� offre diverses possibilit�s d'ajout de paniers ou de sacoches. Ce v�lo reste parfaitement stable une fois charg�.                                                                         |
		| 1504                 | 6/1/2007 12:00:00 AM      | e3bac4a6-220c-4e5e-8261-51e08906c0e8 | Voyagez confortablement et avec �l�gance. Confort et s�curit� maximum. Large �ventail de vitesses pour gravir toutes les c�tes. Sa fabrication en alliage d'aluminium haute technologie est synonyme de robustesse, sans ajout de poids.                                      |
		| 1509                 | 6/1/2007 12:00:00 AM      | 5ed8186a-6049-42b1-b1b0-3b1f899c538b | Patins de freinage pour tous les temps�; freinage renforc� par l'application d'une plus grande surface sur la jante.                                                                                                                                                          |
		| 1510                 | 6/1/2007 12:00:00 AM      | 64723c0c-09d5-497d-83a3-4561818a8f1c | Conception liaison large.                                                                                                                                                                                                                                                     |
		| 1517                 | 6/1/2007 12:00:00 AM      | f3cd990a-b70d-43c8-a075-934a3e98b5aa | Dot� du m�me alliage en aluminium que notre cadre HL haut de gamme, le ML poss�de un tube l�ger dont le diam�tre est pr�vu pour offrir une r�sistance optimale. Version femmes.                                                                                               |
		| 1537                 | 6/1/2007 12:00:00 AM      | 6a60e7f6-a5cd-4e7b-8612-9340e46bf66d | P�dales automatiques l�g�res et robustes avec tension r�glable.                                                                                                                                                                                                               |
		| 1571                 | 6/1/2007 12:00:00 AM      | e95e1259-b822-40ee-aa86-7de9f9e0f0ea | Le cadre LL en aluminium offre une conduite confortable, une excellente absorption des bosses pour un tr�s bon rapport qualit�-prix.                                                                                                                                          |
		| 1587                 | 6/1/2007 12:00:00 AM      | e11a3c2a-b074-48f9-8226-16d65c2f91c2 | Cuissards r�sistants � l'usure pour utilisation intensive, doubl�s � l'int�rieur en Spandex, sans couture, peau de chamois anti-bact�rie pour un meilleur confort.                                                                                                            |
		| 1594                 | 6/1/2007 12:00:00 AM      | fb2a5474-9d83-4a9b-bbbd-8ffc9036866e | Maillot manches courtes classique et anti-transpiration avec contr�le de l'humidit�, fermeture avant � glissi�re et 3�poches arri�re.                                                                                                                                         |
		| 1596                 | 6/1/2007 12:00:00 AM      | 31d4905c-d37c-4128-bcff-4a35da9c1bb7 | Fin, l�ger et r�sistant avec des poignets qui restent en place.                                                                                                                                                                                                               |
		| 1598                 | 6/1/2007 12:00:00 AM      | fb627d1b-2933-4fbe-a6a4-bf69f2814ec2 | Style classique avec une visi�re relevable�; taille unique.                                                                                                                                                                                                                   |
		| 1599                 | 6/1/2007 12:00:00 AM      | 4aae6d4f-8320-4f32-99de-bb3b1b13f1ef | Maillot de cycliste en microfibre avec le logo de l'�quipe AWV, manches longues, unisexe.                                                                                                                                                                                     |
		| 1600                 | 6/1/2020 12:00:00 AM      | 4aae6d4f-1111-4f32-99de-bb3b1b13f1ef | Orphan record to deletion test                                                                                                                                                                                                                                                |
		| 1605                 | 6/1/2007 12:00:00 AM      | 9cfed570-180a-44ea-8233-55116a0ddcb9 | Chaque cadre est fabriqu� artisanalement dans notre atelier de Bordeaux afin d'obtenir le diam�tre et l'�paisseur adapt�s � un v�lo tout-terrain de premier choix. Le cadre en aluminium soud� � chaud pr�sente un tube d'un plus grand diam�tre, afin d'absorber les bosses. |


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
		| 8          | 37         | 5        | 2           |
	And the sorted results are
		| ProductDescriptionId | ModifiedDate         | Rowguid                              | Description                                                                                                                                                                      |
		| 661                  | 6/1/2007 12:00:00 AM | d61c9d54-22c3-4563-a418-0b9dc7e03850 | Made from the same aluminum alloy as our top-of-the line HL frame, the ML features a lightweight down-tube milled to the perfect diameter for optimal strength. Women's version. |
		| 848                  | 6/1/2007 12:00:00 AM | 03acbb19-749a-48a1-b77e-5d2a48e8dc3a | Lightweight, durable, clipless pedal with adjustable tension.                                                                                                                    |
		| 1020                 | 6/1/2007 12:00:00 AM | f4c70a6b-bbe8-4774-9d75-393d3f315e9b | The LL Frame provides a safe comfortable ride, while offering superior bump absorption in a value-priced aluminum frame.                                                         |
		| 1196                 | 6/1/2007 12:00:00 AM | c65bee64-4dba-47ec-91cd-31356ba379e1 | Heavy duty, abrasion-resistant shorts feature seamless, lycra inner shorts with anti-bacterial chamois for comfort.                                                              |
		| 1205                 | 6/1/2007 12:00:00 AM | 58d86ede-0519-4263-a264-a2b5b01a6c7b | Short sleeve classic breathable jersey with superior moisture control, front zipper, and 3 back pockets.                                                                         |

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
		| 5          | 37         | 8        | 2           |
	And the sorted results are
		| ProductDescriptionId | ModifiedDate              | Rowguid                              | Description                                                                                                                                                                                           |
		| 1210                 | 6/1/2007 12:00:00 AM      | 66f84b21-1a43-49d3-8883-09cdb77fffef | Traditional style with a flip-up brim; one-size fits all.                                                                                                                                             |
		| 1211                 | 6/1/2007 12:00:00 AM      | 12f60253-f8e1-4f76-8142-6232396b8f17 | Unisex long-sleeve AWC logo microfiber cycling jersey                                                                                                                                                 |
		| 1487                 | 6/1/2007 12:00:00 AM      | 5c1dab3a-4b31-4d9d-a14f-3cb61949b79b | Adapt� � tous les usages, sur route ou tout-terrain. Pour toutes les bourses. Changement de braquet en douceur et conduite confortable.                                                               |
		| 1488                 | 6/1/2007 12:00:00 AM      | 79065ec8-2080-4120-a4ea-bfa7ea1f1f9d | Ce v�lo offre un excellent rapport qualit�-prix. Vif et facile � man�uvrer, il se conduit en toute tranquillit� sur les chemins et les sentiers.                                                      |
		| 1490                 | 3/11/2008 10:32:17.973 AM | 2b6fa2a7-4815-47b6-a6bc-d6aec23b85cc | Conduite sur terrains tr�s accident�s. Id�al pour tous les niveaux de comp�tition. Utilise le m�me cadre HL que le Montain-100.                                                                       |
		| 1493                 | 6/1/2007 12:00:00 AM      | 7943455f-3fbe-44c0-9ac2-7ee642d3944b | V�lo d'adulte d'entr�e de gamme�; permet une conduite confortable en ville ou sur les chemins de campagne. Moyeux et rayons � blocage rapide.                                                         |
		| 1502                 | 6/1/2007 12:00:00 AM      | e5288050-bc5b-45cc-8849-c7d4af2fe2b6 | V�lo de qualit� pour tous usages, dot� d'un bon niveau de confort et de s�curit�. Pr�sente des pneus plus larges et plus stables pour les sorties en ville ou les randonn�es du week-end.             |
		| 1503                 | 6/1/2007 12:00:00 AM      | 28b132c3-108c-412d-9918-a8c9297dfb73 | La selle rembourr�e offre un confort optimal. Le porte-bagages nouvellement remani� offre diverses possibilit�s d'ajout de paniers ou de sacoches. Ce v�lo reste parfaitement stable une fois charg�. |

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
		| 5          | 37         | 8        | 2           |
	And the sorted results are
		| ProductDescriptionId | ModifiedDate              | Rowguid                              | Description                                                                                                                                                                                           |
		| 1210                 | 6/1/2007 12:00:00 AM      | 66f84b21-1a43-49d3-8883-09cdb77fffef | Traditional style with a flip-up brim; one-size fits all.                                                                                                                                             |
		| 1211                 | 6/1/2007 12:00:00 AM      | 12f60253-f8e1-4f76-8142-6232396b8f17 | Unisex long-sleeve AWC logo microfiber cycling jersey                                                                                                                                                 |
		| 1487                 | 6/1/2007 12:00:00 AM      | 5c1dab3a-4b31-4d9d-a14f-3cb61949b79b | Adapt� � tous les usages, sur route ou tout-terrain. Pour toutes les bourses. Changement de braquet en douceur et conduite confortable.                                                               |
		| 1488                 | 6/1/2007 12:00:00 AM      | 79065ec8-2080-4120-a4ea-bfa7ea1f1f9d | Ce v�lo offre un excellent rapport qualit�-prix. Vif et facile � man�uvrer, il se conduit en toute tranquillit� sur les chemins et les sentiers.                                                      |
		| 1490                 | 3/11/2008 10:32:17.973 AM | 2b6fa2a7-4815-47b6-a6bc-d6aec23b85cc | Conduite sur terrains tr�s accident�s. Id�al pour tous les niveaux de comp�tition. Utilise le m�me cadre HL que le Montain-100.                                                                       |
		| 1493                 | 6/1/2007 12:00:00 AM      | 7943455f-3fbe-44c0-9ac2-7ee642d3944b | V�lo d'adulte d'entr�e de gamme�; permet une conduite confortable en ville ou sur les chemins de campagne. Moyeux et rayons � blocage rapide.                                                         |
		| 1502                 | 6/1/2007 12:00:00 AM      | e5288050-bc5b-45cc-8849-c7d4af2fe2b6 | V�lo de qualit� pour tous usages, dot� d'un bon niveau de confort et de s�curit�. Pr�sente des pneus plus larges et plus stables pour les sorties en ville ou les randonn�es du week-end.             |
		| 1503                 | 6/1/2007 12:00:00 AM      | 28b132c3-108c-412d-9918-a8c9297dfb73 | La selle rembourr�e offre un confort optimal. Le porte-bagages nouvellement remani� offre diverses possibilit�s d'ajout de paniers ou de sacoches. Ce v�lo reste parfaitement stable une fois charg�. |

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
		| 8          | 37         | 5        | 7           |
	And the sorted results are
		| ProductDescriptionId | ModifiedDate         | Rowguid                              | Description                                                                                                                                                                                                                                                                   |
		| 1600                 | 6/1/2020 12:00:00 AM | 4aae6d4f-1111-4f32-99de-bb3b1b13f1ef | Orphan record to deletion test                                                                                                                                                                                                                                                |
		| 1605                 | 6/1/2007 12:00:00 AM | 9cfed570-180a-44ea-8233-55116a0ddcb9 | Chaque cadre est fabriqu� artisanalement dans notre atelier de Bordeaux afin d'obtenir le diam�tre et l'�paisseur adapt�s � un v�lo tout-terrain de premier choix. Le cadre en aluminium soud� � chaud pr�sente un tube d'un plus grand diam�tre, afin d'absorber les bosses. |

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
		| 2          | 37         | 25       | 0           |
	And the sorted results are
		| ProductDescriptionId | ModifiedDate              | Rowguid                              | Description                                                                                                                                                                                                                              |
		| 8                    | 6/1/2007 12:00:00 AM      | 8e6746e5-ad97-46e2-bd24-fcea075c3b52 | Suitable for any type of riding, on or off-road. Fits any budget. Smooth-shifting with a comfortable ride.                                                                                                                               |
		| 64                   | 6/1/2007 12:00:00 AM      | 7b1c4e90-85e2-4792-b47b-e0c424e2ec94 | This bike delivers a high-level of performance on a budget. It is responsive and maneuverable, and offers peace-of-mind when you decide to go off-road.                                                                                  |
		| 128                  | 3/11/2008 10:32:17.973 AM | 130709e6-8512-49b9-9f62-1f5c99152056 | Serious back-country riding. Perfect for all levels of competition. Uses the same HL Frame as the Mountain-100.                                                                                                                          |
		| 209                  | 6/1/2007 12:00:00 AM      | f5ff5ffd-cb7c-4ad6-bbc9-4d250bb6e98d | Entry level adult bike; offers a comfortable ride cross-country or down the block. Quick-release hubs and rims.                                                                                                                          |
		| 513                  | 6/1/2007 12:00:00 AM      | 741eae59-5e59-4dbc-9086-2633392c2582 | All-occasion value bike with our basic comfort and safety features. Offers wider, more stable tires for a ride around town or weekend trip.                                                                                              |
		| 554                  | 6/1/2007 12:00:00 AM      | ddc955b2-843e-49ce-8f7b-54870f6135eb | The plush custom saddle keeps you riding all day,  and there's plenty of space to add panniers and bike bags to the newly-redesigned carrier.  This bike has stability when fully-loaded.                                                |
		| 594                  | 6/1/2007 12:00:00 AM      | 32b82c92-e545-4da0-a175-0be710b482fe | Travel in style and comfort. Designed for maximum comfort and safety. Wide gear range takes on all hills. High-tech aluminum alloy construction provides durability without added weight.                                                |
		| 627                  | 6/1/2007 12:00:00 AM      | ebf2f0a4-89f2-4d31-be48-d8fd278f3024 | All-weather brake pads; provides superior stopping by applying more surface to the rim.                                                                                                                                                  |
		| 630                  | 6/1/2007 12:00:00 AM      | 28c4682c-38b2-4b61-a2ae-bcac7c7ce29b | Wide-link design.                                                                                                                                                                                                                        |
		| 647                  | 6/1/2007 12:00:00 AM      | 7ad9e29f-16cf-4db0-b073-cc62d501b61a | Each frame is hand-crafted in our Bothell facility to the optimum diameter and wall-thickness required of a premium mountain frame. The heat-treated welded aluminum frame has a larger diameter tube that absorbs the bumps.            |
		| 661                  | 6/1/2007 12:00:00 AM      | d61c9d54-22c3-4563-a418-0b9dc7e03850 | Made from the same aluminum alloy as our top-of-the line HL frame, the ML features a lightweight down-tube milled to the perfect diameter for optimal strength. Women's version.                                                         |
		| 848                  | 6/1/2007 12:00:00 AM      | 03acbb19-749a-48a1-b77e-5d2a48e8dc3a | Lightweight, durable, clipless pedal with adjustable tension.                                                                                                                                                                            |
		| 1020                 | 6/1/2007 12:00:00 AM      | f4c70a6b-bbe8-4774-9d75-393d3f315e9b | The LL Frame provides a safe comfortable ride, while offering superior bump absorption in a value-priced aluminum frame.                                                                                                                 |
		| 1196                 | 6/1/2007 12:00:00 AM      | c65bee64-4dba-47ec-91cd-31356ba379e1 | Heavy duty, abrasion-resistant shorts feature seamless, lycra inner shorts with anti-bacterial chamois for comfort.                                                                                                                      |
		| 1205                 | 6/1/2007 12:00:00 AM      | 58d86ede-0519-4263-a264-a2b5b01a6c7b | Short sleeve classic breathable jersey with superior moisture control, front zipper, and 3 back pockets.                                                                                                                                 |
		| 1208                 | 6/1/2007 12:00:00 AM      | 9f436663-525d-4cc2-85ba-47d20bcea0ec | Thin, lightweight and durable with cuffs that stay up.                                                                                                                                                                                   |
		| 1210                 | 6/1/2007 12:00:00 AM      | 66f84b21-1a43-49d3-8883-09cdb77fffef | Traditional style with a flip-up brim; one-size fits all.                                                                                                                                                                                |
		| 1211                 | 6/1/2007 12:00:00 AM      | 12f60253-f8e1-4f76-8142-6232396b8f17 | Unisex long-sleeve AWC logo microfiber cycling jersey                                                                                                                                                                                    |
		| 1487                 | 6/1/2007 12:00:00 AM      | 5c1dab3a-4b31-4d9d-a14f-3cb61949b79b | Adapt� � tous les usages, sur route ou tout-terrain. Pour toutes les bourses. Changement de braquet en douceur et conduite confortable.                                                                                                  |
		| 1488                 | 6/1/2007 12:00:00 AM      | 79065ec8-2080-4120-a4ea-bfa7ea1f1f9d | Ce v�lo offre un excellent rapport qualit�-prix. Vif et facile � man�uvrer, il se conduit en toute tranquillit� sur les chemins et les sentiers.                                                                                         |
		| 1490                 | 3/11/2008 10:32:17.973 AM | 2b6fa2a7-4815-47b6-a6bc-d6aec23b85cc | Conduite sur terrains tr�s accident�s. Id�al pour tous les niveaux de comp�tition. Utilise le m�me cadre HL que le Montain-100.                                                                                                          |
		| 1493                 | 6/1/2007 12:00:00 AM      | 7943455f-3fbe-44c0-9ac2-7ee642d3944b | V�lo d'adulte d'entr�e de gamme�; permet une conduite confortable en ville ou sur les chemins de campagne. Moyeux et rayons � blocage rapide.                                                                                            |
		| 1502                 | 6/1/2007 12:00:00 AM      | e5288050-bc5b-45cc-8849-c7d4af2fe2b6 | V�lo de qualit� pour tous usages, dot� d'un bon niveau de confort et de s�curit�. Pr�sente des pneus plus larges et plus stables pour les sorties en ville ou les randonn�es du week-end.                                                |
		| 1503                 | 6/1/2007 12:00:00 AM      | 28b132c3-108c-412d-9918-a8c9297dfb73 | La selle rembourr�e offre un confort optimal. Le porte-bagages nouvellement remani� offre diverses possibilit�s d'ajout de paniers ou de sacoches. Ce v�lo reste parfaitement stable une fois charg�.                                    |
		| 1504                 | 6/1/2007 12:00:00 AM      | e3bac4a6-220c-4e5e-8261-51e08906c0e8 | Voyagez confortablement et avec �l�gance. Confort et s�curit� maximum. Large �ventail de vitesses pour gravir toutes les c�tes. Sa fabrication en alliage d'aluminium haute technologie est synonyme de robustesse, sans ajout de poids. |

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
		| 8          | 37         | 5        | 7           |
	And the sorted results are
		| ProductDescriptionId | ModifiedDate         | Rowguid                              | Description                                                                                                                                                                                                                                                                   |
		| 1600                 | 6/1/2020 12:00:00 AM | 4aae6d4f-1111-4f32-99de-bb3b1b13f1ef | Orphan record to deletion test                                                                                                                                                                                                                                                |
		| 1605                 | 6/1/2007 12:00:00 AM | 9cfed570-180a-44ea-8233-55116a0ddcb9 | Chaque cadre est fabriqu� artisanalement dans notre atelier de Bordeaux afin d'obtenir le diam�tre et l'�paisseur adapt�s � un v�lo tout-terrain de premier choix. Le cadre en aluminium soud� � chaud pr�sente un tube d'un plus grand diam�tre, afin d'absorber les bosses. |
		
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
		| 8          | 37         | 5        | 7           |
	And the sorted results are
		| ProductDescriptionId | ModifiedDate         | Rowguid                              | Description                                                                                                                                                                                                                                                                   |
		| 1600                 | 6/1/2020 12:00:00 AM | 4aae6d4f-1111-4f32-99de-bb3b1b13f1ef | Orphan record to deletion test                                                                                                                                                                                                                                                |
		| 1605                 | 6/1/2007 12:00:00 AM | 9cfed570-180a-44ea-8233-55116a0ddcb9 | Chaque cadre est fabriqu� artisanalement dans notre atelier de Bordeaux afin d'obtenir le diam�tre et l'�paisseur adapt�s � un v�lo tout-terrain de premier choix. Le cadre en aluminium soud� � chaud pr�sente un tube d'un plus grand diam�tre, afin d'absorber les bosses. |

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
		| 2          | 37         | 25       | 1           |
	And the sorted results are
		| ProductDescriptionId | ModifiedDate         | Rowguid                              | Description                                                                                                                                                                                                                                                                   |
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

	
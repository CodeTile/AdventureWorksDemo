Feature: AddressServiceUpdateBatchTests
System tests for the AddressService
Testing the methods UpdateAsync with a list of AddressModel


Background:
	Given The service to test is 'AdventureWorksDemo.Data.Services.IAddressService'
	And I reset the database after the scenario

Scenario: UpdateBatchAsync01
	
	When I populate a list of the model 'AdventureWorksDemo.Data.Models.AddressModel'
		| AddressId | AddressLine1 |
		| 1         | Ping         |
		| 2         | Pong         |
	And I call the method 'UpdateAsync' with the parameter values
		| Key    | Value      | TypeName                                                 |
		| models | {{models}} | IEnumerable<AdventureWorksDemo.Data.Models.AddressModel> |
	Then the result is of type
		| Expected                                                                                                                         |
		| AdventureWorksDemo.Data.Models.ServiceResult<System.Collections.Generic.IEnumerable<AdventureWorksDemo.Data.Models.AddressModel> |
	And the result is
		| IsFailure | IsSuccess | Message |
		| False     | True      |         |
	And the results property 'Value' contains
		| AddressId | ModifiedDate          | Rowguid                              | AddressLine1 | AddressLine2 | City       | PostalCode | StateProvinceId |
		| 1         | 5/24/2024 12:34:56 PM | 2d53a7fc-8017-412d-a591-b10bac54f9b7 | Ping         |              | Paris      | 75009      | 1               |
		| 2         | 5/24/2024 12:34:56 PM | df254102-23c7-4820-ae4a-6a9f0668c8ba | Pong         |              | Ingolstadt | 85049      | 3               |
    
	And the table 'Person.Address' contains
		| AddressId | ModifiedDate           | Rowguid                              | AddressLine1     | AddressLine2 | City          | PostalCode | StateProvinceId |
		| 1         | 5/24/2024 12:34:56 PM  | 2d53a7fc-8017-412d-a591-b10bac54f9b7 | Ping             |              | Paris         | 75009      | 1               |
		| 2         | 5/24/2024 12:34:56 PM  | df254102-23c7-4820-ae4a-6a9f0668c8ba | Pong             |              | Ingolstadt    | 85049      | 3               |
		| 3         | 6/23/2014 12:00:00 AM  | 513bf254-97b8-433b-b467-3079487a2bd4 | 9093 Gilardy Dr. |              | Milton Keynes | MK8 8ZD    | 4               |
		| 4         | 10/19/2012 12:00:00 AM | 70764525-a746-4f90-b7bf-dd71d6de2bc9 | Celler Weg 504   |              | Poing         | 66041      | 3               |
		| 5         | 1/17/2014 12:00:00 AM  | 9a804484-17af-4360-b83b-330cc89634ab | 3985 Dolores Way |              | Perth         | 6006       | 5               |
		| 6         | 12/1/2013 12:00:00 AM  | a9121e78-13ea-476b-bda4-6c6f654e0d55 | Skywalker House  | Hoth         | Sky Town      | WA3        | 2               |
		| 7         | 12/1/2013 12:00:00 AM  | a9121e78-dddd-dddd-bda4-6c6f654ecd55 | Delete Orphan    |              | Wakanda       | WA3        | 7               |

Scenario: UpdateBatchAsyncNoRecords
	Given I don't reset the database after the scenario
	When I populate a list of the model 'AdventureWorksDemo.Data.Models.AddressModel'
		| AddressId | AddressLine1 |
	And I call the method 'UpdateAsync' with the parameter values
		| Key    | Value      | TypeName                                                 |
		| models | {{models}} | IEnumerable<AdventureWorksDemo.Data.Models.AddressModel> |
	Then the result is of type
		| Expected                                                                                                                         |
		| AdventureWorksDemo.Data.Models.ServiceResult<System.Collections.Generic.IEnumerable<AdventureWorksDemo.Data.Models.AddressModel> |
	And the result is
		| IsFailure | IsSuccess | Message                               |
		| True      | False     | Please select some records to update! |
	And the results property 'Value' contains
		| AddressId | ModifiedDate | Rowguid | AddressLine1 | AddressLine2 | City | PostalCode | StateProvinceId |
	And the table 'Person.Address' contains
		| AddressId | ModifiedDate           | Rowguid                              | AddressLine1                     | AddressLine2 | City          | PostalCode | StateProvinceId |
		| 1         | 12/21/2013 10:09:00 AM | 2d53a7fc-8017-412d-a591-b10bac54f9b7 | 568, avenue de l? Union Centrale |              | Paris         | 75009      | 1               |
		| 2         | 8/15/2013 12:00:00 AM  | df254102-23c7-4820-ae4a-6a9f0668c8ba | Charlottenstr 844                |              | Ingolstadt    | 85049      | 3               |
		| 3         | 6/23/2014 12:00:00 AM  | 513bf254-97b8-433b-b467-3079487a2bd4 | 9093 Gilardy Dr.                 |              | Milton Keynes | MK8 8ZD    | 4               |
		| 4         | 10/19/2012 12:00:00 AM | 70764525-a746-4f90-b7bf-dd71d6de2bc9 | Celler Weg 504                   |              | Poing         | 66041      | 3               |
		| 5         | 1/17/2014 12:00:00 AM  | 9a804484-17af-4360-b83b-330cc89634ab | 3985 Dolores Way                 |              | Perth         | 6006       | 5               |
		| 6         | 12/1/2013 12:00:00 AM  | a9121e78-13ea-476b-bda4-6c6f654e0d55 | Skywalker House                  | Hoth         | Sky Town      | WA3        | 2               |
		| 7         | 12/1/2013 12:00:00 AM  | a9121e78-dddd-dddd-bda4-6c6f654ecd55 | Delete Orphan                    |              | Wakanda       | WA3        | 7               |

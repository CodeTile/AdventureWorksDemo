Feature: AddressServiceAddTests

System tests for the AddressService
Testing the methods AddAsync


Background:
	Given The service to test is 'AdventureWorksDemo.Data.Services.IAddressService'
	And I don't reset the database after the scenario

Scenario: AddAsync
	Given I reset the database after the scenario
	When I populate the model 'AdventureWorksDemo.Data.Models.AddressModel'
		| AddressLine1       | AddressLine2 | City    | StateProvinceId | PostalCode | Rowguid                              |
		| Wind in the Willow | Ping Pong    | Fiction | 1               | AB11 1XX   | 00000000-0000-0000-1111-000000000000 |
	And I call the method 'AddAsync' with the parameter values
		| Key   | Value     | TypeName                                    |
		| model | {{model}} | AdventureWorksDemo.Data.Models.AddressModel |
	Then the result is of type
		| Expected                                                                                  |
		| AdventureWorksDemo.Data.Models.ServiceResult<AdventureWorksDemo.Data.Models.AddressModel> |
	And the result is
		| IsFailure | IsSuccess | Message |
		| False     | True      |         |
	And the results property 'Value' contains
		| AddressId | ModifiedDate          | Rowguid                              | AddressLine1       | AddressLine2 | City    | PostalCode | StateProvinceId |
		| 5001      | 5/24/2024 12:34:56 PM | 00000000-0000-0000-1111-000000000000 | Wind in the Willow | Ping Pong    | Fiction | AB11 1XX   | 1               |
	And the table 'Person.Address' contains
		| AddressId | ModifiedDate           | Rowguid                              | AddressLine1                     | AddressLine2 | City          | PostalCode | StateProvinceId |
		| 1         | 12/21/2013 10:09:00 AM | 2d53a7fc-8017-412d-a591-b10bac54f9b7 | 568, avenue de l? Union Centrale |              | Paris         | 75009      | 1               |
		| 2         | 8/15/2013 12:00:00 AM  | df254102-23c7-4820-ae4a-6a9f0668c8ba | Charlottenstr 844                |              | Ingolstadt    | 85049      | 3               |
		| 3         | 6/23/2014 12:00:00 AM  | 513bf254-97b8-433b-b467-3079487a2bd4 | 9093 Gilardy Dr.                 |              | Milton Keynes | MK8 8ZD    | 4               |
		| 4         | 10/19/2012 12:00:00 AM | 70764525-a746-4f90-b7bf-dd71d6de2bc9 | Celler Weg 504                   |              | Poing         | 66041      | 3               |
		| 5         | 1/17/2014 12:00:00 AM  | 9a804484-17af-4360-b83b-330cc89634ab | 3985 Dolores Way                 |              | Perth         | 6006       | 5               |
		| 6         | 12/1/2013 12:00:00 AM  | a9121e78-13ea-476b-bda4-6c6f654e0d55 | Skywalker House                  | Hoth         | Sky Town      | WA3        | 2               |
		| 7         | 12/1/2013 12:00:00 AM  | a9121e78-dddd-dddd-bda4-6c6f654ecd55 | Delete Orphan                    |              | Wakanda       | WA3        | 7               |
		| 5001      | 5/24/2024 12:34:56 PM  | 00000000-0000-0000-1111-000000000000 | Wind in the Willow               | Ping Pong    | Fiction       | AB11 1XX   | 1               |

		
Scenario: AddAsyncLongAddressLine1
	Given I reset the database after the scenario
	When I populate the model 'AdventureWorksDemo.Data.Models.AddressModel'
		| AddressLine1        | AddressLine2 | City    | StateProvinceId | PostalCode | Rowguid                              |
		| {{PadRight:X:1234}} | Ping Pong    | Fiction | 1               | AB11 1XX   | 00000000-0000-0000-1111-000000000000 |
	And I call the method 'AddAsync' with the parameter values
		| Key   | Value     | TypeName                                    |
		| model | {{model}} | AdventureWorksDemo.Data.Models.AddressModel |
	Then the result is of type
		| Expected                                                                                  |
		| AdventureWorksDemo.Data.Models.ServiceResult<AdventureWorksDemo.Data.Models.AddressModel> |
	And the result is
		| IsFailure | IsSuccess | Message                                                                           |
		| True      | False     | 'Address Line1' must be between 3 and 60 characters. You entered 1234 characters. |

	Then the results property 'Value' contains
		| AddressId | ModifiedDate         | Rowguid                              | AddressLine1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | AddressLine2 | City    | PostalCode | StateProvinceId |
		| 0         | 1/1/0001 12:00:00 AM | 00000000-0000-0000-1111-000000000000 | XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX | Ping Pong    | Fiction | AB11 1XX   | 1               |
    
	And the table 'Person.Address' contains
		| AddressId | ModifiedDate           | Rowguid                              | AddressLine1                     | AddressLine2 | City          | PostalCode | StateProvinceId |
		| 1         | 12/21/2013 10:09:00 AM | 2d53a7fc-8017-412d-a591-b10bac54f9b7 | 568, avenue de l? Union Centrale |              | Paris         | 75009      | 1               |
		| 2         | 8/15/2013 12:00:00 AM  | df254102-23c7-4820-ae4a-6a9f0668c8ba | Charlottenstr 844                |              | Ingolstadt    | 85049      | 3               |
		| 3         | 6/23/2014 12:00:00 AM  | 513bf254-97b8-433b-b467-3079487a2bd4 | 9093 Gilardy Dr.                 |              | Milton Keynes | MK8 8ZD    | 4               |
		| 4         | 10/19/2012 12:00:00 AM | 70764525-a746-4f90-b7bf-dd71d6de2bc9 | Celler Weg 504                   |              | Poing         | 66041      | 3               |
		| 5         | 1/17/2014 12:00:00 AM  | 9a804484-17af-4360-b83b-330cc89634ab | 3985 Dolores Way                 |              | Perth         | 6006       | 5               |
		| 6         | 12/1/2013 12:00:00 AM  | a9121e78-13ea-476b-bda4-6c6f654e0d55 | Skywalker House                  | Hoth         | Sky Town      | WA3        | 2               |
		| 7         | 12/1/2013 12:00:00 AM  | a9121e78-dddd-dddd-bda4-6c6f654ecd55 | Delete Orphan                    |              | Wakanda       | WA3        | 7               |

		
Scenario: AddAsyncShortAddressLine1
	Given I reset the database after the scenario
	When I populate the model 'AdventureWorksDemo.Data.Models.AddressModel'
		| AddressLine1     | AddressLine2 | City    | StateProvinceId | PostalCode | Rowguid                              |
		| {{PadRight:X:2}} | Ping Pong    | Fiction | 1               | AB11 1XX   | 00000000-0000-0000-1111-000000000000 |
	And I call the method 'AddAsync' with the parameter values
		| Key   | Value     | TypeName                                    |
		| model | {{model}} | AdventureWorksDemo.Data.Models.AddressModel |
	Then the result is of type
		| Expected                                                                                  |
		| AdventureWorksDemo.Data.Models.ServiceResult<AdventureWorksDemo.Data.Models.AddressModel> |
	And the result is
		| IsFailure | IsSuccess | Message                                                                        |
		| True      | False     | 'Address Line1' must be between 3 and 60 characters. You entered 2 characters. |

	And the results property 'Value' contains
		| AddressId | ModifiedDate         | Rowguid                              | AddressLine1 | AddressLine2 | City    | PostalCode | StateProvinceId |
		| 0         | 1/1/0001 12:00:00 AM | 00000000-0000-0000-1111-000000000000 | XX           | Ping Pong    | Fiction | AB11 1XX   | 1               |
	And the table 'Person.Address' contains
		| AddressId | ModifiedDate           | Rowguid                              | AddressLine1                     | AddressLine2 | City          | PostalCode | StateProvinceId |
		| 1         | 12/21/2013 10:09:00 AM | 2d53a7fc-8017-412d-a591-b10bac54f9b7 | 568, avenue de l? Union Centrale |              | Paris         | 75009      | 1               |
		| 2         | 8/15/2013 12:00:00 AM  | df254102-23c7-4820-ae4a-6a9f0668c8ba | Charlottenstr 844                |              | Ingolstadt    | 85049      | 3               |
		| 3         | 6/23/2014 12:00:00 AM  | 513bf254-97b8-433b-b467-3079487a2bd4 | 9093 Gilardy Dr.                 |              | Milton Keynes | MK8 8ZD    | 4               |
		| 4         | 10/19/2012 12:00:00 AM | 70764525-a746-4f90-b7bf-dd71d6de2bc9 | Celler Weg 504                   |              | Poing         | 66041      | 3               |
		| 5         | 1/17/2014 12:00:00 AM  | 9a804484-17af-4360-b83b-330cc89634ab | 3985 Dolores Way                 |              | Perth         | 6006       | 5               |
		| 6         | 12/1/2013 12:00:00 AM  | a9121e78-13ea-476b-bda4-6c6f654e0d55 | Skywalker House                  | Hoth         | Sky Town      | WA3        | 2               |
		| 7         | 12/1/2013 12:00:00 AM  | a9121e78-dddd-dddd-bda4-6c6f654ecd55 | Delete Orphan                    |              | Wakanda       | WA3        | 7               |


Scenario: AddBatchAsync
	Given I reset the database after the scenario
	When I populate a list of the model 'AdventureWorksDemo.Data.Models.AddressModel'
		| AddressLine1 | AddressLine2 | City    | PostalCode | StateProvinceId | Rowguid                              |
		| How          |              | Fiction | AB11 1XX   | 2               | 00000000-0000-0000-0000-000000000001 |
		| Now          |              | Fiction | AB11 1XX   | 3               | 00000000-0000-0000-0000-000000000002 |
		| Brown        |              | Fiction | AB11 1XX   | 4               | 00000000-0000-0000-0000-000000000003 |
		| Cow          |              | Fiction | AB11 1XX   | 5               | 00000000-0000-0000-0000-000000000004 |
	And I call the method 'AddBatchAsync' with the parameter values
		| Key   | Value             | TypeName                                                                            |
		| model | {{ListOfObjects}} | System.Collections.Generic.IEnumerable<AdventureWorksDemo.Data.Models.AddressModel> |
	Then the result is of type
		| Expected                                                                                                                         |
		| AdventureWorksDemo.Data.Models.ServiceResult<System.Collections.Generic.IEnumerable<AdventureWorksDemo.Data.Models.AddressModel> |
	And the result is
		| IsFailure | IsSuccess | Message |
		| false     | true      |         |
	
	And the results property 'Value' contains
		| AddressId | ModifiedDate          | Rowguid                              | AddressLine1 | AddressLine2 | City    | PostalCode | StateProvinceId |
		| 5001      | 5/24/2024 12:34:56 PM | 00000000-0000-0000-0000-000000000001 | How          |              | Fiction | AB11 1XX   | 2               |
		| 5002      | 5/24/2024 12:34:56 PM | 00000000-0000-0000-0000-000000000002 | Now          |              | Fiction | AB11 1XX   | 3               |
		| 5003      | 5/24/2024 12:34:56 PM | 00000000-0000-0000-0000-000000000003 | Brown        |              | Fiction | AB11 1XX   | 4               |
		| 5004      | 5/24/2024 12:34:56 PM | 00000000-0000-0000-0000-000000000004 | Cow          |              | Fiction | AB11 1XX   | 5               |
	And the table 'Person.Address' contains
		| AddressId | ModifiedDate           | Rowguid                              | AddressLine1                     | AddressLine2 | City          | PostalCode | StateProvinceId |
		| 1         | 12/21/2013 10:09:00 AM | 2d53a7fc-8017-412d-a591-b10bac54f9b7 | 568, avenue de l? Union Centrale |              | Paris         | 75009      | 1               |
		| 2         | 8/15/2013 12:00:00 AM  | df254102-23c7-4820-ae4a-6a9f0668c8ba | Charlottenstr 844                |              | Ingolstadt    | 85049      | 3               |
		| 3         | 6/23/2014 12:00:00 AM  | 513bf254-97b8-433b-b467-3079487a2bd4 | 9093 Gilardy Dr.                 |              | Milton Keynes | MK8 8ZD    | 4               |
		| 4         | 10/19/2012 12:00:00 AM | 70764525-a746-4f90-b7bf-dd71d6de2bc9 | Celler Weg 504                   |              | Poing         | 66041      | 3               |
		| 5         | 1/17/2014 12:00:00 AM  | 9a804484-17af-4360-b83b-330cc89634ab | 3985 Dolores Way                 |              | Perth         | 6006       | 5               |
		| 6         | 12/1/2013 12:00:00 AM  | a9121e78-13ea-476b-bda4-6c6f654e0d55 | Skywalker House                  | Hoth         | Sky Town      | WA3        | 2               |
		| 7         | 12/1/2013 12:00:00 AM  | a9121e78-dddd-dddd-bda4-6c6f654ecd55 | Delete Orphan                    |              | Wakanda       | WA3        | 7               |
		| 5001      | 5/24/2024 12:34:56 PM  | 00000000-0000-0000-0000-000000000001 | How                              |              | Fiction       | AB11 1XX   | 2               |
		| 5002      | 5/24/2024 12:34:56 PM  | 00000000-0000-0000-0000-000000000002 | Now                              |              | Fiction       | AB11 1XX   | 3               |
		| 5003      | 5/24/2024 12:34:56 PM  | 00000000-0000-0000-0000-000000000003 | Brown                            |              | Fiction       | AB11 1XX   | 4               |
		| 5004      | 5/24/2024 12:34:56 PM  | 00000000-0000-0000-0000-000000000004 | Cow                              |              | Fiction       | AB11 1XX   | 5               |


Scenario: AddBatchAsync2ShortAddressLine1
	Given I reset the database after the scenario
	When I populate a list of the model 'AdventureWorksDemo.Data.Models.AddressModel'
		| AddressLine1     | AddressLine2 | City    | PostalCode | StateProvinceId | Rowguid                              |
		| How              |              | Fiction | AB11 1XX   | 1               | 00000000-0000-0000-0000-000000000001 |
		| {{PadRight:X:2}} |              | Fiction | AB11 1XX   | 2               | 00000000-0000-0000-0000-000000000002 |
		| Brown            |              | Fiction | AB11 1XX   | 3               | 00000000-0000-0000-0000-000000000003 |
		| {{PadRight:X:1}} |              | Fiction | AB11 1XX   | 4               | 00000000-0000-0000-0000-000000000004 |
	And I call the method 'AddBatchAsync' with the parameter values
		| Key   | Value             | TypeName                                                                            |
		| model | {{ListOfObjects}} | System.Collections.Generic.IEnumerable<AdventureWorksDemo.Data.Models.AddressModel> |
	Then the result is of type
		| Expected                                                                                                                         |
		| AdventureWorksDemo.Data.Models.ServiceResult<System.Collections.Generic.IEnumerable<AdventureWorksDemo.Data.Models.AddressModel> |
	And the result is
		| IsFailure | IsSuccess |
		| True      | False     |
	And the results property 'Message' contains
		| Expected                                                                       |
		| 'Address Line1' must be between 3 and 60 characters. You entered 2 characters. |
		| 'Address Line1' must be between 3 and 60 characters. You entered 1 characters. |

	And the results property 'Value' contains
		| AddressId | ModifiedDate         | Rowguid                              | AddressLine1 | AddressLine2 | City    | PostalCode | StateProvinceId |
		| 0         | 1/1/0001 12:00:00 AM | 00000000-0000-0000-0000-000000000001 | How          |              | Fiction | AB11 1XX   | 1               |
		| 0         | 1/1/0001 12:00:00 AM | 00000000-0000-0000-0000-000000000002 | XX           |              | Fiction | AB11 1XX   | 2               |
		| 0         | 1/1/0001 12:00:00 AM | 00000000-0000-0000-0000-000000000003 | Brown        |              | Fiction | AB11 1XX   | 3               |
		| 0         | 1/1/0001 12:00:00 AM | 00000000-0000-0000-0000-000000000004 | X            |              | Fiction | AB11 1XX   | 4               |
    
	And the table 'Person.Address' contains
		| AddressId | ModifiedDate           | Rowguid                              | AddressLine1                     | AddressLine2 | City          | PostalCode | StateProvinceId |
		| 1         | 12/21/2013 10:09:00 AM | 2d53a7fc-8017-412d-a591-b10bac54f9b7 | 568, avenue de l? Union Centrale |              | Paris         | 75009      | 1               |
		| 2         | 8/15/2013 12:00:00 AM  | df254102-23c7-4820-ae4a-6a9f0668c8ba | Charlottenstr 844                |              | Ingolstadt    | 85049      | 3               |
		| 3         | 6/23/2014 12:00:00 AM  | 513bf254-97b8-433b-b467-3079487a2bd4 | 9093 Gilardy Dr.                 |              | Milton Keynes | MK8 8ZD    | 4               |
		| 4         | 10/19/2012 12:00:00 AM | 70764525-a746-4f90-b7bf-dd71d6de2bc9 | Celler Weg 504                   |              | Poing         | 66041      | 3               |
		| 5         | 1/17/2014 12:00:00 AM  | 9a804484-17af-4360-b83b-330cc89634ab | 3985 Dolores Way                 |              | Perth         | 6006       | 5               |
		| 6         | 12/1/2013 12:00:00 AM  | a9121e78-13ea-476b-bda4-6c6f654e0d55 | Skywalker House                  | Hoth         | Sky Town      | WA3        | 2               |
		| 7         | 12/1/2013 12:00:00 AM  | a9121e78-dddd-dddd-bda4-6c6f654ecd55 | Delete Orphan                    |              | Wakanda       | WA3        | 7               |

Scenario: AddBatchAsync2LongAddressLine2
	Given I reset the database after the scenario
	When I populate a list of the model 'AdventureWorksDemo.Data.Models.AddressModel'
		| AddressLine1       | AddressLine2       | City    | PostalCode | StateProvinceId | Rowguid                              |
		| How                |                    | Fiction | AB11 1XX   | 1               | 00000000-0000-0000-0000-000000000001 |
		| {{PadRight:X:61}}  | {{PadRight:X:62}}  | Fiction | AB11 1XX   | 2               | 00000000-0000-0000-0000-000000000002 |
		| Brown              |                    | Fiction | AB11 1XX   | 3               | 00000000-0000-0000-0000-000000000003 |
		| {{PadRight:X:234}} | {{PadRight:X:123}} | Fiction | AB11 1XX   | 4               | 00000000-0000-0000-0000-000000000004 |
	And I call the method 'AddBatchAsync' with the parameter values
		| Key   | Value             | TypeName                                                                            |
		| model | {{ListOfObjects}} | System.Collections.Generic.IEnumerable<AdventureWorksDemo.Data.Models.AddressModel> |
	Then the result is of type
		| Expected                                                                                                                         |
		| AdventureWorksDemo.Data.Models.ServiceResult<System.Collections.Generic.IEnumerable<AdventureWorksDemo.Data.Models.AddressModel> |
	And the result is
		| IsFailure | IsSuccess |
		| True      | False     |
	And the results property 'Message' contains
		| Expected                                                                         |
		| 'Address Line2' must be between 3 and 60 characters. You entered 62 characters.  |
		| 'Address Line2' must be between 3 and 60 characters. You entered 123 characters. |
		| 'Address Line1' must be between 3 and 60 characters. You entered 61 characters.  |
		| 'Address Line1' must be between 3 and 60 characters. You entered 234 characters. |
	And the results property 'Value' contains
		| AddressId | ModifiedDate         | Rowguid                              | AddressLine1       | AddressLine2       | City    | PostalCode | StateProvinceId |
		| 0         | 1/1/0001 12:00:00 AM | 00000000-0000-0000-0000-000000000001 | How                |                    | Fiction | AB11 1XX   | 1               |
		| 0         | 1/1/0001 12:00:00 AM | 00000000-0000-0000-0000-000000000002 | {{PadRight:X:61}}  | {{PadRight:X:62}}  | Fiction | AB11 1XX   | 2               |
		| 0         | 1/1/0001 12:00:00 AM | 00000000-0000-0000-0000-000000000003 | Brown              |                    | Fiction | AB11 1XX   | 3               |
		| 0         | 1/1/0001 12:00:00 AM | 00000000-0000-0000-0000-000000000004 | {{PadRight:X:234}} | {{PadRight:X:123}} | Fiction | AB11 1XX   | 4               |
	And the table 'Person.Address' contains
		| AddressId | ModifiedDate           | Rowguid                              | AddressLine1                     | AddressLine2 | City          | PostalCode | StateProvinceId |
		| 1         | 12/21/2013 10:09:00 AM | 2d53a7fc-8017-412d-a591-b10bac54f9b7 | 568, avenue de l? Union Centrale |              | Paris         | 75009      | 1               |
		| 2         | 8/15/2013 12:00:00 AM  | df254102-23c7-4820-ae4a-6a9f0668c8ba | Charlottenstr 844                |              | Ingolstadt    | 85049      | 3               |
		| 3         | 6/23/2014 12:00:00 AM  | 513bf254-97b8-433b-b467-3079487a2bd4 | 9093 Gilardy Dr.                 |              | Milton Keynes | MK8 8ZD    | 4               |
		| 4         | 10/19/2012 12:00:00 AM | 70764525-a746-4f90-b7bf-dd71d6de2bc9 | Celler Weg 504                   |              | Poing         | 66041      | 3               |
		| 5         | 1/17/2014 12:00:00 AM  | 9a804484-17af-4360-b83b-330cc89634ab | 3985 Dolores Way                 |              | Perth         | 6006       | 5               |
		| 6         | 12/1/2013 12:00:00 AM  | a9121e78-13ea-476b-bda4-6c6f654e0d55 | Skywalker House                  | Hoth         | Sky Town      | WA3        | 2               |
		| 7         | 12/1/2013 12:00:00 AM  | a9121e78-dddd-dddd-bda4-6c6f654ecd55 | Delete Orphan                    |              | Wakanda       | WA3        | 7               |


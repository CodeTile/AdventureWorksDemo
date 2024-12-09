Feature: AddressServiceAddTests

System tests for the AddressService
Testing the methods AddAsync


Background:
	Given The service to test is 'AdventureWorksDemo.Data.Services.IAddressService'
	And I don't reset the database after the scenario



Scenario: AddAsync
	Given I reset the database after the scenario
	When I populate the model 'AdventureWorksDemo.Data.Models.AddressModel'
		| AddressLine1       | AddressLine2 | City    | CountryRegion  | PostalCode | StateProvince | Rowguid                              |
		| Wind in the Willow |              | Fiction | United Kingdom | AB11 1XX   | England       | 00000000-0000-0000-0000-000000000001 |
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
		| AddressId | ModifiedDate          | Rowguid                              | AddressLine1       | AddressLine2 | City    | CountryRegion  | PostalCode | StateProvince |
		| 5001      | 5/24/2024 12:34:56 PM | 00000000-0000-0000-0000-000000000001 | Wind in the Willow |              | Fiction | United Kingdom | AB11 1XX   | England       |
	And the table 'SalesLT.Address' contains
		| AddressId | ModifiedDate          | Rowguid                              | AddressLine1                      | AddressLine2 | City          | CountryRegion  | PostalCode | StateProvince |
		| 640       | 9/1/2007 12:00:00 AM  | 0e4ac5bb-be0d-4a96-a58e-064daec08e1a | 251 The Metro Center              |              | Wokingham     | United Kingdom | RG41 1QW   | England       |
		| 652       | 9/1/2006 12:00:00 AM  | 54e20963-b0e9-41cf-ab7e-d50459a3325c | Wymbush                           |              | Milton Keynes | United Kingdom | MK8 8DF    | England       |
		| 669       | 12/1/2006 12:00:00 AM | 56baec2a-5cc5-4a90-bef9-ee57e82f2e69 | Internet House, 3399 Science Park |              | Cambridge     | United Kingdom | CB4 4BZ    | England       |
		| 1034      | 9/1/2007 12:00:00 AM  | 300d2a6e-67b4-417b-83a9-2026818a21c6 | Oxnard Outlet                     |              | Oxnard        | United States  | 93030      | California    |
		| 1038      | 9/1/2007 12:00:00 AM  | a86c8140-ad7d-4caa-9b40-4006bd9998e2 | 123 Camelia Avenue                |              | Oxnard        | United States  | 93030      | California    |
		| 1090      | 9/1/2007 12:00:00 AM  | cf3ae92a-3e66-4af0-b683-731826e89cd1 | 25130 South State Street          |              | Sandy         | United States  | 84070      | Utah          |
		| 1092      | 9/1/2006 12:00:00 AM  | 79cdd89c-3c91-48db-8277-46d04aad7251 | 99700 Bell Road                   |              | Auburn        | United States  | 95603      | California    |
		| 5001      | 5/24/2024 12:34:56 PM | 00000000-0000-0000-0000-000000000001 | Wind in the Willow                |              | Fiction       | United Kingdom | AB11 1XX   | England       |

		
		
Scenario: AddAsyncShortAddressLine1
	Given I reset the database after the scenario
	When I populate the model 'AdventureWorksDemo.Data.Models.AddressModel'
		| AddressLine1     | AddressLine2 | City    | CountryRegion  | PostalCode | StateProvince |
		| {{PadRight:X:2}} |              | Fiction | United Kingdom | AB11 1XX   | England       |
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
		| AddressId | ModifiedDate         | Rowguid                              | AddressLine1 | AddressLine2 | City    | CountryRegion  | PostalCode | StateProvince |
		| 0         | 1/1/0001 12:00:00 AM | 00000000-0000-0000-0000-000000000000 | XX           |              | Fiction | United Kingdom | AB11 1XX   | England       |
	And the table 'SalesLT.Address' contains
		| AddressId | ModifiedDate          | Rowguid                              | AddressLine1                      | AddressLine2 | City          | CountryRegion  | PostalCode | StateProvince |
		| 640       | 9/1/2007 12:00:00 AM  | 0e4ac5bb-be0d-4a96-a58e-064daec08e1a | 251 The Metro Center              |              | Wokingham     | United Kingdom | RG41 1QW   | England       |
		| 652       | 9/1/2006 12:00:00 AM  | 54e20963-b0e9-41cf-ab7e-d50459a3325c | Wymbush                           |              | Milton Keynes | United Kingdom | MK8 8DF    | England       |
		| 669       | 12/1/2006 12:00:00 AM | 56baec2a-5cc5-4a90-bef9-ee57e82f2e69 | Internet House, 3399 Science Park |              | Cambridge     | United Kingdom | CB4 4BZ    | England       |
		| 1034      | 9/1/2007 12:00:00 AM  | 300d2a6e-67b4-417b-83a9-2026818a21c6 | Oxnard Outlet                     |              | Oxnard        | United States  | 93030      | California    |
		| 1038      | 9/1/2007 12:00:00 AM  | a86c8140-ad7d-4caa-9b40-4006bd9998e2 | 123 Camelia Avenue                |              | Oxnard        | United States  | 93030      | California    |
		| 1090      | 9/1/2007 12:00:00 AM  | cf3ae92a-3e66-4af0-b683-731826e89cd1 | 25130 South State Street          |              | Sandy         | United States  | 84070      | Utah          |
		| 1092      | 9/1/2006 12:00:00 AM  | 79cdd89c-3c91-48db-8277-46d04aad7251 | 99700 Bell Road                   |              | Auburn        | United States  | 95603      | California    |
	
		
Scenario: AddAsyncLongAddressLine1
	Given I reset the database after the scenario
	When I populate the model 'AdventureWorksDemo.Data.Models.AddressModel'
		| AddressLine1        | AddressLine2 | City    | CountryRegion  | PostalCode | StateProvince |
		| {{PadRight:X:1234}} |              | Fiction | United Kingdom | AB11 1XX   | England       |
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
		| AddressId | ModifiedDate         | Rowguid                              | AddressLine1        | AddressLine2 | City    | CountryRegion  | PostalCode | StateProvince |
		| 0         | 1/1/0001 12:00:00 AM | 00000000-0000-0000-0000-000000000000 | {{PadRight:X:1234}} |              | Fiction | United Kingdom | AB11 1XX   | England       |

	And the table 'SalesLT.Address' contains
		| AddressId | ModifiedDate          | Rowguid                              | AddressLine1                      | AddressLine2 | City          | CountryRegion  | PostalCode | StateProvince |
		| 640       | 9/1/2007 12:00:00 AM  | 0e4ac5bb-be0d-4a96-a58e-064daec08e1a | 251 The Metro Center              |              | Wokingham     | United Kingdom | RG41 1QW   | England       |
		| 652       | 9/1/2006 12:00:00 AM  | 54e20963-b0e9-41cf-ab7e-d50459a3325c | Wymbush                           |              | Milton Keynes | United Kingdom | MK8 8DF    | England       |
		| 669       | 12/1/2006 12:00:00 AM | 56baec2a-5cc5-4a90-bef9-ee57e82f2e69 | Internet House, 3399 Science Park |              | Cambridge     | United Kingdom | CB4 4BZ    | England       |
		| 1034      | 9/1/2007 12:00:00 AM  | 300d2a6e-67b4-417b-83a9-2026818a21c6 | Oxnard Outlet                     |              | Oxnard        | United States  | 93030      | California    |
		| 1038      | 9/1/2007 12:00:00 AM  | a86c8140-ad7d-4caa-9b40-4006bd9998e2 | 123 Camelia Avenue                |              | Oxnard        | United States  | 93030      | California    |
		| 1090      | 9/1/2007 12:00:00 AM  | cf3ae92a-3e66-4af0-b683-731826e89cd1 | 25130 South State Street          |              | Sandy         | United States  | 84070      | Utah          |
		| 1092      | 9/1/2006 12:00:00 AM  | 79cdd89c-3c91-48db-8277-46d04aad7251 | 99700 Bell Road                   |              | Auburn        | United States  | 95603      | California    |


Scenario: AddBatchAsync
	Given I reset the database after the scenario
	When I populate a list of the model 'AdventureWorksDemo.Data.Models.AddressModel'
		| AddressLine1 | AddressLine2 | City    | CountryRegion  | PostalCode | StateProvince | Rowguid                              |
		| How          |              | Fiction | United Kingdom | AB11 1XX   | England       | 00000000-0000-0000-0000-000000000001 |
		| Now          |              | Fiction | United Kingdom | AB11 1XX   | England       | 00000000-0000-0000-0000-000000000002 |
		| Brown        |              | Fiction | United Kingdom | AB11 1XX   | England       | 00000000-0000-0000-0000-000000000003 |
		| Cow          |              | Fiction | United Kingdom | AB11 1XX   | England       | 00000000-0000-0000-0000-000000000004 |
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
		| AddressId | ModifiedDate          | Rowguid                              | AddressLine1 | AddressLine2 | City    | CountryRegion  | PostalCode | StateProvince |
		| 5001      | 5/24/2024 12:34:56 PM | 00000000-0000-0000-0000-000000000001 | How          |              | Fiction | United Kingdom | AB11 1XX   | England       |
		| 5002      | 5/24/2024 12:34:56 PM | 00000000-0000-0000-0000-000000000002 | Now          |              | Fiction | United Kingdom | AB11 1XX   | England       |
		| 5003      | 5/24/2024 12:34:56 PM | 00000000-0000-0000-0000-000000000003 | Brown        |              | Fiction | United Kingdom | AB11 1XX   | England       |
		| 5004      | 5/24/2024 12:34:56 PM | 00000000-0000-0000-0000-000000000004 | Cow          |              | Fiction | United Kingdom | AB11 1XX   | England       |


	And the table 'SalesLT.Address' contains
		| AddressId | ModifiedDate          | Rowguid                              | AddressLine1                      | AddressLine2 | City          | CountryRegion  | PostalCode | StateProvince |
		| 640       | 9/1/2007 12:00:00 AM  | 0e4ac5bb-be0d-4a96-a58e-064daec08e1a | 251 The Metro Center              |              | Wokingham     | United Kingdom | RG41 1QW   | England       |
		| 652       | 9/1/2006 12:00:00 AM  | 54e20963-b0e9-41cf-ab7e-d50459a3325c | Wymbush                           |              | Milton Keynes | United Kingdom | MK8 8DF    | England       |
		| 669       | 12/1/2006 12:00:00 AM | 56baec2a-5cc5-4a90-bef9-ee57e82f2e69 | Internet House, 3399 Science Park |              | Cambridge     | United Kingdom | CB4 4BZ    | England       |
		| 1034      | 9/1/2007 12:00:00 AM  | 300d2a6e-67b4-417b-83a9-2026818a21c6 | Oxnard Outlet                     |              | Oxnard        | United States  | 93030      | California    |
		| 1038      | 9/1/2007 12:00:00 AM  | a86c8140-ad7d-4caa-9b40-4006bd9998e2 | 123 Camelia Avenue                |              | Oxnard        | United States  | 93030      | California    |
		| 1090      | 9/1/2007 12:00:00 AM  | cf3ae92a-3e66-4af0-b683-731826e89cd1 | 25130 South State Street          |              | Sandy         | United States  | 84070      | Utah          |
		| 1092      | 9/1/2006 12:00:00 AM  | 79cdd89c-3c91-48db-8277-46d04aad7251 | 99700 Bell Road                   |              | Auburn        | United States  | 95603      | California    |
		| 5001      | 5/24/2024 12:34:56 PM | 00000000-0000-0000-0000-000000000001 | How                               |              | Fiction       | United Kingdom | AB11 1XX   | England       |
		| 5002      | 5/24/2024 12:34:56 PM | 00000000-0000-0000-0000-000000000002 | Now                               |              | Fiction       | United Kingdom | AB11 1XX   | England       |
		| 5003      | 5/24/2024 12:34:56 PM | 00000000-0000-0000-0000-000000000003 | Brown                             |              | Fiction       | United Kingdom | AB11 1XX   | England       |
		| 5004      | 5/24/2024 12:34:56 PM | 00000000-0000-0000-0000-000000000004 | Cow                               |              | Fiction       | United Kingdom | AB11 1XX   | England       |


Scenario: AddBatchAsync2ShortAddressLine1
	Given I reset the database after the scenario
	When I populate a list of the model 'AdventureWorksDemo.Data.Models.AddressModel'
		| AddressLine1     | AddressLine2 | City    | CountryRegion  | PostalCode | StateProvince | Rowguid                              |
		| How              |              | Fiction | United Kingdom | AB11 1XX   | England       | 00000000-0000-0000-0000-000000000001 |
		| {{PadRight:X:2}} |              | Fiction | United Kingdom | AB11 1XX   | England       | 00000000-0000-0000-0000-000000000002 |
		| Brown            |              | Fiction | United Kingdom | AB11 1XX   | England       | 00000000-0000-0000-0000-000000000003 |
		| {{PadRight:X:1}} |              | Fiction | United Kingdom | AB11 1XX   | England       | 00000000-0000-0000-0000-000000000004 |
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
		| AddressId | ModifiedDate         | Rowguid                              | AddressLine1 | AddressLine2 | City    | CountryRegion  | PostalCode | StateProvince |
		| 0         | 1/1/0001 12:00:00 AM | 00000000-0000-0000-0000-000000000001 | How          |              | Fiction | United Kingdom | AB11 1XX   | England       |
		| 0         | 1/1/0001 12:00:00 AM | 00000000-0000-0000-0000-000000000002 | XX           |              | Fiction | United Kingdom | AB11 1XX   | England       |
		| 0         | 1/1/0001 12:00:00 AM | 00000000-0000-0000-0000-000000000003 | Brown        |              | Fiction | United Kingdom | AB11 1XX   | England       |
		| 0         | 1/1/0001 12:00:00 AM | 00000000-0000-0000-0000-000000000004 | X            |              | Fiction | United Kingdom | AB11 1XX   | England       |

	And the table 'SalesLT.Address' contains
		| AddressId | ModifiedDate          | Rowguid                              | AddressLine1                      | AddressLine2 | City          | CountryRegion  | PostalCode | StateProvince |
		| 640       | 9/1/2007 12:00:00 AM  | 0e4ac5bb-be0d-4a96-a58e-064daec08e1a | 251 The Metro Center              |              | Wokingham     | United Kingdom | RG41 1QW   | England       |
		| 652       | 9/1/2006 12:00:00 AM  | 54e20963-b0e9-41cf-ab7e-d50459a3325c | Wymbush                           |              | Milton Keynes | United Kingdom | MK8 8DF    | England       |
		| 669       | 12/1/2006 12:00:00 AM | 56baec2a-5cc5-4a90-bef9-ee57e82f2e69 | Internet House, 3399 Science Park |              | Cambridge     | United Kingdom | CB4 4BZ    | England       |
		| 1034      | 9/1/2007 12:00:00 AM  | 300d2a6e-67b4-417b-83a9-2026818a21c6 | Oxnard Outlet                     |              | Oxnard        | United States  | 93030      | California    |
		| 1038      | 9/1/2007 12:00:00 AM  | a86c8140-ad7d-4caa-9b40-4006bd9998e2 | 123 Camelia Avenue                |              | Oxnard        | United States  | 93030      | California    |
		| 1090      | 9/1/2007 12:00:00 AM  | cf3ae92a-3e66-4af0-b683-731826e89cd1 | 25130 South State Street          |              | Sandy         | United States  | 84070      | Utah          |
		| 1092      | 9/1/2006 12:00:00 AM  | 79cdd89c-3c91-48db-8277-46d04aad7251 | 99700 Bell Road                   |              | Auburn        | United States  | 95603      | California    |

Scenario: AddBatchAsync2LongAddressLine1
	Given I reset the database after the scenario
	When I populate a list of the model 'AdventureWorksDemo.Data.Models.AddressModel'
		| AddressLine1         | AddressLine2 | City    | CountryRegion  | PostalCode | StateProvince | Rowguid                              |
		| How                  |              | Fiction | United Kingdom | AB11 1XX   | England       | 00000000-0000-0000-0000-000000000001 |
		| {{PadRight:X:12345}} |              | Fiction | United Kingdom | AB11 1XX   | England       | 00000000-0000-0000-0000-000000000002 |
		| Brown                |              | Fiction | United Kingdom | AB11 1XX   | England       | 00000000-0000-0000-0000-000000000003 |
		| {{PadRight:X:1234}}  |              | Fiction | United Kingdom | AB11 1XX   | England       | 00000000-0000-0000-0000-000000000004 |
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
		| Expected                                                                           |
		| 'Address Line1' must be between 3 and 60 characters. You entered 12345 characters. |
		| 'Address Line1' must be between 3 and 60 characters. You entered 1234 characters.  |
	And the results property 'Value' contains
		| AddressId | ModifiedDate         | Rowguid                              | AddressLine1         | AddressLine2 | City    | CountryRegion  | PostalCode | StateProvince |
		| 0         | 1/1/0001 12:00:00 AM | 00000000-0000-0000-0000-000000000001 | How                  |              | Fiction | United Kingdom | AB11 1XX   | England       |
		| 0         | 1/1/0001 12:00:00 AM | 00000000-0000-0000-0000-000000000002 | {{PadRight:X:12345}} |              | Fiction | United Kingdom | AB11 1XX   | England       |
		| 0         | 1/1/0001 12:00:00 AM | 00000000-0000-0000-0000-000000000003 | Brown                |              | Fiction | United Kingdom | AB11 1XX   | England       |
		| 0         | 1/1/0001 12:00:00 AM | 00000000-0000-0000-0000-000000000004 | {{PadRight:X:1234}}  |              | Fiction | United Kingdom | AB11 1XX   | England       |
	And the table 'SalesLT.Address' contains
		| AddressId | ModifiedDate          | Rowguid                              | AddressLine1                      | AddressLine2 | City          | CountryRegion  | PostalCode | StateProvince |
		| 640       | 9/1/2007 12:00:00 AM  | 0e4ac5bb-be0d-4a96-a58e-064daec08e1a | 251 The Metro Center              |              | Wokingham     | United Kingdom | RG41 1QW   | England       |
		| 652       | 9/1/2006 12:00:00 AM  | 54e20963-b0e9-41cf-ab7e-d50459a3325c | Wymbush                           |              | Milton Keynes | United Kingdom | MK8 8DF    | England       |
		| 669       | 12/1/2006 12:00:00 AM | 56baec2a-5cc5-4a90-bef9-ee57e82f2e69 | Internet House, 3399 Science Park |              | Cambridge     | United Kingdom | CB4 4BZ    | England       |
		| 1034      | 9/1/2007 12:00:00 AM  | 300d2a6e-67b4-417b-83a9-2026818a21c6 | Oxnard Outlet                     |              | Oxnard        | United States  | 93030      | California    |
		| 1038      | 9/1/2007 12:00:00 AM  | a86c8140-ad7d-4caa-9b40-4006bd9998e2 | 123 Camelia Avenue                |              | Oxnard        | United States  | 93030      | California    |
		| 1090      | 9/1/2007 12:00:00 AM  | cf3ae92a-3e66-4af0-b683-731826e89cd1 | 25130 South State Street          |              | Sandy         | United States  | 84070      | Utah          |
		| 1092      | 9/1/2006 12:00:00 AM  | 79cdd89c-3c91-48db-8277-46d04aad7251 | 99700 Bell Road                   |              | Auburn        | United States  | 95603      | California    |


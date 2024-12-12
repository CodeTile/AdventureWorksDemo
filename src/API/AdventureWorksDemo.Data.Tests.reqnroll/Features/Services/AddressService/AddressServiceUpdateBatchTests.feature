Feature: AddressServiceUpdateBatchTests
System tests for the AddressService
Testing the methods UpdateAsync with a list of AddressModel


Background:
	Given The service to test is 'AdventureWorksDemo.Data.Services.IAddressService'
	And I reset the database after the scenario

Scenario: UpdateBatchAsync01
	
	When I populate a list of the model 'AdventureWorksDemo.Data.Models.AddressModel'
		| AddressId | AddressLine1 |
		| 640       | Ping         |
		| 1092      | Pong         |
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
		| AddressId | ModifiedDate          | Rowguid                              | AddressLine1 | AddressLine2 | City      | CountryRegion  | PostalCode | StateProvince |
		| 640       | 5/24/2024 12:34:56 PM | 0e4ac5bb-be0d-4a96-a58e-064daec08e1a | Ping         |              | Wokingham | United Kingdom | RG41 1QW   | England       |
		| 1092      | 5/24/2024 12:34:56 PM | 79cdd89c-3c91-48db-8277-46d04aad7251 | Pong         |              | Auburn    | United States  | 95603      | California    |
	And the table 'SalesLT.Address' contains
		| AddressId | ModifiedDate          | Rowguid                              | AddressLine1                      | AddressLine2 | City                | CountryRegion  | PostalCode | StateProvince |
		| 640       | 5/24/2024 12:34:56 PM | 0e4ac5bb-be0d-4a96-a58e-064daec08e1a | Ping                              |              | Wokingham           | United Kingdom | RG41 1QW   | England       |
		| 652       | 9/1/2006 12:00:00 AM  | 54e20963-b0e9-41cf-ab7e-d50459a3325c | Wymbush                           |              | Milton Keynes       | United Kingdom | MK8 8DF    | England       |
		| 669       | 12/1/2006 12:00:00 AM | 56baec2a-5cc5-4a90-bef9-ee57e82f2e69 | Internet House, 3399 Science Park |              | Cambridge           | United Kingdom | CB4 4BZ    | England       |
		| 1034      | 9/1/2007 12:00:00 AM  | 300d2a6e-67b4-417b-83a9-2026818a21c6 | Oxnard Outlet                     |              | Oxnard              | United States  | 93030      | California    |
		| 1038      | 9/1/2007 12:00:00 AM  | a86c8140-ad7d-4caa-9b40-4006bd9998e2 | 123 Camelia Avenue                |              | Oxnard              | United States  | 93030      | California    |
		| 1090      | 9/1/2007 12:00:00 AM  | cf3ae92a-3e66-4af0-b683-731826e89cd1 | 25130 South State Street          |              | Sandy               | United States  | 84070      | Utah          |
		| 1092      | 5/24/2024 12:34:56 PM | 79cdd89c-3c91-48db-8277-46d04aad7251 | Pong                              |              | Auburn              | United States  | 95603      | California    |
		| 1111      | 9/1/2006 12:00:00 AM  | 00000000-1111-2222-0000-000000000001 | Orphan Record                     |              | Use In Delete Tests | United States  | 95603      | California    |

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
		| AddressId | ModifiedDate | Rowguid | AddressLine1 | AddressLine2 | City | CountryRegion | PostalCode | StateProvince |
	And the table 'SalesLT.Address' contains
		| AddressId | ModifiedDate          | Rowguid                              | AddressLine1                      | AddressLine2 | City                | CountryRegion  | PostalCode | StateProvince |
		| 640       | 9/1/2007 12:00:00 AM  | 0e4ac5bb-be0d-4a96-a58e-064daec08e1a | 251 The Metro Center              |              | Wokingham           | United Kingdom | RG41 1QW   | England       |
		| 652       | 9/1/2006 12:00:00 AM  | 54e20963-b0e9-41cf-ab7e-d50459a3325c | Wymbush                           |              | Milton Keynes       | United Kingdom | MK8 8DF    | England       |
		| 669       | 12/1/2006 12:00:00 AM | 56baec2a-5cc5-4a90-bef9-ee57e82f2e69 | Internet House, 3399 Science Park |              | Cambridge           | United Kingdom | CB4 4BZ    | England       |
		| 1034      | 9/1/2007 12:00:00 AM  | 300d2a6e-67b4-417b-83a9-2026818a21c6 | Oxnard Outlet                     |              | Oxnard              | United States  | 93030      | California    |
		| 1038      | 9/1/2007 12:00:00 AM  | a86c8140-ad7d-4caa-9b40-4006bd9998e2 | 123 Camelia Avenue                |              | Oxnard              | United States  | 93030      | California    |
		| 1090      | 9/1/2007 12:00:00 AM  | cf3ae92a-3e66-4af0-b683-731826e89cd1 | 25130 South State Street          |              | Sandy               | United States  | 84070      | Utah          |
		| 1092      | 9/1/2006 12:00:00 AM  | 79cdd89c-3c91-48db-8277-46d04aad7251 | 99700 Bell Road                   |              | Auburn              | United States  | 95603      | California    |
		| 1111      | 9/1/2006 12:00:00 AM  | 00000000-1111-2222-0000-000000000001 | Orphan Record                     |              | Use In Delete Tests | United States  | 95603      | California    |

Feature: AddressServiceFindTests

System tests for the AddressService
Testing the methods FindAsync and FindAllAsync


Background:
	Given The service to test is 'AdventureWorksDemo.Data.Services.IAddressService'
	And I don't reset the database after the scenario
		
Scenario: FindAllAsync_1_5
	When I populate the model 'AdventureWorksDemo.Data.Paging.PagingFilter'
		| PageNumber | PageSize |
		| 1          | 5        |
	And I call the method 'FindAllAsync' with the parameter values
		| Key           | Value     | TypeName                                    |
		| pageingFilter | {{model}} | AdventureWorksDemo.Data.Paging.PagingFilter |
	Then the result is of type
		| Expected                                                                              |
		| AdventureWorksDemo.Data.Paging.PagedList<AdventureWorksDemo.Data.Models.AddressModel> |
	And the PagedList values are
		| TotalPages | TotalCount | PageSize | CurrentPage | 
		| 2          | 8          | 5        | 1           |
	And the results are
		| AddressId | ModifiedDate          | Rowguid                              | AddressLine1                      | AddressLine2 | City          | CountryRegion  | PostalCode | StateProvince |
		| 640       | 9/1/2007 12:00:00 AM  | 0e4ac5bb-be0d-4a96-a58e-064daec08e1a | 251 The Metro Center              |              | Wokingham     | United Kingdom | RG41 1QW   | England       |
		| 652       | 9/1/2006 12:00:00 AM  | 54e20963-b0e9-41cf-ab7e-d50459a3325c | Wymbush                           |              | Milton Keynes | United Kingdom | MK8 8DF    | England       |
		| 669       | 12/1/2006 12:00:00 AM | 56baec2a-5cc5-4a90-bef9-ee57e82f2e69 | Internet House, 3399 Science Park |              | Cambridge     | United Kingdom | CB4 4BZ    | England       |
		| 1034      | 9/1/2007 12:00:00 AM  | 300d2a6e-67b4-417b-83a9-2026818a21c6 | Oxnard Outlet                     |              | Oxnard        | United States  | 93030      | California    |
		| 1038      | 9/1/2007 12:00:00 AM  | a86c8140-ad7d-4caa-9b40-4006bd9998e2 | 123 Camelia Avenue                |              | Oxnard        | United States  | 93030      | California    |



Scenario: FindAllAsync_1_500
	When I populate the model 'AdventureWorksDemo.Data.Paging.PagingFilter'
		| PageNumber | PageSize |
		| 1          | 500      |
	And I call the method 'FindAllAsync' with the parameter values
		| Key           | Value     | TypeName                                    |
		| pageingFilter | {{model}} | AdventureWorksDemo.Data.Paging.PagingFilter |
	Then the result is of type
		| Expected                                                                              |
		| AdventureWorksDemo.Data.Paging.PagedList<AdventureWorksDemo.Data.Models.AddressModel> |
	And the PagedList values are
		| TotalPages | TotalCount | PageSize | CurrentPage | 
		| 1          | 8          | 100      | 1           | 
	And the results are
		| AddressId | ModifiedDate          | Rowguid                              | AddressLine1                      | AddressLine2 | City                | CountryRegion  | PostalCode | StateProvince |
		| 640       | 9/1/2007 12:00:00 AM  | 0e4ac5bb-be0d-4a96-a58e-064daec08e1a | 251 The Metro Center              |              | Wokingham           | United Kingdom | RG41 1QW   | England       |
		| 652       | 9/1/2006 12:00:00 AM  | 54e20963-b0e9-41cf-ab7e-d50459a3325c | Wymbush                           |              | Milton Keynes       | United Kingdom | MK8 8DF    | England       |
		| 669       | 12/1/2006 12:00:00 AM | 56baec2a-5cc5-4a90-bef9-ee57e82f2e69 | Internet House, 3399 Science Park |              | Cambridge           | United Kingdom | CB4 4BZ    | England       |
		| 1034      | 9/1/2007 12:00:00 AM  | 300d2a6e-67b4-417b-83a9-2026818a21c6 | Oxnard Outlet                     |              | Oxnard              | United States  | 93030      | California    |
		| 1038      | 9/1/2007 12:00:00 AM  | a86c8140-ad7d-4caa-9b40-4006bd9998e2 | 123 Camelia Avenue                |              | Oxnard              | United States  | 93030      | California    |
		| 1090      | 9/1/2007 12:00:00 AM  | cf3ae92a-3e66-4af0-b683-731826e89cd1 | 25130 South State Street          |              | Sandy               | United States  | 84070      | Utah          |
		| 1092      | 9/1/2006 12:00:00 AM  | 79cdd89c-3c91-48db-8277-46d04aad7251 | 99700 Bell Road                   |              | Auburn              | United States  | 95603      | California    |
		| 1111      | 9/1/2006 12:00:00 AM  | 00000000-1111-2222-0000-000000000001 | Orphan Record                     |              | Use In Delete Tests | United States  | 95603      | California    |

Scenario: FindAllAsync_2_5
	When I populate the model 'AdventureWorksDemo.Data.Paging.PagingFilter'
		| PageNumber | PageSize |
		| 2          | 5        |
	And I call the method 'FindAllAsync' with the parameter values
		| Key           | Value     | TypeName                                    |
		| pageingFilter | {{model}} | AdventureWorksDemo.Data.Paging.PagingFilter |
	Then the result is of type
		| Expected                                                                              |
		| AdventureWorksDemo.Data.Paging.PagedList<AdventureWorksDemo.Data.Models.AddressModel> |
	And the PagedList values are
		| TotalPages | TotalCount | PageSize | CurrentPage | 
		| 2          | 8          | 5        | 2           |
	And the results are
		| AddressId | ModifiedDate         | Rowguid                              | AddressLine1             | AddressLine2 | City                | CountryRegion | PostalCode | StateProvince |
		| 1090      | 9/1/2007 12:00:00 AM | cf3ae92a-3e66-4af0-b683-731826e89cd1 | 25130 South State Street |              | Sandy               | United States | 84070      | Utah          |
		| 1092      | 9/1/2006 12:00:00 AM | 79cdd89c-3c91-48db-8277-46d04aad7251 | 99700 Bell Road          |              | Auburn              | United States | 95603      | California    |
		| 1111      | 9/1/2006 12:00:00 AM | 00000000-1111-2222-0000-000000000001 | Orphan Record            |              | Use In Delete Tests | United States | 95603      | California    |

Scenario: FindAllAsync_2_8
	When I populate the model 'AdventureWorksDemo.Data.Paging.PagingFilter'
		| PageNumber | PageSize |
		| 2          | 8        |
	And I call the method 'FindAllAsync' with the parameter values
		| Key           | Value     | TypeName                                    |
		| pageingFilter | {{model}} | AdventureWorksDemo.Data.Paging.PagingFilter |
	Then the result is of type
		| Expected                                                                              |
		| AdventureWorksDemo.Data.Paging.PagedList<AdventureWorksDemo.Data.Models.AddressModel> |
	And the PagedList values are
		| TotalPages | TotalCount | PageSize | CurrentPage | 
		| 1          | 8          | 8        | 2           | 
	And the results are
		| AddressId | ModifiedDate | Rowguid | AddressLine1 | AddressLine2 | City | CountryRegion | PostalCode | StateProvince |

Scenario: FindAllAsync_20_20
	When I populate the model 'AdventureWorksDemo.Data.Paging.PagingFilter'
		| PageNumber | PageSize |
		| 2          | 8        |
	And I call the method 'FindAllAsync' with the parameter values
		| Key           | Value     | TypeName                                    |
		| pageingFilter | {{model}} | AdventureWorksDemo.Data.Paging.PagingFilter |
	Then the result is of type
		| Expected                                                                              |
		| AdventureWorksDemo.Data.Paging.PagedList<AdventureWorksDemo.Data.Models.AddressModel> |
	And the PagedList values are
		| TotalPages | TotalCount | PageSize | CurrentPage | 
		| 1          | 8          | 8        | 2           | 
	And the results are
		| AddressId | ModifiedDate | Rowguid | AddressLine1 | AddressLine2 | City | CountryRegion | PostalCode | StateProvince |

Scenario: FindAllAsync_1234_5
	When I populate the model 'AdventureWorksDemo.Data.Paging.PagingFilter'
		| PageNumber | PageSize |
		| 1234       | 5        |
	And I call the method 'FindAllAsync' with the parameter values
		| Key           | Value     | TypeName                                    |
		| pageingFilter | {{model}} | AdventureWorksDemo.Data.Paging.PagingFilter |
	Then the result is of type
		| Expected                                                                              |
		| AdventureWorksDemo.Data.Paging.PagedList<AdventureWorksDemo.Data.Models.AddressModel> |
	And the PagedList values are
		| TotalPages | TotalCount | PageSize | CurrentPage | 
		| 2          | 8          | 5        | 1234        | 
	And the results are
		| AddressId | ModifiedDate | Rowguid | AddressLine1 | AddressLine2 | City | CountryRegion | PostalCode | StateProvince |

Scenario: FindAllAsync_0_0
	When I populate the model 'AdventureWorksDemo.Data.Paging.PagingFilter'
		| PageNumber | PageSize |
		| 0          | 0        |
	And I call the method 'FindAllAsync' with the parameter values
		| Key           | Value     | TypeName                                    |
		| pageingFilter | {{model}} | AdventureWorksDemo.Data.Paging.PagingFilter |
	Then the result is of type
		| Expected                                                                              |
		| AdventureWorksDemo.Data.Paging.PagedList<AdventureWorksDemo.Data.Models.AddressModel> |

	And the PagedList values are
		| TotalPages | TotalCount | PageSize | CurrentPage |
		| 1          | 8          | 25       | 1           |
	And the results are
		| AddressId | ModifiedDate          | Rowguid                              | AddressLine1                      | AddressLine2 | City                | CountryRegion  | PostalCode | StateProvince |
		| 640       | 9/1/2007 12:00:00 AM  | 0e4ac5bb-be0d-4a96-a58e-064daec08e1a | 251 The Metro Center              |              | Wokingham           | United Kingdom | RG41 1QW   | England       |
		| 652       | 9/1/2006 12:00:00 AM  | 54e20963-b0e9-41cf-ab7e-d50459a3325c | Wymbush                           |              | Milton Keynes       | United Kingdom | MK8 8DF    | England       |
		| 669       | 12/1/2006 12:00:00 AM | 56baec2a-5cc5-4a90-bef9-ee57e82f2e69 | Internet House, 3399 Science Park |              | Cambridge           | United Kingdom | CB4 4BZ    | England       |
		| 1034      | 9/1/2007 12:00:00 AM  | 300d2a6e-67b4-417b-83a9-2026818a21c6 | Oxnard Outlet                     |              | Oxnard              | United States  | 93030      | California    |
		| 1038      | 9/1/2007 12:00:00 AM  | a86c8140-ad7d-4caa-9b40-4006bd9998e2 | 123 Camelia Avenue                |              | Oxnard              | United States  | 93030      | California    |
		| 1090      | 9/1/2007 12:00:00 AM  | cf3ae92a-3e66-4af0-b683-731826e89cd1 | 25130 South State Street          |              | Sandy               | United States  | 84070      | Utah          |
		| 1092      | 9/1/2006 12:00:00 AM  | 79cdd89c-3c91-48db-8277-46d04aad7251 | 99700 Bell Road                   |              | Auburn              | United States  | 95603      | California    |
		| 1111      | 9/1/2006 12:00:00 AM  | 00000000-1111-2222-0000-000000000001 | Orphan Record                     |              | Use In Delete Tests | United States  | 95603      | California    |

Scenario: FindAllAsync_0_5
	When I populate the model 'AdventureWorksDemo.Data.Paging.PagingFilter'
		| PageNumber | PageSize |
		| 0          | 5        |
	And I call the method 'FindAllAsync' with the parameter values
		| Key           | Value     | TypeName                                    |
		| pageingFilter | {{model}} | AdventureWorksDemo.Data.Paging.PagingFilter |
	Then the result is of type
		| Expected                                                                              |
		| AdventureWorksDemo.Data.Paging.PagedList<AdventureWorksDemo.Data.Models.AddressModel> |
	And the PagedList values are
		| TotalPages | TotalCount | PageSize | CurrentPage |
		| 2          | 8          | 5        | 1           |
	And the results are
		| AddressId | ModifiedDate          | Rowguid                              | AddressLine1                      | AddressLine2 | City                | CountryRegion  | PostalCode | StateProvince |
		| 640       | 9/1/2007 12:00:00 AM  | 0e4ac5bb-be0d-4a96-a58e-064daec08e1a | 251 The Metro Center              |              | Wokingham           | United Kingdom | RG41 1QW   | England       |
		| 652       | 9/1/2006 12:00:00 AM  | 54e20963-b0e9-41cf-ab7e-d50459a3325c | Wymbush                           |              | Milton Keynes       | United Kingdom | MK8 8DF    | England       |
		| 669       | 12/1/2006 12:00:00 AM | 56baec2a-5cc5-4a90-bef9-ee57e82f2e69 | Internet House, 3399 Science Park |              | Cambridge           | United Kingdom | CB4 4BZ    | England       |
		| 1034      | 9/1/2007 12:00:00 AM  | 300d2a6e-67b4-417b-83a9-2026818a21c6 | Oxnard Outlet                     |              | Oxnard              | United States  | 93030      | California    |
		| 1038      | 9/1/2007 12:00:00 AM  | a86c8140-ad7d-4caa-9b40-4006bd9998e2 | 123 Camelia Avenue                |              | Oxnard              | United States  | 93030      | California    |
		


Scenario: FindAllAsync_5_0
	When I populate the model 'AdventureWorksDemo.Data.Paging.PagingFilter'
		| PageNumber | PageSize |
		| 5          | 0        |
	And I call the method 'FindAllAsync' with the parameter values
		| Key           | Value     | TypeName                                    |
		| pageingFilter | {{model}} | AdventureWorksDemo.Data.Paging.PagingFilter |
	Then the result is of type
		| Expected                           |
		| AdventureWorksDemo.Data.Paging.PagedList<AdventureWorksDemo.Data.Models.AddressModel> |
	And the PagedList values are
		| TotalPages | TotalCount | PageSize | CurrentPage |
		| 1          | 8          | 25       | 5           |

	And the results are
		| AddressId | ModifiedDate          | Rowguid                              | AddressLine1                      | AddressLine2 | City                | CountryRegion  | PostalCode | StateProvince |
	
Scenario: FindAsync1090
	When I call the method 'FindAsync' with the parameter values
		| Key       | Value | TypeName |
		| AddressId | 1090  | int      |
	Then the result is of type
		| Expected                                    |
		| AdventureWorksDemo.Data.Models.AddressModel |
	And the result is
		| AddressId | ModifiedDate         | Rowguid                              | AddressLine1             | AddressLine2 | City  | CountryRegion | PostalCode | StateProvince |
		| 1090      | 9/1/2007 12:00:00 AM | cf3ae92a-3e66-4af0-b683-731826e89cd1 | 25130 South State Street |              | Sandy | United States | 84070      | Utah          |

Scenario: FindAsync12345
	When I call the method 'FindAsync' with the parameter values
		| Key       | Value | TypeName |
		| AddressId | 12345 | int      |

	Then the result is of type
		| Expected                                    |
		| AdventureWorksDemo.Data.Models.AddressModel |
	And the result is null
Scenario: FindAsync640
	When I call the method 'FindAsync' with the parameter values
		| Key       | Value | TypeName |
		| AddressId | 640   | int      |
	Then the result is of type
		| Expected                                    |
		| AdventureWorksDemo.Data.Models.AddressModel |
	And the result is
		| AddressId | ModifiedDate         | Rowguid                              | AddressLine1         | AddressLine2 | City      | CountryRegion  | PostalCode | StateProvince |
		| 640       | 9/1/2007 12:00:00 AM | 0e4ac5bb-be0d-4a96-a58e-064daec08e1a | 251 The Metro Center |              | Wokingham | United Kingdom | RG41 1QW   | England       |

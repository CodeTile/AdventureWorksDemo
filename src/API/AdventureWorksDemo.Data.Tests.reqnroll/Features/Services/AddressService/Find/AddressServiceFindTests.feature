Feature: AddressServiceFindTests

System tests for the AddressService
Testing the methods FindAsync and FindAllAsync


Background:
	Given The service to test is 'AdventureWorksDemo.Data.Services.IAddressService'
	And I don't reset the database after the scenario
		
Scenario: FindAllAsync_1_5
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
		| 2          | 7          | 5        | 0           |
	And the sorted results are
		| AddressId | ModifiedDate           | Rowguid                              | AddressLine1                     | AddressLine2 | City          | PostalCode | StateProvinceId |
		| 1         | 12/21/2013 10:09:00 AM | 2d53a7fc-8017-412d-a591-b10bac54f9b7 | 568, avenue de l? Union Centrale |              | Paris         | 75009      | 1               |
		| 2         | 8/15/2013 12:00:00 AM  | df254102-23c7-4820-ae4a-6a9f0668c8ba | Charlottenstr 844                |              | Ingolstadt    | 85049      | 3               |
		| 3         | 6/23/2014 12:00:00 AM  | 513bf254-97b8-433b-b467-3079487a2bd4 | 9093 Gilardy Dr.                 |              | Milton Keynes | MK8 8ZD    | 4               |
		| 4         | 10/19/2012 12:00:00 AM | 70764525-a746-4f90-b7bf-dd71d6de2bc9 | Celler Weg 504                   |              | Poing         | 66041      | 3               |
		| 5         | 1/17/2014 12:00:00 AM  | 9a804484-17af-4360-b83b-330cc89634ab | 3985 Dolores Way                 |              | Perth         | 6006       | 5               |


Scenario: FindAllAsync_1_500
	When I populate the model 'AdventureWorksDemo.Data.Paging.PagingFilter'
		| PageNumber | PageSize |
		| 0          | 500      |
	And I call the method 'FindAllAsync' with the parameter values
		| Key           | Value     | TypeName                                    |
		| pageingFilter | {{model}} | AdventureWorksDemo.Data.Paging.PagingFilter |
	Then the result is of type
		| Expected                                                                              |
		| AdventureWorksDemo.Data.Paging.PagedList<AdventureWorksDemo.Data.Models.AddressModel> |
	And the PagedList values are
		| TotalPages | TotalCount | PageSize | CurrentPage |
		| 1          | 7          | 100      | 0           |
	And the sorted results are
		| AddressId | ModifiedDate           | Rowguid                              | AddressLine1                     | AddressLine2 | City          | PostalCode | StateProvinceId |
		| 1         | 12/21/2013 10:09:00 AM | 2d53a7fc-8017-412d-a591-b10bac54f9b7 | 568, avenue de l? Union Centrale |              | Paris         | 75009      | 1               |
		| 2         | 8/15/2013 12:00:00 AM  | df254102-23c7-4820-ae4a-6a9f0668c8ba | Charlottenstr 844                |              | Ingolstadt    | 85049      | 3               |
		| 3         | 6/23/2014 12:00:00 AM  | 513bf254-97b8-433b-b467-3079487a2bd4 | 9093 Gilardy Dr.                 |              | Milton Keynes | MK8 8ZD    | 4               |
		| 4         | 10/19/2012 12:00:00 AM | 70764525-a746-4f90-b7bf-dd71d6de2bc9 | Celler Weg 504                   |              | Poing         | 66041      | 3               |
		| 5         | 1/17/2014 12:00:00 AM  | 9a804484-17af-4360-b83b-330cc89634ab | 3985 Dolores Way                 |              | Perth         | 6006       | 5               |
		| 6         | 12/1/2013 12:00:00 AM  | a9121e78-13ea-476b-bda4-6c6f654e0d55 | Skywalker House                  | Hoth         | Sky Town      | WA3        | 2               |
		| 7         | 12/1/2013 12:00:00 AM  | a9121e78-dddd-dddd-bda4-6c6f654ecd55 | Delete Orphan                    |              | Wakanda       | WA3        | 7               |

Scenario: FindAllAsync_2_5
	When I populate the model 'AdventureWorksDemo.Data.Paging.PagingFilter'
		| PageNumber | PageSize |
		| 3          | 5        |
	And I call the method 'FindAllAsync' with the parameter values
		| Key           | Value     | TypeName                                    |
		| pageingFilter | {{model}} | AdventureWorksDemo.Data.Paging.PagingFilter |
	Then the result is of type
		| Expected                                                                              |
		| AdventureWorksDemo.Data.Paging.PagedList<AdventureWorksDemo.Data.Models.AddressModel> |
	And the PagedList values are
		| TotalPages | TotalCount | PageSize | CurrentPage |
		| 2          | 7          | 5        | 1           |
	And the sorted results are
		| AddressId | ModifiedDate          | Rowguid                              | AddressLine1    | AddressLine2 | City     | PostalCode | StateProvinceId |
		| 6         | 12/1/2013 12:00:00 AM | a9121e78-13ea-476b-bda4-6c6f654e0d55 | Skywalker House | Hoth         | Sky Town | WA3        | 2               |
		| 7         | 12/1/2013 12:00:00 AM | a9121e78-dddd-dddd-bda4-6c6f654ecd55 | Delete Orphan   |              | Wakanda  | WA3        | 7               |

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
		| 1          | 7          | 8        | 0           |
	And the sorted results are
		| AddressId | ModifiedDate           | Rowguid                              | AddressLine1                     | AddressLine2 | City          | PostalCode | StateProvinceId |
		| 1         | 12/21/2013 10:09:00 AM | 2d53a7fc-8017-412d-a591-b10bac54f9b7 | 568, avenue de l? Union Centrale |              | Paris         | 75009      | 1               |
		| 2         | 8/15/2013 12:00:00 AM  | df254102-23c7-4820-ae4a-6a9f0668c8ba | Charlottenstr 844                |              | Ingolstadt    | 85049      | 3               |
		| 3         | 6/23/2014 12:00:00 AM  | 513bf254-97b8-433b-b467-3079487a2bd4 | 9093 Gilardy Dr.                 |              | Milton Keynes | MK8 8ZD    | 4               |
		| 4         | 10/19/2012 12:00:00 AM | 70764525-a746-4f90-b7bf-dd71d6de2bc9 | Celler Weg 504                   |              | Poing         | 66041      | 3               |
		| 5         | 1/17/2014 12:00:00 AM  | 9a804484-17af-4360-b83b-330cc89634ab | 3985 Dolores Way                 |              | Perth         | 6006       | 5               |
		| 6         | 12/1/2013 12:00:00 AM  | a9121e78-13ea-476b-bda4-6c6f654e0d55 | Skywalker House                  | Hoth         | Sky Town      | WA3        | 2               |
		| 7         | 12/1/2013 12:00:00 AM  | a9121e78-dddd-dddd-bda4-6c6f654ecd55 | Delete Orphan                    |              | Wakanda       | WA3        | 7               |

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
		| 1          | 7          | 8        | 0           |
	And the sorted results are
		| AddressId | ModifiedDate           | Rowguid                              | AddressLine1                     | AddressLine2 | City          | PostalCode | StateProvinceId |
		| 1         | 12/21/2013 10:09:00 AM | 2d53a7fc-8017-412d-a591-b10bac54f9b7 | 568, avenue de l? Union Centrale |              | Paris         | 75009      | 1               |
		| 2         | 8/15/2013 12:00:00 AM  | df254102-23c7-4820-ae4a-6a9f0668c8ba | Charlottenstr 844                |              | Ingolstadt    | 85049      | 3               |
		| 3         | 6/23/2014 12:00:00 AM  | 513bf254-97b8-433b-b467-3079487a2bd4 | 9093 Gilardy Dr.                 |              | Milton Keynes | MK8 8ZD    | 4               |
		| 4         | 10/19/2012 12:00:00 AM | 70764525-a746-4f90-b7bf-dd71d6de2bc9 | Celler Weg 504                   |              | Poing         | 66041      | 3               |
		| 5         | 1/17/2014 12:00:00 AM  | 9a804484-17af-4360-b83b-330cc89634ab | 3985 Dolores Way                 |              | Perth         | 6006       | 5               |
		| 6         | 12/1/2013 12:00:00 AM  | a9121e78-13ea-476b-bda4-6c6f654e0d55 | Skywalker House                  | Hoth         | Sky Town      | WA3        | 2               |
		| 7         | 12/1/2013 12:00:00 AM  | a9121e78-dddd-dddd-bda4-6c6f654ecd55 | Delete Orphan                    |              | Wakanda       | WA3        | 7               |

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
		| 2          | 7          | 5        | 1           |
	And the sorted results are
		| AddressId | ModifiedDate          | Rowguid                              | AddressLine1    | AddressLine2 | City     | PostalCode | StateProvinceId |
		| 6         | 12/1/2013 12:00:00 AM | a9121e78-13ea-476b-bda4-6c6f654e0d55 | Skywalker House | Hoth         | Sky Town | WA3        | 2               |
		| 7         | 12/1/2013 12:00:00 AM | a9121e78-dddd-dddd-bda4-6c6f654ecd55 | Delete Orphan   |              | Wakanda  | WA3        | 7               |

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
		| 1          | 7          | 25       | 0           |
	And the sorted results are
		| AddressId | ModifiedDate           | Rowguid                              | AddressLine1                     | AddressLine2 | City          | PostalCode | StateProvinceId |
		| 1         | 12/21/2013 10:09:00 AM | 2d53a7fc-8017-412d-a591-b10bac54f9b7 | 568, avenue de l? Union Centrale |              | Paris         | 75009      | 1               |
		| 2         | 8/15/2013 12:00:00 AM  | df254102-23c7-4820-ae4a-6a9f0668c8ba | Charlottenstr 844                |              | Ingolstadt    | 85049      | 3               |
		| 3         | 6/23/2014 12:00:00 AM  | 513bf254-97b8-433b-b467-3079487a2bd4 | 9093 Gilardy Dr.                 |              | Milton Keynes | MK8 8ZD    | 4               |
		| 4         | 10/19/2012 12:00:00 AM | 70764525-a746-4f90-b7bf-dd71d6de2bc9 | Celler Weg 504                   |              | Poing         | 66041      | 3               |
		| 5         | 1/17/2014 12:00:00 AM  | 9a804484-17af-4360-b83b-330cc89634ab | 3985 Dolores Way                 |              | Perth         | 6006       | 5               |
		| 6         | 12/1/2013 12:00:00 AM  | a9121e78-13ea-476b-bda4-6c6f654e0d55 | Skywalker House                  | Hoth         | Sky Town      | WA3        | 2               |
		| 7         | 12/1/2013 12:00:00 AM  | a9121e78-dddd-dddd-bda4-6c6f654ecd55 | Delete Orphan                    |              | Wakanda       | WA3        | 7               |

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
		| 2          | 7          | 5        | 0           |
	And the sorted results are
		| AddressId | ModifiedDate           | Rowguid                              | AddressLine1                     | AddressLine2 | City          | PostalCode | StateProvinceId |
		| 1         | 12/21/2013 10:09:00 AM | 2d53a7fc-8017-412d-a591-b10bac54f9b7 | 568, avenue de l? Union Centrale |              | Paris         | 75009      | 1               |
		| 2         | 8/15/2013 12:00:00 AM  | df254102-23c7-4820-ae4a-6a9f0668c8ba | Charlottenstr 844                |              | Ingolstadt    | 85049      | 3               |
		| 3         | 6/23/2014 12:00:00 AM  | 513bf254-97b8-433b-b467-3079487a2bd4 | 9093 Gilardy Dr.                 |              | Milton Keynes | MK8 8ZD    | 4               |
		| 4         | 10/19/2012 12:00:00 AM | 70764525-a746-4f90-b7bf-dd71d6de2bc9 | Celler Weg 504                   |              | Poing         | 66041      | 3               |
		| 5         | 1/17/2014 12:00:00 AM  | 9a804484-17af-4360-b83b-330cc89634ab | 3985 Dolores Way                 |              | Perth         | 6006       | 5               |
	

Scenario: FindAllAsync_5_0
	When I populate the model 'AdventureWorksDemo.Data.Paging.PagingFilter'
		| PageNumber | PageSize |
		| 5          | 0        |
	And I call the method 'FindAllAsync' with the parameter values
		| Key           | Value     | TypeName                                    |
		| pageingFilter | {{model}} | AdventureWorksDemo.Data.Paging.PagingFilter |
	Then the result is of type
		| Expected                                                                              |
		| AdventureWorksDemo.Data.Paging.PagedList<AdventureWorksDemo.Data.Models.AddressModel> |
	And the PagedList values are
		| TotalPages | TotalCount | PageSize | CurrentPage |
		| 1          | 7          | 25       | 0           |
	And the sorted results are
		| AddressId | ModifiedDate           | Rowguid                              | AddressLine1                     | AddressLine2 | City          | PostalCode | StateProvinceId |
		| 1         | 12/21/2013 10:09:00 AM | 2d53a7fc-8017-412d-a591-b10bac54f9b7 | 568, avenue de l? Union Centrale |              | Paris         | 75009      | 1               |
		| 2         | 8/15/2013 12:00:00 AM  | df254102-23c7-4820-ae4a-6a9f0668c8ba | Charlottenstr 844                |              | Ingolstadt    | 85049      | 3               |
		| 3         | 6/23/2014 12:00:00 AM  | 513bf254-97b8-433b-b467-3079487a2bd4 | 9093 Gilardy Dr.                 |              | Milton Keynes | MK8 8ZD    | 4               |
		| 4         | 10/19/2012 12:00:00 AM | 70764525-a746-4f90-b7bf-dd71d6de2bc9 | Celler Weg 504                   |              | Poing         | 66041      | 3               |
		| 5         | 1/17/2014 12:00:00 AM  | 9a804484-17af-4360-b83b-330cc89634ab | 3985 Dolores Way                 |              | Perth         | 6006       | 5               |
		| 6         | 12/1/2013 12:00:00 AM  | a9121e78-13ea-476b-bda4-6c6f654e0d55 | Skywalker House                  | Hoth         | Sky Town      | WA3        | 2               |
		| 7         | 12/1/2013 12:00:00 AM  | a9121e78-dddd-dddd-bda4-6c6f654ecd55 | Delete Orphan                    |              | Wakanda       | WA3        | 7               |


Scenario: FindAsync2
	When I call the method 'FindAsync' with the parameter values
		| Key       | Value | TypeName |
		| AddressId | 2     | int      |
	Then the result is of type
		| Expected                                    |
		| AdventureWorksDemo.Data.Models.AddressModel |
	And the result is
		| AddressId | ModifiedDate          | Rowguid                              | AddressLine1      | AddressLine2 | City       | PostalCode | StateProvinceId |
		| 2         | 8/15/2013 12:00:00 AM | df254102-23c7-4820-ae4a-6a9f0668c8ba | Charlottenstr 844 |              | Ingolstadt | 85049      | 3               |

Scenario: FindAsync3
	When I call the method 'FindAsync' with the parameter values
		| Key       | Value | TypeName |
		| AddressId | 3     | int      |
	Then the result is of type
		| Expected                                    |
		| AdventureWorksDemo.Data.Models.AddressModel |
	And the result is
		| AddressId | ModifiedDate          | Rowguid                              | AddressLine1     | AddressLine2 | City          | PostalCode | StateProvinceId |
		| 3         | 6/23/2014 12:00:00 AM | 513bf254-97b8-433b-b467-3079487a2bd4 | 9093 Gilardy Dr. |              | Milton Keynes | MK8 8ZD    | 4               |

Scenario: FindAsync12345
	When I call the method 'FindAsync' with the parameter values
		| Key       | Value | TypeName |
		| AddressId | 12345 | int      |

	Then the result is of type
		| Expected                                    |
		| AdventureWorksDemo.Data.Models.AddressModel |
	And the result is null
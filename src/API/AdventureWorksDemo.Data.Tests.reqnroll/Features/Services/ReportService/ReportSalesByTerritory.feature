Feature: ReportSalesByTerritoryTests

Tests for the report ReportOnLineVsOffLine

Background:
	Given The service to test is 'AdventureWorksDemo.Data.Services.IReportService'
	And I don't reset the database after the scenario

Scenario: debug
	When I call the method 'ReportSalesByTerritory'
	Then the result is of type
		| Expected                                                                                                             |
		| Microsoft.EntityFrameworkCore.Query.Internal.EntityQueryable<AdventureWorksDemo.Data.Models.Reports.SaleByTerritory> |
	And the results are
		| CountryRegion  | SalesLastYear | SalesYTD     |
		| Australia      | 2278548.9800  | 5977814.9200 |
		| Canada         | 5693988.8600  | 6771829.1400 |
		| Delete Orphan  | 0.0000        | 0.0000       |
		| France         | 2396539.7600  | 4772398.3100 |
		| Germany        | 1307949.7900  | 3805202.3500 |
		| Tokelau        | 2344344.4000  | 4325344.3700 |
		| United Kingdom | 1635823.4000  | 5012905.3700 |

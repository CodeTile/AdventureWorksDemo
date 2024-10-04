using AdventureWorksDemo.Data.Entities;

namespace AdventureWorksDemo.Data.Tests.nUnit.Helpers
{
	internal partial class FakeDbContext
	{
		internal static List<Address> FakeAddresses
		{
			get
			{
				return [
					new Address()
					{
						AddressId = 1,
						AddressLine1 = "2564 S. Redwood Rd.",
						City = "Riverton",
						StateProvince = "Utah",
						CountryRegion = "United States",
						PostalCode = "84065",
						Rowguid = new Guid("E299E96D-63CB-4ACC-9BFD-5F0C23AE5820"),
						ModifiedDate = Convert.ToDateTime("12 May 2005 01:52:23")
					},
					new Address()
					{
						AddressId = 2,
						AddressLine1 = "9905 Three Rivers Drive",
						City = "Kelso",
						StateProvince = "Washington",
						CountryRegion = "United States",
						PostalCode = "98626",
						Rowguid = new Guid("01A85112-6EE1-4F2C-9212-1C2ABC612E67"),
						ModifiedDate = Convert.ToDateTime("12 May 2005 01:52:23")
					},
					new Address()
					{
						AddressId = 3,
						AddressLine1 = "25 First Canadian Place",
						City = "Toronto",
						StateProvince = "Ontario",
						CountryRegion = "Canada",
						PostalCode = "M4B 1V5",
						Rowguid = new Guid("07A009B2-1421-4597-AB85-22BCE3C82B2C"),
						ModifiedDate = Convert.ToDateTime("12 May 2005 01:52:24")
					},
					new Address()
					{
						AddressId = 4,
						AddressLine1 = "2560 Bay Street",
						City = "Toronto",
						StateProvince = "Ontario",
						CountryRegion = "Canada",
						PostalCode = "M4B 1V7",
						Rowguid = new Guid("726819A8-1B02-4EFD-AEB9-3FD801D9F153"),
						ModifiedDate = Convert.ToDateTime("13 May 2005 01:45:23")
					},
					new Address()
					{
						AddressId = 5,
						AddressLine1 = "9992 Whipple Rd",
						City = "Union City",
						StateProvince = "California",
						CountryRegion = "United States",
						PostalCode = "94587",
						Rowguid = new Guid("88258A1B-B50F-440F-93B9-5D7AF831D5FC"),
						ModifiedDate = Convert.ToDateTime("14 May 2005 06:52:23")
					},
					new Address()
					{
						AddressId = 6,
						AddressLine1 = "25915 140th Ave Ne",
						City = "Bellevue",
						StateProvince = "Washington",
						CountryRegion = "United States",
						PostalCode = "98004",
						Rowguid = new Guid("0D46F203-CDB6-4495-83F5-A97FF0CEC174"),
						ModifiedDate = Convert.ToDateTime("28 May 2005 22:52:23")
					},
					new Address()
					{
						AddressId = 7,
						AddressLine1 = "2574 Milton Park",
						City = "Oxford",
						StateProvince = "England",
						CountryRegion = "United Kingdom",
						PostalCode = "OX14 4SE",
						Rowguid = new Guid("62D0C689-CF44-4AB3-9C3E-6142F4E0101C"),
						ModifiedDate = Convert.ToDateTime("12 June 2005 01:52:23")
					}
					];
			}
		}

		internal static Address NewAddress1() => new()
		{
			AddressLine1 = "Ping",
			AddressLine2 = "Pong",
			City = "Ping Pong",
			StateProvince = "Foo",
			CountryRegion = "Bar",
			PostalCode = "98765",
		};
	}
}
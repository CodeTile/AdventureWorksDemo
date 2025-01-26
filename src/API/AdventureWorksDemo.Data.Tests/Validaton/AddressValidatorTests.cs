using AdventureWorksDemo.Data.Entities;
using AdventureWorksDemo.Data.Validation;

using AdventureWorksDemo.Common.Tests.Extensions;
using FluentValidation.TestHelper;

namespace AdventureWorksDemo.Data.Tests.Validaton
{
	[TestClass]
	public class AddressValidatorTests
	{
		private Address? _address;

		private AddressValidator _validator = new();

		[DataRow("123")]
		[DataRow("{{PadRight:X:59}}")]
		[DataRow("{{PadRight:X:60}}")]
		[TestMethod]
		public void AddressLine1_Length_Between_3_And_60(string value)
		{
			// arrange
			var entity = _address;
			entity.AddressLine1 = value.InterpretValue();
			//act
			var result = _validator.TestValidate(entity);
			//assert
			result.ShouldNotHaveValidationErrorFor(m => m.AddressLine1);
		}

		[DataRow("")]
		[DataRow("1")]
		[DataRow("12")]
		[DataRow("66")]
		[DataRow("{{PadRight:X:61}}")]
		[TestMethod]
		public void AddressLine1_Length_Not_Between_3_And_60(string value)
		{
			// arrange
			var entity = _address;
			entity.AddressLine1 = value.InterpretValue();
			//act
			var result = _validator.TestValidate(entity);
			//assert
			result.ShouldHaveValidationErrorFor(m => m.AddressLine1);
		}

		[DataRow("123")]
		[DataRow("{{PadRight:X:59}}")]
		[DataRow("{{PadRight:X:60}}")]
		[TestMethod]
		public void AddressLine2_Length_Between_3_And_60(string value)
		{
			// arrange
			var entity = _address;
			entity.AddressLine2 = value.InterpretValue();
			//act
			var result = _validator.TestValidate(entity);
			//assert
			result.ShouldNotHaveValidationErrorFor(m => m.AddressLine2);
		}

		[DataRow("")]
		[DataRow("1")]
		[DataRow("12")]
		[DataRow("66")]
		[DataRow("{{PadRight:X:61}}")]
		[TestMethod]
		public void AddressLine2_Length_Not_Between_3_And_60(string value)
		{
			// arrange
			var entity = _address;
			entity.AddressLine2 = value.InterpretValue();
			//act
			var result = _validator.TestValidate(entity);
			//assert
			result.ShouldHaveValidationErrorFor(m => m.AddressLine2);
		}

		[DataRow("{{PadRight:X:3}}")]
		[DataRow("{{PadRight:X:4}}")]
		[DataRow("{{PadRight:X:30}}")]
		[DataRow("{{PadRight:X:29}}")]
		[TestMethod]
		public void City_Should_Have_Length_Between_3_And_30(string value)
		{
			// arrange
			var entity = _address;
			entity.City = value.InterpretValue();
			//act
			var result = _validator.TestValidate(entity);
			//assert
			result.ShouldNotHaveValidationErrorFor(m => m.City);
		}

		[DataRow("")]
		[DataRow("1")]
		[DataRow("12")]
		[DataRow("66")]
		[DataRow("{{PadRight:X:31}}")]
		[TestMethod]
		public void City_Should_Not_Have_Length_Between_3_And_30(string value)
		{
			// arrange
			var entity = _address;
			entity.City = value.InterpretValue();
			//act
			var result = _validator.TestValidate(entity);
			//assert
			result.ShouldHaveValidationErrorFor(m => m.City);
		}

		[DataRow("{{PadRight:X:3}}")]
		[DataRow("{{PadRight:X:4}}")]
		[DataRow("{{PadRight:X:49}}")]
		[DataRow("{{PadRight:X:50}}")]
		[TestMethod]
		public void CountryRegion_Should_Have_Length_Between_3_And_50(string value)
		{
			// arrange
			var entity = _address;
			entity.CountryRegion = value.InterpretValue();
			//act
			var result = _validator.TestValidate(entity);
			//assert
			result.ShouldNotHaveValidationErrorFor(m => m.CountryRegion);
		}

		[DataRow("")]
		[DataRow("1")]
		[DataRow("12")]
		[DataRow("66")]
		[DataRow("{{PadRight:X:51}}")]
		[TestMethod]
		public void CountryRegion_Should_NotHave_Length_Between_3_And_50(string value)
		{
			// arrange
			var entity = _address;
			entity.CountryRegion = value.InterpretValue();
			//act
			var result = _validator.TestValidate(entity);
			//assert
			result.ShouldHaveValidationErrorFor(m => m.CountryRegion);
		}

		[DataRow("{{PadRight:X:3}}")]
		[DataRow("{{PadRight:X:4}}")]
		[DataRow("{{PadRight:X:14}}")]
		[DataRow("{{PadRight:X:15}}")]
		[TestMethod]
		public void PostalCode_Should_Have_Length_Between_3_And_15(string value)
		{
			// arrange
			var entity = _address;
			entity.PostalCode = value.InterpretValue();
			//act
			var result = _validator.TestValidate(entity);
			//assert
			result.ShouldNotHaveValidationErrorFor(m => m.PostalCode);
		}

		[DataRow("")]
		[DataRow("1")]
		[DataRow("12")]
		[DataRow("66")]
		[DataRow("{{PadRight:X:16}}")]
		[TestMethod]
		public void PostalCode_Should_NotHave_Length_Between_3_And_15(string value)
		{
			// arrange
			var entity = _address;
			entity.PostalCode = value.InterpretValue();
			//act
			var result = _validator.TestValidate(entity);
			//assert
			result.ShouldHaveValidationErrorFor(m => m.PostalCode);
		}

		[DataRow("{{PadRight:X:3}}")]
		[DataRow("{{PadRight:X:4}}")]
		[DataRow("{{PadRight:X:49}}")]
		[DataRow("{{PadRight:X:50}}")]
		[TestMethod]
		public void StateProvince_Should_Have_Length_Between_3_And_50(string value)
		{
			// arrange
			var entity = _address;
			entity.StateProvince = value.InterpretValue();
			//act
			var result = _validator.TestValidate(entity);
			//assert
			result.ShouldNotHaveValidationErrorFor(m => m.StateProvince);
		}

		[DataRow("")]
		[DataRow("1")]
		[DataRow("12")]
		[DataRow("66")]
		[DataRow("{{PadRight:X:51}}")]
		[TestMethod]
		public void StateProvince_Should_NotHave_Length_Between_3_And_50(string value)
		{
			// arrange
			var entity = _address;
			entity.StateProvince = value.InterpretValue();
			//act
			var result = _validator.TestValidate(entity);
			//assert
			result.ShouldHaveValidationErrorFor(m => m.StateProvince);
		}

		[TestInitialize]
		public void TestInitialize()
		{
			_validator = new AddressValidator();
			_address = new Address()
			{
				AddressId = 1,
				AddressLine1 = "12345",
				AddressLine2 = "12345",
				City = "12345",
				CountryRegion = "12345",
				PostalCode = "12345"
			};
		}
	}
}
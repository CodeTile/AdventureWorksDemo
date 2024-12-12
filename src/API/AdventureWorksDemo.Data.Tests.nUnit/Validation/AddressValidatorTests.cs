using System;

using AdventureWorksDemo.Common.Tests.Extensions;
using AdventureWorksDemo.Data.Entities;
using AdventureWorksDemo.Data.Validation;

using FluentAssertions;

using FluentValidation.TestHelper;

using NUnit.Framework;

namespace AdventureWorksDemo.Data.Tests.nUnit.Validation
{
	[TestFixture]
	public class AddressValidatorTests
	{
		private Address _address;
		private AddressValidator _validator = new();

		[TestCase("123")]
		[TestCase("{{PadRight:X:59}}")]
		[TestCase("{{PadRight:X:60}}")]
		[Test]
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

		[TestCase("")]
		[TestCase("1")]
		[TestCase("12")]
		[TestCase("66")]
		[TestCase("{{PadRight:X:61}}")]
		[Test]
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

		[TestCase("123")]
		[TestCase("{{PadRight:X:59}}")]
		[TestCase("{{PadRight:X:60}}")]
		[Test]
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

		[TestCase("")]
		[TestCase("1")]
		[TestCase("12")]
		[TestCase("66")]
		[TestCase("{{PadRight:X:61}}")]
		[Test]
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

		[TestCase("{{PadRight:X:3}}")]
		[TestCase("{{PadRight:X:4}}")]
		[TestCase("{{PadRight:X:30}}")]
		[TestCase("{{PadRight:X:29}}")]
		[Test]
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

		[TestCase("")]
		[TestCase("1")]
		[TestCase("12")]
		[TestCase("66")]
		[TestCase("{{PadRight:X:31}}")]
		[Test]
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

		[TestCase("{{PadRight:X:3}}")]
		[TestCase("{{PadRight:X:4}}")]
		[TestCase("{{PadRight:X:49}}")]
		[TestCase("{{PadRight:X:50}}")]
		[Test]
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

		[TestCase("")]
		[TestCase("1")]
		[TestCase("12")]
		[TestCase("66")]
		[TestCase("{{PadRight:X:51}}")]
		[Test]
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

		[TestCase("{{PadRight:X:3}}")]
		[TestCase("{{PadRight:X:4}}")]
		[TestCase("{{PadRight:X:14}}")]
		[TestCase("{{PadRight:X:15}}")]
		[Test]
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

		[TestCase("")]
		[TestCase("1")]
		[TestCase("12")]
		[TestCase("66")]
		[TestCase("{{PadRight:X:16}}")]
		[Test]
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

		[SetUp]
		public void SetUp()
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

		[TestCase("{{PadRight:X:3}}")]
		[TestCase("{{PadRight:X:4}}")]
		[TestCase("{{PadRight:X:49}}")]
		[TestCase("{{PadRight:X:50}}")]
		[Test]
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

		[TestCase("")]
		[TestCase("1")]
		[TestCase("12")]
		[TestCase("66")]
		[TestCase("{{PadRight:X:51}}")]
		[Test]
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

		//[Test]
		//public void StateProvince_Should_Have_Length_Between_3_And_50()
		//{
		//	_validator.ShouldHaveValidationErrorFor(a => a.StateProvince, "ST");
		//	_validator.ShouldHaveValidationErrorFor(a => a.StateProvince, new string('S', 51));
		//	_validator.ShouldNotHaveValidationErrorFor(a => a.StateProvince, "Valid State");
		//}
	}
}
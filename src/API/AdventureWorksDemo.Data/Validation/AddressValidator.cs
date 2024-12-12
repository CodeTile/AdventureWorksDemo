using AdventureWorksDemo.Data.Entities;

using FluentValidation;

namespace AdventureWorksDemo.Data.Validation
{
	public class AddressValidator : AbstractValidator<Address>
	{
		public AddressValidator()
		{
			RuleFor(m => m.AddressLine1).Length(3, 60);
			RuleFor(m => m.City).Length(3, 30);
			RuleFor(m => m.StateProvince).Length(3, 50);
			RuleFor(m => m.CountryRegion).Length(3, 50);
			RuleFor(m => m.PostalCode).Length(3, 15);
		}
	}
}
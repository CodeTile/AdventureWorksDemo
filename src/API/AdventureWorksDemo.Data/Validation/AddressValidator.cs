using AdventureWorksDemo.Data.Entities;

using FluentValidation;

namespace AdventureWorksDemo.Data.Validation
{
	public class AddressValidator : AbstractValidator<Address>
	{
		public AddressValidator()
		{
			RuleFor(m => m.AddressLine1).Length(3, 60);
			RuleFor(m => m.AddressLine2).Length(3, 60);
			RuleFor(m => m.City).Length(3, 30);
			RuleFor(m => m.StateProvinceId).GreaterThan(0).WithMessage("State province is required!");

			RuleFor(m => m.PostalCode).Length(3, 15);
		}
	}
}
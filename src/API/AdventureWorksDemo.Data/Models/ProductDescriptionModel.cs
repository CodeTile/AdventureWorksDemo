#nullable disable

using System.Diagnostics.CodeAnalysis;

using AdventureWorksDemo.Data.Entities;

namespace AdventureWorksDemo.Data.Models;

public sealed record ProductDescriptionModel
{
	/// <summary>
	/// Description of the product.
	/// </summary>

	public string Description { get; set; }

	/// <summary>
	/// Date and time the record was last updated.
	/// </summary>
	public DateTime ModifiedDate { get; set; }

	/// <summary>
	/// Primary key for ProductDescription records.
	/// </summary>
	public int ProductDescriptionId { get; set; }

	/// <summary>
	/// ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.
	/// </summary>

	public Guid Rowguid { get; set; }

	public bool Equals(ProductDescriptionModel revised)
	{
		return revised != null
			&& ProductDescriptionId == revised.ProductDescriptionId
			&& Description.Equals(revised.Description)
			;
	}

	public override int GetHashCode() => ProductDescriptionId.GetHashCode();
}
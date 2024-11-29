#nullable disable

using System.Diagnostics.CodeAnalysis;

namespace AdventureWorksDemo.Data.Models;

/// <summary>
/// High-level product categorization.
/// </summary>
public sealed record ProductCategoryModel
{
	/// <summary>
	/// Date and time the record was last updated.
	/// </summary>
	public DateTime ModifiedDate { get; set; }

	/// <summary>
	/// Category description.
	/// </summary>
	public string Name { get; set; }

	/// <summary>
	/// Product category identification number of immediate ancestor category. Foreign key to ProductCategory.ProductCategoryID.
	/// </summary>
	public int? ParentProductCategoryId { get; set; }

	/// <summary>
	/// Primary key for ProductCategory records.
	/// </summary>
	public int ProductCategoryId { get; set; }

	/// <summary>
	/// ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.
	/// </summary>
	public Guid Rowguid { get; set; }

	public bool Equals(ProductCategoryModel revised)
	{
		return revised != null
				&& Name.Equals(revised.Name)
			   && ParentProductCategoryId.Equals(revised.ParentProductCategoryId);
	}
	public override int GetHashCode() => ProductCategoryId.GetHashCode();
}
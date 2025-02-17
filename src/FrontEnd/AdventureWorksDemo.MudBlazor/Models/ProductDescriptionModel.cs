using System.ComponentModel.DataAnnotations;

namespace AdventureWorksDemo.MudBlazor.Models
{
	public record ProductDescriptionModel
	{
		[Required]
		[StringLength(400)]
		public string? Description { get; set; }

		/// <summary>
		/// Date and time the record was last updated.
		/// </summary>
		public DateTime ModifiedDate { get; set; }

		/// <summary>
		/// Primary key for ProductDescription records.
		/// </summary>
		public int ProductDescriptionId { get; set; }
	}
}
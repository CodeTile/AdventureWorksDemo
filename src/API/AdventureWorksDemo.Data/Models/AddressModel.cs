using System.ComponentModel.DataAnnotations;

namespace AdventureWorksDemo.Data.Models
{
    public class AddressModel
    {
        /// <summary>
        /// Primary key for Address records.
        /// </summary>

        public int AddressId { get; set; }

        /// <summary>
        /// First street address line.
        /// </summary>
        [Required]
        [StringLength(60)]
        public string AddressLine1 { get; set; }

        /// <summary>
        /// Second street address line.
        /// </summary>
        [StringLength(60)]
        public string AddressLine2 { get; set; }

        /// <summary>
        /// Name of the city.
        /// </summary>
        [Required]
        [StringLength(30)]
        public string City { get; set; }

        [Required]
        [StringLength(50)]
        public string CountryRegion { get; set; }

        /// <summary>
        /// Date and time the record was last updated.
        /// </summary>
        public DateTime ModifiedDate { get; set; }

        /// <summary>
        /// Postal code for the street address.
        /// </summary>
        [Required]
        [StringLength(15)]
        public string PostalCode { get; set; }

        /// <summary>
        /// ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.
        /// </summary>
        public Guid Rowguid { get; set; }

        /// <summary>
        /// Name of state or province.
        /// </summary>
        [Required]
        [StringLength(50)]
        public string StateProvince { get; set; }

        ////////[InverseProperty("Address")]
        ////////public virtual ICollection<CustomerAddress> CustomerAddresses { get; set; } = new List<CustomerAddress>();

        ////////[InverseProperty("BillToAddress")]
        ////////public virtual ICollection<SalesOrderHeader> SalesOrderHeaderBillToAddresses { get; set; } = new List<SalesOrderHeader>();

        ////////[InverseProperty("ShipToAddress")]
        ////////public virtual ICollection<SalesOrderHeader> SalesOrderHeaderShipToAddresses { get; set; } = new List<SalesOrderHeader>();
    }
}
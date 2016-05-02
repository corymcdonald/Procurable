using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace Procurable.Models
{
    public class InventoryItem
    {

        public int ID { get; set; }
        public string Name { get; set; }

        public int VendorID { get; set; }
        public virtual Vendor Vendor { get; set; }

        public int? PurchaseOrderID { get; set; }
        [Display(Name = "Purchase Order")]
        public virtual PurchaseOrder PurchaseOrder { get; set; }
        public decimal Price { get; set; }

        [DataType(DataType.MultilineText)]
        public string Comments { get; set; }

        [Display(Name = "Part Number")]
        public string PartNumber { get; set; }
        [JsonProperty(PropertyName = "email", DefaultValueHandling = DefaultValueHandling.Populate)]
        public string Location { get; set; }

        [Display(Name = "Inventory Status")]
        public InventoryStatus Status { get; set; }
        public string StatusDisplay
        {
            get
            {
                return Status.ToString();
            }
        }

        private decimal MonthToDay = 30.4167M;

        public decimal? DepreciationRemaining { get; set; }
        public decimal? Depreciation { get; set; }
        public TimeSpan DepreciationDate
        {
            get
            {
                TimeSpan t = new TimeSpan();
                if (Depreciation.HasValue)
                {
                    t = new TimeSpan((int)Math.Ceiling((Price / Depreciation.Value) * MonthToDay), 0, 0, 0);
                }
                return t;
            }
        }
    }
}
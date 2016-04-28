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

        [Display(Name = "Purchase Order")]
        public PurchaseOrder PurchaseOrder { get; set; }
        public decimal Price { get; set; }

        [DataType(DataType.MultilineText)]
        public string Comments { get; set; }

        [Display(Name = "Part Order")]
        public string PartNumber { get; set; }
        public string Location { get; set; }

        [Display(Name = "Inventory Status")]
        public InventoryStatus Status { get; set; }

        private decimal MonthToDay = 30.4167M;

        public decimal? DepreciationRemaining { get; set; }
        public decimal? Depreciation { get; set; }
        public TimeSpan DepreciationDate
        {
            get
            {
                TimeSpan t = new TimeSpan();
                if(Depreciation.HasValue)
                {
                    t = new TimeSpan((int)Math.Ceiling((Price / Depreciation.Value) * MonthToDay), 0,0,0);
                }
                return t;  
            }
        }
    }
}

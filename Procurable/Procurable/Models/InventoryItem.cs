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

        public PurchaseOrder PurchaseOrder { get; set; }
        public decimal Price { get; set; }

        [DataType(DataType.MultilineText)]
        public string Comments { get; set; }
        public string PartNumber { get; set; }
        public string Location { get; set; }
        

        public InventoryStatus Status { get; set; }
    }
}

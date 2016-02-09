using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Procurable.Models
{
    public class InventoryItem
    {
        public int ID { get; set; }
        public string Name { get; set; }
        public Vendor Vendor { get; set; }
        public PurchaseOrder PurchaseOrder { get; set; }
        public decimal Price { get; set; }

        public string Comments { get; set; }
        public string PartNumber { get; set; }
        public string Location { get; set; }
        public InventoryStatus Status { get; set; }
    }
}
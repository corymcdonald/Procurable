using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Procurable.Models
{
    public class PurchaseOrder
    {
        public int ID { get; set; }
        public string Name { get; set; }
        public virtual ICollection<InventoryItem> RequestedItems { get; set; }
        public Decimal Price { get; set; }
    }
}
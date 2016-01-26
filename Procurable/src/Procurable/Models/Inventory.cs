using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Procurable.Models
{
    public class Inventory
    {
        public int ID { get; set; }
        public string Location { get; set; }
        public virtual ICollection<InventoryItem> Items { get; set; }
    }
}
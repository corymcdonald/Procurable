using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Procurable.Models
{
    public class RequestedItem 
    {
        public int ID { get; set; }
        public bool InInventory { get; set; }
        public string Name { get; set; }
        public string Comments { get; set; }
        public string URL { get; set; }
        public InventoryItem Item { get; set; }
    }
}
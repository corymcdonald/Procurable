using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Procurable.Models
{
    public class InventoryItemIndex
    {
        public string Name { get; set;  }
        public List<InventoryItem> Item { get; set; }
        public int Count { get; set; }
    }
}
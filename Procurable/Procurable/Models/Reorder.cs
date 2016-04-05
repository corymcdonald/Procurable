using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Procurable.Models
{
    public class Reorder
    {
        public int ID { get; set; }
        public string Name { get; set; }

        public string InventoryItemName { get; set; }
        public int ReorderThreshold { get; set; }

        public TimeSpan? ReorderFrequency { get; set; }
        public DateTime LastOrdered { get; set; }
    }
}
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Procurable.Models
{
    public class Reorder
    {
        public int ID { get; set; }
        public string Name { get; set; }

        public string InventoryItemName { get; set; }

        [Display(Name = "Automatic Threshold to Reoder")]
        public int ReorderThreshold { get; set; }

        [Display(Name = "Quanity To Reorder")]
        public int QuanityToOrder { get; set; }

        public int? ReorderFrequencyInDays { get; set; }
        public DateTime LastOrdered { get; set; }
    }
}
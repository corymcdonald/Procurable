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

        [Display(Name = "Item Name")]
        [Required]
        public string InventoryItemName { get; set; }

        [Display(Name = "Automatic Threshold to Reorder")]
        public int? ReorderThreshold { get; set; }

        [Display(Name = "Quanity To Reorder")]
        public int QuanityToOrder { get; set; }

        [Display(Name = "Reorder frequencly")]
        public int? ReorderFrequencyInDays { get; set; }

        [Display(Name = "Last Ordered")]
        public DateTime LastOrdered { get; set; }
    }
}
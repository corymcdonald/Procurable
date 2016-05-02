using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace Procurable.Models
{
    public class RequestedItem 
    {
        public int ID { get; set; }
        
        public string Name { get; set; }
        [DataType(DataType.MultilineText)]
        public string Comments { get; set; }
        public string URL { get; set; }

        
        public int? ItemID { get; set; }
        [ForeignKey("ItemID")]
        [Display(Name = "Inventory Item")]
        public virtual InventoryItem Item { get; set; }

        public bool InInventory {
            get
            {
                return Item != null;
            }
        }
    }
}
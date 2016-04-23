using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace Procurable.Models
{
    public class InventoryItemHistory : InventoryItem
    {
        public enum Actions
        {
            Create, 
            Update,
            Delete,
        }

        public Actions Action { get; set; }

    }
}

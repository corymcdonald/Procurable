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
        public InventoryItemHistory() { }

        public int InventoryItemID { get; set; }
        public DateTime ModifiedDate { get; set; }
        public InventoryItemHistory(InventoryItem inventoryItem)
        {
            this.InventoryItemID = inventoryItem.ID;
            this.Name = inventoryItem.Name;
            this.VendorID = inventoryItem.VendorID;
            this.Vendor = inventoryItem.Vendor;
            this.PurchaseOrder = inventoryItem.PurchaseOrder;
            this.Price = inventoryItem.Price;
            this.Comments = inventoryItem.Comments;
            this.PartNumber = inventoryItem.PartNumber;
            this.Location = inventoryItem.Location;
            this.Status = inventoryItem.Status;
            this.Depreciation = inventoryItem.Depreciation;
            this.ModifiedDate = DateTime.Now;
        }

        public enum Actions
        {
            Create, 
            Update,
            Delete,
        }

        public Actions Action { get; set; }

    }
}

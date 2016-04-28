using Procurable.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;

namespace Procurable.Controllers
{
    public class ReportsController : Controller
    {

        private ApplicationDbContext db = new ApplicationDbContext();

        [Authorize]
        public ActionResult Index()
        {
            return View();
        }
    

        [Authorize]
        public ActionResult InventoryItem(int? id)
        {
            if (id == null)
            {
                var List = db.InventoryItemsHistory.GroupBy(x => new { x.Name, x.Vendor}).Select(x => x.FirstOrDefault()).ToList();
                return View("~/Views/Reports/InventoryItem/Index.cshtml", List);
            }
            var InventoryItem = db.InventoryItems.Find(id.Value);
            var inventoryCount = db.InventoryItemsHistory.Where(x => x.Name == InventoryItem.Name && x.VendorID == InventoryItem.VendorID).Select(x => new InventoryItemsReport() { Name = x.Name, Price = x.Price, LastModified = x.ModifiedDate }).OrderByDescending(x=>x.LastModified);

            //if (purchaseOrder == null)
            //{
            //    return HttpNotFound();
            //}
            return View("~/Views/Reports/InventoryItem/Details.cshtml", inventoryCount);
        }

     
    }
    public class InventoryItemsReport
    {
        public DateTime LastModified { get; internal set; }
        public string Name { get; set; }
        public decimal Price { get; set; }
    }
}
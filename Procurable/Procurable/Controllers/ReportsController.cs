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
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            var inventoryCount = db.InventoryItemsHistory.Where(x => x.InventoryItemID == id.Value).Select(x => new InventoryItemsReport() { Name = x.Name, Price = x.Price });

            //if (purchaseOrder == null)
            //{
            //    return HttpNotFound();
            //}
            return View(inventoryCount);
        }

     
    }
    public class InventoryItemsReport
    {
        public string Name { get; set; }
        public decimal Price { get; set; }
    }
}
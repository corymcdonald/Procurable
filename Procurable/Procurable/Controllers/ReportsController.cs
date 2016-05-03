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
        public ActionResult InventoryItems(int? id)
        {
            if (id == null)
            {
                var List = db.InventoryItemsHistory.GroupBy(x => new { x.Name, x.Vendor}).Select(x => x.FirstOrDefault()).ToList();
                return View("~/Views/Reports/InventoryItem/Index.cshtml", List);
            }
            var InventoryItem = db.InventoryItems.Find(id.Value);
            var inventoryCount = db.InventoryItemsHistory.Where(x => x.PartNumber == InventoryItem.PartNumber && x.Name == InventoryItem.Name).Select(x => new InventoryItemsReport() { Name = x.Name, Price = x.Price, LastModified = x.ModifiedDate }).OrderByDescending(x=>x.LastModified);
            
            return View("~/Views/Reports/InventoryItem/Details.cshtml", inventoryCount);
        }

        [Authorize]
        public ActionResult Depreciation(int? id)
        {

            if (id == null)
            {
                var inventoryCount = db.InventoryItems.Where(x => x.Depreciation.HasValue);
                return View("~/Views/Reports/Depreciation/Index.cshtml", inventoryCount);
            }
            List<DeperciationReport> dep = new List<DeperciationReport>();
            var InventoryItem = db.InventoryItems.Find(id.Value);
            DateTime d = DateTime.Now.AddMonths(-6);
            if (InventoryItem.CreatedDate.HasValue)
                d = InventoryItem.CreatedDate.Value;

            ViewData["inventoryItem"] = InventoryItem;
            decimal currentPrice = InventoryItem.Price;
            while(d < DateTime.Now)
            {
                dep.Add(new DeperciationReport() {Date=d.Date, Price= currentPrice});
                currentPrice -= InventoryItem.Depreciation ?? 0;
                d= d.AddMonths(1);
            }

            return View("~/Views/Reports/Depreciation/Details.cshtml", dep);
        }

        

    }
    public class DeperciationReport
    {
        public decimal Price { get; set; }
        public DateTime Date { get; set; }
    }

    public class InventoryItemsReport
    {
        public DateTime LastModified { get; internal set; }
        public string Name { get; set; }
        public decimal Price { get; set; }
    }
}
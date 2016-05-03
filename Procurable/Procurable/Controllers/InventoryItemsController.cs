using Newtonsoft.Json;
using Procurable.Controllers;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;

namespace Procurable.Models
{
    public class InventoryItemsController : Controller
    {
        private ApplicationDbContext db = new ApplicationDbContext();

        // GET: InventoryItems
        [Authorize]
        public ActionResult Index()
        {
            var inventoryCount = db.InventoryItems.ToList().GroupBy(x => new { x.Name }).Select(group => new InventoryItemIndex() { Name=group.Key.Name, Item = group.ToList<InventoryItem>(), Count = group.Count() }).ToList();
            if (Request.AcceptTypes.Contains("application/json"))
            {
                return Json(inventoryCount, JsonRequestBehavior.AllowGet);
            }
            return View(inventoryCount);
        }

        [Authorize]
        public ActionResult GetInventoryItems()
        {
            return Json(db.InventoryItems.ToList(), JsonRequestBehavior.AllowGet);
        }

        [Authorize]
        public ActionResult GetInventoryItemsDepreciation()
        {
            var list = JsonConvert.SerializeObject(db.InventoryItems.Where(x => x.Depreciation.HasValue).ToList(),
                Formatting.None,
                new JsonSerializerSettings()
                {
                    ReferenceLoopHandling = Newtonsoft.Json.ReferenceLoopHandling.Ignore
                });
            return Content(list, "application/json");

        }


        // GET: InventoryItems/Details/5
        [Authorize]
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                if (Request.AcceptTypes.Contains("application/json"))
                {
                    return Json(new { Error = "BadRequest" }, JsonRequestBehavior.AllowGet);
                }
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            InventoryItem inventoryItem = db.InventoryItems.Find(id);
            if (inventoryItem == null)
            {
                if (Request.AcceptTypes.Contains("application/json"))
                {
                    return Json(new { Error = "NotFound" }, JsonRequestBehavior.AllowGet);
                }
                return HttpNotFound();
            }
            if (Request.AcceptTypes.Contains("application/json"))
            {
                return Json(inventoryItem, JsonRequestBehavior.AllowGet);
            }
            ViewData["IsReportAvailable"] = db.InventoryItemsHistory.Count(x => x.InventorySourceID == id.Value) > 0;
            return View(inventoryItem);
        }

        // GET: InventoryItems/Create
        [Authorize]
        public ActionResult Create()
        {
            return View();
        }

        // POST: InventoryItems/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [Authorize]
        public ActionResult Create([Bind(Include = "ID,Name,Price,Comments,PartNumber,Location,Status, VendorID")] InventoryItem inventoryItem)
        {
            if (ModelState.IsValid)
            {
                inventoryItem.DepreciationRemaining = inventoryItem.Price;
                inventoryItem.CreatedDate = DateTime.Now;
                db.InventoryItems.Add(inventoryItem);
                db.SaveChanges();
                if (Request.AcceptTypes.Contains("application/json"))
                {
                    return Json(new { Succeeded = true });
                }
                return RedirectToAction("Index");
            }

            return View(inventoryItem);
        }

        // GET: InventoryItems/Edit/5
        [Authorize]
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            InventoryItem inventoryItem = db.InventoryItems.Find(id);
            if (inventoryItem == null)
            {
                return HttpNotFound();
            }
            return View(inventoryItem);
        }

        // POST: InventoryItems/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [Authorize]
        public ActionResult Edit([Bind(Include = "ID,Name,Price,Comments,PartNumber,Location,Status,VendorID,Depreciation")] InventoryItem inventoryItem)
        {
            if (ModelState.IsValid)
            {
                var existingItem  = db.InventoryItems.AsNoTracking().FirstOrDefault(x => x.ID == inventoryItem.ID);
                inventoryItem.DepreciationRemaining = existingItem.DepreciationRemaining;
                inventoryItem.PurchaseOrderID = existingItem.PurchaseOrderID;
                if(!existingItem.Depreciation.HasValue)
                {
                    inventoryItem.DepreciationRemaining = inventoryItem.Price;
                }

                var itemHistory = new InventoryItemHistory(db.InventoryItems.AsNoTracking().FirstOrDefault(x=> x.ID==inventoryItem.ID)) { Action = InventoryItemHistory.Actions.Update };
                db.InventoryItemsHistory.Add(itemHistory);

                db.Entry(inventoryItem).State = EntityState.Modified;
                db.SaveChanges();
                if (Request.AcceptTypes.Contains("application/json"))
                {
                    return Json(new { Succeeded = true });
                }
                return RedirectToAction("Index");
            }
            return View(inventoryItem);
        }

        // GET: InventoryItems/Delete/5
        [Authorize]
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            InventoryItem inventoryItem = db.InventoryItems.Find(id);
            if (inventoryItem == null)
            {
                return HttpNotFound();
            }
            return View(inventoryItem);
        }

        // POST: InventoryItems/Delete/5
        [HttpPost, ActionName("Delete")]
        [Authorize]
        public ActionResult DeleteConfirmed(int id)
        {
            InventoryItem inventoryItem = db.InventoryItems.Find(id);
            db.InventoryItemsHistory.Add(new InventoryItemHistory(inventoryItem) { Action = InventoryItemHistory.Actions.Delete });
            db.InventoryItems.Remove(inventoryItem);
            db.SaveChanges();
            if (Request.AcceptTypes.Contains("application/json"))
            {
                return Json(new { Succeeded = true });
            }
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        public List<InventoryItem> SearchForRequest(string query)
        {            
            var asResult = new List<InventoryItem>();
            if (!String.IsNullOrEmpty(query))
            {
                query = query.ToUpper().Trim();
                var temp = from a in db.InventoryItems
                           where (a.Name.Trim().ToUpper().Contains(query)
                           || a.PartNumber.Trim().ToUpper().Contains(query)
                           || a.Vendor.Name.Trim().ToUpper().Contains(query)
                           || a.Location.Trim().ToUpper().Contains(query))
                           && a.Status == InventoryStatus.Unallocated
                           select a;
               
                asResult = temp.ToList();
            }
            return asResult;
        }
        public List<InventoryItemIndex> SearchInternal(string query)
        {
            var asResult = new List<InventoryItemIndex>();
            if (!string.IsNullOrEmpty(query))
            {
            query = query.ToUpper().Trim();
                var temp = from a in db.InventoryItems
                           where a.Name.Trim().ToUpper().Contains(query) 
                           || a.PartNumber.Trim().ToUpper().Contains(query)
                           || a.Vendor.Name.Trim().ToUpper().Contains(query)                           
                           || a.Location.Trim().ToUpper().Contains(query)
                           select a;

                asResult = temp.ToList().GroupBy(x => new { x.Name }).Select(group => new InventoryItemIndex() { Name = group.Key.Name, Item = group.ToList<InventoryItem>(), Count = group.Count() }).ToList(); ;
            }
            return asResult;
        }
        public ActionResult Search(string query)
        {
            if (Request.AcceptTypes.Contains("application/json"))
                return Json(SearchInternal(query), JsonRequestBehavior.AllowGet);
            return PartialView("Search", SearchInternal(query));
        }

        public ActionResult RequestSearch(string query)
        {

            if (Request.AcceptTypes.Contains("application/json"))
            {
                var list = JsonConvert.SerializeObject(SearchForRequest(query),
                Formatting.None,
                new JsonSerializerSettings()
                {
                    ReferenceLoopHandling = Newtonsoft.Json.ReferenceLoopHandling.Ignore
                });
                return Content(list, "application/json");

            }
            return PartialView("RequestSearch", SearchForRequest(query));
        }
    }
}

using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using Procurable.Models;

namespace Procurable.Controllers
{
    public class RequestedItemsController : Controller
    {
        private ApplicationDbContext db = new ApplicationDbContext();

        // GET: RequestedItems
        [Authorize]
        public ActionResult Index()
        {
            if (Request.AcceptTypes.Contains("application/json"))
            {
                return Json(db.RequestedItems.ToList(), JsonRequestBehavior.AllowGet);
            }
            return View(db.RequestedItems.ToList());
        }

        // GET: RequestedItems/Details/5
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
            RequestedItem requestedItem = db.RequestedItems.Find(id);
            if (requestedItem == null)
            {
                if (Request.AcceptTypes.Contains("application/json"))
                {
                    return Json(new { Error = "NotFound" }, JsonRequestBehavior.AllowGet);
                }
                return HttpNotFound();
            }
            if (Request.AcceptTypes.Contains("application/json"))
            {
                return Json(requestedItem, JsonRequestBehavior.AllowGet);
            }
            return View(requestedItem);
        }

        // GET: RequestedItems/Create
        [Authorize]
        public ActionResult Create()
        {
            return View();
        }

        // POST: RequestedItems/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [Authorize]
        public ActionResult Create([Bind(Include = "ID,InInventory,Name,Comments,URL")] RequestedItem requestedItem)
        {
            if (ModelState.IsValid)
            {
                db.RequestedItems.Add(requestedItem);
                db.SaveChanges();
                if (Request.AcceptTypes.Contains("application/json"))
                {
                    return Json(new { Succeeded = true });
                }
                return RedirectToAction("Index");
            }

            return View(requestedItem);
        }

        // GET: RequestedItems/Edit/5
        [Authorize]
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            RequestedItem requestedItem = db.RequestedItems.Find(id);
            if (requestedItem == null)
            {
                return HttpNotFound();
            }
            return View(requestedItem);
        }

        // POST: RequestedItems/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [Authorize]
        public ActionResult Edit([Bind(Include = "ID,InInventory,Name,Comments,URL")] RequestedItem requestedItem)
        {
            if (ModelState.IsValid)
            {
                db.Entry(requestedItem).State = EntityState.Modified;
                db.SaveChanges();
                if (Request.AcceptTypes.Contains("application/json"))
                {
                    return Json(new { Succeeded = true });
                }
                return RedirectToAction("Index");
            }
            return View(requestedItem);
        }

        // GET: RequestedItems/Delete/5
        [Authorize]
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            RequestedItem requestedItem = db.RequestedItems.Find(id);
            if (requestedItem == null)
            {
                return HttpNotFound();
            }
            return View(requestedItem);
        }

        // POST: RequestedItems/Delete/5
        [HttpPost, ActionName("Delete")]
        [Authorize]
        public ActionResult DeleteConfirmed(int id)
        {
            RequestedItem requestedItem = db.RequestedItems.Find(id);
            db.RequestedItems.Remove(requestedItem);
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
    }
}

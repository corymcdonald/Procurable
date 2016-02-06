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
        public ActionResult Index()
        {
            return View(db.RequestedItems.ToList());
        }

        // GET: RequestedItems/Details/5
        public ActionResult Details(int? id)
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

        // GET: RequestedItems/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: RequestedItems/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "ID,InInventory,Name,Comments,URL")] RequestedItem requestedItem)
        {
            if (ModelState.IsValid)
            {
                db.RequestedItems.Add(requestedItem);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(requestedItem);
        }

        // GET: RequestedItems/Edit/5
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
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "ID,InInventory,Name,Comments,URL")] RequestedItem requestedItem)
        {
            if (ModelState.IsValid)
            {
                db.Entry(requestedItem).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(requestedItem);
        }

        // GET: RequestedItems/Delete/5
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
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            RequestedItem requestedItem = db.RequestedItems.Find(id);
            db.RequestedItems.Remove(requestedItem);
            db.SaveChanges();
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

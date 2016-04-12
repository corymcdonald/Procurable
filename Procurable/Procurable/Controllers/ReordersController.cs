using System;

using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using Procurable.Models;
using System.Data.SqlTypes;

namespace Procurable
{
    public class ReordersController : Controller
    {
        private ApplicationDbContext db = new ApplicationDbContext();

        // GET: Reorders
        public ActionResult Index()
        {
            return View(db.Reorders.ToList());
        }

        // GET: Reorders/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Reorder reorder = db.Reorders.Find(id);
            if (reorder == null)
            {
                return HttpNotFound();
            }
            return View(reorder);
        }

        // GET: Reorders/Create
        public ActionResult Create()
        {
            return View();
        }

        public ActionResult CreateEdit(string InventoryItemName)
        {
            var Found = db.Reorders.FirstOrDefault(x => x.InventoryItemName.Equals(InventoryItemName));
            if (String.IsNullOrEmpty(InventoryItemName) || Found == null)
            {
                return View("Create");
            }
            else
                return View("Edit", Found);
        }


        [HttpPost]
        public ActionResult CreateEdit([Bind(Include = "ID,Name,InventoryItemName,ReorderThreshold,ReorderFrequencyInDays,QuanityToOrder,LastOrdered")] Reorder reorder)
        {
            if (ModelState.IsValid)
            {
                if (reorder.LastOrdered == DateTime.MinValue)
                    reorder.LastOrdered = SqlDateTime.MinValue.Value;
                if (reorder.ID == 0)
                {
                    db.Reorders.Add(reorder);
                }
                else {
                    db.Entry(reorder).State = EntityState.Modified;
                }
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View("Details", reorder);
        }
        // POST: Reorders/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "ID,Name,InventoryItemName,ReorderThreshold,ReorderFrequencyInDays,,QuanityToOrder,LastOrdered")] Reorder reorder)
        {
            return CreateEdit(reorder);
        }

        // GET: Reorders/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Reorder reorder = db.Reorders.Find(id);
            if (reorder == null)
            {
                return HttpNotFound();
            }
            return View(reorder);
        }

        // POST: Reorders/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "ID,Name,InventoryItemName,ReorderThreshold,ReorderFrequencyInDays,QuanityToOrder,LastOrdered")] Reorder reorder)
        {
            return CreateEdit(reorder);
        }

        // GET: Reorders/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Reorder reorder = db.Reorders.Find(id);
            if (reorder == null)
            {
                return HttpNotFound();
            }
            return View(reorder);
        }

        // POST: Reorders/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Reorder reorder = db.Reorders.Find(id);
            db.Reorders.Remove(reorder);
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

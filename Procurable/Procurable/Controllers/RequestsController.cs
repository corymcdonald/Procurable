using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using Procurable.Models;
using Microsoft.AspNet.Identity.Owin;
using Microsoft.AspNet.Identity;

namespace Procurable.Controllers
{
    public class RequestsController : Controller
    {
        private ApplicationDbContext db = new ApplicationDbContext();
         

        // GET: My Requests
        [Authorize]
        public ActionResult Index()
        {  
            var uId = User.Identity.GetUserId();
          
            if (Request.AcceptTypes.Contains("application/json"))
            {
                return Json(db.Requests.Where(x => x.RequestedBy.Id.Equals(uId)).ToList(), JsonRequestBehavior.AllowGet);
            }
            return View(db.Requests.Where(x => x.RequestedBy.Id.Equals(uId)).ToList());
        }

        // GET: Requests for Approval
        [Authorize(Roles = "Admin, Reviewer")]
        public ActionResult Approve()
        {
          //MAKE BY DEPARTMENT
            if (Request.AcceptTypes.Contains("application/json"))
            {
                return Json(db.Requests.ToList(), JsonRequestBehavior.AllowGet);
            }
            return View(db.Requests.ToList());
        }

        // GET: Requests/Details/5
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
            Request request = db.Requests.Find(id);
            if (request == null)
            {
                if (Request.AcceptTypes.Contains("application/json"))
                {
                    return Json(new { Error = "NotFound" }, JsonRequestBehavior.AllowGet);
                }
                return HttpNotFound();
            }
            if (Request.AcceptTypes.Contains("application/json"))
            {
                return Json(request, JsonRequestBehavior.AllowGet);
            }
            return View(request);
        }

        // GET: Requests/Create
        [Authorize]
        public ActionResult Create()
        {
            ViewBag.users = new SelectList(db.Users.ToList(), "users", "users");
            return View();
        }

        // POST: Requests/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [Authorize]
        public ActionResult Create([Bind(Include = "ID,Name,Comments,UserID")] Request request)
        {
            if (ModelState.IsValid)
            {
                request.CreatedDate = DateTime.Now;
                request.LastModified = DateTime.Now;
                               
                
                ApplicationUser currentUser = db.Users.Find(User.Identity.GetUserId());
                request.RequestedBy = currentUser;
          
                //System.Diagnostics.Debug.WriteLine(currentUser);
                

                db.Requests.Add(request);
                db.SaveChanges();
                if (Request.AcceptTypes.Contains("application/json"))
                {
                    return Json(new { Succeeded = true });
                }
                return RedirectToAction("Index");
            }

            return View(request);
        }

        // GET: Requests/Edit/5
        [Authorize]
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Request request = db.Requests.Find(id);
            if (request == null)
            {
                return HttpNotFound();
            }
            return View(request);
        }

        // POST: Requests/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [Authorize]
        public ActionResult Edit([Bind(Include = "ID,Name,Comments")] Request request)
        {
            if (ModelState.IsValid)
            {

                var dbPost = db.Requests.FirstOrDefault(p => p.ID == request.ID);
                if (dbPost == null)
                {
                    return HttpNotFound();
                }

                dbPost.Name = request.Name;
                dbPost.Comments = request.Comments;
         
                dbPost.LastModified = DateTime.Now;
                
                db.SaveChanges();
                if (Request.AcceptTypes.Contains("application/json"))
                {
                    return Json(new { Succeeded = true });
                }
                return RedirectToAction("Index");
            }
            return View(request);
        }

        // GET: Requests/Delete/5
        [Authorize]
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Request request = db.Requests.Find(id);
            if (request == null)
            {
                return HttpNotFound();
            }
            return View(request);
        }

        // POST: Requests/Delete/5
        [HttpPost, ActionName("Delete")]
        [Authorize]
        public ActionResult DeleteConfirmed(int id)
        {
            Request request = db.Requests.Find(id);
            db.Requests.Remove(request);
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

        // POST: Requests/UpdateStatus/5
        [HttpPost]
        [Authorize]
        public void UpdateStatus(int id)
        {

            //TODO: check to see if they are in that department


        }
    }
}

using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using Procurable.Models;
using Microsoft.AspNet.Identity;
using System.Data.SqlTypes;

namespace Procurable.Controllers
{
    public class ProjectsController : Controller
    {
        private ApplicationDbContext db = new ApplicationDbContext();

        // GET: Projects
        [Authorize]
        public ActionResult Index()
        {
            if (Request.AcceptTypes.Contains("application/json"))
            {
                return Json(db.Projects.ToList(), JsonRequestBehavior.AllowGet);
            }
            return View(db.Projects.ToList());
        }

        // GET: Projects/Details/5
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
            Project project = db.Projects.Find(id);
            if (project == null)
            {
                if (Request.AcceptTypes.Contains("application/json"))
                {
                    return Json(new { Error = "NotFound" }, JsonRequestBehavior.AllowGet);
                }
                return HttpNotFound();
            }
            if (Request.AcceptTypes.Contains("application/json"))
            {
                return Json(project, JsonRequestBehavior.AllowGet);
            }
            ViewData["Tasks"] = db.ProjectTasks.Where(x => x.ProjectID == id.Value);
            return View(project);
        }

        // GET: Projects/Create
        [Authorize]
        public ActionResult Create(string RequestID="")
        {
            Project p = new Project();
            int ParsedID = 0;

            if (!String.IsNullOrEmpty(RequestID) && Int32.TryParse(RequestID, out ParsedID))
            {
                p.Request = db.Requests.Find(ParsedID);
            }
            return View(p);
        }

        // POST: Projects/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [Authorize]
        public ActionResult Create([Bind(Include = "ProjectID,Priority, RequestID,Status,CreatedDate,DateNeeded,UserID, Comments")] Project project)
        {
            if (ModelState.IsValid && !String.IsNullOrEmpty(Request.Form["UserID"]))
            {
                project.LastModified = DateTime.Now;
                project.CreatedDate = DateTime.Now;
                project.CreatedBy = db.Users.Find(User.Identity.GetUserId());
                if (project.Status == ProjectStatus.Completed)
                    project.CompletedDate = DateTime.Now;
                if (project.DateNeeded < SqlDateTime.MinValue.Value)
                    project.DateNeeded = SqlDateTime.MinValue.Value;
                
                project.AssignedToID = db.Users.Find(Request.Form["UserID"]).Id;
                db.Projects.Add(project);
                db.SaveChanges();
                if (Request.AcceptTypes.Contains("application/json"))
                {
                    return Json(new { Succeeded = true }, JsonRequestBehavior.AllowGet);
                }
                return RedirectToAction("Index");
            }

            return View(project);
        }

        // GET: Projects/Edit/5
        [Authorize]
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
             
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Project project = db.Projects.Find(id);
            if (project == null)
            {
               
                return HttpNotFound();
            }
            return View(project);
        }

        // POST: Projects/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [Authorize]
        public ActionResult Edit([Bind(Include = "ProjectID,Priority,Status, DateNeeded, Comments")] Project project)
        {
            if (ModelState.IsValid)
            {
                string SentUserID = Request.Form["UserID"];
                var currentTask = db.Projects.AsNoTracking().FirstOrDefault(x => x.ProjectID == project.ProjectID);
                project.RequestID = currentTask.RequestID;
                project.Request = currentTask.Request;
                project.CreatedDate = currentTask.CreatedDate;
                project.CreatedByID = currentTask.CreatedBy.Id;

                project.AssignedToID = db.Users.AsNoTracking().FirstOrDefault(x=> x.Id == SentUserID).Id;

                project.LastModified = DateTime.Now;
                if (project.Status == ProjectStatus.Completed && currentTask.Status != ProjectStatus.Completed)
                    project.CompletedDate = DateTime.Now;

                db.Entry(project).State = EntityState.Modified;
                db.SaveChanges();
                if (Request.AcceptTypes.Contains("application/json"))
                {
                    return Json(new { Succeeded = true });
                }
                return RedirectToAction("Index");
            }
            return View(project);
        }

        // GET: Projects/Delete/5
        [Authorize]
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
               
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Project project = db.Projects.Find(id);
            if (project == null)
            {
                
                return HttpNotFound();
            }
            return View(project);
        }

        // POST: Projects/Delete/5
        [HttpPost, ActionName("Delete")]
        [Authorize]
        public ActionResult DeleteConfirmed(int id)
        {
            Project project = db.Projects.Find(id);
            db.Projects.Remove(project);
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

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
using Microsoft.AspNet.Identity;

namespace Procurable.Controllers
{
    public class ProjectTasksController : Controller
    {
        private ApplicationDbContext db = new ApplicationDbContext();

        // GET: ProjectTasks
        [Authorize]
        public ActionResult Index()
        {
            if (Request.AcceptTypes.Contains("application/json"))
            {
                return Json(db.ProjectTasks.ToList(), JsonRequestBehavior.AllowGet);
            }
            return View(db.ProjectTasks.ToList());
        }

        // GET: ProjectTasks/Details/5
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
            ProjectTask projectTask = db.ProjectTasks.Find(id);
            if (projectTask == null)
            {
                if (Request.AcceptTypes.Contains("application/json"))
                {
                    return Json(new { Error = "NotFound" }, JsonRequestBehavior.AllowGet);
                }
                return HttpNotFound();
            }
            if (Request.AcceptTypes.Contains("application/json"))
            {
                return Json(projectTask, JsonRequestBehavior.AllowGet);
            }
            return View(projectTask);
        }

        // GET: ProjectTasks/Create
        [Authorize]
        public ActionResult Create(string projectID ="")
        {
            ProjectTask p = new ProjectTask();
            p.DateNeeded = DateTime.Now.AddDays(7);
            int pID;
            if(Int32.TryParse(projectID, out pID))
            {
                p.ProjectID = pID;
            }
            return View(p);
        }

        // POST: ProjectTasks/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [Authorize]
        public ActionResult Create([Bind(Include = "ID,ProjectID,Comments,DateNeeded,Comments,Name,Status")] ProjectTask projectTask)
        {
            if (ModelState.IsValid)
            {
                projectTask.LastModified = DateTime.Now;
                projectTask.CreatedDate = DateTime.Now;
                projectTask.CreatedBy = db.Users.Find(User.Identity.GetUserId());

                if (projectTask.DateNeeded < SqlDateTime.MinValue.Value)
                    projectTask.DateNeeded = SqlDateTime.MinValue.Value;

                projectTask.AssignedToID = db.Users.Find(Request.Form["UserID"]).Id;
                db.ProjectTasks.Add(projectTask);
                db.SaveChanges();
                if (Request.AcceptTypes.Contains("application/json"))
                {
                    return Json(new { Succeeded = true });
                }
                return RedirectToAction("Index");
            }

            return View(projectTask);
        }

        // GET: ProjectTasks/Edit/5
        [Authorize]
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            ProjectTask projectTask = db.ProjectTasks.Find(id);
            if (projectTask == null)
            {
                return HttpNotFound();
            }
            return View(projectTask);
        }

        // POST: ProjectTasks/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [Authorize]
        public ActionResult Edit([Bind(Include = "ID,ProjectID,Comments,DateNeeded,Comments,Name,Status")] ProjectTask projectTask)
        {
            if (ModelState.IsValid)
            {
                string SentUserID = Request.Form["UserID"];
                var oldProject = db.ProjectTasks.AsNoTracking().FirstOrDefault(x => x.ID == projectTask.ID);

                projectTask.CreatedDate = oldProject.CreatedDate;
                projectTask.LastModified = DateTime.Now;
                projectTask.CreatedByID = oldProject.CreatedBy.Id;
                projectTask.AssignedToID = db.Users.AsNoTracking().FirstOrDefault(x => x.Id == SentUserID).Id;
                db.Entry(projectTask).State = EntityState.Modified;
                db.SaveChanges();

                if (Request.AcceptTypes.Contains("application/json"))
                {
                    return Json(new { Succeeded = true });
                }
                return RedirectToAction("Index");
            }
            return View(projectTask);
        }

        // GET: ProjectTasks/Delete/5
        [Authorize]
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            ProjectTask projectTask = db.ProjectTasks.Find(id);
            if (projectTask == null)
            {
                return HttpNotFound();
            }
            return View(projectTask);
        }

        // POST: ProjectTasks/Delete/5
        [HttpPost, ActionName("Delete")]
        [Authorize]
        public ActionResult DeleteConfirmed(int id)
        {
            ProjectTask projectTask = db.ProjectTasks.Find(id);
            db.ProjectTasks.Remove(projectTask);
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

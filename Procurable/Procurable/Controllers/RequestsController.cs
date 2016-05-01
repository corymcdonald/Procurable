using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Web.Mvc;
using Procurable.Models;
using Microsoft.AspNet.Identity;
using System.Web.Script.Serialization;
using Newtonsoft.Json;

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
            ApplicationUser currentUser = db.Users.Find(User.Identity.GetUserId());
            System.Diagnostics.Debug.WriteLine(currentUser);
            if (User.IsInRole("Admin") || User.IsInRole("Reviewer"))
            {
                ViewData["powerUser"] = true;
                
            }
            else
            {
                ViewData["powerUser"] = false;
            }
            
            return View(db.Requests.Where(x => x.RequestedBy.Id.Equals(uId)).ToList());
        }

        [Authorize]
        public ActionResult All()
        {

            if (Request.AcceptTypes.Contains("application/json"))
            {
                return Json(db.Requests.ToList(), JsonRequestBehavior.AllowGet);
            }
            ApplicationUser currentUser = db.Users.Find(User.Identity.GetUserId());
            if (User.IsInRole("Admin") || User.IsInRole("Reviewer"))
                ViewData["powerUser"] = true;
            else
                ViewData["powerUser"] = false;
            return View("Index", db.Requests.ToList());
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
            return PartialView(db.Requests.ToList());
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
            
            List<RequestedItem> requestedItems = new List<RequestedItem>();

            if (ModelState.IsValid)
            {
                if (Request.AcceptTypes.Contains("application/json"))
                {
                    request.CreatedDate = DateTime.Now;
                    request.LastModified = DateTime.Now;
                    
                    ApplicationUser currentUser = db.Users.Find(User.Identity.GetUserId());
                    request.RequestedBy = currentUser;

                    Request.InputStream.Position = 0;
                    System.IO.StreamReader str = new System.IO.StreamReader(Request.InputStream);
                    string rawBody = str.ReadToEnd();
                    JavaScriptSerializer serializer = new JavaScriptSerializer();
                    var InventoryItemsJSON = serializer.Deserialize<Dictionary<string, dynamic>>(rawBody);
                    foreach (var item in InventoryItemsJSON["Items"])
                    {
                        var requestedItem = new RequestedItem()
                        {
                            Name = item["Name"],
                            Comments = item["Comments"],
                            URL = item["Url"],
                        };
                        List<InventoryItem> results = new InventoryItemsController().SearchInternal(item["Name"]);
                        if (results.Any())
                        {
                            foreach(var invenItem in results)
                            {
                                if(invenItem.Status == InventoryStatus.Unallocated)
                                {
                                    requestedItem.ItemID = invenItem.ID;
                                    break;
                                }
                            }
                        }
                        
                        db.RequestedItems.Add(requestedItem);
                        db.SaveChanges();
                        requestedItems.Add(requestedItem);
                    }
                    
                    request.Items = requestedItems;
                    db.Requests.Add(request);
                    db.SaveChanges();
                
                    return RedirectToAction("Index");
                                    
                }
                else
                {
                    request.CreatedDate = DateTime.Now;
                    request.LastModified = DateTime.Now;

                    ApplicationUser currentUser = db.Users.Find(User.Identity.GetUserId());
                    request.RequestedBy = currentUser;
                    //System.Diagnostics.Debug.WriteLine(currentUser);

                    dynamic RequestItemsJSON= JsonConvert.DeserializeObject(Request.Form.Get("RequestItems"));
                 

                    if (RequestItemsJSON != null)
                    {
                        foreach (var item in RequestItemsJSON)
                        {
                            if (!String.IsNullOrEmpty(item["Name"].ToString()))
                            {
                                
                                var requestedItem = new RequestedItem()
                                {
                                    Name = item["Name"],
                                    Comments = item["Comments"],
                                    URL = item["URL"],
                                };

                                List<InventoryItem> results = new InventoryItemsController().SearchInternal(item["Name"].ToString());
                                if (results.Any())
                                {
                                    foreach (var invenItem in results)
                                    {
                                        if (invenItem.Status == InventoryStatus.Unallocated)
                                        {
                                            requestedItem.ItemID = invenItem.ID;
                                            break;
                                        }
                                    }
                                }

                                db.RequestedItems.Add(requestedItem);
                                db.SaveChanges();
                                requestedItems.Add(requestedItem);
                            }
                        }
                    }
                    request.Items = requestedItems;

                    db.Requests.Add(request);
                    db.SaveChanges();
                    if (Request.AcceptTypes.Contains("application/json"))
                    {
                        return Json(new { Succeeded = true });
                    }
                    return RedirectToAction("Index");
                }
                
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
        public void UpdateStatus(int id, RequestStatus status)
        {

            //TODO: check to see if they are in that department
            var dbPost = db.Requests.FirstOrDefault(p => p.ID == id);

            dbPost.Status = status;
   
            dbPost.LastModified = DateTime.Now;

            db.SaveChanges();
            
        }
    }
}

using Procurable.Models;
using RestSharp;
using RestSharp.Authenticators;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Text;
using System.Threading.Tasks;
using System.Net.Http;
using System.Net.Mail;
using Newtonsoft.Json;
using System.Net.Mime;
using System.Data.SqlTypes;

namespace ProcurableService
{
    class Program
    {
        static void Main(string[] args)
        {
            string APIKey = Environment.GetEnvironmentVariable("SendGridAPI", EnvironmentVariableTarget.User);

            string URL = "http://procurable.azurewebsites.net/";
            URL = "http://localhost:55504/";
            var client = new RestClient(URL);


            client.Authenticator = new HttpBasicAuthenticator("admin@test.com", "password");

            var request = new RestRequest("Reorders/Index", Method.POST);
            var adminUsers = new RestRequest("Account/GetAdministrators", Method.POST);
            var inventoryItemsRequest = new RestRequest("InventoryItems/Index", Method.POST);
            var depreciationRequest = new RestRequest("InventoryItems/GetInventoryItemsDepreciation", Method.POST);

            var loginRequest = new RestRequest("Account/Login", Method.POST);

            loginRequest.AddHeader("AcceptType", "application/json");
            request.AddHeader("AcceptType", "application/json");
            inventoryItemsRequest.AddHeader("AcceptType", "application/json");
            depreciationRequest.AddHeader("AcceptType", "application/json");


            loginRequest.AddParameter("Email", "admin@test.com");
            loginRequest.AddParameter("Password", "password");
            var loginResponse = client.Execute(loginRequest);
            var Cookie = loginResponse.Cookies.FirstOrDefault(x => x.Name.Contains("ApplicationCookie"));


            request.AddCookie(Cookie.Name, Cookie.Value);
            inventoryItemsRequest.AddCookie(Cookie.Name, Cookie.Value);
            adminUsers.AddCookie(Cookie.Name, Cookie.Value);
            depreciationRequest.AddCookie(Cookie.Name, Cookie.Value);

            var reorderResponse = client.Execute<List<Reorder>>(request);
            var inventoryItemResponse = client.Execute<List<InventoryItemIndex>>(inventoryItemsRequest);
            var depreciationRequestResponse = client.Execute<List<Class1>>(depreciationRequest);
            dynamic adminResponse = JsonConvert.DeserializeObject(client.Execute(adminUsers).Content);


            //ProcessReorders(APIKey, URL, reorderResponse, inventoryItemResponse, adminResponse);




        }

        private static void ProcessReorders(string APIKey, string URL, IRestResponse<List<Reorder>> reorderResponse, IRestResponse<List<InventoryItemIndex>> inventoryItemResponse, dynamic adminResponse)
        {
            foreach (Reorder entry in reorderResponse.Data)
            {
                bool Frequency = false;
                bool Stock = false;
                int Count = 0;
                if (entry.ReorderFrequencyInDays != null && entry.ReorderFrequencyInDays > 0)
                {
                    var Result = entry.LastOrdered.AddDays(entry.ReorderFrequencyInDays.Value);
                    if (DateTime.Now > Result)
                    {

                        Frequency = true;
                    }
                }
                if (entry.ReorderThreshold.HasValue)
                {
                    var Items = inventoryItemResponse.Data.FirstOrDefault(x => x.Name == entry.InventoryItemName);
                    if (Items == null)
                    {
                        //Send an email to notify the following item doesn't have an inventory item associated with it 
                    }
                    else if ((Count = Items.Item.Where(x => x.Status == InventoryStatus.Unallocated).Count()) <= entry.ReorderThreshold) //We need to handle 0s
                    {
                        Stock = true;
                    }
                }
                if (Stock || Frequency)
                {

                    string Reason = "";
                    if (Frequency)
                    {
                        string Days = (entry.LastOrdered.Date == SqlDateTime.MinValue.Value.Date) ? "has not been reordered before. " : "been " + (DateTime.Now - entry.LastOrdered).Days.ToString() + " days since the last order.";
                        Reason += entry.InventoryItemName + " is to be ordered every " + entry.ReorderFrequencyInDays + " days. It has  " + Days + "<br/>";
                    }
                    if (Stock)
                    {
                        Reason += String.Format("{0} has only {1} unallocated items. This is less than or equal to the threshold of {2} to be in stock at all times.", entry.InventoryItemName, Count, entry.ReorderThreshold);
                    }

                    var myMessage = new SendGrid.SendGridMessage();

                    //todo figure out if we need to email or contact the vendor about this. But for now just email the administrators
                    foreach (var User in adminResponse)
                    {
                        if (!User.Email.ToString().Contains("test.com"))
                        {
                            myMessage.AddTo(User.Email.ToString());
                        }
                    }

                    myMessage.From = new MailAddress("Admin@Procurable.com", "Administrator");
                    myMessage.Subject = "[Procurable] Time to reorder " + entry.InventoryItemName;

                    myMessage.Html = string.Format(@"<!doctype html><html><head></head><body>
                                
                                <table width = ""100%"" style = "" border-collapse: collapse;"">
                                  <tr bgcolor = ""#121314"">
                                    <td width = ""5%""></td>
                                    <td width = ""95%""><h2 style = ""color:#F44336; font-family: Arial""> Procurable </h2></td>
                                  </tr>
                                  <td style = ""line-height:10px;"" colspan = 3> &nbsp;</td>
                                         <tr>
                                           <td  width = ""5%""></td>
                                            <td width = ""95%"" style = ""font-family:Arial;"">
                                                Howdy! This is an automated email from Procurable.<br />
                                                We've determined that {0} needs to be reordered according to the rules you've set into place. <br />
                                                <br />
                                                The following actions triggered this alert: <br />
                                                {1}
                                    </td>
                                  </tr>
                                </table>
                                </body>
                                </html>",
                                @"<a style=""color:#337ab7;"" href=""" + URL + @"/Reorders/Details/" + entry.ID + @""">" + entry.InventoryItemName + "</a>",
                                Reason);



                    var transportWeb = new SendGrid.Web(APIKey);
                    transportWeb.DeliverAsync(myMessage).Wait();
                }
            }
        }
    }


    public class Class1
    {
        public Purchaseorder PurchaseOrder { get; set; }
        public Vendor Vendor { get; set; }
        public int ID { get; set; }
        public string Name { get; set; }
        public int VendorID { get; set; }
        public int PurchaseOrderID { get; set; }
        public float Price { get; set; }
        public string Comments { get; set; }
        public string PartNumber { get; set; }
        public object email { get; set; }
        public int Status { get; set; }
        public string StatusDisplay { get; set; }
        public float DepreciationRemaining { get; set; }
        public float Depreciation { get; set; }
        public string DepreciationDate { get; set; }
    }

    public class Purchaseorder
    {
        public Requesteditem[] RequestedItems { get; set; }
        public int ID { get; set; }
        public string Name { get; set; }
        public float Price { get; set; }
    }

    public class Requesteditem
    {
        public Vendor Vendor { get; set; }
        public int ID { get; set; }
        public string Name { get; set; }
        public int VendorID { get; set; }
        public int PurchaseOrderID { get; set; }
        public float Price { get; set; }
        public string Comments { get; set; }
        public string PartNumber { get; set; }
        public object email { get; set; }
        public int Status { get; set; }
        public string StatusDisplay { get; set; }
        public object DepreciationRemaining { get; set; }
        public object Depreciation { get; set; }
        public string DepreciationDate { get; set; }
    }

    public class Vendor
    {
        public int ID { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public string Website { get; set; }
        public object Contact { get; set; }
    }


    public class Rootobject
    {
        public User[] Property1 { get; set; }
    }

    public class User
    {
        public object ApprovalDepartment { get; set; }
        public object[] Claims { get; set; }
        public Department Department { get; set; }
        public object[] Logins { get; set; }
        public Role[] Roles { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public int DepartmentID { get; set; }
        public object ApprovalDepartmentID { get; set; }
        public string GravatarHash { get; set; }
        public string Email { get; set; }
        public bool EmailConfirmed { get; set; }
        public string PasswordHash { get; set; }
        public string SecurityStamp { get; set; }
        public object PhoneNumber { get; set; }
        public bool PhoneNumberConfirmed { get; set; }
        public bool TwoFactorEnabled { get; set; }
        public object LockoutEndDateUtc { get; set; }
        public bool LockoutEnabled { get; set; }
        public int AccessFailedCount { get; set; }
        public string Id { get; set; }
        public string UserName { get; set; }
    }

    public class Department
    {
        public object[] Users { get; set; }
        public int ID { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public float Budget { get; set; }
    }

    public class Role
    {
        public string UserId { get; set; }
        public string RoleId { get; set; }
    }


}
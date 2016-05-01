using System.Data.Entity;
using System.Security.Claims;
using System.Threading.Tasks;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using System.Security.Cryptography;
using System.Text;

namespace Procurable.Models
{
    // You can add profile data for the user by adding more properties to your ApplicationUser class, please visit http://go.microsoft.com/fwlink/?LinkID=317594 to learn more.
    public class ApplicationUser : IdentityUser
    {
        public async Task<ClaimsIdentity> GenerateUserIdentityAsync(UserManager<ApplicationUser> manager)
        {
            // Note the authenticationType must match the one defined in CookieAuthenticationOptions.AuthenticationType
            var userIdentity = await manager.CreateIdentityAsync(this, DefaultAuthenticationTypes.ApplicationCookie);
            // Add custom user claims here
            return userIdentity;
        }

        // Extended Properties
        public string FirstName { get; set; }
        public string LastName { get; set; }

        public int DepartmentID { get; set; }
        public virtual Department Department { get; set; }

        public int? ApprovalDepartmentID { get; set; }
        public virtual Department ApprovalDepartment { get; set; }

        public string GravatarHash
        {
            get
            {
                MD5 md5 = System.Security.Cryptography.MD5.Create();
                byte[] toBytes = md5.ComputeHash(Encoding.ASCII.GetBytes(Email.Trim().ToLower()));
                return Encoding.ASCII.GetString(toBytes);
            }
        }
    }

    public class ApplicationDbContext : IdentityDbContext<ApplicationUser>
    {
        public ApplicationDbContext()
            : base("DefaultConnection", throwIfV1Schema: false)
        {
        }

        public static ApplicationDbContext Create()
        {
            return new ApplicationDbContext();
        }



        public System.Data.Entity.DbSet<Procurable.Models.Vendor> Vendors { get; set; }

        public System.Data.Entity.DbSet<Procurable.Models.InventoryItem> InventoryItems { get; set; }

        public System.Data.Entity.DbSet<Procurable.Models.InventoryItemHistory> InventoryItemsHistory { get; set; }

        public System.Data.Entity.DbSet<Procurable.Models.Inventory> Inventories { get; set; }

        public System.Data.Entity.DbSet<Procurable.Models.PurchaseOrder> PurchaseOrders { get; set; }

        public System.Data.Entity.DbSet<Procurable.Models.Request> Requests { get; set; }

        public System.Data.Entity.DbSet<Procurable.Models.RequestedItem> RequestedItems { get; set; }

        public System.Data.Entity.DbSet<Procurable.Models.ProjectTask> ProjectTasks { get; set; }

        public System.Data.Entity.DbSet<Procurable.Models.Project> Projects { get; set; }

        public System.Data.Entity.DbSet<Procurable.Models.Reorder> Reorders { get; set; }

        public System.Data.Entity.DbSet<Procurable.Models.Department> Departments { get; set; }

    }
}
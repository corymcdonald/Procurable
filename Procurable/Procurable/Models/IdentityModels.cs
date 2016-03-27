using System.Data.Entity;
using System.Security.Claims;
using System.Threading.Tasks;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;

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

        public System.Data.Entity.DbSet<Procurable.Models.Inventory> Inventories { get; set; }

        public System.Data.Entity.DbSet<Procurable.Models.PurchaseOrder> PurchaseOrders { get; set; }

        public System.Data.Entity.DbSet<Procurable.Models.Request> Requests { get; set; }

        public System.Data.Entity.DbSet<Procurable.Models.RequestedItem> RequestedItems { get; set; }

        public System.Data.Entity.DbSet<Procurable.Models.ProjectTask> ProjectTasks { get; set; }

        public System.Data.Entity.DbSet<Procurable.Models.Project> Projects { get; set; }
    }
}
namespace Procurable.Migrations
{
    using Microsoft.AspNet.Identity;
    using Microsoft.AspNet.Identity.EntityFramework;
    using Models;
    using System;
    using System.Collections.Generic;
    using System.Data.Entity;
    using System.Data.Entity.Migrations;
    using System.Diagnostics;
    using System.Linq;
    using System.Web.Security;
    internal sealed class Configuration : DbMigrationsConfiguration<Procurable.Models.ApplicationDbContext>
    {
        public Configuration()
        {
            AutomaticMigrationsEnabled = true;
            AutomaticMigrationDataLossAllowed = true;
            ContextKey = "Procurable.Models.ApplicationDbContext";
        }
            
        private Random rand = new Random();
        protected override void Seed(Procurable.Models.ApplicationDbContext context)
        {
            //if (System.Diagnostics.Debugger.IsAttached == false)
            //    System.Diagnostics.Debugger.Launch();
            //  This method will be called after migrating to the latest version.

            //  You can use the DbSet<T>.AddOrUpdate() helper extension method 
            //  to avoid creating duplicate seed data. E.g.
            //
            //    context.People.AddOrUpdate(
            //      p => p.FullName,
            //      new Person { FullName = "Andrew Peters" },
            //      new Person { FullName = "Brice Lambson" },
            //      new Person { FullName = "Rowan Miller" }
            //    );
            #region Vendors
            var vendors = new List<Vendor>();
            vendors.Add(new Vendor() { ID = 0, Name = "Amazon", Description = "An American electronic commerce and cloud computing company with headquarters in Seattle, Washington.", Website = "http://amazon.com/", Contact = "1 (888) 280-4331" });
            vendors.Add(new Vendor() { ID = 1, Name = "Acer", Description = "Taiwanese multinational hardware and electronics corporation specializing in advanced electronics technology", Website = "http://Acer.com" });
            vendors.Add(new Vendor() { ID = 2, Name = "Gateway", Description = "American computer hardware company based in South Dakota, that developed, manufactured, supported, and marketed a wide range of personal computers", Website = "http://Gateway.com" });
            vendors.Add(new Vendor() { ID = 3, Name = "Advent", Description = "", Website = "http://Advent.com" });
            vendors.Add(new Vendor() { ID = 5, Name = "Aigo", Description = "aigo is the trade name of Chinese consumer electronics company Beijing Huaqi Information Digital Technology Co", Website = "http://Aigo.com" });
            vendors.Add(new Vendor() { ID = 6, Name = "AMD", Description = "Advanced Micro Devices, Inc. is an American worldwide semiconductor company based in Sunnyvale, California, United States", Website = "http://AMD.com" });
            vendors.Add(new Vendor() { ID = 9, Name = "AORUS", Description = "", Website = "http://AORUS.com" });
            vendors.Add(new Vendor() { ID = 10, Name = "AOpen", Description = "", Website = "http://AOpen.com" });
            vendors.Add(new Vendor() { ID = 11, Name = "Apple", Description = "Apple Inc. is an American multinational technology company headquartered in Cupertino, California, that designs, develops, and sells consumer electronics, computer software, and online services", Website = "http://Apple.com" });
            vendors.Add(new Vendor() { ID = 12, Name = "ASRock", Description = "", Website = "http://ASRock.com" });
            vendors.Add(new Vendor() { ID = 13, Name = "Asus", Description = "", Website = "http://Asus.com" });
            vendors.Add(new Vendor() { ID = 14, Name = "AVADirect", Description = "", Website = "http://AVADirect.com" });
            vendors.Add(new Vendor() { ID = 19, Name = "Cray", Description = "", Website = "http://Cray.com" });
            vendors.Add(new Vendor() { ID = 21, Name = "Dell", Description = "", Website = "http://Dell.com" });
            vendors.Add(new Vendor() { ID = 25, Name = "Everex", Description = "", Website = "http://Everex.com" });
            vendors.Add(new Vendor() { ID = 26, Name = "EVGA", Description = "", Website = "http://EVGA.com" });
            vendors.Add(new Vendor() { ID = 28, Name = "Fujitsu", Description = "", Website = "http://Fujitsu.com" });
            vendors.Add(new Vendor() { ID = 31, Name = "Gigabyte", Description = "Gigabyte Technology Co., Ltd., is an international manufacturer and distributor of computer hardware products", Website = "http://Gigabyte.com" });
            vendors.Add(new Vendor() { ID = 32, Name = "Gradiente", Description = "", Website = "http://Gradiente.com" });
            vendors.Add(new Vendor() { ID = 33, Name = "Hasee", Description = "", Website = "http://Hasee.com" });
            vendors.Add(new Vendor() { ID = 34, Name = "Compaq", Description = "", Website = "http://Compaq.com" });
            vendors.Add(new Vendor() { ID = 36, Name = "HTC", Description = "HTC Corporation, Full name:, is a Taiwanese multinational manufacturer of smartphones and tablets headquartered in New Taipei City, Taiwan.", Website = "http://HTC.com" });
            vendors.Add(new Vendor() { ID = 37, Name = "Hyundai", Description = "", Website = "http://Hyundai.com" });
            vendors.Add(new Vendor() { ID = 38, Name = "IBM", Description = "", Website = "http://IBM.com" });
            vendors.Add(new Vendor() { ID = 39, Name = "IBuyPower", Description = "", Website = "http://IBuyPower.com" });
            vendors.Add(new Vendor() { ID = 40, Name = "Intel", Description = "", Website = "http://Intel.com" });
            vendors.Add(new Vendor() { ID = 41, Name = "Inventec", Description = "", Website = "http://Inventec.com" });
            vendors.Add(new Vendor() { ID = 46, Name = "Lanix", Description = "", Website = "http://Lanix.com" });
            vendors.Add(new Vendor() { ID = 47, Name = "Lenovo", Description = "", Website = "http://Lenovo.com" });
            vendors.Add(new Vendor() { ID = 48, Name = "Medion", Description = "", Website = "http://Medion.com" });
            vendors.Add(new Vendor() { ID = 49, Name = "LG", Description = "", Website = "http://LG.com" });
            vendors.Add(new Vendor() { ID = 50, Name = "LiteOn", Description = "", Website = "http://LiteOn.com" });
            vendors.Add(new Vendor() { ID = 51, Name = "Maingear", Description = "", Website = "http://Maingear.com" });
            vendors.Add(new Vendor() { ID = 53, Name = "Micron", Description = "", Website = "http://Micron.com" });
            vendors.Add(new Vendor() { ID = 54, Name = "Microsoft", Description = "", Website = "http://Microsoft.com" });
            vendors.Add(new Vendor() { ID = 55, Name = "MiTAC", Description = "", Website = "http://MiTAC.com" });
            vendors.Add(new Vendor() { ID = 56, Name = "Motorola", Description = "", Website = "http://Motorola.com" });
            vendors.Add(new Vendor() { ID = 57, Name = "NComputing", Description = "", Website = "http://NComputing.com" });
            vendors.Add(new Vendor() { ID = 58, Name = "NCR", Description = "", Website = "http://NCR.com" });
            vendors.Add(new Vendor() { ID = 59, Name = "NEC", Description = "", Website = "http://NEC.com" });
            vendors.Add(new Vendor() { ID = 61, Name = "NZXT", Description = "", Website = "http://NZXT.com" });
            vendors.Add(new Vendor() { ID = 62, Name = "Olidata", Description = "", Website = "http://Olidata.com" });
            vendors.Add(new Vendor() { ID = 63, Name = "Olivetti", Description = "", Website = "http://Olivetti.com" });
            vendors.Add(new Vendor() { ID = 64, Name = "Oracle", Description = "", Website = "http://Oracle.com" });
            vendors.Add(new Vendor() { ID = 65, Name = "Panasonic", Description = "", Website = "http://Panasonic.com" });
            vendors.Add(new Vendor() { ID = 66, Name = "Psychsoftpc", Description = "", Website = "http://Psychsoftpc.com" });
            vendors.Add(new Vendor() { ID = 69, Name = "RoseWill", Description = "", Website = "http://RoseWill.com" });
            vendors.Add(new Vendor() { ID = 70, Name = "Samsung", Description = "", Website = "http://Samsung.com" });
            vendors.Add(new Vendor() { ID = 71, Name = "Shuttle", Description = "", Website = "http://Shuttle.com" });
            vendors.Add(new Vendor() { ID = 72, Name = "SGI", Description = "", Website = "http://SGI.com" });
            vendors.Add(new Vendor() { ID = 73, Name = "Síragon", Description = "", Website = "http://Siragon.com" });
            vendors.Add(new Vendor() { ID = 74, Name = "Sony", Description = "", Website = "http://Sony.com" });
            vendors.Add(new Vendor() { ID = 75, Name = "StealthMachines", Description = "", Website = "http://StealthMachines.com" });
            vendors.Add(new Vendor() { ID = 76, Name = "Supermicro", Description = "", Website = "http://Supermicro.com" });
            vendors.Add(new Vendor() { ID = 77, Name = "Systemax", Description = "", Website = "http://Systemax.com" });
            vendors.Add(new Vendor() { ID = 78, Name = "System76", Description = "", Website = "http://System76.com" });
            vendors.Add(new Vendor() { ID = 80, Name = "TabletKiosk", Description = "", Website = "http://TabletKiosk.com" });
            vendors.Add(new Vendor() { ID = 81, Name = "Tatung", Description = "", Website = "http://Tatung.com" });
            vendors.Add(new Vendor() { ID = 82, Name = "Toshiba", Description = "", Website = "http://Toshiba.com" });
            vendors.Add(new Vendor() { ID = 83, Name = "Tyan", Description = "", Website = "http://Tyan.com" });
            vendors.Add(new Vendor() { ID = 84, Name = "Unisys", Description = "", Website = "http://Unisys.com" });
            vendors.Add(new Vendor() { ID = 85, Name = "Vestel", Description = "", Website = "http://Vestel.com" });
            vendors.Add(new Vendor() { ID = 87, Name = "ViewSonic", Description = "", Website = "http://ViewSonic.com" });
            vendors.Add(new Vendor() { ID = 89, Name = "Vizio", Description = "", Website = "http://Vizio.com" });
            vendors.Add(new Vendor() { ID = 92, Name = "Wortmann", Description = "", Website = "http://Wortmann.com" });
            vendors.Add(new Vendor() { ID = 93, Name = "Xidax", Description = "", Website = "http://Xidax.com" });
            vendors.Add(new Vendor() { ID = 95, Name = "Zoostorm", Description = "", Website = "http://Zoostorm.com" });
            vendors.Add(new Vendor() { ID = 96, Name = "Zotac", Description = "", Website = "http://Zotac.com" });
            vendors.ForEach(s => context.Vendors.AddOrUpdate(p => p.ID, s));
            #endregion


            #region Users
            var departments = new List<Department>();
            departments.Add(new Department() { ID = 1, Name = "Project Planning", Description = "Handle IT Projects in the company", Budget = 30000000});
            departments.Add(new Department() { ID = 2, Name = "Network Infrastructure", Description = "Maintain Networks", Budget = 10000000 });
            departments.Add(new Department() { ID = 3, Name = "Mobile Development", Description = "Develop iPhone and Android apps", Budget = 500000 });
            departments.Add(new Department() { ID = 4, Name = "Web Development", Description = "Develop Websites", Budget = 760000 });
            departments.ForEach(s => context.Departments.AddOrUpdate(p => p.ID, s));

            context.Roles.AddOrUpdate(r => r.Name,
                new IdentityRole { Name = "Admin" },
                new IdentityRole { Name = "Reviewer" },
                new IdentityRole { Name = "Inventory" },
                new IdentityRole { Name = "User" });
           
            var UserManager = new UserManager<ApplicationUser>(new UserStore<ApplicationUser>(context));

            var adminID = "";
            var lucasID = "";
            var mattID = "";
            
            

            //Admins
            if (!(context.Users.Any(u => u.UserName == "admin@test.com")))
            {
                
                var userToInsert = new ApplicationUser { UserName = "admin@test.com", DepartmentID = 1, ApprovalDepartmentID = 1, Email = "admin@gustr.com", FirstName = "Admin", LastName = "Admin" };
                UserManager.Create(userToInsert, "password");
                UserManager.AddToRole(userToInsert.Id,"Admin");
                adminID = userToInsert.Id;
            }
            else
            {
                adminID = UserManager.FindByName("admin@test.com").Id;
            }

            

            //Reviewers
            if (!(context.Users.Any(u => u.UserName == "reviewer@test.com")))
            {
                
                var userToInsert = new ApplicationUser { UserName = "reviewer@test.com", DepartmentID = 1, ApprovalDepartmentID = 2, Email = "reviewer@gustr.com", FirstName = "Reviewer", LastName = "Reviewer" };
                UserManager.Create(userToInsert, "password");
                UserManager.AddToRole(userToInsert.Id, "Reviewer");
            }
            if (!(context.Users.Any(u => u.UserName == "abel@test.com")))
            {
                
                var userToInsert = new ApplicationUser { UserName = "abel@test.com", DepartmentID = 1, ApprovalDepartmentID = 3, Email = "abel@gustr.com", FirstName = "Abel", LastName = "Trespalacios" };
                UserManager.Create(userToInsert, "password");
                UserManager.AddToRole(userToInsert.Id, "Reviewer");
            }
            if (!(context.Users.Any(u => u.UserName == "chris@test.com")))
            {
                
                var userToInsert = new ApplicationUser { UserName = "chris@test.com", DepartmentID = 1, ApprovalDepartmentID = 4, Email = "chris@gustr.com", FirstName = "Chris", LastName = "Rogers" };
                UserManager.Create(userToInsert, "password");
                UserManager.AddToRole(userToInsert.Id, "Reviewer");
            }
       
            

            //Inventory Managers
            if (!(context.Users.Any(u => u.UserName == "inventory@test.com")))
            {
                
                var userToInsert = new ApplicationUser { UserName = "inventory@test.com", DepartmentID = 1, Email = "inventory@gustr.com", FirstName = "Inventory", LastName = "Inventory" };
                UserManager.Create(userToInsert, "password");
                UserManager.AddToRole(userToInsert.Id, "Inventory");
            }

            //Users
            if (!(context.Users.Any(u => u.UserName == "lucas@test.com")))
            {
               
                var userToInsert = new ApplicationUser { UserName = "lucas@test.com", DepartmentID = 4, Email = "lucas.dorrough.b@gmail.com", FirstName = "Lucas", LastName = "Dorrough" };
                UserManager.Create(userToInsert, "password");
                UserManager.AddToRole(userToInsert.Id, "User");
                lucasID = userToInsert.Id;
            }
            else
            {
                lucasID = UserManager.FindByName("lucas@test.com").Id;
            }

            if (!(context.Users.Any(u => u.UserName == "will@test.com")))
            {
               
                var userToInsert = new ApplicationUser { UserName = "will@test.com", DepartmentID = 3, Email = "wsturner.1123@gmail.com", FirstName = "Will", LastName = "Turner" };
                UserManager.Create(userToInsert, "password");
                UserManager.AddToRole(userToInsert.Id, "User");
            }
            if (!(context.Users.Any(u => u.UserName == "matt@test.com")))
            {
                
                var userToInsert = new ApplicationUser { UserName = "matt@test.com", DepartmentID = 3, Email = "maluther@uark.edu", FirstName = "Matt", LastName = "Luther" };
                UserManager.Create(userToInsert, "password");
                UserManager.AddToRole(userToInsert.Id, "User");
                mattID = userToInsert.Id;
            }
            {
                mattID = UserManager.FindByName("matt@test.com").Id;
            }
            string CoryID = "";
            if (!(context.Users.Any(u => u.UserName == "cory@test.com")))
            {
               
                var userToInsert = new ApplicationUser { UserName = "cory@test.com", DepartmentID = 4, Email = "cory@corywmcdonald.com ", FirstName = "Cory", LastName = "McDonald" };
                UserManager.Create(userToInsert, "password");
                UserManager.AddToRole(userToInsert.Id, "User");
                CoryID = userToInsert.Id;
            }
            else
            {
                CoryID = UserManager.FindByName("cory@test.com").Id;
            }
            if (!(context.Users.Any(u => u.UserName == "erin@test.com")))
            {
                
                var userToInsert = new ApplicationUser { UserName = "erin@test.com", DepartmentID = 2, Email = "erin@gustr.com", FirstName = "Erin", LastName = "Butcher" };
                UserManager.Create(userToInsert, "password");
                UserManager.AddToRole(userToInsert.Id, "User");
            }
            if (!(context.Users.Any(u => u.UserName == "andrea@test.com")))
            {
               
                var userToInsert = new ApplicationUser { UserName = "andrea@test.com", DepartmentID = 2, Email = "andrea@gustr.com", FirstName = "Andrea", LastName = "Dobbs" };
                UserManager.Create(userToInsert, "password");
                UserManager.AddToRole(userToInsert.Id, "User");
            }

            if (!(context.Users.Any(u => u.UserName == "loren@test.com")))
            {
               
                var userToInsert = new ApplicationUser { UserName = "loren@test.com", DepartmentID = 2, Email = "loren@gustr.com", FirstName = "Loren", LastName = "Anthony" };
                UserManager.Create(userToInsert, "password");
                UserManager.AddToRole(userToInsert.Id, "User");
            }

            #endregion

            #region InventoryItems and Purchase Orders
            List<InventoryItem> InventoryItems1 = new List<InventoryItem>();
            List<InventoryItem> InventoryItems2 = new List<InventoryItem>();
            List<InventoryItem> InventoryItems3 = new List<InventoryItem>();

            InventoryItems1.Add(new InventoryItem() {
                ID = 1,
                VendorID=context.Vendors.FirstOrDefault(x=> x.Name == "Intel").ID,
                Name = "Inspiron i3847-4616BK",
                Comments = "Gen 4 i5-4440/ 8GB/ 1TB/ Windows 8.1",
                Status = InventoryStatus.Unallocated,
                Price = new decimal(560.00),
                PartNumber = "i3847-4616BK",
                Depreciation = 30.00M,
                DepreciationRemaining = 260,
                CreatedDate = DateTime.Now.AddMonths(-10)
            });
            InventoryItems1.Add(new InventoryItem()
            {
                ID = 2,
                VendorID = context.Vendors.FirstOrDefault(x => x.Name == "Intel").ID,
                Name = "Inspiron i3847-4616BK",
                Comments = "Gen 4 i5-4440/ 8GB/ 1TB/ Windows 8.1",
                Status = InventoryStatus.Unallocated,
                Price = new decimal(560.00),
                PartNumber = "i3847-4616BK",
                  Depreciation = 30.00M,
                DepreciationRemaining = 260,
                CreatedDate = DateTime.Now.AddMonths(-10)
            });
            InventoryItems1.Add(new InventoryItem()
            {
                ID = 3,
                VendorID = context.Vendors.FirstOrDefault(x => x.Name == "HTC").ID,
                Name = "One",
                Comments = "145.75 x 70.8. x 7.26 mm",
                Status = InventoryStatus.Unallocated,
                Price = new decimal(499.99),
                PartNumber = "A9"
            });
          
            InventoryItems1.Add(new InventoryItem()
            {
                ID = 4,
                VendorID = context.Vendors.FirstOrDefault(x => x.Name == "Gigabyte").ID,
                Name = "Inspiron i3847-4616BK",
                Comments = "Gen 4 i5-4440/ 8GB/ 1TB/ Windows 8.1",
                Status = InventoryStatus.Unallocated,
                Price = new decimal(499.99),
                PartNumber = "i3847-4616BK",
            });

            InventoryItems2.Add(new InventoryItem()
            {
                ID = 5,
                VendorID = context.Vendors.FirstOrDefault(x => x.Name == "LG").ID,
                Name = "Q21",
                Comments = "Intel Celeron N2930 Processor (1.83-2.17GHz) " + Environment.NewLine + "500GB/1TB 2.5\" HDD 5400rpm",
                Status = InventoryStatus.Unallocated,
                Price = new decimal(625.99),
                PartNumber = "Q21",
            });
            InventoryItems2.Add(new InventoryItem()
            {
                ID = 6,
                VendorID = context.Vendors.FirstOrDefault(x => x.Name == "Apple").ID,
                Name = "iPad Air 2",
                Comments = "iOS 8.1",
                Status = InventoryStatus.Allocated,
                Price = new decimal(575.00),
                PartNumber = "MC769LL",
                Depreciation = 20,
                CreatedDate = DateTime.Now.AddMonths(-12),
                DepreciationRemaining = 575 - (20 * 12),
            });
            InventoryItems2.Add(new InventoryItem()
            {
                ID = 7,
                VendorID = context.Vendors.FirstOrDefault(x => x.Name == "Apple").ID,
                Name = "iPad Air 2",
                Comments = "iOS 8.1",
                Status = InventoryStatus.Allocated,
                Price = new decimal(575.00),
                PartNumber = "MC769LL",
                Depreciation = 20,
                CreatedDate = DateTime.Now.AddMonths(-12),
                DepreciationRemaining = 575 - (20 * 12),
            });
            InventoryItems2.Add(new InventoryItem()
            {
                ID = 8,
                VendorID = context.Vendors.FirstOrDefault(x => x.Name == "Apple").ID,
                Name = "iPad Air 2",
                Comments = "iOS 8.1",
                Status = InventoryStatus.Unallocated,
                Price = new decimal(575.00),
                PartNumber = "MC769LL",
                Depreciation = 20,
                CreatedDate = DateTime.Now.AddMonths(-14),
                DepreciationRemaining = 575 - (20 * 14),
            });
            InventoryItems2.Add(new InventoryItem()
            {
                ID = 9,
                VendorID = context.Vendors.FirstOrDefault(x => x.Name == "Apple").ID,
                Name = "iPad Air 2",
                Comments = "iOS 8.1",
                Status = InventoryStatus.Unallocated,
                Price = new decimal(575.00),
                PartNumber = "MC769LL",
                CreatedDate = DateTime.Now.AddMonths(-5),
            });
            InventoryItems2.Add(new InventoryItem()
            {
                ID = 10,
                VendorID = context.Vendors.FirstOrDefault(x => x.Name == "HTC").ID,
                Name = "One",
                Comments = "145.75 x 70.8. x 7.26 mm",
                Status = InventoryStatus.Unallocated,
                CreatedDate = DateTime.Now.AddMonths(-5),
                Price = new decimal(599.99),
                PartNumber = "A9"
            });

            InventoryItems3.Add(new InventoryItem()
            {
                ID = 11,
                VendorID = context.Vendors.FirstOrDefault(x => x.Name == "Amazon").ID,
                Name = "Digital A6 Color Printer",
                Status = InventoryStatus.Allocated,
                Price = new decimal(1300.00),
                PartNumber = "UPD25MD",
                CreatedDate = DateTime.Now.AddMonths(-5),
            });
            InventoryItems3.Add(new InventoryItem()
            {
                ID = 12,
                VendorID = context.Vendors.FirstOrDefault(x => x.Name == "Microsoft").ID,
                Name = "Microsoft Office Home",
                Status = InventoryStatus.Allocated,
                Price = new decimal(124.94),
                CreatedDate = DateTime.Now.AddMonths(-5),
                PartNumber = "79G-04368"
            });
            InventoryItems3.Add(new InventoryItem()
            {
                ID = 13,
                VendorID = context.Vendors.FirstOrDefault(x => x.Name == "Microsoft").ID,
                Name = "Microsoft Office Student",
                Status = InventoryStatus.Allocated,
                Price = new decimal(94.99),
                CreatedDate = DateTime.Now.AddMonths(-5),
                PartNumber = "79G-04332"
            });

            InventoryItems3.Add(new InventoryItem()
            {
                ID = 14,
                VendorID = context.Vendors.FirstOrDefault(x => x.Name == "Amazon").ID,
                Name = "32GB Micro SDHC Card",
                Status = InventoryStatus.Allocated,
                Price = new decimal(9.99),
                PartNumber = "MB-MP32DA/AM",
                CreatedDate = DateTime.Now.AddMonths(-5),
            });
            InventoryItems3.Add(new InventoryItem()
            {
                ID = 15,
                VendorID = context.Vendors.FirstOrDefault(x => x.Name == "Amazon").ID,
                Name = "32GB Micro SDHC Card",
                Status = InventoryStatus.Unallocated,
                Price = new decimal(9.99),
                PartNumber = "MB-MP32DA/AM",
                CreatedDate = DateTime.Now.AddMonths(-5),
            });
            InventoryItems3.Add(new InventoryItem()
            {
                ID = 16,
                VendorID = context.Vendors.FirstOrDefault(x => x.Name == "Amazon").ID,
                Name = "32GB Micro SDHC Card",
                Status = InventoryStatus.Unallocated,
                Price = new decimal(9.99),
                PartNumber = "MB-MP32DA/AM"
            });
            InventoryItems3.Add(new InventoryItem()
            {
                ID = 17,
                VendorID = context.Vendors.FirstOrDefault(x => x.Name == "Acer").ID,
                Name = "Aspire",
                Status = InventoryStatus.Unallocated,
                Price = new decimal(465.00),
                PartNumber = "B0197Z2MN6",
            });
            InventoryItems3.Add(new InventoryItem()
            {
                ID = 18,
                VendorID = context.Vendors.FirstOrDefault(x => x.Name == "Acer").ID,
                Name = "23-Inch Screen LED-Lit Monitor",
                Status = InventoryStatus.Unallocated,
                Price = new decimal(110.48),
                PartNumber = "G236HL",
            });

            InventoryItems1.ForEach(s => context.InventoryItems.AddOrUpdate(p => p.ID, s));
            InventoryItems2.ForEach(s => context.InventoryItems.AddOrUpdate(p => p.ID, s));
            InventoryItems3.ForEach(s => context.InventoryItems.AddOrUpdate(p => p.ID, s));

            List<PurchaseOrder> POs = new List<PurchaseOrder>();

            var PO1 = (new PurchaseOrder()
            {
                ID = 1,
                Name = "Purchase Order (" + DateTime.Now.ToShortDateString() + ")"
                                        ,
                RequestedItems = InventoryItems1,
                Price = InventoryItems1.Sum(x => x.Price)
            });
            var PO2 = (new PurchaseOrder()
            {
                ID = 2,
                Name = "Purchase Order - 3/21/2016",
                RequestedItems = InventoryItems2,
                Price = InventoryItems2.Sum(x => x.Price)
            });
            var PO3 = (new PurchaseOrder()
            {
                ID = 3,
                Name = "Purchase Order - 3/26/2016",
                RequestedItems = InventoryItems3,
                Price = InventoryItems3.Sum(x => x.Price)
            });

            POs.Add(PO1);
            POs.Add(PO2);
            POs.Add(PO3);

            POs.ForEach(s => context.PurchaseOrders.AddOrUpdate(p => p.ID, s));

            foreach (var inventoryItem in InventoryItems1)
                inventoryItem.PurchaseOrder = PO1;
            foreach (var inventoryItem in InventoryItems2)
                inventoryItem.PurchaseOrder = PO2;
            foreach (var inventoryItem in InventoryItems3)
                inventoryItem.PurchaseOrder = PO3;

            InventoryItems1.ForEach(s => context.InventoryItems.AddOrUpdate(p => p.ID, s));
            InventoryItems2.ForEach(s => context.InventoryItems.AddOrUpdate(p => p.ID, s));
            InventoryItems3.ForEach(s => context.InventoryItems.AddOrUpdate(p => p.ID, s));

            #endregion


            #region RequestedItems and Requests
            List<RequestedItem> RequestItems1 = new List<RequestedItem>();
            List<RequestedItem> RequestItems2 = new List<RequestedItem>();
            List<RequestedItem> RequestItems3 = new List<RequestedItem>();
            List<RequestedItem> RequestItems4 = new List<RequestedItem>();
            List<RequestedItem> RequestItems5 = new List<RequestedItem>();


            RequestItems1.Add(new RequestedItem()
            {
                ID = 1,
                Name = "Paper",
                Comments = "For the printer",
                URL = "http://www.amazon.com/Hammermill-Paper-Bright-Sheets-150200P/dp/B00U03707S/ref=sr_1_2?s=office-products&ie=UTF8&qid=1462298943&sr=1-2&keywords=paper"
            });
            RequestItems1.Add(new RequestedItem()
            {
                ID = 2,
                Name = "Dell T510",
                Comments = "TowerServer",
                URL = "http://www.amazon.com"
            });
            RequestItems1.Add(new RequestedItem()
            {
                ID = 3,
                Name = "Antec Cooler",
                Comments = "My pc is running hot",
                URL = "http://www.amazon.com/Antec-Notebook-Cooler-USB-Powered/dp/B0000BVYTV/ref=sr_1_sc_1?ie=UTF8&qid=1462298988&sr=8-1-spell&keywords=Antec+Coole"
            });
            RequestItems1.Add(new RequestedItem()
            {
                ID = 4,
                Name = "Keyboard",
                Comments = "t'nac epyt",
                URL = ""
            });

            RequestItems2.Add(new RequestedItem()
            {
                ID = 5,
                Name = "24Inch Monitor",
                Comments = "Cant see",
                URL = ""
            });
            RequestItems2.Add(new RequestedItem()
            {
                ID = 6,
                Name = "Dell T510",
                Comments = "TowerServer",
                URL = "http://www.dell.com"
            });

            RequestItems3.Add(new RequestedItem()
            {
                ID = 7,
                Name = "Some Board Game",
                Comments = "Cant see",
                URL = "http://www.amazon.com"
            });
            RequestItems2.Add(new RequestedItem()
            {
                ID = 8,
                Name = "Some Mobile Device",
                Comments = "NOT iOS",
                URL = "http://www.dell.com"
            });

            RequestItems4.Add(new RequestedItem()
            {
                ID = 9,
                Name = "iPad Air 2 ",
                Comments = "",
                URL = "",
            });

            RequestItems5.Add(new RequestedItem()
            {
                ID = 10,
                Name = "iPad Air 2 ",
                Comments = "",
                URL = "",
            });

            RequestItems1.ForEach(s => context.RequestedItems.AddOrUpdate(p => p.ID, s));
            RequestItems2.ForEach(s => context.RequestedItems.AddOrUpdate(p => p.ID, s));
            RequestItems3.ForEach(s => context.RequestedItems.AddOrUpdate(p => p.ID, s));
            RequestItems4.ForEach(s => context.RequestedItems.AddOrUpdate(p => p.ID, s));
            RequestItems5.ForEach(s => context.RequestedItems.AddOrUpdate(p => p.ID, s));
            
            List<Request> REQs = new List<Request>();

            var Req1 = (new Request()
            {
                ID = 1,
                Name = "General Items",
                Comments = "Items I require to do my job",
                RequestedById = adminID,
                RequestedForId = adminID,
                Items = RequestItems1,
                Status = RequestStatus.InProgress,
                CreatedDate = DateTime.Now,
                LastModified = DateTime.Now

            });

            var Req2 = (new Request()
            {
                ID = 2,
                Name = "Cory's Request",
                Comments = "Please give me these things. I want them.",
                RequestedById = lucasID,
                RequestedForId = lucasID,
                Items = RequestItems2,
                Status = RequestStatus.Opened,
                CreatedDate = DateTime.Now,
                LastModified = DateTime.Now

            });

            var Req3 = (new Request()
            {
                ID = 3,
                Name = "I don't really need these",
                Comments = "But I might one day!",
                RequestedById = mattID,
                RequestedForId = mattID,
                Items = RequestItems3,
                Status = RequestStatus.Reopened,
                CreatedDate = DateTime.Now,
                LastModified = DateTime.Now
            });

            var Req4 = (new Request()
            {
                ID = 4,
                Name = "Requsting iPad for testing purposes",
                Comments = "In order to test the iOS mobile application I need an iPad Air.",
                RequestedById = adminID,
                RequestedForId = mattID,
                Items = RequestItems4,
                Status = RequestStatus.Opened,
                CreatedDate = DateTime.Now,
                LastModified = DateTime.Now
            });

            var Req5 = (new Request()
            {
                ID = 5,
                Name = "Requsting iPad for testing purposes",
                Comments = "In order to test the wireless I would like an iPad.",
                RequestedById = adminID,
                RequestedForId = lucasID,
                Items = RequestItems5,
                Status = RequestStatus.Completed,
                CreatedDate = DateTime.Now.AddDays(-7),
                LastModified = DateTime.Now.AddDays(-3)
            });

            REQs.Add(Req1);
            REQs.Add(Req2);
            REQs.Add(Req3);
            REQs.Add(Req4);
            REQs.Add(Req5);

            foreach(var request in REQs)
            {
                context.Requests.AddOrUpdate(x => x.ID, request);
            }


            var Projects = new List<Project>();
            Projects.Add(new Project()
            {
                ProjectID = 1,
                CreatedByID = adminID,
                AssignedToID = CoryID,
                DateNeeded = DateTime.Now.AddDays(7),
                Comments = "Please make sure all these items are delivered and that the user is satisfied",
                Status = ProjectStatus.New,
                RequestID = 1,
                LastModified = DateTime.Now,
                CreatedDate = DateTime.Now,
                Priority = ProjectPriority.Medium,
            });
            Projects.Add(new Project()
            {
                ProjectID = 2,
                CreatedByID = adminID,
                AssignedToID = lucasID,
                DateNeeded = DateTime.Now.AddDays(-3),
                Comments = "Please make sure all these items are delivered and that the user is satisfied",
                Status = ProjectStatus.Completed,
                RequestID = 5,
                LastModified = DateTime.Now.AddDays(-2),
                CreatedDate = DateTime.Now.AddDays(-7),
                CompletedDate = DateTime.Now.AddDays(-2),
                Priority = ProjectPriority.Low,
            });

            Projects.ForEach(s => context.Projects.AddOrUpdate(p => p.ProjectID, s));

            var Tasks = new List<ProjectTask>();
            Tasks.Add(new ProjectTask()
            {
                ID = 1,
                AssignedToID = lucasID,
                CreatedByID = adminID,
                Name = "Delivery Task",
                ProjectID = 1,
                CreatedDate = DateTime.Now,
                Comments = "The user for this sits by the window on the second floor. Please make sure these items get there",
                Status = ProjectStatus.New,
                LastModified = DateTime.Now,
                DateNeeded = DateTime.Now.AddDays(5),
            });
            Tasks.Add(new ProjectTask()
            {
                ID = 2,
                AssignedToID = CoryID,
                CreatedByID = adminID,
                Name = "Ensure delivery",
                ProjectID = 1,
                CreatedDate = DateTime.Now,
                Comments = "Be sure the other task got completed successfully",
                Status = ProjectStatus.New,
                LastModified = DateTime.Now,
                DateNeeded = DateTime.Now.AddDays(7),
            });
            Tasks.Add(new ProjectTask()
            {
                ID = 3,
                AssignedToID = mattID,
                CreatedByID = adminID,
                Name = "Ensure delivery",
                ProjectID = 2,
                CreatedDate = DateTime.Now.AddDays(-7),
                Comments = "Ship this out to the user at the following address 323 W 8th St, Kansas City, MO 64105",
                Status = ProjectStatus.Completed,
                CompletedDate = DateTime.Now.AddDays(-2),
                LastModified = DateTime.Now.AddDays(-2),
                DateNeeded = DateTime.Now.AddDays(-3),
            });

            Tasks.ForEach(s => context.ProjectTasks.AddOrUpdate(p => p.ID, s));

            #endregion

            #region Reporting
            try
            {
                var inventoryItemCount = context.InventoryItems.Max(x => x.ID);
                if (inventoryItemCount != null)
                {
                    var inventoryItemReportItem = context.InventoryItems.Find(rand.Next(inventoryItemCount));

                    List<InventoryItemHistory> ItemsToInsert = new List<InventoryItemHistory>();
                    inventoryItemReportItem.Price += rand.Next(-100, 100);
                    if (inventoryItemReportItem.Price <= 0)
                        inventoryItemReportItem.Price = rand.Next(5, 30);
                    ItemsToInsert.Add(new InventoryItemHistory(inventoryItemReportItem) { Action = InventoryItemHistory.Actions.Update, ModifiedDate = RandomDay() });
                    inventoryItemReportItem.Price += rand.Next(-100, 100);
                    if (inventoryItemReportItem.Price <= 0)
                        inventoryItemReportItem.Price = rand.Next(5, 30);
                    ItemsToInsert.Add(new InventoryItemHistory(inventoryItemReportItem) { Action = InventoryItemHistory.Actions.Update, ModifiedDate = RandomDay() });
                    inventoryItemReportItem.Price += rand.Next(-100, 100);
                    if (inventoryItemReportItem.Price <= 0)
                        inventoryItemReportItem.Price = rand.Next(5, 30);
                    ItemsToInsert.Add(new InventoryItemHistory(inventoryItemReportItem) { Action = InventoryItemHistory.Actions.Update, ModifiedDate = RandomDay() });
                    if (inventoryItemReportItem.Price <= 0)
                        inventoryItemReportItem.Price = rand.Next(5, 30);
                    inventoryItemReportItem.Price += rand.Next(-100, 100);
                    ItemsToInsert.Add(new InventoryItemHistory(inventoryItemReportItem) { Action = InventoryItemHistory.Actions.Update, ModifiedDate = RandomDay() });

                    ItemsToInsert.ForEach(s => context.InventoryItemsHistory.Add(s));
                }
            }
            catch (Exception ex)
            {
                
            }
            #endregion

        }
        DateTime RandomDay()
        {
            DateTime start = new DateTime(2016, 1, 1);
            int range = (DateTime.Today - start).Days;
            return start.AddDays(rand.Next(range));
        }
    }
}

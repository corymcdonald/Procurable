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

    internal sealed class Configuration : DbMigrationsConfiguration<Procurable.Models.ApplicationDbContext>
    {
        public Configuration()
        {
            AutomaticMigrationsEnabled = true;
            AutomaticMigrationDataLossAllowed = true;
            ContextKey = "Procurable.Models.ApplicationDbContext";
        }
  
        protected override void Seed(Procurable.Models.ApplicationDbContext context)
        {
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
            vendors.Add(new Vendor() { ID = 0, Name = "Amazon", Description = "An American electronic commerce and cloud computing company with headquarters in Seattle, Washington.", Website = "http://www.amazon.com/", Contact = "1 (888) 280-4331" });
            vendors.Add(new Vendor() { ID = 1, Name = "Acer", Description = "Taiwanese multinational hardware and electronics corporation specializing in advanced electronics technology", Website = "http://Acer.com" });
            vendors.Add(new Vendor() { ID = 2, Name = "Gateway", Description = "American computer hardware company based in South Dakota, that developed, manufactured, supported, and marketed a wide range of personal computers", Website = "http://Gateway.com" });
            vendors.Add(new Vendor() { ID = 3, Name = "Advent", Description = "", Website = "http://Advent.com" });
            vendors.Add(new Vendor() { ID = 4, Name = "A-EON Technology", Description = "", Website = "Ahttp://-EO.com" });
            vendors.Add(new Vendor() { ID = 5, Name = "Aigo", Description = "aigo is the trade name of Chinese consumer electronics company Beijing Huaqi Information Digital Technology Co", Website = "http://Aigo.com" });
            vendors.Add(new Vendor() { ID = 6, Name = "AMD", Description = "Advanced Micro Devices, Inc. is an American worldwide semiconductor company based in Sunnyvale, California, United States", Website = "http://AMD.com" });
            vendors.Add(new Vendor() { ID = 7, Name = "Aleutia", Description = "Aleutia Computers Ltd. is a privately owned computer manufacturer based in London, United Kingdom.", Website = "http://Aleutia.com" });
            vendors.Add(new Vendor() { ID = 8, Name = "Ankermann", Description = "", Website = "http://Ankermann.com" });
            vendors.Add(new Vendor() { ID = 9, Name = "AORUS", Description = "", Website = "http://AORUS.com" });
            vendors.Add(new Vendor() { ID = 10, Name = "AOpen", Description = "", Website = "http://AOpen.com" });
            vendors.Add(new Vendor() { ID = 11, Name = "Apple", Description = "Apple Inc. is an American multinational technology company headquartered in Cupertino, California, that designs, develops, and sells consumer electronics, computer software, and online services", Website = "http://Apple.com" });
            vendors.Add(new Vendor() { ID = 12, Name = "ASRock", Description = "", Website = "http://ASRock.com" });
            vendors.Add(new Vendor() { ID = 13, Name = "Asus", Description = "", Website = "http://Asus.com" });
            vendors.Add(new Vendor() { ID = 14, Name = "AVADirect", Description = "", Website = "http://AVADirect.com" });
            vendors.Add(new Vendor() { ID = 15, Name = "BenQ", Description = "", Website = "http://BenQ.com" });
            vendors.Add(new Vendor() { ID = 16, Name = "Biostar", Description = "", Website = "http://Biostar.com" });
            vendors.Add(new Vendor() { ID = 17, Name = "Chillblast", Description = "", Website = "http://Chillblast.com" });
            vendors.Add(new Vendor() { ID = 18, Name = "Clevo", Description = "", Website = "http://Clevo.com" });
            vendors.Add(new Vendor() { ID = 19, Name = "Cray", Description = "", Website = "http://Cray.com" });
            vendors.Add(new Vendor() { ID = 20, Name = "Compal", Description = "", Website = "http://Compal.com" });
            vendors.Add(new Vendor() { ID = 21, Name = "Dell", Description = "", Website = "http://Dell.com" });
            vendors.Add(new Vendor() { ID = 22, Name = "DFI", Description = "", Website = "http://DFI.com" });
            vendors.Add(new Vendor() { ID = 23, Name = "Doel (computer)", Description = "", Website = "Doel (http://compute.com" });
            vendors.Add(new Vendor() { ID = 24, Name = "Evans & Sutherland", Description = "", Website = "http://Evans.com" });
            vendors.Add(new Vendor() { ID = 25, Name = "Everex", Description = "", Website = "http://Everex.com" });
            vendors.Add(new Vendor() { ID = 26, Name = "EVGA", Description = "", Website = "http://EVGA.com" });
            vendors.Add(new Vendor() { ID = 27, Name = "FIC", Description = "", Website = "http://FIC.com" });
            vendors.Add(new Vendor() { ID = 28, Name = "Fujitsu", Description = "", Website = "http://Fujitsu.com" });
            vendors.Add(new Vendor() { ID = 29, Name = "Foxconn", Description = "", Website = "http://Foxconn.com" });
            vendors.Add(new Vendor() { ID = 30, Name = "Getac", Description = "", Website = "http://Getac.com" });
            vendors.Add(new Vendor() { ID = 31, Name = "Gigabyte", Description = "Gigabyte Technology Co., Ltd., is an international manufacturer and distributor of computer hardware products", Website = "http://Gigabyte.com" });
            vendors.Add(new Vendor() { ID = 32, Name = "Gradiente", Description = "", Website = "http://Gradiente.com" });
            vendors.Add(new Vendor() { ID = 33, Name = "Hasee", Description = "", Website = "http://Hasee.com" });
            vendors.Add(new Vendor() { ID = 34, Name = "Compaq", Description = "", Website = "http://Compaq.com" });
            vendors.Add(new Vendor() { ID = 35, Name = "Hitachi", Description = "", Website = "http://Hitachi.com" });
            vendors.Add(new Vendor() { ID = 36, Name = "HTC", Description = "HTC Corporation, Full name:, is a Taiwanese multinational manufacturer of smartphones and tablets headquartered in New Taipei City, Taiwan.", Website = "http://HTC.com" });
            vendors.Add(new Vendor() { ID = 37, Name = "Hyundai", Description = "", Website = "http://Hyundai.com" });
            vendors.Add(new Vendor() { ID = 38, Name = "IBM", Description = "", Website = "http://IBM.com" });
            vendors.Add(new Vendor() { ID = 39, Name = "IBuyPower", Description = "", Website = "http://IBuyPower.com" });
            vendors.Add(new Vendor() { ID = 40, Name = "Intel", Description = "", Website = "http://Intel.com" });
            vendors.Add(new Vendor() { ID = 41, Name = "Inventec", Description = "", Website = "http://Inventec.com" });
            vendors.Add(new Vendor() { ID = 42, Name = "Itautec", Description = "", Website = "http://Itautec.com" });
            vendors.Add(new Vendor() { ID = 43, Name = "IGEL", Description = "", Website = "http://IGEL.com" });
            vendors.Add(new Vendor() { ID = 44, Name = "Kohjinsha", Description = "", Website = "http://Kohjinsha.com" });
            vendors.Add(new Vendor() { ID = 45, Name = "LanFirePC", Description = "", Website = "http://LanFirePC.com" });
            vendors.Add(new Vendor() { ID = 46, Name = "Lanix", Description = "", Website = "http://Lanix.com" });
            vendors.Add(new Vendor() { ID = 47, Name = "Lenovo", Description = "", Website = "http://Lenovo.com" });
            vendors.Add(new Vendor() { ID = 48, Name = "Medion", Description = "", Website = "http://Medion.com" });
            vendors.Add(new Vendor() { ID = 49, Name = "LG", Description = "", Website = "http://LG.com" });
            vendors.Add(new Vendor() { ID = 50, Name = "LiteOn", Description = "", Website = "http://LiteOn.com" });
            vendors.Add(new Vendor() { ID = 51, Name = "Maingear", Description = "", Website = "http://Maingear.com" });
            vendors.Add(new Vendor() { ID = 52, Name = "Meebox", Description = "", Website = "http://Meebox.com" });
            vendors.Add(new Vendor() { ID = 53, Name = "Micron", Description = "", Website = "http://Micron.com" });
            vendors.Add(new Vendor() { ID = 54, Name = "Microsoft", Description = "", Website = "http://Microsoft.com" });
            vendors.Add(new Vendor() { ID = 55, Name = "MiTAC", Description = "", Website = "http://MiTAC.com" });
            vendors.Add(new Vendor() { ID = 56, Name = "Motorola", Description = "", Website = "http://Motorola.com" });
            vendors.Add(new Vendor() { ID = 57, Name = "NComputing", Description = "", Website = "http://NComputing.com" });
            vendors.Add(new Vendor() { ID = 58, Name = "NCR", Description = "", Website = "http://NCR.com" });
            vendors.Add(new Vendor() { ID = 59, Name = "NEC", Description = "", Website = "http://NEC.com" });
            vendors.Add(new Vendor() { ID = 60, Name = "NUDT", Description = "", Website = "http://NUDT.com" });
            vendors.Add(new Vendor() { ID = 61, Name = "NZXT", Description = "", Website = "http://NZXT.com" });
            vendors.Add(new Vendor() { ID = 62, Name = "Olidata", Description = "", Website = "http://Olidata.com" });
            vendors.Add(new Vendor() { ID = 63, Name = "Olivetti", Description = "", Website = "http://Olivetti.com" });
            vendors.Add(new Vendor() { ID = 64, Name = "Oracle", Description = "", Website = "http://Oracle.com" });
            vendors.Add(new Vendor() { ID = 65, Name = "Panasonic", Description = "", Website = "http://Panasonic.com" });
            vendors.Add(new Vendor() { ID = 66, Name = "Psychsoftpc", Description = "", Website = "http://Psychsoftpc.com" });
            vendors.Add(new Vendor() { ID = 67, Name = "RCA", Description = "", Website = "http://RCA.com" });
            vendors.Add(new Vendor() { ID = 68, Name = "Razer", Description = "", Website = "http://Razer.com" });
            vendors.Add(new Vendor() { ID = 69, Name = "RoseWill", Description = "", Website = "http://RoseWill.com" });
            vendors.Add(new Vendor() { ID = 70, Name = "Samsung", Description = "", Website = "http://Samsung.com" });
            vendors.Add(new Vendor() { ID = 71, Name = "Shuttle", Description = "", Website = "http://Shuttle.com" });
            vendors.Add(new Vendor() { ID = 72, Name = "SGI", Description = "", Website = "http://SGI.com" });
            vendors.Add(new Vendor() { ID = 73, Name = "Síragon", Description = "", Website = "http://Síragon.com" });
            vendors.Add(new Vendor() { ID = 74, Name = "Sony", Description = "", Website = "http://Sony.com" });
            vendors.Add(new Vendor() { ID = 75, Name = "StealthMachines", Description = "", Website = "http://StealthMachines.com" });
            vendors.Add(new Vendor() { ID = 76, Name = "Supermicro", Description = "", Website = "http://Supermicro.com" });
            vendors.Add(new Vendor() { ID = 77, Name = "Systemax", Description = "", Website = "http://Systemax.com" });
            vendors.Add(new Vendor() { ID = 78, Name = "System76", Description = "", Website = "http://System76.com" });
            vendors.Add(new Vendor() { ID = 79, Name = "T-Platforms", Description = "", Website = "http://T-Platform.com" });
            vendors.Add(new Vendor() { ID = 80, Name = "TabletKiosk", Description = "", Website = "http://TabletKiosk.com" });
            vendors.Add(new Vendor() { ID = 81, Name = "Tatung", Description = "", Website = "http://Tatung.com" });
            vendors.Add(new Vendor() { ID = 82, Name = "Toshiba", Description = "", Website = "http://Toshiba.com" });
            vendors.Add(new Vendor() { ID = 83, Name = "Tyan", Description = "", Website = "http://Tyan.com" });
            vendors.Add(new Vendor() { ID = 84, Name = "Unisys", Description = "", Website = "http://Unisys.com" });
            vendors.Add(new Vendor() { ID = 85, Name = "Vestel", Description = "", Website = "http://Vestel.com" });
            vendors.Add(new Vendor() { ID = 86, Name = "Venom", Description = "", Website = "http://Venom.com" });
            vendors.Add(new Vendor() { ID = 87, Name = "ViewSonic", Description = "", Website = "http://ViewSonic.com" });
            vendors.Add(new Vendor() { ID = 88, Name = "Viglen", Description = "", Website = "http://Viglen.com" });
            vendors.Add(new Vendor() { ID = 89, Name = "Vizio", Description = "", Website = "http://Vizio.com" });
            vendors.Add(new Vendor() { ID = 90, Name = "WidowPC", Description = "", Website = "http://WidowPC.com" });
            vendors.Add(new Vendor() { ID = 91, Name = "Wistron", Description = "", Website = "http://Wistron.com" });
            vendors.Add(new Vendor() { ID = 92, Name = "Wortmann", Description = "", Website = "http://Wortmann.com" });
            vendors.Add(new Vendor() { ID = 93, Name = "Xidax", Description = "", Website = "http://Xidax.com" });
            vendors.Add(new Vendor() { ID = 94, Name = "Zelybron", Description = "", Website = "http://Zelybron.com" });
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
            
            //Admins
            if (!(context.Users.Any(u => u.UserName == "admin@test.com")))
            {
                var userStore = new UserStore<ApplicationUser>(context);
                var userManager = new UserManager<ApplicationUser>(userStore);
                var userToInsert = new ApplicationUser { UserName = "admin@test.com", DepartmentID = 1, ApprovalDepartmentID = 1, Email = "admin@gustr.com", FirstName = "Admin", LastName = "Admin" };
                userManager.Create(userToInsert, "password");
                UserManager.AddToRole(userToInsert.Id,"Admin");
            }

            //Reviewers
            if (!(context.Users.Any(u => u.UserName == "reviewer@test.com")))
            {
                var userStore = new UserStore<ApplicationUser>(context);
                var userManager = new UserManager<ApplicationUser>(userStore);
                var userToInsert = new ApplicationUser { UserName = "reviewer@test.com", DepartmentID = 1, ApprovalDepartmentID = 2, Email = "reviewer@gustr.com", FirstName = "Reviewer", LastName = "Reviewer" };
                userManager.Create(userToInsert, "password");
                UserManager.AddToRole(userToInsert.Id, "Reviewer");
            }
            if (!(context.Users.Any(u => u.UserName == "abel@test.com")))
            {
                var userStore = new UserStore<ApplicationUser>(context);
                var userManager = new UserManager<ApplicationUser>(userStore);
                var userToInsert = new ApplicationUser { UserName = "abel@test.com", DepartmentID = 1, ApprovalDepartmentID = 3, Email = "abel@gustr.com", FirstName = "Abel", LastName = "Trespalacios" };
                userManager.Create(userToInsert, "password");
                UserManager.AddToRole(userToInsert.Id, "Reviewer");
            }
            if (!(context.Users.Any(u => u.UserName == "chris@test.com")))
            {
                var userStore = new UserStore<ApplicationUser>(context);
                var userManager = new UserManager<ApplicationUser>(userStore);
                var userToInsert = new ApplicationUser { UserName = "chris@test.com", DepartmentID = 1, ApprovalDepartmentID = 4, Email = "chris@gustr.com", FirstName = "Chris", LastName = "Rogers" };
                userManager.Create(userToInsert, "password");
                UserManager.AddToRole(userToInsert.Id, "Reviewer");
            }
       
            

            //Inventory Managers
            if (!(context.Users.Any(u => u.UserName == "inventory@test.com")))
            {
                var userStore = new UserStore<ApplicationUser>(context);
                var userManager = new UserManager<ApplicationUser>(userStore);
                var userToInsert = new ApplicationUser { UserName = "inventory@test.com", DepartmentID = 1, Email = "inventory@gustr.com", FirstName = "Inventory", LastName = "Inventory" };
                userManager.Create(userToInsert, "password");
                UserManager.AddToRole(userToInsert.Id, "Inventory");
            }

            //Users
            if (!(context.Users.Any(u => u.UserName == "lucas@test.com")))
            {
                var userStore = new UserStore<ApplicationUser>(context);
                var userManager = new UserManager<ApplicationUser>(userStore);
                var userToInsert = new ApplicationUser { UserName = "lucas@test.com", DepartmentID = 4, Email = "lucas.dorrough.b@gmail.com", FirstName = "Lucas", LastName = "Dorrough" };
                userManager.Create(userToInsert, "password");
                UserManager.AddToRole(userToInsert.Id, "User");
            }
            if (!(context.Users.Any(u => u.UserName == "will@test.com")))
            {
                var userStore = new UserStore<ApplicationUser>(context);
                var userManager = new UserManager<ApplicationUser>(userStore);
                var userToInsert = new ApplicationUser { UserName = "will@test.com", DepartmentID = 3, Email = "wsturner.1123@gmail.com", FirstName = "Will", LastName = "Turner" };
                userManager.Create(userToInsert, "password");
                UserManager.AddToRole(userToInsert.Id, "User");
            }
            if (!(context.Users.Any(u => u.UserName == "matt@test.com")))
            {
                var userStore = new UserStore<ApplicationUser>(context);
                var userManager = new UserManager<ApplicationUser>(userStore);
                var userToInsert = new ApplicationUser { UserName = "matt@test.com", DepartmentID = 3, Email = "maluther@uark.edu", FirstName = "Matt", LastName = "Luther" };
                userManager.Create(userToInsert, "password");
                UserManager.AddToRole(userToInsert.Id, "User");
            }
            if (!(context.Users.Any(u => u.UserName == "cory@test.com")))
            {
                var userStore = new UserStore<ApplicationUser>(context);
                var userManager = new UserManager<ApplicationUser>(userStore);
                var userToInsert = new ApplicationUser { UserName = "cory@test.com", DepartmentID = 4, Email = "cory@corywmcdonald.com ", FirstName = "Cory", LastName = "McDonald" };
                userManager.Create(userToInsert, "password");
                UserManager.AddToRole(userToInsert.Id, "User");
            }
            if (!(context.Users.Any(u => u.UserName == "erin@test.com")))
            {
                var userStore = new UserStore<ApplicationUser>(context);
                var userManager = new UserManager<ApplicationUser>(userStore);
                var userToInsert = new ApplicationUser { UserName = "erin@test.com", DepartmentID = 2, Email = "erin@gustr.com", FirstName = "Erin", LastName = "Butcher" };
                userManager.Create(userToInsert, "password");
                UserManager.AddToRole(userToInsert.Id, "User");
            }
            if (!(context.Users.Any(u => u.UserName == "andrea@test.com")))
            {
                var userStore = new UserStore<ApplicationUser>(context);
                var userManager = new UserManager<ApplicationUser>(userStore);
                var userToInsert = new ApplicationUser { UserName = "andrea@test.com", DepartmentID = 2, Email = "andrea@gustr.com", FirstName = "Andrea", LastName = "Dobbs" };
                userManager.Create(userToInsert, "password");
                UserManager.AddToRole(userToInsert.Id, "User");
            }

            if (!(context.Users.Any(u => u.UserName == "loren@test.com")))
            {
                var userStore = new UserStore<ApplicationUser>(context);
                var userManager = new UserManager<ApplicationUser>(userStore);
                var userToInsert = new ApplicationUser { UserName = "loren@test.com", DepartmentID = 2, Email = "loren@gustr.com", FirstName = "Loren", LastName = "Anthony" };
                userManager.Create(userToInsert, "password");
                UserManager.AddToRole(userToInsert.Id, "User");
            }

            #endregion

            #region InventoryItems and Purchase Orders
            List<InventoryItem> InventoryItems1 = new List<InventoryItem>();
            List<InventoryItem> InventoryItems2 = new List<InventoryItem>();
            List<InventoryItem> InventoryItems3 = new List<InventoryItem>();

            InventoryItems1.Add(new InventoryItem() {
                ID = 1,
                VendorID=33,
                Name = "Inspiron i3847-4616BK",
                Comments = "Gen 4 i5-4440/ 8GB/ 1TB/ Windows 8.1",
                Status = InventoryStatus.Unallocated,
                Price = new decimal(560.00),
                PartNumber = "i3847-4616BK"
            });
            InventoryItems1.Add(new InventoryItem()
            {
                ID = 2,
                VendorID = 33,
                Name = "Inspiron i3847-4616BK",
                Comments = "Gen 4 i5-4440/ 8GB/ 1TB/ Windows 8.1",
                Status = InventoryStatus.Unallocated,
                Price = new decimal(560.00),
                PartNumber = "i3847-4616BK"
            });
            InventoryItems1.Add(new InventoryItem()
            {
                ID = 3,
                VendorID = 55,
                Name = "One",
                Comments = "145.75 x 70.8. x 7.26 mm",
                Status = InventoryStatus.Unallocated,
                Price = new decimal(499.99),
                PartNumber = "A9"
            });
          
            InventoryItems1.Add(new InventoryItem()
            {
                ID = 4,
                VendorID = 60,
                Name = "Inspiron i3847-4616BK",
                Comments = "Gen 4 i5-4440/ 8GB/ 1TB/ Windows 8.1",
                Status = InventoryStatus.Unallocated,
                Price = new decimal(499.99),
                PartNumber = "i3847-4616BK",
            });

            InventoryItems2.Add(new InventoryItem()
            {
                ID = 5,
                VendorID = 48,
                Name = "Q21",
                Comments = "Intel Celeron N2930 Processor (1.83-2.17GHz) " + Environment.NewLine + "500GB/1TB 2.5\" HDD 5400rpm",
                Status = InventoryStatus.Unallocated,
                Price = new decimal(625.99),
                PartNumber = "Q21",
            });
            InventoryItems2.Add(new InventoryItem()
            {
                ID = 6,
                VendorID = 14,
                Name = "iPad Air 2",
                Comments = "iOS 8.1",
                Status = InventoryStatus.Allocated,
                Price = new decimal(575.00),
                PartNumber = "MC769LL",
            });
            InventoryItems2.Add(new InventoryItem()
            {
                ID = 7,
                VendorID = 14,
                Name = "iPad Air 2",
                Comments = "iOS 8.1",
                Status = InventoryStatus.Allocated,
                Price = new decimal(575.00),
                PartNumber = "MC769LL",
            });
            InventoryItems2.Add(new InventoryItem()
            {
                ID = 8,
                VendorID = 14,
                Name = "iPad Air 2",
                Comments = "iOS 8.1",
                Status = InventoryStatus.Unallocated,
                Price = new decimal(575.00),
                PartNumber = "MC769LL",
            });
            InventoryItems2.Add(new InventoryItem()
            {
                ID = 9,
                VendorID = 14,
                Name = "iPad Air 2",
                Comments = "iOS 8.1",
                Status = InventoryStatus.Unallocated,
                Price = new decimal(575.00),
                PartNumber = "MC769LL",
            });
            InventoryItems2.Add(new InventoryItem()
            {
                ID = 10,
                VendorID = 60,
                Name = "One",
                Comments = "145.75 x 70.8. x 7.26 mm",
                Status = InventoryStatus.Unallocated,
                Price = new decimal(599.99),
                PartNumber = "A9"
            });

            InventoryItems3.Add(new InventoryItem()
            {
                ID = 11,
                VendorID = 50,
                Name = "Digital A6 Color Printer",
                Status = InventoryStatus.Allocated,
                Price = new decimal(1300.00),
                PartNumber = "UPD25MD"
            });
            InventoryItems3.Add(new InventoryItem()
            {
                ID = 12,
                VendorID = 80,
                Name = "Microsoft Office Home",
                Status = InventoryStatus.Allocated,
                Price = new decimal(124.94),
                PartNumber = "79G-04368"
            });
            InventoryItems3.Add(new InventoryItem()
            {
                ID = 13,
                VendorID = 80,
                Name = "Microsoft Office Student",
                Status = InventoryStatus.Allocated,
                Price = new decimal(94.99),
                PartNumber = "79G-04332"
            });

            InventoryItems3.Add(new InventoryItem()
            {
                ID = 14,
                VendorID = 50,
                Name = "32GB Micro SDHC Card",
                Status = InventoryStatus.Allocated,
                Price = new decimal(9.99),
                PartNumber = "MB-MP32DA/AM"
            });
            InventoryItems3.Add(new InventoryItem()
            {
                ID = 15,
                VendorID = 50,
                Name = "32GB Micro SDHC Card",
                Status = InventoryStatus.Unallocated,
                Price = new decimal(9.99),
                PartNumber = "MB-MP32DA/AM"
            });
            InventoryItems3.Add(new InventoryItem()
            {
                ID = 16,
                VendorID = 50,
                Name = "32GB Micro SDHC Card",
                Status = InventoryStatus.Unallocated,
                Price = new decimal(9.99),
                PartNumber = "MB-MP32DA/AM"
            });
            InventoryItems3.Add(new InventoryItem()
            {
                ID = 17,
                VendorID = 1,
                Name = "Aspire",
                Status = InventoryStatus.Unallocated,
                Price = new decimal(465.00),
                PartNumber = "B0197Z2MN6"
            });
            InventoryItems3.Add(new InventoryItem()
            {
                ID = 18,
                VendorID = 1,
                Name = "23-Inch Screen LED-Lit Monitor",
                Status = InventoryStatus.Unallocated,
                Price = new decimal(110.48),
                PartNumber = "G236HL"
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




            #endregion



        }
    }
}

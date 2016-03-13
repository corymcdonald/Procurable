namespace Procurable.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class VendorID : DbMigration
    {
        public override void Up()
        {
            DropForeignKey("dbo.InventoryItems", "Vendor_ID", "dbo.Vendors");
            DropIndex("dbo.InventoryItems", new[] { "Vendor_ID" });
            RenameColumn(table: "dbo.InventoryItems", name: "Vendor_ID", newName: "VendorID");
            AlterColumn("dbo.InventoryItems", "VendorID", c => c.Int(nullable: false));
            CreateIndex("dbo.InventoryItems", "VendorID");
            AddForeignKey("dbo.InventoryItems", "VendorID", "dbo.Vendors", "ID", cascadeDelete: true);
        }
        
        public override void Down()
        {
            DropForeignKey("dbo.InventoryItems", "VendorID", "dbo.Vendors");
            DropIndex("dbo.InventoryItems", new[] { "VendorID" });
            AlterColumn("dbo.InventoryItems", "VendorID", c => c.Int());
            RenameColumn(table: "dbo.InventoryItems", name: "VendorID", newName: "Vendor_ID");
            CreateIndex("dbo.InventoryItems", "Vendor_ID");
            AddForeignKey("dbo.InventoryItems", "Vendor_ID", "dbo.Vendors", "ID");
        }
    }
}

namespace Procurable.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class InventoryandInventoryItem : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.Inventories",
                c => new
                    {
                        ID = c.Int(nullable: false, identity: true),
                        Location = c.String(),
                    })
                .PrimaryKey(t => t.ID);
            
            CreateTable(
                "dbo.InventoryItems",
                c => new
                    {
                        ID = c.Int(nullable: false, identity: true),
                        Name = c.String(),
                        Price = c.Decimal(nullable: false, precision: 18, scale: 2),
                        Comments = c.String(),
                        PartNumber = c.String(),
                        Location = c.String(),
                        Status = c.Int(nullable: false),
                        PurchaseOrder_ID = c.Int(),
                        Vendor_ID = c.Int(),
                        Inventory_ID = c.Int(),
                    })
                .PrimaryKey(t => t.ID)
                .ForeignKey("dbo.PurchaseOrders", t => t.PurchaseOrder_ID)
                .ForeignKey("dbo.Vendors", t => t.Vendor_ID)
                .ForeignKey("dbo.Inventories", t => t.Inventory_ID)
                .Index(t => t.PurchaseOrder_ID)
                .Index(t => t.Vendor_ID)
                .Index(t => t.Inventory_ID);
            
            CreateTable(
                "dbo.PurchaseOrders",
                c => new
                    {
                        ID = c.Int(nullable: false, identity: true),
                        Name = c.String(),
                        Price = c.Decimal(nullable: false, precision: 18, scale: 2),
                    })
                .PrimaryKey(t => t.ID);
            
        }
        
        public override void Down()
        {
            DropForeignKey("dbo.InventoryItems", "Inventory_ID", "dbo.Inventories");
            DropForeignKey("dbo.InventoryItems", "Vendor_ID", "dbo.Vendors");
            DropForeignKey("dbo.InventoryItems", "PurchaseOrder_ID", "dbo.PurchaseOrders");
            DropIndex("dbo.InventoryItems", new[] { "Inventory_ID" });
            DropIndex("dbo.InventoryItems", new[] { "Vendor_ID" });
            DropIndex("dbo.InventoryItems", new[] { "PurchaseOrder_ID" });
            DropTable("dbo.PurchaseOrders");
            DropTable("dbo.InventoryItems");
            DropTable("dbo.Inventories");
        }
    }
}

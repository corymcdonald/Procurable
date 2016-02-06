namespace Procurable.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class RequestsRequesteditemProjectTasks : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.ProjectTasks",
                c => new
                    {
                        ID = c.Int(nullable: false, identity: true),
                        ProjectID = c.Int(nullable: false),
                        Comments = c.String(),
                        DateNeeded = c.DateTime(nullable: false),
                        AssignedTo_Id = c.String(maxLength: 128),
                    })
                .PrimaryKey(t => t.ID)
                .ForeignKey("dbo.AspNetUsers", t => t.AssignedTo_Id)
                .Index(t => t.AssignedTo_Id);
            
            CreateTable(
                "dbo.RequestedItems",
                c => new
                    {
                        ID = c.Int(nullable: false, identity: true),
                        InInventory = c.Boolean(nullable: false),
                        Name = c.String(),
                        Comments = c.String(),
                        URL = c.String(),
                        Item_ID = c.Int(),
                        Request_ID = c.Int(),
                    })
                .PrimaryKey(t => t.ID)
                .ForeignKey("dbo.InventoryItems", t => t.Item_ID)
                .ForeignKey("dbo.Requests", t => t.Request_ID)
                .Index(t => t.Item_ID)
                .Index(t => t.Request_ID);
            
            CreateTable(
                "dbo.Requests",
                c => new
                    {
                        ID = c.Int(nullable: false, identity: true),
                        Name = c.String(),
                        Comments = c.String(),
                        CreatedDate = c.DateTime(nullable: false),
                        LastModified = c.DateTime(nullable: false),
                        RequestedBy_Id = c.String(maxLength: 128),
                        RequestedFor_Id = c.String(maxLength: 128),
                    })
                .PrimaryKey(t => t.ID)
                .ForeignKey("dbo.AspNetUsers", t => t.RequestedBy_Id)
                .ForeignKey("dbo.AspNetUsers", t => t.RequestedFor_Id)
                .Index(t => t.RequestedBy_Id)
                .Index(t => t.RequestedFor_Id);
            
            AddColumn("dbo.AspNetUsers", "Request_ID", c => c.Int());
            CreateIndex("dbo.AspNetUsers", "Request_ID");
            AddForeignKey("dbo.AspNetUsers", "Request_ID", "dbo.Requests", "ID");
        }
        
        public override void Down()
        {
            DropForeignKey("dbo.Requests", "RequestedFor_Id", "dbo.AspNetUsers");
            DropForeignKey("dbo.Requests", "RequestedBy_Id", "dbo.AspNetUsers");
            DropForeignKey("dbo.RequestedItems", "Request_ID", "dbo.Requests");
            DropForeignKey("dbo.AspNetUsers", "Request_ID", "dbo.Requests");
            DropForeignKey("dbo.RequestedItems", "Item_ID", "dbo.InventoryItems");
            DropForeignKey("dbo.ProjectTasks", "AssignedTo_Id", "dbo.AspNetUsers");
            DropIndex("dbo.Requests", new[] { "RequestedFor_Id" });
            DropIndex("dbo.Requests", new[] { "RequestedBy_Id" });
            DropIndex("dbo.RequestedItems", new[] { "Request_ID" });
            DropIndex("dbo.RequestedItems", new[] { "Item_ID" });
            DropIndex("dbo.AspNetUsers", new[] { "Request_ID" });
            DropIndex("dbo.ProjectTasks", new[] { "AssignedTo_Id" });
            DropColumn("dbo.AspNetUsers", "Request_ID");
            DropTable("dbo.Requests");
            DropTable("dbo.RequestedItems");
            DropTable("dbo.ProjectTasks");
        }
    }
}

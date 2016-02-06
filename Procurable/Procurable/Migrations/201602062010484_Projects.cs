namespace Procurable.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class Projects : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.Projects",
                c => new
                    {
                        ProjectID = c.Int(nullable: false, identity: true),
                        Priority = c.Int(nullable: false),
                        Status = c.Int(nullable: false),
                        CreatedDate = c.DateTime(nullable: false),
                        LastModified = c.DateTime(nullable: false),
                        Request_ID = c.Int(),
                    })
                .PrimaryKey(t => t.ProjectID)
                .ForeignKey("dbo.Requests", t => t.Request_ID)
                .Index(t => t.Request_ID);
            
            AddColumn("dbo.InventoryItems", "Project_ProjectID", c => c.Int());
            CreateIndex("dbo.InventoryItems", "Project_ProjectID");
            AddForeignKey("dbo.InventoryItems", "Project_ProjectID", "dbo.Projects", "ProjectID");
        }
        
        public override void Down()
        {
            DropForeignKey("dbo.Projects", "Request_ID", "dbo.Requests");
            DropForeignKey("dbo.InventoryItems", "Project_ProjectID", "dbo.Projects");
            DropIndex("dbo.Projects", new[] { "Request_ID" });
            DropIndex("dbo.InventoryItems", new[] { "Project_ProjectID" });
            DropColumn("dbo.InventoryItems", "Project_ProjectID");
            DropTable("dbo.Projects");
        }
    }
}

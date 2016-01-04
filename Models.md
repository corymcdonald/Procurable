#Models

This is the file describing all the models we intend to create for this project. This serves as a reference during the development and lifespan of the project.
These are all work in progress and we might need to create the ability to have custom fields for extensiability. Some of these models might not even be used

------

###Project 

Projects are used for allocating items to users. 

- ID
- Name
- Comments
- Priority: Normal, high, etc
- Ready to Deliver: bool
- Purchase order: ID for PO
- Created by 
- Last Updated
- Status
- Assigned To
- Problem Ticket
- Order information - like computers, printers, etc - We might want to put this into a seperate table

### Inventory
Used for allocating and removing things

- ID
- Name
- Comments
- Vendor Association - If they have same inventory ID
- Part number
- Location
- Status - Allocate / In

###Locations 
If they want to manage each location, perhaps a user has a specific location that they want to view inventory items for 

- ID
- Name
- Coordinates 


###Vendor information

- Vendor name
- Inventory ID
- Price


###Tasks

These are assigned to the people who are going to deliver the product

- Requested for 
- Department
- Division
- Location
- Dated Needed
- Additional Comments
- Assigned To
- Project ID
- File attachments
- Reason for Need
- Approvers


###Approver relationships
These are going to be used to so that people who have certain approval procedures can customize them

- Business unit
- Approver userID / Name


###Shipping Information
Have the ability to tie certain tasks or projects to a shipping info from fedex / usps /etc?

- Task or project info
- Tracking no


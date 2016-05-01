package com.procurable.domain.response;

import java.io.Serializable;

/**
 * Created by Matt on 4/24/2016.
 */
public class InventoryItem implements Serializable{

    private Vendor Vendor;
    private Integer ID;
    private String Name;
    private Integer VendorID;
    private Object PurchaseOrder;
    private Double Price;
    private String Comments;
    private String PartNumber;
    private Object Location;
    private Integer Status;

    public Vendor getVendor() {
        return Vendor;
    }

    public void setVendor(Vendor Vendor) {
        this.Vendor = Vendor;
    }

    public Integer getID() {
        return ID;
    }

    public void setID(Integer ID) {
        this.ID = ID;
    }

    public String getName() {
        return Name;
    }

    public void setName(String Name) {
        this.Name = Name;
    }

    public Integer getVendorID() {
        return VendorID;
    }

    public void setVendorID(Integer VendorID) {
        this.VendorID = VendorID;
    }

    public Object getPurchaseOrder() {
        return PurchaseOrder;
    }

    public void setPurchaseOrder(Object PurchaseOrder) {
        this.PurchaseOrder = PurchaseOrder;
    }

    public Double getPrice() {
        return Price;
    }

    public void setPrice(Double Price) {
        this.Price = Price;
    }

    public String getComments() {
        return Comments;
    }

    public void setComments(String Comments) {
        this.Comments = Comments;
    }

    public String getPartNumber() {
        return PartNumber;
    }

    public void setPartNumber(String PartNumber) {
        this.PartNumber = PartNumber;
    }

    public Object getLocation() {
        return Location;
    }

    public void setLocation(Object Location) {
        this.Location = Location;
    }

    public Integer getStatus() {
        return Status;
    }

    public void setStatus(Integer Status) {
        this.Status = Status;
    }
}
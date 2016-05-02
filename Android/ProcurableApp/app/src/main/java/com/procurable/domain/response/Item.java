
package com.procurable.domain.response;

import java.io.Serializable;

public class Item implements Serializable{

    private Object PurchaseOrder;
    private Vendor Vendor;
    private Integer ID;
    private String Name;
    private Integer VendorID;
    private Object PurchaseOrderID;
    private Double Price;
    private Object Comments;
    private String PartNumber;
    private Object Location;
    private Integer Status;
    private Object DepreciationRemaining;
    private Object Depreciation;
    private DepreciationDate DepreciationDate;

    /**
     * 
     * @return
     *     The PurchaseOrder
     */
    public Object getPurchaseOrder() {
        return PurchaseOrder;
    }

    /**
     * 
     * @param PurchaseOrder
     *     The PurchaseOrder
     */
    public void setPurchaseOrder(Object PurchaseOrder) {
        this.PurchaseOrder = PurchaseOrder;
    }

    /**
     * 
     * @return
     *     The Vendor
     */
    public Vendor getVendor() {
        return Vendor;
    }

    /**
     * 
     * @param Vendor
     *     The Vendor
     */
    public void setVendor(Vendor Vendor) {
        this.Vendor = Vendor;
    }

    /**
     * 
     * @return
     *     The ID
     */
    public Integer getID() {
        return ID;
    }

    /**
     * 
     * @param ID
     *     The ID
     */
    public void setID(Integer ID) {
        this.ID = ID;
    }

    /**
     * 
     * @return
     *     The Name
     */
    public String getName() {
        return Name;
    }

    /**
     * 
     * @param Name
     *     The Name
     */
    public void setName(String Name) {
        this.Name = Name;
    }

    /**
     * 
     * @return
     *     The VendorID
     */
    public Integer getVendorID() {
        return VendorID;
    }

    /**
     * 
     * @param VendorID
     *     The VendorID
     */
    public void setVendorID(Integer VendorID) {
        this.VendorID = VendorID;
    }

    /**
     * 
     * @return
     *     The PurchaseOrderID
     */
    public Object getPurchaseOrderID() {
        return PurchaseOrderID;
    }

    /**
     * 
     * @param PurchaseOrderID
     *     The PurchaseOrderID
     */
    public void setPurchaseOrderID(Object PurchaseOrderID) {
        this.PurchaseOrderID = PurchaseOrderID;
    }

    /**
     * 
     * @return
     *     The Price
     */
    public Double getPrice() {
        return Price;
    }

    /**
     * 
     * @param Price
     *     The Price
     */
    public void setPrice(Double Price) {
        this.Price = Price;
    }

    /**
     * 
     * @return
     *     The Comments
     */
    public Object getComments() {
        return Comments;
    }

    /**
     * 
     * @param Comments
     *     The Comments
     */
    public void setComments(Object Comments) {
        this.Comments = Comments;
    }

    /**
     * 
     * @return
     *     The PartNumber
     */
    public String getPartNumber() {
        return PartNumber;
    }

    /**
     * 
     * @param PartNumber
     *     The PartNumber
     */
    public void setPartNumber(String PartNumber) {
        this.PartNumber = PartNumber;
    }

    /**
     * 
     * @return
     *     The Location
     */
    public Object getLocation() {
        return Location;
    }

    /**
     * 
     * @param Location
     *     The Location
     */
    public void setLocation(Object Location) {
        this.Location = Location;
    }

    /**
     * 
     * @return
     *     The Status
     */
    public Integer getStatus() {
        return Status;
    }

    /**
     * 
     * @param Status
     *     The Status
     */
    public void setStatus(Integer Status) {
        this.Status = Status;
    }

    /**
     * 
     * @return
     *     The DepreciationRemaining
     */
    public Object getDepreciationRemaining() {
        return DepreciationRemaining;
    }

    /**
     * 
     * @param DepreciationRemaining
     *     The DepreciationRemaining
     */
    public void setDepreciationRemaining(Object DepreciationRemaining) {
        this.DepreciationRemaining = DepreciationRemaining;
    }

    /**
     * 
     * @return
     *     The Depreciation
     */
    public Object getDepreciation() {
        return Depreciation;
    }

    /**
     * 
     * @param Depreciation
     *     The Depreciation
     */
    public void setDepreciation(Object Depreciation) {
        this.Depreciation = Depreciation;
    }

    /**
     * 
     * @return
     *     The DepreciationDate
     */
    public DepreciationDate getDepreciationDate() {
        return DepreciationDate;
    }

    /**
     * 
     * @param DepreciationDate
     *     The DepreciationDate
     */
    public void setDepreciationDate(DepreciationDate DepreciationDate) {
        this.DepreciationDate = DepreciationDate;
    }

}

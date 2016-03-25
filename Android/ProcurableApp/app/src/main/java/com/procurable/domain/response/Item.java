package com.procurable.domain.response;

/**
 * Created by Matt on 3/23/2016.
 */
import java.util.HashMap;
import java.util.Map;

public class Item {

    private String Name;
    private Double Price;
    private String Comments;
    private String PartNumber;
    private String Status;
    private Integer VendorID;
    private Map<String, Object> additionalProperties = new HashMap<String, Object>();

    public String getName() {
        return Name;
    }

    public void setName(String Name) {
        this.Name = Name;
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

    public String getStatus() {
        return Status;
    }

    public void setStatus(String Status) {
        this.Status = Status;
    }

    public Integer getVendorID() {
        return VendorID;
    }

    public void setVendorID(Integer VendorID) {
        this.VendorID = VendorID;
    }

    public Map<String, Object> getAdditionalProperties() {
        return this.additionalProperties;
    }

    public void setAdditionalProperty(String name, Object value) {
        this.additionalProperties.put(name, value);
    }
}
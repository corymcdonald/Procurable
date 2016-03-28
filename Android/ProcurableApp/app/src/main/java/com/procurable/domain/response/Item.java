package com.procurable.domain.response;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by Matt on 3/27/2016.
 */
public class Item {
    private String Name;
    private Double Price;
    private String Comments;
    private String PartNumber;
    private String Status;
    private Integer VendorID;

    public Map<String, Object> getAdditionalProperties() {
        return additionalProperties;
    }

    public void setAdditionalProperties(Map<String, Object> additionalProperties) {
        this.additionalProperties = additionalProperties;
    }

    public String getComments() {
        return Comments;
    }

    public void setComments(String comments) {
        Comments = comments;
    }

    public String getName() {
        return Name;
    }

    public void setName(String name) {
        Name = name;
    }

    public String getPartNumber() {
        return PartNumber;
    }

    public void setPartNumber(String partNumber) {
        PartNumber = partNumber;
    }

    public Double getPrice() {
        return Price;
    }

    public void setPrice(Double price) {
        Price = price;
    }

    public String getStatus() {
        return Status;
    }

    public void setStatus(String status) {
        Status = status;
    }

    public Integer getVendorID() {
        return VendorID;
    }

    public void setVendorID(Integer vendorID) {
        VendorID = vendorID;
    }

    private Map<String, Object> additionalProperties = new HashMap<String, Object>();
}

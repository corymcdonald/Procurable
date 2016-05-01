package com.procurable.domain.response;

/**
 * Created by Matt on 3/23/2016.
 */
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Request implements Serializable {

    private List<RequestItem> Items = new ArrayList<RequestItem>();
    //private Person RequestedBy;


   // private Person requestItems;
    private Integer ID;


    private String Name;
    private String Comments;

    private String CreatedDate;
    private Date CreatedDateDisplay;
    private String LastModified;
    private Date LastModifiedDisplay;
    private Integer Status;
    private String StatusDisplay;
    /*public Person getRequestedBy() {
        return RequestedBy;
    }

    public void setRequestedBy(Person requestedBy) {
        RequestedBy = requestedBy;
    }

    public Person getRequestedFor() {
        return requestItems;
    }

    public void setRequestedFor(Person requestedFor) {
        requestItems = requestedFor;
    }*/
    private Map<String, Object> additionalProperties = new HashMap<String, Object>();

    public String getComments() {
        return Comments;
    }

    public void setComments(String comments) {
        Comments = comments;
    }

    public String getCreatedDate() {
        return CreatedDate;
    }

    public void setCreatedDate(String createdDate) {
        CreatedDate = createdDate;
    }

    public Date getCreatedDateDisplay() {
        return CreatedDateDisplay;
    }

    public void setCreatedDateDisplay(Date createdDateDisplay) {
        CreatedDateDisplay = createdDateDisplay;
    }

    public Integer getID() {
        return ID;
    }

    public void setID(Integer ID) {
        this.ID = ID;
    }

    public List<RequestItem> getRequestItems() {
        return Items;
    }

    public void setRequestItems(List<RequestItem> requestItems) {
        Items = requestItems;
    }

    public String getLastModified() {
        return LastModified;
    }

    public void setLastModified(String lastModified) {
        LastModified = lastModified;
    }

    public Date getLastModifiedDisplay() {
        return LastModifiedDisplay;
    }

    public void setLastModifiedDisplay(Date lastModifiedDisplay) {
        LastModifiedDisplay = lastModifiedDisplay;
    }

    public String getName() {
        return Name;
    }

    public void setName(String name) {
        Name = name;
    }

    public Integer getStatus() {
        return Status;
    }

    public void setStatus(Integer status) {
        Status = status;
    }

    public String getStatusDisplay() {
        return StatusDisplay;
    }

    public void setStatusDisplay(String statusDisplay) {
        StatusDisplay = statusDisplay;
    }

    public Map<String, Object> getAdditionalProperties() {
        return additionalProperties;
    }

    public void setAdditionalProperties(Map<String, Object> additionalProperties) {
        this.additionalProperties = additionalProperties;
    }
}
package com.procurable.domain.response;

/**
 * Created by Matt on 3/23/2016.
 */
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Request {

    private List<Object> Approvers = new ArrayList<Object>();
    private List<Item> Items = new ArrayList<Item>();
    private Integer ID;
    private String Name;
    private String Comments;
    private String RequestedFor;
    private String RequestedBy;
    private String CreatedDate;
    private String LastModified;
    private Map<String, Object> additionalProperties = new HashMap<String, Object>();

    public List<Object> getApprovers() {
        return Approvers;
    }

    public void setApprovers(List<Object> Approvers) {
        this.Approvers = Approvers;
    }

    public List<Item> getItems() {
        return Items;
    }

    public void setItems(List<Item> Items) {
        this.Items = Items;
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

    public String getComments() {
        return Comments;
    }

    public void setComments(String Comments) {
        this.Comments = Comments;
    }

    public Object getRequestedFor() {
        return RequestedFor;
    }

    public void setRequestedFor(String RequestedFor) {
        this.RequestedFor = RequestedFor;
    }

    public Object getRequestedBy() {
        return RequestedBy;
    }

    public void setRequestedBy(String RequestedBy) {
        this.RequestedBy = RequestedBy;
    }

    public String getCreatedDate() {
        return CreatedDate;
    }

    public void setCreatedDate(String CreatedDate) {
        this.CreatedDate = CreatedDate;
    }

    public String getLastModified() {
        return LastModified;
    }

    public void setLastModified(String LastModified) {
        this.LastModified = LastModified;
    }

    public Map<String, Object> getAdditionalProperties() {
        return this.additionalProperties;
    }

    public void setAdditionalProperty(String name, Object value) {
        this.additionalProperties.put(name, value);
    }

}
package com.procurable.domain.response;

/**
 * Created by Matt on 3/6/2016.
 */
public class Project {
    String[] Items;
    String Request;
    Integer Priority;
    Integer Status;
    String CreatedDate;
    String LastModified;
    Integer ProjectID;

    public Integer getProjectID() {
        return ProjectID;
    }

    public void setProjectID(Integer projectID) {
        ProjectID = projectID;
    }

    public String[] getItems() {
        return Items;
    }

    public void setItems(String[] items) {
        Items = items;
    }

    public String getRequest() {
        return Request;
    }

    public void setRequest(String request) {
        Request = request;
    }

    public Integer getPriority() {
        return Priority;
    }

    public void setPriority(Integer priority) {
        Priority = priority;
    }

    public Integer getStatus() {
        return Status;
    }

    public void setStatus(Integer status) {
        Status = status;
    }

    public String getCreatedDate() {
        return CreatedDate;
    }

    public void setCreatedDate(String createdDate) {
        CreatedDate = createdDate;
    }

    public String getLastModified() {
        return LastModified;
    }

    public void setLastModified(String lastModified) {
        LastModified = lastModified;
    }


}

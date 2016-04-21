package com.procurable.domain.response;

import com.procurable.domain.enums.ProjectPriority;
import com.procurable.domain.enums.ProjectStatus;

import java.util.Date;

/**
 * Created by Matt on 3/6/2016.
 */
public class Project {

    public Project() {
        this.Priority = 0;
        this.Status = 0;
    }
    String[] Items;
    String Request;
    Integer Priority;
    Integer Status;
    Date CreatedDate;
    Date LastModified;
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

    public Date getCreatedDate() {
        return CreatedDate;
    }

    public void setCreatedDate(Date createdDate) {
        CreatedDate = createdDate;
    }

    public Date getLastModified() {
        return LastModified;
    }

    public void setLastModified(Date lastModified) {
        LastModified = lastModified;
    }


}

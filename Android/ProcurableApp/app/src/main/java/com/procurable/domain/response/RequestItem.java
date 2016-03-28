package com.procurable.domain.response;

/**
 * Created by Matt on 3/23/2016.
 */
import java.util.HashMap;
import java.util.Map;

public class RequestItem {

    private Integer ID;
    private Boolean InInventory;
    private String Name;

    private String Comments;
    private String Url;

    public Item getRequestItem() {
        return RequestItem;
    }

    public void setRequestItem(Item requestItem) {
        RequestItem = requestItem;
    }

    private Item RequestItem;
    private Map<String, Object> additionalProperties = new HashMap<String, Object>();

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

    public Integer getID() {
        return ID;
    }

    public void setID(Integer ID) {
        this.ID = ID;
    }

    public Boolean getInInventory() {
        return InInventory;
    }

    public void setInInventory(Boolean inInventory) {
        InInventory = inInventory;
    }

    public String getName() {
        return Name;
    }

    public void setName(String name) {
        Name = name;
    }

    public String getUrl() {
        return Url;
    }

    public void setUrl(String url) {
        Url = url;
    }

}
package com.procurable.domain.request;

/**
 * Created by Matt on 4/30/2016.
 */
public class ItemRequest {
    String Name;
    String Url;
    String Comments;

    public String getComments() {
        return Comments;
    }

    public void setComments(String comments) {
        this.Comments = comments;
    }

    public String getUrl() {
        return Url;
    }

    public void setUrl(String url) {
        this.Url = url;
    }

    public String getName() {
        return Name;
    }

    public void setName(String name) {
        this.Name = name;
    }

}

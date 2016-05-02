package com.procurable.domain.request;

/**
 * Created by Matt on 5/1/2016.
 */
public class CreateRequestRequest {
    String Name;
    String Comments;
    ItemRequest[] Items;

    public String getComments() {
        return Comments;
    }

    public void setComments(String comments) {
        Comments = comments;
    }

    public ItemRequest[] getItems() {
        return Items;
    }

    public void setItems(ItemRequest[] items) {
        Items = items;
    }

    public String getName() {
        return Name;
    }

    public void setName(String name) {
        Name = name;
    }

}

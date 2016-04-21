package com.procurable.domain.response;

/**
 * Created by Matt on 3/6/2016.
 */
public class Inventory {
    String[] Items;
    Integer ID;
    String Location;

    public String[] getItems() {
        return Items;
    }

    public void setItems(String[] items) {
        Items = items;
    }

    public String getLocation() {
        return Location;
    }

    public void setLocation(String location) {
        Location = location;
    }

    public Integer getID() {
        return ID;
    }

    public void setID(Integer ID) {
        this.ID = ID;
    }
}

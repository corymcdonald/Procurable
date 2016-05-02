package com.procurable.domain;

import com.procurable.domain.response.InventoryItem;

/**
 * Created by Matt on 4/24/2016.
 */
public class ItemSearchRow {
    private String title;
    private String price;
    private InventoryItem item;

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }


    public InventoryItem getItem() {
        return item;
    }

    public void setItem(InventoryItem item) {
        this.item = item;
    }
}

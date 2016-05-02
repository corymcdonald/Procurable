package com.procurable.utils;

import android.content.Context;
import android.view.inputmethod.InputMethodManager;

import com.procurable.domain.ItemInCart;
import com.procurable.domain.NewItemRow;
import com.procurable.domain.request.ItemRequest;
import com.procurable.domain.response.InventoryItem;
import com.procurable.domain.response.Item;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Matt on 4/30/2016.
 */
public class ItemUtilities {

    public static List<ItemRequest> convertItemInCartToItemRequests(ItemInCart itemInCart) {
        List<ItemRequest> itemRequests = new ArrayList<ItemRequest>();
        for (int i = 0; i < itemInCart.getCount(); i++) {
            ItemRequest item = new ItemRequest();
            item.setComments(itemInCart.getComments());
            item.setName(itemInCart.getName());
            item.setUrl(itemInCart.getUrl());
            itemRequests.add(item);
        }
        return itemRequests;
    }

    public static ItemInCart convertInventoryItemsToItemInCart(InventoryItem inventoryItem, Integer count, String comments) {
        ItemInCart item = new ItemInCart();
        item.setComments(comments);
        item.setName(inventoryItem.getName());
        item.setCount(count);
        item.setUrl("");

        String priceText = "Not found";
        Double priceNumber = Double.MAX_VALUE;
        for(int j = 0; j < inventoryItem.getItem().size(); j++)
        {
            if(inventoryItem.getItem().get(j).getPrice() != null && inventoryItem.getItem().get(j).getPrice() < priceNumber)
                priceNumber = inventoryItem.getItem().get(j).getPrice();
        }
        if(priceNumber != Double.MAX_VALUE)
            priceText = priceNumber.toString();
        item.setPrice(priceText);

        return item;
    }

    public static NewItemRow convertAddedItemToNewItemRow(ItemInCart itemInCart)
    {
        NewItemRow newItemRow = new NewItemRow();
        newItemRow.setQuantity("Amount requested: " + itemInCart.getCount());
        newItemRow.setPrice("Price: " + itemInCart.getPrice());
        newItemRow.setTitle("Item Name: " + itemInCart.getName());
        return newItemRow;
    }

}

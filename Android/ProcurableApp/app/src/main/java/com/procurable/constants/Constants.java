package com.procurable.constants;

import android.support.v7.widget.RecyclerView;

import com.procurable.adapter.RecyclerAdapter;
import com.procurable.domain.response.Inventory;
import com.procurable.domain.response.InventoryItem;
import com.procurable.domain.response.Item;

import java.util.ArrayList;
import java.util.List;

import okhttp3.OkHttpClient;
import retrofit2.Retrofit;

/**
 * Created by Matt on 2/22/2016.
 */
public class Constants {
    public static final String BASE_URL = "http://procurable.azurewebsites.net/";
    public static OkHttpClient client;
    public static Retrofit retrofit;
    public static String EXTRA_ITEMS = "com.procurable.ITEMS";
    public static String INVENTORY_ITEM = "com.procurable.INVENTORY_ITEM";
    public static List<InventoryItem> cartItems = new ArrayList<InventoryItem>();
}
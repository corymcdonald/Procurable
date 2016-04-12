package com.procurable.constants;

import android.support.v7.widget.RecyclerView;

import com.procurable.adapter.RecyclerAdapter;

import okhttp3.OkHttpClient;
import retrofit2.Retrofit;

/**
 * Created by Matt on 2/22/2016.
 */
public class Constants {
    public static final String BASE_URL = "http://procurabledev.azurewebsites.net/";
    public static OkHttpClient client;
    public static Retrofit retrofit;
    public static String EXTRA_ITEMS = "com.procurable.ITEMS";
}


package com.procurable.service;

import android.content.Intent;
import android.support.annotation.IntegerRes;

import com.procurable.domain.request.CreateRequestRequest;
import com.procurable.domain.request.LoginRequest;
import com.procurable.domain.request.RegisterRequest;
import com.procurable.domain.request.UpdateStatusRequest;
import com.procurable.domain.response.Department;
import com.procurable.domain.response.GenericResponse;
import com.procurable.domain.response.Inventory;
import com.procurable.domain.response.InventoryItem;
import com.procurable.domain.response.Project;
import com.procurable.domain.response.Request;

import java.util.List;

import retrofit2.Call;
import retrofit2.http.Body;
import retrofit2.http.GET;
import retrofit2.http.Headers;
import retrofit2.http.POST;
import retrofit2.http.Path;
import retrofit2.http.Query;

/**
 * Created by Matt on 2/22/2016.
 */
public interface ProcurableService {

    @Headers({"Content-Type: application/json", "Accept: application/json"})
    @POST("Account/Register")
    Call<GenericResponse> register(@Body RegisterRequest registerRequest);

    @Headers({"Content-Type: application/json", "Accept: application/json"})
    @POST("Account/Login")
    Call<GenericResponse> login(@Body LoginRequest loginRequest);

    @Headers({"Content-Type: application/json", "Accept: application/json"})
    @GET("Inventories")
    Call<Inventory[]> inventory();

    @Headers({"Content-Type: application/json", "Accept: application/json"})
    @GET("Projects")
    Call<Project[]> projects();

    @Headers({"Content-Type: application/json", "Accept: application/json"})
    @POST("Projects/Create")
    Call<GenericResponse> projectCreate(@Body Project project);

    @Headers({"Content-Type: application/json", "Accept: application/json"})
    @GET("requests")
    Call<Request[]> myRequests();

    @Headers({"Content-Type: application/json", "Accept: application/json"})
    @GET("requests")
    Call<Request[]> requestsToApprove();

    @Headers({"Content-Type: application/json", "Accept: application/json"})
    @POST("requests/Create")
    Call<Request[]> createRequest(@Body CreateRequestRequest createRequestRequest);

    @Headers({"Content-Type: application/json", "Accept: application/json"})
    @GET("InventoryItems")
    Call<InventoryItem[]> inventoryItems();

    @Headers({"Content-Type: application/json", "Accept: application/json"})
    @GET("InventoryItems/search")
    Call<InventoryItem[]> searchInventoryItems(@Query("query")String query);

    @Headers({"Content-Type: application/json", "Accept: application/json"})
    @POST("/requests/UpdateStatus/{id}")
    Call<Object> updateStatus(@Body UpdateStatusRequest updateStatusRequest, @Path("id")Integer id);

    @Headers({"Content-Type: application/json", "Accept: application/json"})
    @GET("Departments")
    Call<List<Department>> departments();
}
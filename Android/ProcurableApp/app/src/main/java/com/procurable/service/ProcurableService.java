package com.procurable.service;

import com.procurable.domain.request.LoginRequest;
import com.procurable.domain.request.RegisterRequest;
import com.procurable.domain.response.GenericResponse;

import retrofit2.Call;
import retrofit2.http.Body;
import retrofit2.http.Headers;
import retrofit2.http.POST;

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
}
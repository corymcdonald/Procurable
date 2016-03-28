package com.procurable.domain;

import com.procurable.activity.ManageRequest;
import com.procurable.constants.Constants;
import com.procurable.domain.response.Request;
import com.procurable.service.ProcurableService;

import java.util.ArrayList;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class RequestRow {

	private String title;
	private String description;
	private Request request;

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Request getRequest() {
		return request;
	}

	public void setRequest(Request request) {
		this.request = request;
	}

}
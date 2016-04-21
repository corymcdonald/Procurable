package com.procurable.activity;

import android.animation.Animator;
import android.animation.AnimatorListenerAdapter;
import android.annotation.TargetApi;
import android.os.Build;
import android.support.v4.widget.DrawerLayout;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.DefaultItemAnimator;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.support.v7.widget.Toolbar;
import android.view.View;

import com.procurable.adapter.RecyclerAdapter;
import com.procurable.capstone.R;
import com.procurable.constants.Constants;
import com.procurable.domain.RequestRow;
import com.procurable.domain.response.Request;
import com.procurable.service.ProcurableService;

import java.util.ArrayList;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class ManageRequest extends AppCompatActivity {

    Toolbar toolbar;
    View mRequestView;
    View mProgressView;
    RecyclerView recyclerView;
    RecyclerAdapter adapter;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_manage_request);

        setUpToolbar();
        setUpRecyclerView();
        setUpDrawer();
        showProgress(true);
    }
    private void setUpRecyclerView() {

        recyclerView = (RecyclerView) findViewById(R.id.recyclerView);
        adapter = new RecyclerAdapter(this, getData());

        recyclerView.setAdapter(adapter);

        LinearLayoutManager mLinearLayoutManagerVertical = new LinearLayoutManager(this); // (Context context, int spanCount)
        mLinearLayoutManagerVertical.setOrientation(LinearLayoutManager.VERTICAL);
        recyclerView.setLayoutManager(mLinearLayoutManagerVertical);

        recyclerView.setItemAnimator(new DefaultItemAnimator());
    }


    private void setUpToolbar() {
        toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);
        getSupportActionBar().setTitle("Manage Requests");
    }
    private void setUpDrawer() {
        NavigationDrawerFragment drawerFragment = (NavigationDrawerFragment) getSupportFragmentManager().findFragmentById(R.id.nav_drwr_fragment);
        DrawerLayout drawerLayout = (DrawerLayout) findViewById(R.id.drawer_layout);
        drawerFragment.setUpDrawer(R.id.nav_drwr_fragment, drawerLayout, toolbar);
    }

    @TargetApi(Build.VERSION_CODES.HONEYCOMB_MR2)
    private void showProgress(final boolean show) {
        // On Honeycomb MR2 we have the ViewPropertyAnimator APIs, which allow
        // for very easy animations. If available, use these APIs to fade-in
        // the progress spinner.
        mRequestView = findViewById(R.id.recyclerView);
        mProgressView = findViewById(R.id.request_process);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB_MR2) {
            int shortAnimTime = getResources().getInteger(android.R.integer.config_shortAnimTime);

            mRequestView.setVisibility(show ? View.GONE : View.VISIBLE);
            mRequestView.animate().setDuration(shortAnimTime).alpha(
                    show ? 0 : 1).setListener(new AnimatorListenerAdapter() {
                @Override
                public void onAnimationEnd(Animator animation) {
                    mRequestView.setVisibility(show ? View.GONE : View.VISIBLE);
                }
            });

            mProgressView.setVisibility(show ? View.VISIBLE : View.GONE);
            mProgressView.animate().setDuration(shortAnimTime).alpha(
                    show ? 1 : 0).setListener(new AnimatorListenerAdapter() {
                @Override
                public void onAnimationEnd(Animator animation) {
                    mProgressView.setVisibility(show ? View.VISIBLE : View.GONE);
                }
            });
        } else {
            // The ViewPropertyAnimator APIs are not available, so simply show
            // and hide the relevant UI components.
            mProgressView.setVisibility(show ? View.VISIBLE : View.GONE);
            mRequestView.setVisibility(show ? View.GONE : View.VISIBLE);
        }
    }


    public ArrayList<RequestRow> getData() {

        final ArrayList<RequestRow> dataList = new ArrayList<>();

        ProcurableService procurableService = Constants.retrofit.create(ProcurableService.class);
        Call<Request[]> call = procurableService.requests();
        call.enqueue(new Callback<Request[]>() {
            @Override
            public void onResponse(Call<Request[]> call, Response<Request[]> response) {
                for (int i = 0; i < response.body().length; i++) {

                    RequestRow landscape = new RequestRow();
                    landscape.setTitle(response.body()[i].getName());
                    landscape.setDescription(response.body()[i].getID().toString());
                    landscape.setRequest(response.body()[i]);
                    dataList.add(landscape);
                }
                adapter.mData = dataList;
                recyclerView.setAdapter(adapter);
                showProgress(false);
            }

            @Override
            public void onFailure(Call<Request[]> call, Throwable t) {
                System.out.println();
            }
        });
        return dataList;
    }
}

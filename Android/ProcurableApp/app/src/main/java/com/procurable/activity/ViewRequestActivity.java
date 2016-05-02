package com.procurable.activity;

import android.content.Intent;
import android.os.Bundle;
import android.support.v4.widget.DrawerLayout;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.DefaultItemAnimator;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.support.v7.widget.Toolbar;
import android.view.View;
import android.widget.TextView;

import com.procurable.adapter.ItemRecyclerAdapter;
import com.procurable.capstone.R;
import com.procurable.constants.Constants;
import com.procurable.domain.ItemRow;
import com.procurable.domain.response.Request;
import com.procurable.domain.response.RequestItem;
import com.procurable.service.WrappingLinearLayoutManager;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

public class ViewRequestActivity extends AppCompatActivity {

    Toolbar toolbar;
    RecyclerView recyclerView;
    ItemRecyclerAdapter adapter;
    View mRequestView;
    View mProgressView;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_view_request);
        setUpPage();
        setUpToolbar();
        setUpDrawer();
        setUpRecyclerView();
    }

    private void setUpPage() {
        Intent intent = getIntent();
        Request request = (Request)intent.getSerializableExtra(Constants.EXTRA_ITEMS);
        TextView textView = (TextView) findViewById(R.id.textView);
        if(request.getStatus() == 0)
            textView.setText("Status: Opened");
        else if(request.getStatus() == 1)
            textView.setText("Status: Reopened");
        else if(request.getStatus() == 2)
            textView.setText("Status: Approved");
        else if(request.getStatus() == 3)
            textView.setText("Status: Denied");
        else if(request.getStatus() == 4)
            textView.setText("Status: In Progress");
        else if(request.getStatus() == 5)
            textView.setText("Status: Completed");
        TextView requestId = (TextView) findViewById(R.id.request_id);
        TextView requestDate = (TextView) findViewById(R.id.request_date);
        requestId.setText("Request ID: " + request.getID().toString());
        SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
        String formattedDate = formatter.format(request.getCreatedDateDisplay());
        requestDate.setText("Request Date: " + formattedDate);

    }

    private void setUpDrawer() {
        NavigationDrawerFragment drawerFragment = (NavigationDrawerFragment) getSupportFragmentManager().findFragmentById(R.id.nav_drwr_fragment);
        DrawerLayout drawerLayout = (DrawerLayout) findViewById(R.id.drawer_layout);
        drawerFragment.setUpDrawer(R.id.nav_drwr_fragment, drawerLayout, toolbar);
    }

    private void setUpToolbar() {
        toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);
        getSupportActionBar().setTitle("View Request");
    }

    private void setUpRecyclerView() {

        recyclerView = (RecyclerView) findViewById(R.id.item_recycler_view);
        Intent intent = getIntent();
        adapter = new ItemRecyclerAdapter(this, getData((Request)intent.getSerializableExtra(Constants.EXTRA_ITEMS)));

        recyclerView.setAdapter(adapter);

        LinearLayoutManager mLinearLayoutManagerVertical = new LinearLayoutManager(this); // (Context context, int spanCount)
        mLinearLayoutManagerVertical.setOrientation(LinearLayoutManager.VERTICAL);
        recyclerView.setLayoutManager(mLinearLayoutManagerVertical);

        recyclerView.setItemAnimator(new DefaultItemAnimator());
        //recyclerView.setLayoutManager(new WrappingLinearLayoutManager(this));
        //recyclerView.setNestedScrollingEnabled(false);
        recyclerView.setHasFixedSize(false);
    }
    public ArrayList<ItemRow> getData(Request request) {

        final ArrayList<ItemRow> dataList = new ArrayList<>();
        List<RequestItem> requestItems = request.getRequestItems();
        for (int i = 0; i < requestItems.size(); i++) {

            ItemRow landscape = new ItemRow();
            landscape.setTitle("Item Name: " + requestItems.get(i).getName());
            //landscape.setPrice(requestItems.get(i).getRequestItem().getPrice().toString());
            landscape.setComments("Request Reason: " + requestItems.get(i).getComments());

            dataList.add(landscape);
        }
        return dataList;
    }
}
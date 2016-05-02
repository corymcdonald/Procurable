package com.procurable.activity;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.support.v4.widget.DrawerLayout;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.DefaultItemAnimator;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.support.v7.widget.Toolbar;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import com.procurable.adapter.ItemRecyclerAdapter;
import com.procurable.capstone.R;
import com.procurable.constants.Constants;
import com.procurable.domain.ItemRow;
import com.procurable.domain.request.UpdateStatusRequest;
import com.procurable.domain.response.Request;
import com.procurable.domain.response.RequestItem;
import com.procurable.service.ProcurableService;
import com.procurable.service.WrappingLinearLayoutManager;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class ApproveRequestActivity extends AppCompatActivity {

    Toolbar toolbar;
    RecyclerView recyclerView;
    ItemRecyclerAdapter adapter;
    View mRequestView;
    View mProgressView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_approve_request);
        setUpPage();
        setUpToolbar();
        setUpDrawer();
        setUpRecyclerView();
        setUpButtons();
    }

    private void setUpButtons() {
        Button approve = (Button) findViewById(R.id.Approve);
        approve.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                changeStatus(true);
            }
        });
        Button deny = (Button) findViewById(R.id.Deny);
        deny.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                changeStatus(false);
            }
        });
    }

    private void changeStatus(final boolean isApproved) {
        Intent intent = getIntent();
        Request request = (Request) intent.getSerializableExtra(Constants.EXTRA_ITEMS);
        ProcurableService procurableService = Constants.retrofit.create(ProcurableService.class);
        UpdateStatusRequest updateStatusRequest;
        if (isApproved)
            updateStatusRequest = new UpdateStatusRequest(2);
        else
            updateStatusRequest = new UpdateStatusRequest(3);
        Call<Object> call = procurableService.updateStatus(updateStatusRequest, request.getID());
        call.enqueue(new Callback<Object>() {
            @Override
            public void onResponse(Call<Object> call, Response<Object> response) {
                AlertDialog.Builder alertDialogBuilder = new AlertDialog.Builder(
                        ApproveRequestActivity.this);
                if(isApproved)
                    alertDialogBuilder.setTitle("Processed Approval");
                else
                    alertDialogBuilder.setTitle("Processed Denial");
                alertDialogBuilder
                        .setPositiveButton("Okay", new DialogInterface.OnClickListener() {
                            public void onClick(DialogInterface dialog, int id) {
                                Intent intent2 = new Intent(ApproveRequestActivity.this, ManageRequest.class);
                                startActivity(intent2);
                            }
                        });
                AlertDialog alertDialog = alertDialogBuilder.create();
                alertDialog.show();
            }

            @Override
            public void onFailure(Call<Object> call, Throwable t) {
                AlertDialog.Builder alertDialogBuilder = new AlertDialog.Builder(
                        ApproveRequestActivity.this);
                if(isApproved)
                    alertDialogBuilder.setTitle("Processed Approval");
                else
                    alertDialogBuilder.setTitle("Processed Denial");
                alertDialogBuilder
                        .setPositiveButton("Okay", new DialogInterface.OnClickListener() {
                            public void onClick(DialogInterface dialog, int id) {
                                Intent intent2 = new Intent(ApproveRequestActivity.this, ManageRequest.class);
                                startActivity(intent2);
                            }
                        });
                AlertDialog alertDialog = alertDialogBuilder.create();
                alertDialog.show();
            }
        });
    }

    private void setUpPage() {
        Intent intent = getIntent();
        Request request = (Request) intent.getSerializableExtra(Constants.EXTRA_ITEMS);
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
        getSupportActionBar().setTitle("Approve/Deny Request");
    }

    private void setUpRecyclerView() {

        recyclerView = (RecyclerView) findViewById(R.id.item_recycler_view);
        Intent intent = getIntent();
        adapter = new ItemRecyclerAdapter(this, getData((Request) intent.getSerializableExtra(Constants.EXTRA_ITEMS)));

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
            landscape.setTitle("Item: " + requestItems.get(i).getName());
            //landscape.setPrice(requestItems.get(i).getRequestItem().getPrice().toString());
            landscape.setComments("Reason requested: " + requestItems.get(i).getComments());

            dataList.add(landscape);
        }
        return dataList;
    }
}
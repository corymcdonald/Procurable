package com.procurable.activity;

import android.app.AlertDialog;
import android.app.Dialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.support.v4.widget.DrawerLayout;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.DefaultItemAnimator;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.support.v7.widget.Toolbar;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.View;
import android.view.inputmethod.InputMethodManager;
import android.widget.Button;
import android.widget.EditText;

import com.procurable.adapter.NewItemRecycler2Adapter;
import com.procurable.adapter.NewItemRecyclerAdapter;
import com.procurable.capstone.R;
import com.procurable.constants.Constants;
import com.procurable.domain.ItemInCart;
import com.procurable.domain.NewItemRow;
import com.procurable.domain.request.CreateRequestRequest;
import com.procurable.domain.request.ItemRequest;
import com.procurable.domain.response.Request;
import com.procurable.service.ProcurableService;
import com.procurable.utils.ItemUtilities;

import java.util.ArrayList;
import java.util.List;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class MyCartActivity extends AppCompatActivity {

    Toolbar toolbar;
    RecyclerView recyclerView;
    RecyclerView recyclerView2;
    NewItemRecyclerAdapter adapter;
    NewItemRecycler2Adapter adapterNewItems;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_my_cart);

        setUpToolbar();
        setUpRecyclerViews();
        setUpDrawer();
        setUpButtons();
        setUpEditText();
    }

    private void setUpEditText() {
        EditText name = (EditText) findViewById(R.id.title);
        name.setText(Constants.newRequestName);
        name.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {

            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {

            }

            @Override
            public void afterTextChanged(Editable s) {
                Constants.newRequestName = s.toString();
            }
        });
    }

    private void setUpButtons() {
        final Button outsideItem = (Button) findViewById(R.id.button3);
        outsideItem.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                final Dialog commentDialog = new Dialog(MyCartActivity.this);
                commentDialog.setContentView(R.layout.new_item);
                Button okBtn = (Button) commentDialog.findViewById(R.id.ok);

                okBtn.setOnClickListener(new View.OnClickListener() {


                    @Override
                    public void onClick(View v) {
                        EditText name = (EditText) commentDialog.findViewById(R.id.name);
                        EditText comments = (EditText) commentDialog.findViewById(R.id.comments);
                        EditText url = (EditText) commentDialog.findViewById(R.id.url);
                        ItemInCart itemInCart = new ItemInCart();
                        itemInCart.setCount(1);
                        itemInCart.setComments(comments.getText().toString());
                        itemInCart.setName(name.getText().toString());
                        itemInCart.setPrice("Unknown");
                        itemInCart.setUrl(url.getText().toString());
                        Constants.cartAddedItems.add(itemInCart);
                        adapterNewItems.mData.add(ItemUtilities.convertAddedItemToNewItemRow(itemInCart));
                        InputMethodManager imm = (InputMethodManager) MyCartActivity.this.getSystemService(Context.INPUT_METHOD_SERVICE);
                        imm.hideSoftInputFromWindow(v.getWindowToken(), 0);
                        commentDialog.dismiss();
                    }
                });
                Button cancelBtn = (Button) commentDialog.findViewById(R.id.cancel);
                cancelBtn.setOnClickListener(new View.OnClickListener() {

                    @Override
                    public void onClick(View v) {
                        View view = MyCartActivity.this.getWindow().getCurrentFocus();
                        if (view != null) {
                            InputMethodManager imm = (InputMethodManager) MyCartActivity.this.getSystemService(Context.INPUT_METHOD_SERVICE);
                            imm.hideSoftInputFromWindow(view.getWindowToken(), 0);
                        }
                        commentDialog.dismiss();
                    }
                });
                commentDialog.show();
            }
        });


        Button submitRequest = (Button) findViewById(R.id.submit_request);
        submitRequest.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                CreateRequestRequest createRequestRequest = new CreateRequestRequest();
                EditText name = (EditText) findViewById(R.id.title);
                EditText comments = (EditText) findViewById(R.id.comments);
                createRequestRequest.setName(name.getText().toString());
                createRequestRequest.setComments(comments.getText().toString());
                List<ItemRequest> itemRequests = new ArrayList<ItemRequest>();

                for (int i = 0; i < Constants.cartInventoryItems.size(); i++)
                    itemRequests.addAll(ItemUtilities.convertItemInCartToItemRequests(Constants.cartInventoryItems.get(i)));
                for (int i = 0; i < Constants.cartAddedItems.size(); i++)
                    itemRequests.addAll(ItemUtilities.convertItemInCartToItemRequests(Constants.cartAddedItems.get(i)));
                createRequestRequest.setItems(itemRequests.toArray(new ItemRequest[itemRequests.size()]));
                ProcurableService procurableService = Constants.retrofit.create(ProcurableService.class);
                Call<Request[]> call = procurableService.createRequest(createRequestRequest);
                call.enqueue(new Callback<Request[]>() {
                    @Override
                    public void onResponse(Call<Request[]> call, Response<Request[]> response) {


                        AlertDialog.Builder alertDialogBuilder = new AlertDialog.Builder(
                                MyCartActivity.this);
                        alertDialogBuilder.setTitle("Submited Request");
                        alertDialogBuilder
                                .setMessage("Request Submitted Successfully")
                                .setCancelable(false)
                                .setPositiveButton("Okay", new DialogInterface.OnClickListener() {
                                    public void onClick(DialogInterface dialog, int id) {
                                        Intent intent = new Intent(MyCartActivity.this, SearchActivity.class);
                                        startActivity(intent);
                                    }
                                });
                        AlertDialog alertDialog = alertDialogBuilder.create();
                        alertDialog.show();
                    }

                    @Override
                    public void onFailure(Call<Request[]> call, Throwable t) {
                        AlertDialog.Builder alertDialogBuilder = new AlertDialog.Builder(
                                MyCartActivity.this);
                        alertDialogBuilder.setTitle("Submited Request Failed");
                        alertDialogBuilder
                                .setMessage("Please try again. If the error continues to occur, please contact the help desk.")
                                .setCancelable(false)
                                .setPositiveButton("Okay", new DialogInterface.OnClickListener() {
                                    public void onClick(DialogInterface dialog, int id) {
                                    }
                                });
                        AlertDialog alertDialog = alertDialogBuilder.create();
                        alertDialog.show();
                    }
                });
            }
        });
    }

    private void setUpRecyclerViews() {

        recyclerView = (RecyclerView) findViewById(R.id.recyclerView);
        adapter = new NewItemRecyclerAdapter(this, getInInventoryData());

        recyclerView.setAdapter(adapter);

        LinearLayoutManager mLinearLayoutManagerVertical = new LinearLayoutManager(this); // (Context context, int spanCount)
        mLinearLayoutManagerVertical.setOrientation(LinearLayoutManager.VERTICAL);
        recyclerView.setLayoutManager(mLinearLayoutManagerVertical);

        recyclerView.setItemAnimator(new DefaultItemAnimator());


        recyclerView2 = (RecyclerView) findViewById(R.id.recyclerView2);
        adapterNewItems = new NewItemRecycler2Adapter(this, getAddedData());

        recyclerView2.setAdapter(adapterNewItems);

        LinearLayoutManager mLinearLayoutManagerVertical2 = new LinearLayoutManager(this); // (Context context, int spanCount)
        mLinearLayoutManagerVertical2.setOrientation(LinearLayoutManager.VERTICAL);
        recyclerView2.setLayoutManager(mLinearLayoutManagerVertical2);

        recyclerView2.setItemAnimator(new DefaultItemAnimator());
    }

    private void setUpToolbar() {
        toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);
        getSupportActionBar().setTitle("My Cart");
    }

    private void setUpDrawer() {
        NavigationDrawerFragment drawerFragment = (NavigationDrawerFragment) getSupportFragmentManager().findFragmentById(R.id.nav_drwr_fragment);
        DrawerLayout drawerLayout = (DrawerLayout) findViewById(R.id.drawer_layout);
        drawerFragment.setUpDrawer(R.id.nav_drwr_fragment, drawerLayout, toolbar);
    }

    public ArrayList<NewItemRow> getInInventoryData() {

        final ArrayList<NewItemRow> dataList = new ArrayList<>();

        for (int i = 0; i < Constants.cartInventoryItems.size(); i++) {

            NewItemRow landscape = new NewItemRow();
            landscape.setTitle(Constants.cartInventoryItems.get(i).getName());
            landscape.setPrice("Price: " + Constants.cartInventoryItems.get(i).getPrice());
            landscape.setQuantity("Amount requested: " + Constants.cartInventoryItems.get(i).getCount().toString());
            dataList.add(landscape);
        }
        return dataList;
    }

    public ArrayList<NewItemRow> getAddedData() {

        final ArrayList<NewItemRow> dataList = new ArrayList<>();

        for (int i = 0; i < Constants.cartAddedItems.size(); i++) {

            NewItemRow landscape = new NewItemRow();
            landscape.setTitle(Constants.cartAddedItems.get(i).getName());
            landscape.setPrice("Price: " + Constants.cartAddedItems.get(i).getPrice());
            landscape.setQuantity("Amount requested: " + Constants.cartAddedItems.get(i).getCount().toString());
            dataList.add(landscape);
        }
        return dataList;
    }
}

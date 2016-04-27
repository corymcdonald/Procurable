package com.procurable.activity;

import android.app.AlertDialog;
import android.app.SearchManager;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.support.v4.widget.DrawerLayout;
import android.support.v7.app.ActionBar;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.DefaultItemAnimator;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.support.v7.widget.SearchView;
import android.support.v7.widget.Toolbar;
import android.view.KeyEvent;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.inputmethod.EditorInfo;
import android.view.inputmethod.InputMethodManager;
import android.widget.EditText;
import android.widget.TextView;

import com.procurable.adapter.ItemSearchRecyclerAdapter;
import com.procurable.adapter.RecyclerAdapter;
import com.procurable.capstone.R;
import com.procurable.constants.Constants;
import com.procurable.domain.ItemSearchRow;
import com.procurable.domain.RequestRow;
import com.procurable.domain.response.InventoryItem;
import com.procurable.domain.response.Request;
import com.procurable.service.ProcurableService;

import java.util.ArrayList;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class SearchActivity extends AppCompatActivity {

    Toolbar toolbar;
    private MenuItem mSearchAction;
    private boolean isSearchOpened = false;
    private EditText edtSeach;
    RecyclerView recyclerView;
    ItemSearchRecyclerAdapter adapter;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_search);

        setUpToolbar();
        setUpDrawer();

    }

    private void setUpDrawer() {
        NavigationDrawerFragment drawerFragment = (NavigationDrawerFragment) getSupportFragmentManager().findFragmentById(R.id.nav_drwr_fragment);
        DrawerLayout drawerLayout = (DrawerLayout) findViewById(R.id.drawer_layout);
        drawerFragment.setUpDrawer(R.id.nav_drwr_fragment, drawerLayout, toolbar);
    }

    private void setUpToolbar() {
        toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);
        getSupportActionBar().setTitle("Search");
    }

    @Override
    public boolean onPrepareOptionsMenu(Menu menu) {
        mSearchAction = menu.findItem(R.id.action_search);
        return super.onPrepareOptionsMenu(menu);
    }


    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        int id = item.getItemId();

                handleMenuSearch();
                return true;
    }


    protected void handleMenuSearch() {
        ActionBar action = getSupportActionBar(); //get the actionbar

        if (isSearchOpened) { //test if the search is open

            action.setDisplayShowCustomEnabled(false); //disable a custom view inside the actionbar
            action.setDisplayShowTitleEnabled(true); //show the title in the action bar

            //hides the keyboard
            InputMethodManager imm = (InputMethodManager) getSystemService(Context.INPUT_METHOD_SERVICE);
            imm.hideSoftInputFromWindow(edtSeach.getWindowToken(), 0);

            //add the search icon in the action bar
            mSearchAction.setIcon(getResources().getDrawable(R.drawable.ic_birds));

            isSearchOpened = false;
        } else { //open the search entry

            action.setDisplayShowCustomEnabled(true); //enable it to display a
            // custom view in the action bar.
            action.setCustomView(R.layout.search_bar);//add the custom view
            action.setDisplayShowTitleEnabled(false); //hide the title

            edtSeach = (EditText) action.getCustomView().findViewById(R.id.edtSearch); //the text editor

            //this is a listener to do a search when the user clicks on search button
            edtSeach.setOnEditorActionListener(new TextView.OnEditorActionListener() {
                @Override
                public boolean onEditorAction(TextView v, int actionId, KeyEvent event) {
                    if (actionId == EditorInfo.IME_ACTION_SEARCH) {
                        doSearch();
                        return true;
                    }
                    return false;
                }
            });


            edtSeach.requestFocus();

            //open the keyboard focused in the edtSearch
            InputMethodManager imm = (InputMethodManager) getSystemService(Context.INPUT_METHOD_SERVICE);
            imm.showSoftInput(edtSeach, InputMethodManager.SHOW_IMPLICIT);


            //add the close icon
            mSearchAction.setIcon(getResources().getDrawable(R.drawable.ic_birds));

            isSearchOpened = true;
        }
    }

    @Override
    public void onBackPressed() {
        if (isSearchOpened) {
            handleMenuSearch();
            return;
        }
        super.onBackPressed();
    }


    private void doSearch() {
        setUpRecyclerView();
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        MenuInflater menuInflater = getMenuInflater();
        menuInflater.inflate(R.menu.menu, menu);

        MenuItem searchItem = menu.findItem(R.id.action_search);

        SearchManager searchManager = (SearchManager) SearchActivity.this.getSystemService(Context.SEARCH_SERVICE);

        SearchView searchView = null;
        if (searchItem != null) {
            searchView = (SearchView) searchItem.getActionView();
        }
        if (searchView != null) {
            searchView.setSearchableInfo(searchManager.getSearchableInfo(SearchActivity.this.getComponentName()));
        }
        return super.onCreateOptionsMenu(menu);
    }

    private void setUpRecyclerView() {

        recyclerView = (RecyclerView) findViewById(R.id.recyclerView);
        adapter = new ItemSearchRecyclerAdapter(this, getData());

        recyclerView.setAdapter(adapter);

        LinearLayoutManager mLinearLayoutManagerVertical = new LinearLayoutManager(this); // (Context context, int spanCount)
        mLinearLayoutManagerVertical.setOrientation(LinearLayoutManager.VERTICAL);
        recyclerView.setLayoutManager(mLinearLayoutManagerVertical);

        recyclerView.setItemAnimator(new DefaultItemAnimator());
    }

    public ArrayList<ItemSearchRow> getData() {

        final ArrayList<ItemSearchRow> dataList = new ArrayList<>();

        ProcurableService procurableService = Constants.retrofit.create(ProcurableService.class);
        Call<InventoryItem[]> call = procurableService.inventoryItems();
        call.enqueue(new Callback<InventoryItem[]>() {
            @Override
            public void onResponse(Call<InventoryItem[]> call, Response<InventoryItem[]> response) {
                for (int i = 0; i < response.body().length; i++) {

                    ItemSearchRow landscape = new ItemSearchRow();
                    landscape.setTitle(response.body()[i].getName());
                    landscape.setPrice(response.body()[i].getPrice().toString());
                    landscape.setItem(response.body()[i]);
                    dataList.add(landscape);
                }
                adapter.mData = dataList;
                recyclerView.setAdapter(adapter);
            }

            @Override
            public void onFailure(Call<InventoryItem[]> call, Throwable t) {
                System.out.println();
            }
        });
        return dataList;
    }
}

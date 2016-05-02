package com.procurable.activity;

import android.app.AlertDialog;
import android.app.Dialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.support.v4.widget.DrawerLayout;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.RecyclerView;
import android.support.v7.widget.Toolbar;
import android.view.View;
import android.view.WindowManager;
import android.view.inputmethod.InputMethodManager;
import android.widget.Button;
import android.widget.EditText;
import android.widget.NumberPicker;
import android.widget.TextView;

import com.procurable.capstone.R;
import com.procurable.constants.Constants;
import com.procurable.domain.response.InventoryItem;
import com.procurable.domain.response.Request;
import com.procurable.utils.ItemUtilities;

import org.w3c.dom.Text;

public class ItemDetailsActivity extends AppCompatActivity implements NumberPicker.OnValueChangeListener{

    Toolbar toolbar;
    InventoryItem inventoryItem;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_item_details);
        Intent intent = getIntent();
        inventoryItem = (InventoryItem)intent.getSerializableExtra(Constants.INVENTORY_ITEM);

        setUpToolbar();
        setUpDrawer();

        TextView name = (TextView) findViewById(R.id.item_name);
        TextView price = (TextView) findViewById(R.id.item_price);
        TextView comments = (TextView) findViewById(R.id.item_comments);
        name.setText("Item name: " + inventoryItem.getName());
        String priceText = "Not found";
        Double priceNumber = Double.MAX_VALUE;
        for(int i = 0; i < inventoryItem.getItem().size(); i++)
        {
            if(inventoryItem.getItem().get(i).getPrice() != null && inventoryItem.getItem().get(i).getPrice() < priceNumber)
                priceNumber = inventoryItem.getItem().get(i).getPrice();
        }
        if(priceNumber != Double.MAX_VALUE)
            priceText = priceNumber.toString();
        price.setText("Price: " + priceText);
        comments.setText("Item description: " + (inventoryItem.getItem().get(0).getComments() != null ? inventoryItem.getItem().get(0).getComments() : "Not found"));

        Button requestItem = (Button)findViewById(R.id.button);

        requestItem.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                showNumberPicker();
                //Constants.cartItems.add((InventoryItem)getIntent().getSerializableExtra(Constants.INVENTORY_ITEM));
            }
        });
    }

    private void showNumberPicker() {
        final Dialog d = new Dialog(ItemDetailsActivity.this);
        d.setTitle("Quantity Requested");
        d.setContentView(R.layout.number_picker_dialog);
        Button b1 = (Button) d.findViewById(R.id.button1);
        Button b2 = (Button) d.findViewById(R.id.button2);
        final NumberPicker np = (NumberPicker) d.findViewById(R.id.numberPicker1);
        np.setMaxValue(100);
        np.setMinValue(1);
        np.setWrapSelectorWheel(false);
        np.setOnValueChangedListener(this);
        b1.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                EditText comments = (EditText) findViewById(R.id.addr_edittext);
                Constants.cartInventoryItems.add(ItemUtilities.convertInventoryItemsToItemInCart((InventoryItem) getIntent().getSerializableExtra(Constants.INVENTORY_ITEM), np.getValue(), comments.getText().toString()));
                d.dismiss();
                AlertDialog.Builder alertDialogBuilder = new AlertDialog.Builder(
                        ItemDetailsActivity.this);
                alertDialogBuilder.setTitle("Item Added");
                alertDialogBuilder
                        .setMessage("The item is now part of your next request.")
                        .setCancelable(false)
                        .setPositiveButton("Okay", new DialogInterface.OnClickListener() {
                            public void onClick(DialogInterface dialog, int id) {
                                onBackPressed();
                            }
                        });
                AlertDialog alertDialog = alertDialogBuilder.create();
                alertDialog.show();
                //onBackPressed();

            }
        });
        b2.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                d.dismiss();
            }
        });
        d.show();

    }

    @Override
    public void onValueChange(NumberPicker picker, int oldVal, int newVal) {

    }

    private void setUpToolbar() {
        toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);
        getSupportActionBar().setTitle(inventoryItem.getName());
    }
    private void setUpDrawer() {
        NavigationDrawerFragment drawerFragment = (NavigationDrawerFragment) getSupportFragmentManager().findFragmentById(R.id.nav_drwr_fragment);
        DrawerLayout drawerLayout = (DrawerLayout) findViewById(R.id.drawer_layout);
        drawerFragment.setUpDrawer(R.id.nav_drwr_fragment, drawerLayout, toolbar);
    }
}

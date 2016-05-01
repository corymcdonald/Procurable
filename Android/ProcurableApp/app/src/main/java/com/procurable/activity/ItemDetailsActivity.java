package com.procurable.activity;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.RecyclerView;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import com.procurable.capstone.R;
import com.procurable.constants.Constants;
import com.procurable.domain.response.InventoryItem;
import com.procurable.domain.response.Request;

import org.w3c.dom.Text;

public class ItemDetailsActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_item_details);
        Intent intent = getIntent();
        InventoryItem inventoryItem = (InventoryItem)intent.getSerializableExtra(Constants.INVENTORY_ITEM);
        TextView name = (TextView) findViewById(R.id.item_name);
        TextView price = (TextView) findViewById(R.id.item_price);
        TextView comments = (TextView) findViewById(R.id.item_comments);
        name.setText(inventoryItem.getName());
        price.setText(inventoryItem.getPrice().toString());
        comments.setText(inventoryItem.getComments());

        Button requestItem = (Button)findViewById(R.id.button);

        requestItem.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Constants.cartItems.add((InventoryItem)getIntent().getSerializableExtra(Constants.INVENTORY_ITEM));
            }
        });

    }
}

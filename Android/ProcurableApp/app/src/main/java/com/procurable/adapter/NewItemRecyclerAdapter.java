package com.procurable.adapter;

import android.content.Context;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.PopupMenu;
import android.widget.TextView;

import com.procurable.activity.MyCartActivity;
import com.procurable.capstone.R;
import com.procurable.constants.Constants;
import com.procurable.domain.NewItemRow;

import java.util.List;

/**
 * Created by Matt on 3/27/2016.
 */
public class NewItemRecyclerAdapter extends RecyclerView.Adapter<NewItemRecyclerAdapter.MyViewHolder> {
    public List<NewItemRow> mData;
    private LayoutInflater inflater;
    private Context context;

    public NewItemRecyclerAdapter(Context context, List<NewItemRow> data) {
        inflater = LayoutInflater.from(context);
        this.context = context;
        this.mData = data;
    }

    @Override
    public MyViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = inflater.inflate(R.layout.new_request_item, parent, false);
        MyViewHolder holder = new MyViewHolder(view);
        return holder;
    }

    @Override
    public void onBindViewHolder(final MyViewHolder holder, int position) {
        NewItemRow current = mData.get(position);
        holder.setData(current, position);
        holder.itemView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
            }
        });
    }

    @Override
    public int getItemCount() {
        return mData.size();
    }

    public void removeItem(int position) {
        mData.remove(position);
        notifyItemRemoved(position);
        notifyItemRangeChanged(position, mData.size());
    }

    public void addItem(int position, NewItemRow requestRow) {
        mData.add(position, requestRow);
        notifyItemInserted(position);
        notifyItemRangeChanged(position, mData.size());
    }

    class MyViewHolder extends RecyclerView.ViewHolder implements View.OnClickListener {
        TextView title;
        TextView price;
        final TextView quantity;
        int position;
        NewItemRow current;
        protected View mRootView;

        public MyViewHolder(View itemView) {
            super(itemView);
            title       = (TextView)  itemView.findViewById(R.id.tvItemTitle);
            price = (TextView)  itemView.findViewById(R.id.tvItemPrice);
            quantity       = (TextView)  itemView.findViewById(R.id.tvItemQuantity);
            quantity.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    PopupMenu popup = new PopupMenu(context, quantity);
                    //Inflating the Popup using xml file
                    for(int i = 1; i < 100; i++)
                        popup.getMenu().add(0, i, i, String.valueOf(i));

                    //registering popup with OnMenuItemClickListener
                    popup.setOnMenuItemClickListener(new PopupMenu.OnMenuItemClickListener() {
                        public boolean onMenuItemClick(MenuItem item) {
                            current.setQuantity(item.getTitle().toString());
                            quantity.setText("Amount requested: " + item.getTitle());
                            Constants.cartInventoryItems.get(position).setCount(Integer.parseInt(current.getQuantity()));
                            return true;
                        }
                    });

                    popup.show();//showing popup menu
                }
            });
            mRootView = itemView;
        }

        public void setData(NewItemRow current, int position) {
            this.title.setText(current.getTitle());
            this.price.setText("Price: " + current.getPrice() != null ? current.getPrice() : "Not found");
            this.quantity.setText(String.valueOf(current.getQuantity()));
            this.position = position;
            this.current = current;
        }

        @Override
        public void onClick(View v) {

        }
    }
}
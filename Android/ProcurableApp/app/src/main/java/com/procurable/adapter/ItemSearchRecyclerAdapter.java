package com.procurable.adapter;

import android.content.Context;
import android.content.Intent;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.procurable.activity.ApproveRequestActivity;
import com.procurable.activity.ItemDetailsActivity;
import com.procurable.capstone.R;
import com.procurable.constants.Constants;
import com.procurable.domain.ItemSearchRow;
import com.procurable.domain.response.InventoryItem;

import java.util.List;

/**
 * Created by Matt on 3/27/2016.
 */
public class ItemSearchRecyclerAdapter extends RecyclerView.Adapter<ItemSearchRecyclerAdapter.MyViewHolder> {
    public List<ItemSearchRow> mData;
    private LayoutInflater inflater;
    private Context context;

    public ItemSearchRecyclerAdapter(Context context, List<ItemSearchRow> data) {
        inflater = LayoutInflater.from(context);
        this.context = context;
        this.mData = data;
    }

    @Override
    public MyViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = inflater.inflate(R.layout.inventory_item_card_view, parent, false);
        MyViewHolder holder = new MyViewHolder(view);
        return holder;
    }

    @Override
    public void onBindViewHolder(final MyViewHolder holder, int position) {
        final ItemSearchRow current = mData.get(position);
        holder.setData(current, position);
        holder.itemView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(context, ItemDetailsActivity.class);
                intent.putExtra(Constants.INVENTORY_ITEM, current.getItem());
                context.startActivity(intent);
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

    public void addItem(int position, ItemSearchRow requestRow) {
        mData.add(position, requestRow);
        notifyItemInserted(position);
        notifyItemRangeChanged(position, mData.size());
    }

    class MyViewHolder extends RecyclerView.ViewHolder implements View.OnClickListener {
        TextView title;
        TextView price;
        TextView comments;
        int position;
        ItemSearchRow current;
        protected View mRootView;

        public MyViewHolder(View itemView) {
            super(itemView);
            title       = (TextView)  itemView.findViewById(R.id.tvItemTitle);
            price = (TextView)  itemView.findViewById(R.id.tvItemPrice);
            mRootView = itemView;
        }

        public void setData(ItemSearchRow current, int position) {
            this.title.setText(current.getTitle());
            this.price.setText(current.getPrice());
            this.position = position;
            this.current = current;
        }

        @Override
        public void onClick(View v) {

        }
    }
}
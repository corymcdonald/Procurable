package com.procurable.adapter;

import android.content.Context;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import android.widget.Toast;

import com.procurable.capstone.R;
import com.procurable.domain.ItemRow;

import java.util.List;

/**
 * Created by Matt on 3/27/2016.
 */
public class ItemRecyclerAdapter extends RecyclerView.Adapter<ItemRecyclerAdapter.MyViewHolder> {
    public List<ItemRow> mData;
    private LayoutInflater inflater;
    private Context context;

    public ItemRecyclerAdapter(Context context, List<ItemRow> data) {
        inflater = LayoutInflater.from(context);
        this.context = context;
        this.mData = data;
    }

    @Override
    public MyViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = inflater.inflate(R.layout.item_card_view, parent, false);
        MyViewHolder holder = new MyViewHolder(view);
        return holder;
    }

    @Override
    public void onBindViewHolder(final MyViewHolder holder, int position) {
        ItemRow current = mData.get(position);
        holder.setData(current, position);
        holder.itemView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Toast.makeText(context, holder.title.getText().toString(), Toast.LENGTH_SHORT).show();
                //Intent intent = new Intent(context, ApproveRequestActivity.class);
                //context.startActivity(intent);
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

    public void addItem(int position, ItemRow requestRow) {
        mData.add(position, requestRow);
        notifyItemInserted(position);
        notifyItemRangeChanged(position, mData.size());
    }

    class MyViewHolder extends RecyclerView.ViewHolder implements View.OnClickListener {
        TextView title;
        TextView price;
        TextView comments;
        int position;
        ItemRow current;
        protected View mRootView;

        public MyViewHolder(View itemView) {
            super(itemView);
            title       = (TextView)  itemView.findViewById(R.id.tvItemTitle);
            price = (TextView)  itemView.findViewById(R.id.tvItemPrice);
            comments       = (TextView)  itemView.findViewById(R.id.tvItemComments);
            mRootView = itemView;
        }

        public void setData(ItemRow current, int position) {
            this.title.setText(current.getTitle());
            this.price.setText(current.getPrice());
            this.comments.setText(current.getComments());
            this.position = position;
            this.current = current;
        }

        @Override
        public void onClick(View v) {

        }
    }
}
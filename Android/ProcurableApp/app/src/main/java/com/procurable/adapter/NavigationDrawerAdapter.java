package com.procurable.adapter;

import android.content.Context;
import android.content.Intent;
import android.support.v7.widget.RecyclerView;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import com.procurable.activity.LoginActivity;
import com.procurable.activity.ManageRequest;
import com.procurable.activity.MyRequest;
import com.procurable.activity.SearchActivity;
import com.procurable.capstone.R;
import com.procurable.constants.Constants;
import com.procurable.domain.NavigationDrawerItem;

import java.util.Collections;
import java.util.List;

public class NavigationDrawerAdapter extends RecyclerView.Adapter<NavigationDrawerAdapter.MyViewHolder> {

	private List<NavigationDrawerItem> mDataList = Collections.emptyList();
    private LayoutInflater inflater;
    private Context context;

    public NavigationDrawerAdapter(Context context, List<NavigationDrawerItem> data) {
        this.context = context;
        inflater = LayoutInflater.from(context);
        this.mDataList = data;
    }

    @Override
    public MyViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = inflater.inflate(R.layout.nav_drawer_list_item, parent, false);
        MyViewHolder holder = new MyViewHolder(view);
        return holder;
    }

    @Override
    public void onBindViewHolder(final MyViewHolder holder, int position) {
        NavigationDrawerItem current = mDataList.get(position);

	    holder.imgIcon.setImageResource(current.getImageId());
        holder.title.setText(current.getTitle());
        holder.itemView.setOnClickListener(new View.OnClickListener() {
	        @Override
	        public void onClick(View v) {
                Intent intent;
                Toast.makeText(context, holder.title.getText().toString(), Toast.LENGTH_SHORT).show();
                if("Manage Requests".equalsIgnoreCase(holder.title.getText().toString()))
                {
                    intent = new Intent(context, ManageRequest.class);
                    context.startActivity(intent);
                } else if("Search".equalsIgnoreCase(holder.title.getText().toString()))
                {
                    intent = new Intent(context, SearchActivity.class);
                    context.startActivity(intent);
                } else if("My Requests".equalsIgnoreCase(holder.title.getText().toString()))
                {
                    intent = new Intent(context, MyRequest.class);
                    context.startActivity(intent);
                } else if("Log Out".equalsIgnoreCase(holder.title.getText().toString()))
                {
                    intent = new Intent(context, LoginActivity.class);
                    context.startActivity(intent);
                }
                /*switch (holder.title.getText().toString())
                {
                    case "Manage Requests" :
                        intent = new Intent(context, ManageRequest.class);
                        context.startActivity(intent);
                    case "Search" :
                        intent = new Intent(context, SearchActivity.class);
                        context.startActivity(intent);
                    case "My Requests" :
                        intent = new Intent(context, ManageRequest.class);
                        context.startActivity(intent);
                    case "Log Out" :
                        intent = new Intent(context, LoginActivity.class);
                        context.startActivity(intent);
                    default: Toast.makeText(context, holder.title.getText().toString(), Toast.LENGTH_SHORT).show();
                }*/

	        }
        });
    }

    @Override
    public int getItemCount() {
        return mDataList.size();
    }

    class MyViewHolder extends RecyclerView.ViewHolder {
        TextView title;
	    ImageView imgIcon;

        public MyViewHolder(View itemView) {
            super(itemView);
            title = (TextView) itemView.findViewById(R.id.title);
	        imgIcon = (ImageView) itemView.findViewById(R.id.imgIcon);
        }
    }
}

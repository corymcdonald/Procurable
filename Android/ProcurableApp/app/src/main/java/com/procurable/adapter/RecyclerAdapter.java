package com.procurable.adapter;

import android.content.Context;
import android.content.Intent;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.TextView;

import com.procurable.activity.ApproveRequestActivity;
import com.procurable.activity.ManageRequest;
import com.procurable.capstone.R;
import com.procurable.constants.Constants;
import com.procurable.domain.RequestRow;

import java.util.List;

public class RecyclerAdapter extends RecyclerView.Adapter<RecyclerAdapter.MyViewHolder> {
	public List<RequestRow> mData;
	private LayoutInflater inflater;
	private Context context;

	public RecyclerAdapter(Context context, List<RequestRow> data) {
		inflater = LayoutInflater.from(context);
		this.context = context;
		this.mData = data;
	}

	@Override
	public MyViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
		View view = inflater.inflate(R.layout.request_item_view, parent, false);
		MyViewHolder holder = new MyViewHolder(view);
		return holder;
	}

	@Override
	public void onBindViewHolder(final MyViewHolder holder, final int position) {
		final RequestRow current = mData.get(position);
		holder.setData(current, position);
		holder.itemView.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				Intent intent = new Intent(context, ApproveRequestActivity.class);
				intent.putExtra(Constants.EXTRA_ITEMS,current.getRequest());
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

	public void addItem(int position, RequestRow requestRow) {
		mData.add(position, requestRow);
		notifyItemInserted(position);
		notifyItemRangeChanged(position, mData.size());
	}

	class MyViewHolder extends RecyclerView.ViewHolder implements View.OnClickListener {
		TextView title;
		TextView description;
		int position;
		RequestRow current;
		protected View mRootView;

		public MyViewHolder(View itemView) {
			super(itemView);
			title       = (TextView)  itemView.findViewById(R.id.tvTitle);
			description       = (TextView)  itemView.findViewById(R.id.tvDescription);
			mRootView = itemView;
		}

		public void setData(RequestRow current, int position) {
			this.title.setText(current.getTitle());
			this.description.setText(current.getDescription());
			this.position = position;
			this.current = current;
		}

		@Override
		public void onClick(View v) {

		}
	}
}

package com.procurable.activity;

import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.design.widget.Snackbar;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.Spinner;

import com.procurable.capstone.R;
import com.procurable.constants.Constants;
import com.procurable.domain.request.LoginRequest;
import com.procurable.domain.response.GenericResponse;
import com.procurable.domain.response.Project;
import com.procurable.domain.response.Request;
import com.procurable.service.ProcurableService;

import java.util.Date;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class SearchActivity extends AppCompatActivity implements AdapterView.OnItemSelectedListener {

    Project project = new Project();
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_search);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);
        getSupportActionBar().setTitle("Search");

        Spinner spinner = (Spinner) findViewById(R.id.prioritySpinner);
        ArrayAdapter<CharSequence> adapter = ArrayAdapter.createFromResource(this,
                R.array.priority, android.R.layout.simple_spinner_item);
        adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        spinner.setAdapter(adapter);

        Spinner spinner2 = (Spinner) findViewById(R.id.statusSpinner);
        ArrayAdapter<CharSequence> adapter2 = ArrayAdapter.createFromResource(this,
                R.array.priority, android.R.layout.simple_spinner_item);
        adapter2.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        spinner2.setAdapter(adapter2);

        Button button = (Button) findViewById(R.id.button);
        button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                ProcurableService procurableService = Constants.retrofit.create(ProcurableService.class);
                Call<Request[]> call = procurableService.requests();
                call.enqueue(new Callback<Request[]>() {
                    @Override
                    public void onResponse(Call<Request[]> call, Response<Request[]> response) {
                        System.out.println();
                    }

                    @Override
                    public void onFailure(Call<Request[]> call, Throwable t) {
                        System.out.println();
                    }
                });
            }
        });
    }

    public void onItemSelected(AdapterView<?> parent, View view,
                               int pos, long id) {
        if(parent.getId() == R.id.prioritySpinner) {
            project.setPriority((int)parent.getItemAtPosition(pos));
        } else if(parent.getId() == R.id.statusSpinner) {
            project.setStatus((int)parent.getItemAtPosition(pos));
        }
    }

    public void onNothingSelected(AdapterView<?> parent) {
        // Another interface callback
    }

}

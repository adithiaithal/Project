activity_main.xml

<?xml version="1.0" encoding="utf-8"?>
<androidx.constraintlayout.widget.ConstraintLayout xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:app="http://schemas.android.com/apk/res-auto"
    xmlns:tools="http://schemas.android.com/tools"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    tools:context=".MainActivity">

    <TextView
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="Grocery App"
        android:id="@+id/title"
        android:textSize="30dp"
        app:layout_constraintBottom_toBottomOf="parent"
        app:layout_constraintHorizontal_bias="0.446"
        app:layout_constraintLeft_toLeftOf="parent"
        app:layout_constraintRight_toRightOf="parent"
        app:layout_constraintTop_toTopOf="parent"
        app:layout_constraintVertical_bias="0.068" />

    <ListView
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:id="@+id/listView"
        app:layout_constraintBottom_toBottomOf="parent"
        app:layout_constraintTop_toTopOf="parent"
        app:layout_constraintVertical_bias="0.19"
        tools:layout_editor_absoluteX="16dp" />

    <Button
        android:id="@+id/button"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_marginTop="92dp"
        android:text="Total"
        app:layout_constraintBottom_toBottomOf="parent"
        app:layout_constraintEnd_toEndOf="parent"
        app:layout_constraintHorizontal_bias="0.498"
        app:layout_constraintStart_toStartOf="parent"
        app:layout_constraintTop_toTopOf="@+id/title"
        app:layout_constraintVertical_bias="0.775" />

    <TextView
        android:id="@+id/result"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_marginTop="336dp"
        android:text="TextView"
        android:textSize="20dp"
        app:layout_constraintBottom_toBottomOf="parent"
        app:layout_constraintEnd_toEndOf="parent"
        app:layout_constraintStart_toStartOf="parent"
        app:layout_constraintTop_toTopOf="parent"
        app:layout_constraintVertical_bias="0.882" />

</androidx.constraintlayout.widget.ConstraintLayout>

list_row.xml

<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:orientation="horizontal" android:layout_width="match_parent"

    android:layout_height="match_parent">

    <TextView
    android:layout_marginTop="40dp"
    android:layout_marginLeft="40dp"
    android:id="@+id/name_list"
    android:layout_width="92dp"
    android:layout_height="wrap_content"
    />

    <TextView
    android:layout_marginTop="40dp"
    android:layout_marginLeft="40dp"
    android:id="@+id/cost_list"
    android:layout_width="92dp"
    android:layout_height="wrap_content"
     />

    <EditText
        android:layout_width="52dp"
        android:layout_height="wrap_content"
        android:id="@+id/quantity_list"
        android:layout_marginTop="40dp"
        android:layout_marginLeft="40dp"
        />



</LinearLayout>

MainActivity.java

package com.example.a2b;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.TextView;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        final String[] names = {"Bread", "butter", "Beer", "Jam"};
        final int[] cost = {20, 30, 40, 50};
        final ListView lv = findViewById(R.id.listView);

        MyAdapter adapter = new MyAdapter(this, names, cost);
        lv.setAdapter(adapter);

        Button b = findViewById(R.id.button);

        b.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {

                int total = 0;
                for(int i = 0; i < names.length; i++){

                    View v = lv.getChildAt(i);
                    EditText quantity_ET = v.findViewById(R.id.quantity_list);
                    String quantity = quantity_ET.getText().toString();
                    int qty;
                    if(quantity != null)
                        qty = Integer.valueOf(quantity);
                    else
                        qty = 0;

                    total += qty * cost[i];

                }
                TextView result = findViewById(R.id.result);
                result.setText("Total Cost: " + String.valueOf(total));

            }
        });




    }
}

MyAdapter.java

package com.example.a2b;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

public class MyAdapter extends ArrayAdapter<String> {
    private Context mContext;
    private String[] names;
    private int[] costs;

    public MyAdapter(Context context, String[] names, int[] costs) {
        super(context, R.layout.list_row, names);
        this.mContext = context;
        this.names = names;
        this.costs = costs;
    }

    @NonNull
    @Override
    public View getView(int position, @Nullable View convertView, @NonNull ViewGroup parent) {
        LayoutInflater inf = LayoutInflater.from(getContext());
        View list_view = inf.inflate(R.layout.list_row, parent, false);

        TextView names_tv = list_view.findViewById(R.id.name_list);
        names_tv.setText(names[position]);

        TextView costs_tv = list_view.findViewById(R.id.cost_list);
        costs_tv.setText("Cost: " + String.valueOf(costs[position]));

        return list_view;
    }
}

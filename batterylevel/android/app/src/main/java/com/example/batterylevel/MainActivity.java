//package com.example..batterylevel;
//
//
//import android.widget.Toast;
//
//import androidx.annotation.NonNull;
//
//import io.flutter.embedding.android.FlutterActivity;
//import io.flutter.embedding.engine.FlutterEngine;
//import io.flutter.plugin.common.MethodChannel;
//
//
//public class MainActivity extends FlutterActivity {
//
// private String channelName="ganesh/testApp";
//
//
// @Override
// public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
//  super.configureFlutterEngine(flutterEngine);
//
//  MethodChannel channel= new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(),channelName);
//
//  channel.setMethodCallHandler{
//   call,result ->
//
//  if(call.method=="showToast"){
//   Toast.makeText(context:this,"ganesh/testApp\",Toast.LENGTH.LONG).show()
//  }
//  }
//}}

package com.example.batterylevel;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;

import androidx.annotation.NonNull;

import java.util.List;
import java.util.concurrent.Future;

import io.flutter.Log;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
 private String channelName = "ganesh/testapp";

 @Override
 public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
  super.configureFlutterEngine(flutterEngine);

  MethodChannel channel = new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), channelName);

     final Context context = this;

  channel.setMethodCallHandler(
          
          (call, result) -> {
           if (call.method.equals("getMyInfo")) {
            // showToast("This is a toast message from native Android code");

               Intent intent = new Intent(context, DemoActivity.class);
               context.startActivity(intent);
               //result.success();

               Bundle obj=new Bundle();

               onCreate(obj);

               //obj.requestLocationPermission();
               
            result.success(getMyInfo());

           } else {
            result.notImplemented();
           }}
  );
 }

//  private void showToast(String message) {
//   Toast.makeText(this, message, Toast.LENGTH_LONG).show();
//  }

 private List<String> getMyInfo() {
// Here you would fetch your information from wherever it is stored
//         List<String> info = Arrays.asList("Ganesh", "Subhash", "Godase");
//         Log.d("MainActivity", "Sending info: " + info);



     Log.d("MainActivity", "Sending info: " + DemoActivity.bodyMeasurements);
          return DemoActivity.bodyMeasurements;
     }
}


package com.edutech.edutech;

import android.content.Intent;
import android.os.Bundle;

import androidx.annotation.Nullable;

import com.easebuzz.payment.kit.PWECouponsActivity;
import com.google.gson.Gson;

import org.json.JSONObject;

import java.util.HashMap;
import java.util.Map;

import datamodels.PWEStaticDataModel;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "easebuzz";
    private MethodChannel.Result channel_result;
    public boolean start_payment = true;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        start_payment = true;
        new MethodChannel(getFlutterEngine().getDartExecutor().getBinaryMessenger(), CHANNEL).setMethodCallHandler(
                new MethodChannel.MethodCallHandler() {
                    @Override
                    public void onMethodCall(MethodCall call, MethodChannel.Result result) {
                        channel_result = result;
                        if(call.method.equals("payWithEasebuzz"))
                        {
                            if(start_payment)
                            {
                                start_payment=false;
                                startPayment(call.arguments);
                            }

                        }

                    }
                });
    }

    private void startPayment(Object arguments)
    {
        try {
            Gson gson = new Gson();
            JSONObject parameters = new JSONObject(gson.toJson(arguments));
            Intent intentProceed = new Intent(getBaseContext(), PWECouponsActivity.class);
            float amount = Float.parseFloat(parameters.getString("amount"));
            intentProceed.putExtra("txnid",parameters.optString("txnid"));
            intentProceed.putExtra("amount",amount);
            intentProceed.putExtra("productinfo",parameters.optString("productinfo"));
            intentProceed.putExtra("firstname",parameters.optString("firstname"));
            intentProceed.putExtra("email",parameters.optString("email"));
            intentProceed.putExtra("phone",parameters.optString("phone"));
            intentProceed.putExtra("s_url",parameters.optString("s_url"));
            intentProceed.putExtra("f_url",parameters.optString("f_url"));
            intentProceed.putExtra("key",parameters.optString("key"));
            intentProceed.putExtra("udf1",parameters.optString("udf1"));
            intentProceed.putExtra("udf2",parameters.optString("udf2"));
            intentProceed.putExtra("udf3",parameters.optString("udf3"));
            intentProceed.putExtra("udf4",parameters.optString("udf4"));
            intentProceed.putExtra("udf5",parameters.optString("udf5"));
            intentProceed.putExtra("address1",parameters.optString("address1"));
            intentProceed.putExtra("address2",parameters.optString("address2"));
            intentProceed.putExtra("city",parameters.optString("city"));
            intentProceed.putExtra("state",parameters.optString("state"));
            intentProceed.putExtra("country",parameters.optString("country"));
            intentProceed.putExtra("zipcode",parameters.optString("zipcode"));
            intentProceed.putExtra("hash",parameters.optString("hash"));
            intentProceed.putExtra("pay_mode",parameters.optString("pay_mode"));
            intentProceed.putExtra("unique_id",parameters.optString("unique_id"));
            startActivityForResult(intentProceed, PWEStaticDataModel.PWE_REQUEST_CODE);
        }catch (Exception e) {
            System.out.println("test exception =="+e.getMessage());
            start_payment=true;
            Map<String, Object> error_map = new HashMap<>();
            Map<String, Object> error_desc_map = new HashMap<>();
            String error_desc = "exception occured:"+e.getMessage();
            error_desc_map.put("error","Exception");
            error_desc_map.put("error_msg",error_desc);
            error_map.put("result", PWEStaticDataModel.TXN_FAILED_CODE);
            error_map.put("payment_response",error_desc_map);
            channel_result.success(error_map);

        }
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        if(requestCode==PWEStaticDataModel.PWE_REQUEST_CODE) {

            start_payment=true;
            JSONObject response = new JSONObject();
            Map<String, Object> error_map = new HashMap<>();
            if(data != null ) {
                String result = data.getStringExtra("result");
                String payment_response = data.getStringExtra("payment_response");
                try {
                    JSONObject obj = new JSONObject(payment_response);
                    response.put("result", result);
                    response.put("payment_response", obj);
                    channel_result.success(JsonConverter.convertToMap(response));

                }catch (Exception e){
                    Map<String, Object> error_desc_map = new HashMap<>();
                    error_desc_map.put("error",result);
                    error_desc_map.put("error_msg",payment_response);
                    error_map.put("result",result);
                    error_map.put("payment_response",error_desc_map);
                    channel_result.success(error_map);
                }
            }else{
                Map<String, Object> error_desc_map = new HashMap<>();
                String error_desc = "Empty payment response";
                error_desc_map.put("error","Empty error");
                error_desc_map.put("error_msg",error_desc);
                error_map.put("result",PWEStaticDataModel.TXN_FAILED_CODE);
                error_map.put("payment_response",error_desc_map);
                channel_result.success(error_map);

            }
        }else
        {
            super.onActivityResult(requestCode, resultCode, data);
        }
    }
}

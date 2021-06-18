import 'package:edutech/api/api_service.dart';
import 'package:edutech/api/urlManage.dart';
import 'package:edutech/utils/strings.dart';
import 'package:edutech/utils/toast_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PaymentController extends GetxController{

  RxBool isLoading = false.obs;
  static final dataStorage = GetStorage();
  static MethodChannel channel = MethodChannel('easebuzz');
  String packageRemoveSymbolFromRight="";
  String finalPurchaseId="";
  String firstName="";
  String email="";
  String phone="";
  String billingAddress="";
  String shippingAddress="";
  String furl="";
  String surl="";
  int user_id;

  @override
  void onInit() {
    super.onInit();
  }

  /*User payment*/
  Future<void> userPayment(BuildContext context) async {
    isLoading.value = true;
     packageRemoveSymbolFromRight = Strings.packagePurchaseList.toString().replaceAll("[", "");
     finalPurchaseId = packageRemoveSymbolFromRight.replaceAll("]", "");
     firstName = dataStorage.read("first_name");
     email = dataStorage.read("email");
     phone = dataStorage.read("phone");
     billingAddress = dataStorage.read("billing_address");
     shippingAddress = dataStorage.read("shipping_address");
    user_id = dataStorage.read("user_id");
    double totalPayment = Strings.price.toDouble();
    Map<String, dynamic> params = {
      "userId":user_id.toString(),
      "amount": totalPayment,
      "email": email,
      "phone": phone,
      "firstname": firstName,
      "udf1": "",
      "udf2": "",
      "udf3": "",
      "udf4": "",
      "udf5": "",
      "productinfo": finalPurchaseId,
      "udf6": "",
      "udf7": "",
      "udf8": "",
      "udf9": "",
      "udf10": "",
      "address1":billingAddress,
      "address2":shippingAddress,
      "city":"",
      "state":"",
      "country":"",
      "zipcode":""
    };

    print(params);
    var res = await ApiService.postWithDynamic(createPaymentUrl, params, tokenOptional: false);
    if (res["message"] == Strings.create_payment_success) {
      isLoading.value = false;
      print(res["result"]);
      ToastComponent.showDialog(res["message"], context);
      openPayment(res["result"]['transactionID'],firstName,email,phone,res["result"]["furl"],res["result"]["surl"],
          res["result"]["paymentHashKey"],res["result"]['merchantKey'],res['result']['salt']);
    } else {
      isLoading.value = false;
      ToastComponent.showDialog(res["message"], context);
    }
  }

  openPayment(String transId,String firstName,String emailId,String phoneNo,String failUrl,String successUrl,
      String paymentHashKey, String payKey, String saltFromApi) async {

    double totalPayment = Strings.price.toDouble();
    packageRemoveSymbolFromRight = Strings.packagePurchaseList.toString().replaceAll("[", "");
    finalPurchaseId = packageRemoveSymbolFromRight.replaceAll("]", "");

   //  String txnid = transId; //This txnid should be unique every time.
   //  double amount = totalPayment;
   //  //String productinfo= finalPurchaseId;
   //  String productinfo= finalPurchaseId;
   //  String firstname= firstName;
   //  String email = emailId;
   //  String phone = phoneNo;
   //  String surl = successUrl;
   //  String furl = failUrl;
   //  String key = payKey;
   //  String udf1 = "";
   //  String udf2 = "";
   //  String udf3 = "";
   //  String udf4 = "";
   //  String udf5 = "";
   //  String address1=billingAddress;
   //  String address2=shippingAddress;
   //  String city="";
   //  String state="";
   //  String country="";
   //  String zipcode="";
   //  //String hash=paymentHashKey;
   //  String hash="4414db724da68d256f0d9e558d10f2ccf579e10ae874543bda8eb39094e7badee51e61fa7e055d50b47b4c4fa4e7d06d078ca626737e874012220efff3bf9dee";
   // // String salt=Strings.salt;
   //   hash=Strings.key+txnid+amount+productinfo+firstname+email+udf1+udf2+udf3+udf4+
   //  // udf5+udf6+udf7+udf8+udf9+udf10+Strings.salt+Strings.key;
   //  String pay_mode="test";
   //  String unique_id=transId;
   //


    String txnid = "dd11284a988a968f15b6293bc7eeb9e3";
    double amount = 29730.0;
    //String productinfo= finalPurchaseId;
    String productinfo= "10, 11, 12, 13, 14, 15, 16";
    String firstname= "Lisa";
    String email = "lisasupriya@gmail.com";
    String phone = phoneNo;
    String surl = successUrl;
    String furl = failUrl;
    String key = payKey;
    String udf1 = "";
    String udf2 = "";
    String udf3 = "";
    String udf4 = "";
    String udf5 = "";
    String address1=billingAddress;
    String address2=shippingAddress;
    String city="";
    String state="";
    String country="";
    String zipcode="";
    //String hash=paymentHashKey;
    String hash="b40650de1a0004292a0c3b2a1cfe8749c0d7e4a514d76756777958c047123d392b3c594e95fa3d10e8ff2e8dd37a965c7e9d081c5bd8afa2d83d789983be9a94";
    // String salt=Strings.salt;
    // hash=Strings.key+txnid+amount+productinfo+firstname+email+udf1+udf2+udf3+udf4+
    // udf5+udf6+udf7+udf8+udf9+udf10+Strings.salt+Strings.key;
    String pay_mode="test";
    String unique_id=transId;
    String salt = "7ESY3PUI2B";
    Object parameters = {"txnid":txnid,"amount":amount, "productinfo":productinfo,
      "firstname":firstname,"email":email,"phone":phone,"surl":surl,
      "furl":furl,"key":key,"udf1":udf1,"udf2":udf2,"udf3":udf3,
      "udf4":udf4,"udf5":udf5,"address1":address1,"address2":address2,"city":city,"state":state,
      "country":country,"zipcode":zipcode,"hash":hash,"pay_mode":pay_mode,
      "salt":salt};

    print(parameters);
    final Map response = await channel.invokeMethod("payWithEasebuzz", parameters);
    BuildContext context;
    print(response["result"]);
    // if(response['result']=="payment_successfull")
    // {
    //   ToastComponent.showDialog("Success", context);
    // }
    // else
    // {
    //   ToastComponent.showDialog("Failed", context);
    // }
  }
}



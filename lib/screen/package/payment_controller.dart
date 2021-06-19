import 'package:edutech/api/api_service.dart';
import 'package:edutech/api/urlManage.dart';
import 'package:edutech/navigation-Animator/navigation.dart';
import 'package:edutech/screen/common/bottom_navigation_screen.dart';
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

  /* User payment */
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
      "amount": totalPayment.toString(),
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

    var res = await ApiService.postWithDynamic(createPaymentUrl, params, tokenOptional: false);
    if (res["message"] == Strings.create_payment_success) {
      isLoading.value = false;
      ToastComponent.showDialog(res["message"], context);
      openPayment(res["result"]['transactionID'],firstName,email,phone,res["result"]["furl"],res["result"]["surl"],
          res["result"]["paymentHashKey"],res["result"]['merchantKey'],res['result']['salt'],context);
    } else {
      isLoading.value = false;
      ToastComponent.showDialog(res["message"], context);
    }
  }

  /* Open Payment Gateway */
  openPayment(String transId,String firstName,String emailId,String phoneNo,String failUrl,String successUrl,
      String paymentHashKey, String payKey, String saltFromApi,BuildContext context) async {

    double totalPayment = Strings.price.toDouble();
    packageRemoveSymbolFromRight = Strings.packagePurchaseList.toString().replaceAll("[", "");
    finalPurchaseId = packageRemoveSymbolFromRight.replaceAll("]", "");

    String txnid = transId;
    double amount = totalPayment;
    String productinfo= finalPurchaseId;
    String firstname= firstName;
    String email = emailId;
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
    String hash=paymentHashKey;
    //String hash="4414db724da68d256f0d9e558d10f2ccf579e10ae874543bda8eb39094e7badee51e61fa7e055d50b47b4c4fa4e7d06d078ca626737e874012220efff3bf9dee";
     String salt=saltFromApi;
    // hash=Strings.key+txnid+amount+productinfo+firstname+email+udf1+udf2+udf3+udf4+
    // udf5+udf6+udf7+udf8+udf9+udf10+Strings.salt+Strings.key;
    String pay_mode="test";

    Object parameters = {"txnid":txnid,"amount":amount, "productinfo":productinfo,
      "firstname":firstname,"email":email,"phone":phone,"surl":surl,
      "furl":furl,"key":key,"udf1":udf1,"udf2":udf2,"udf3":udf3,
      "udf4":udf4,"udf5":udf5,"address1":address1,"address2":address2,"city":city,"state":state,
      "country":country,"zipcode":zipcode,"hash":hash,"pay_mode":pay_mode,
      "salt":salt};

    final Map response = await channel.invokeMethod("payWithEasebuzz", parameters);

    if(response['result']=="payment_successfull")
    {
      confirmPayment(context,response);
    }
    else
    {
      ToastComponent.showDialog(response['result'], context);
    }
  }

  /* Confirm Payment status */
  Future<void> confirmPayment(BuildContext context,Map response) async {
    Map<String,dynamic> params={
       "userId": user_id,
      "firstname": response["payment_response"]["firstname"],
      "flag": response["payment_response"]["flag"],
      "merchant_logo": response["payment_response"]["merchant_logo"],
      "cardCategory": response["payment_response"]["cardCategory"],
      "udf10": response["payment_response"]["udf10"],
      "error": response["payment_response"]["error"],
      "addedon": response["payment_response"]["addedon"],
      "mode": response["payment_response"]["mode"],
      "udf9": response["payment_response"]["udf9"],
      "udf7": response["payment_response"]["udf7"],
      "issuing_bank": response["payment_response"]["issuing_bank"],
      "cash_back_percentage": response["payment_response"]["cash_back_percentage"],
      "udf8": response["payment_response"]["udf8"],
      "deduction_percentage": response["payment_response"]["deduction_percentage"],
      "error_Message": response["payment_response"]["error_Message"],
      "payment_source": response["payment_response"]["payment_source"],
      "bank_ref_num": response["payment_response"]["bank_ref_num"],
      "email": response["payment_response"]["email"],
      "key": response["payment_response"]["key"],
      "bankcode": response["payment_response"]["bankcode"],
      "txnid": response["payment_response"]["txnid"],
      "amount": response["payment_response"]["amount"],
      "unmappedstatus": response["payment_response"]["unmappedstatus"],
      "easepayid": response["payment_response"]["easepayid"],
      "udf5": response["payment_response"]["udf5"],
      "udf6": response["payment_response"]["udf6"],
      "surl": response["payment_response"]["surl"],
      "udf3": response["payment_response"]["udf3"],
      "net_amount_debit": response["payment_response"]["net_amount_debit"],
      "udf4": response["payment_response"]["udf4"],
      "card_type": response["payment_response"]["card_type"],
      "udf1": response["payment_response"]["udf1"],
      "udf2": response["payment_response"]["udf2"],
      "cardnum": response["payment_response"]["cardnum"],
      "phone": response["payment_response"]["phone"],
      "furl": response["payment_response"]["furl"],
      "productinfo": response["payment_response"]["productinfo"],
      "PG_TYPE": response["payment_response"]["PG_TYPE"],
      "hash": response["payment_response"]["hash"],
      "name_on_card": response["payment_response"]["name_on_card"],
      "status": response["payment_response"]["status"]
    };

    var res = await ApiService.postWithDynamic(confirmPaymentStatusUrl, params, tokenOptional: false);
    if (res["message"] == Strings.payment_successfull_message) {
    isLoading.value = false;

    ToastComponent.showDialog(res["message"], context);

    Future.delayed(Duration(seconds: 2), () {
        Navigator.pushReplacement(context, FadeNavigation(widget: BottomNavigationScreen()));
      });
    } else {
    isLoading.value = false;
    ToastComponent.showDialog(res["message"], context);
    }
  }
}



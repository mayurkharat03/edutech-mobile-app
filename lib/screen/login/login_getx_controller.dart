import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:mlm/api/api_service.dart';
import 'package:mlm/api/urlManage.dart';
import 'package:mlm/navigation-Animator/navigation.dart';
import 'package:mlm/screen/dashboard_screen.dart';
import 'package:mlm/utils/Functions.dart';
import 'package:mlm/utils/strings.dart';
import 'package:mlm/utils/toast_component.dart';

class LoginController extends GetxController {
  TextEditingController emailTextController;
  TextEditingController passwordTextController;
  TextEditingController forgotPasswordController;
  RxBool isLoading = false.obs;
  RxBool isReferLoading = false.obs;
  RxBool isMobileVerify = false.obs;

  /*Controller for verify referrals*/
  TextEditingController verifyReferralController;
  TextEditingController mobileNoController;

  @override
  void onInit() {
    emailTextController = TextEditingController();
    passwordTextController = TextEditingController();
    forgotPasswordController = TextEditingController();
    verifyReferralController = TextEditingController();
    mobileNoController = TextEditingController();
    super.onInit();
  }

  void apiLogin(BuildContext context) async {
    isLoading.value = true;
    Map<String, String> params = {
      "username": emailTextController.text,
      "password": passwordTextController.text
    };
    var res = await ApiService.post(getLogin, params, tokenOptional: false);
    if (res["message"] == Strings.login_success_message) {
      isLoading.value = false;
      ApiService.dataStorage.write("user_id", res["result"][0]["id_user"]);
      ApiService.dataStorage
          .write("first_name", res["result"][0]["first_name"]);
      ApiService.dataStorage.write("last_name", res["result"][0]["last_name"]);
      ApiService.dataStorage.write("email", res["result"][0]["email"]);
      ApiService.dataStorage
          .write("referred_by", res["result"][0]["referred_by"]);

      ApiService.dataStorage.write("token", res["token"]);
      ToastComponent.showDialog("Login SuccessFull", context);

      Navigator.pushReplacement(context, FadeNavigation(widget: DashBoard()));
    } else {
      isLoading.value = false;
      ToastComponent.showDialog(res["message"], context);
    }
  }

  void apiVerifyReferral(BuildContext context) async {
    isReferLoading.value = true;
    var res = await ApiService.get(verifyReferral, params: verifyReferralController.text, tokenOptional: false);
    if (res["message"] == Strings.referral_success) {
      isReferLoading.value = false;
      ApiService.dataStorage.write("id_referral_code", res["result"][0]["id_referral_code"]);
      ApiService.dataStorage.write("code", res["result"][0]["code"]);
      ApiService.dataStorage.write("refer_user_id", res["result"][0]["user_id"]);
      showAlertDialog(context, Strings.verify_refer, "refer",Strings.verified_dialog_message);
    } else {
      isReferLoading.value = false;
      ToastComponent.showDialog(res["message"], context);
    }
  }

  void apiVerifyMobile(BuildContext context) async {
    isMobileVerify.value = true;
    var res = await ApiService.get(getOtp,params: mobileNoController.text,tokenOptional: false);
    isReferLoading.value=false;
    if (res["message"] == Strings.otp_generated_success) {
      isMobileVerify.value = false;
      isReferLoading.value=false;
      showAlertDialog(
          context, Strings.mobile_verify, "mobile", Strings.mobile_dialog_message,
          intentValue: mobileNoController.text);
      ApiService.dataStorage.write("mobile", mobileNoController.text);
    }
    else {
      isMobileVerify.value = false;
      isReferLoading.value=false;
      ToastComponent.showDialog(res["message"], context);
    }
  }

  void getStandardList(int boardId) async {
    isMobileVerify.value = true;
    var res = await ApiService.get(getStandardsUrl, params: boardId,tokenOptional:true);
    print(res);
  }

  @override
  void onClose() {
    emailTextController?.dispose();
    passwordTextController?.dispose();
    verifyReferralController?.dispose();
    forgotPasswordController?.dispose();
    mobileNoController?.dispose();
    super.onClose();
  }
}

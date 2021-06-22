import 'package:edutech/screen/common/bottom_navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:edutech/api/api_service.dart';
import 'package:edutech/api/urlManage.dart';
import 'package:edutech/navigation-Animator/navigation.dart';
import 'package:edutech/screen/common/dashboard_screen.dart';
import 'package:edutech/utils/Functions.dart';
import 'package:edutech/utils/strings.dart';
import 'package:edutech/utils/toast_component.dart';

class LoginController extends GetxController {
  TextEditingController emailTextController;
  TextEditingController passwordTextController;
  TextEditingController forgotPasswordController;
  TextEditingController otpController;
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
    otpController = TextEditingController();
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
      Strings.userId=res["result"][0]["id_user"];
      ApiService.dataStorage.write("user_id", res["result"][0]["id_user"]);
      ApiService.dataStorage.write("first_name", res["result"][0]["first_name"]);
      ApiService.dataStorage.write("last_name", res["result"][0]["last_name"]);
      ApiService.dataStorage.write("email", res["result"][0]["email"]);
      ApiService.dataStorage.write("referred_by", res["result"][0]["referred_by"]);
      ApiService.dataStorage.write("phone", res["result"][0]["phone_number"]);
      ApiService.dataStorage.write("billing_address", res["result"][0]["billing_address"]);
      ApiService.dataStorage.write("shipping_address", res["result"][0]["shipping_address"]);
      ApiService.dataStorage.write("isAadhaarFrontUploaded", res["result"][0]["isAadhaarFrontUploaded"]);
      ApiService.dataStorage.write("isAadhaarBackUploaded", res["result"][0]["isAadhaarBackUploaded"]);
      ApiService.dataStorage.write("isPanUploaded", res["result"][0]["isPanUploaded"]);
      ApiService.dataStorage.write("isProfileUploaded", res["result"][0]["isProfileUploaded"]);
      ApiService.dataStorage.write("token", res["token"]);

      ToastComponent.showDialog("Login Successful", context);
      Navigator.pushReplacement(context, FadeNavigation(widget: BottomNavigationScreen()));
      //Navigator.pushReplacement(context, FadeNavigation(widget: StudentDetailsScreen()));
    } else {
      isLoading.value = false;
      ToastComponent.showDialog(res["message"], context);
    }
  }

  void apiVerifyReferral(BuildContext context) async {
    isReferLoading.value = true;
    var res = await ApiService.get(verifyReferral, params: verifyReferralController.text, tokenOptional: true);
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

  void apiVerifyOtp(BuildContext context) async {

    isReferLoading.value = true;
    var res = await ApiService.verifyOTPService(verifyOtp, mobileNoController.text, otpController.text, tokenOptional: true);
    if (res["message"] == Strings.referral_success) {
      isReferLoading.value = false;
      showOtpAlertDialog(context);
    } else {
      isReferLoading.value = false;
      ToastComponent.showDialog(res["message"], context);
    }
  }

  void apiVerifyMobile(BuildContext context) async {
    isMobileVerify.value = true;
    var res = await ApiService.get(getOtp,params: mobileNoController.text,tokenOptional: true);
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

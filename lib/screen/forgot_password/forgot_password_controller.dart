import 'package:edutech/api/api_service.dart';
import 'package:edutech/api/urlManage.dart';
import 'package:edutech/navigation-Animator/navigation.dart';
import 'package:edutech/screen/forgot_password/enter_new_password_screen.dart';
import 'package:edutech/screen/forgot_password/forgot_password_otp_screen.dart';
import 'package:edutech/screen/login/login_screen.dart';
import 'package:edutech/utils/Functions.dart';
import 'package:edutech/utils/strings.dart';
import 'package:edutech/utils/toast_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ForgotPasswordController extends GetxController{

  static final dataStorage = GetStorage();
  int userId;
  TextEditingController forgotPasswordController;
  TextEditingController mobileNoController;
  TextEditingController otpController;
  TextEditingController confirmPasswordController;
  RxBool isLoading = false.obs;
  RxBool isOtpLoading = false.obs;
  RxBool isChangePassLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    mobileNoController = TextEditingController();
    forgotPasswordController = TextEditingController();
    otpController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  void getOtpForgotPassword(BuildContext context) async{
    isLoading.value = true;
    var res = await ApiService.get(getOTPForForgotPasswordUrl,
        params: mobileNoController.text,tokenOptional: true);

    if (res["message"] == Strings.otp_for_forgot_password_success) {
      isLoading.value = false;
      ApiService.dataStorage.write("user_id", res["result"]["id_user"]);
      ToastComponent.showDialog(res["message"], context);
      Navigator.pushReplacement(context, FadeNavigation(widget: ForgotPasswordOtpScreen(forgotPasswordController.text)));
    }
    else {
      isLoading.value = false;
      ToastComponent.showDialog(res["message"], context);
    }
  }

  void verifyOtpForgotPassword(BuildContext context) async{
    isOtpLoading.value = true;
     userId = ApiService.dataStorage.read("user_id");
    var res = await ApiService.get(verifyForgotPasswordOTPUrl,
        params: userId.toString() + "/" + otpController.text,tokenOptional: true);

    if (res["message"] == Strings.otp_verify_for_forgot_password) {
      isOtpLoading.value = false;
      ToastComponent.showDialog(res["message"], context);
      showForgotOtpAlertDialog(context);
      //Navigator.pushReplacement(context, FadeNavigation(widget: EnterNewPasswordScreen()));
    }
    else {
      isOtpLoading.value = false;
      ToastComponent.showDialog(res["message"], context);
    }
  }

  void changePassword(BuildContext context) async{
    isChangePassLoading.value = false;
    userId = ApiService.dataStorage.read("user_id");
    Map<String,dynamic> params={
    "userId":userId,
    "newPassword" : confirmPasswordController.text,
    };
    var res = await ApiService.postWithDynamic(changePasswordUrl,params,tokenOptional: true);

    if (res["message"] == Strings.update_forgot_password) {
      isChangePassLoading.value = false;
      ToastComponent.showDialog(res["message"], context);
      showForgotOtpAlertDialog(context);
      //Navigator.pushReplacement(context, FadeNavigation(widget: LoginScreen()));
    }
    else {
      isChangePassLoading.value = false;
      ToastComponent.showDialog(res["message"], context);
    }
   }
}
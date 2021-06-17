import 'package:edutech/api/api_service.dart';
import 'package:edutech/api/urlManage.dart';
import 'package:edutech/navigation-Animator/navigation.dart';
import 'package:edutech/screen/seller/final_congrats_seller_screen.dart';
import 'package:edutech/utils/strings.dart';
import 'package:edutech/utils/toast_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddBankDetailsController extends GetxController{

  TextEditingController bankNameController;
  TextEditingController accountNumberController;
  TextEditingController accountNameController;
  TextEditingController ifscCodeController;
  TextEditingController upiIdController;

  @override
  void onInit() {
    super.onInit();
    bankNameController=TextEditingController();
    accountNumberController=TextEditingController();
    accountNameController=TextEditingController();
    ifscCodeController=TextEditingController();
    upiIdController=TextEditingController();
  }
  /// Add seller's bank details
  void addSellerBankDetails(BuildContext context) async {

    Map<String, dynamic> params={
      "userId":Strings.userId,
      "bankName":bankNameController.text,
      "accountNumber":accountNumberController.text,
      "accountName":accountNameController.text,
      "ifscCode":ifscCodeController.text,
      "upiId":upiIdController.text??"NA",
    };
    var res = await ApiService.postWithDynamic(addBackDetailsUrl, params,tokenOptional:false);
    if (res["message"] == Strings.added_bank_details_success) {
      Navigator.pushReplacement(context, FadeNavigation(widget: FinalCongratsSellerScreen()));
    }
    else {
      ToastComponent.showDialog(res["message"], context);
    }
  }
}
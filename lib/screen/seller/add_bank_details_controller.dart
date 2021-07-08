import 'dart:io';

import 'package:edutech/api/api_service.dart';
import 'package:edutech/api/urlManage.dart';
import 'package:edutech/navigation-Animator/navigation.dart';
import 'package:edutech/screen/seller/add_bank_account_screen.dart';
import 'package:edutech/screen/seller/final_congrats_seller_screen.dart';
import 'package:edutech/utils/strings.dart';
import 'package:edutech/utils/toast_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

class AddBankDetailsController extends GetxController{

  TextEditingController bankNameController;
  TextEditingController accountNumberController;
  TextEditingController accountNameController;
  TextEditingController ifscCodeController;
  TextEditingController upiIdController;
  PickedFile profileImage;
  PickedFile pancardImage;
  static final dataStorage = GetStorage();
  int user_id;
  int isPanUploaded;
  int isProfileUploaded;

  @override
  void onInit() {
    super.onInit();
    bankNameController=TextEditingController();
    accountNumberController=TextEditingController();
    accountNameController=TextEditingController();
    ifscCodeController=TextEditingController();
    upiIdController=TextEditingController();
    isPanUploaded = dataStorage.read("isPanUploaded");
    isProfileUploaded = dataStorage.read("isProfileUploaded");
  }

  /// Add seller's bank details
  void addSellerBankDetails(BuildContext context) async {

    user_id = dataStorage.read("user_id");

    Map<String, dynamic> params={
      "userId":user_id.toString(),
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

  /// Upload profile image
  Future<void> uploadSellerPhoto(BuildContext context) async {
    var res = await ApiService.upload(File(profileImage.path), uploadProfileImageUrl,'image');
    String response;
    res.listen((value) {
      response=value.toString();
      if (response.contains(Strings.profile_success)) {
        if(isPanUploaded == 0)
          {
            Navigator.pushReplacement(context, FadeNavigation(widget: AddBankAccountScreen()));
          }
        else{
          ToastComponent.showDialog("Uploaded Successfully", context);
        }
      }
      else {
        ToastComponent.showDialog(Strings.failed_message, context);
      }
    });
  }

  /// Upload pancard image
  Future<void> uploadPancardPhoto(BuildContext context) async {
    var res = await ApiService.upload(File(pancardImage.path), uploadPancardUrl,'image');
    String response;
    res.listen((value) {
      response=value.toString();
      if (response.contains(Strings.profile_success)) {
        if(isProfileUploaded == 0)
        {
          Navigator.pushReplacement(context, FadeNavigation(widget: AddBankAccountScreen()));
        }
        else{
          ToastComponent.showDialog("Uploaded Successfully", context);
        }
      }
      else {
        ToastComponent.showDialog(Strings.failed_message, context);
      }
    });
  }
}
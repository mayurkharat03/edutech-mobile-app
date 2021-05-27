import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mlm/api/api_service.dart';
import 'package:mlm/api/urlManage.dart';
import 'package:mlm/navigation-Animator/navigation.dart';
import 'package:mlm/screen/dashboard_screen.dart';
import 'package:mlm/utils/Functions.dart';
import 'package:mlm/utils/strings.dart';
import 'package:mlm/utils/toast_component.dart';

class RegistrationController extends GetxController {
  /*personal detail textField Controller*/
  TextEditingController firstNameController;
  TextEditingController lastNameController;
  String dateOfBirthController;
  TextEditingController middleNameController;
  String salutation;
  String gender;
  PickedFile frontImagePath;
  PickedFile backImagePath;
  PickedFile profileImage;

  /*shipping address details*/
  TextEditingController addressLineFirstController;
  TextEditingController addressLineSecondController;
  TextEditingController pinCodeController;
  TextEditingController cityController;
  TextEditingController districtController;
  TextEditingController stateController;

  TextEditingController billingAddressLineFirstController;
  TextEditingController billingAddressLineSecondController;
  TextEditingController billingPinCodeController;
  TextEditingController billingCityController;
  TextEditingController billingDistrictController;
  TextEditingController billingStateController;

  /*Confirm password details*/
  TextEditingController mobileNumberController;
  TextEditingController emailIdController;
  TextEditingController setPasswordController;
  TextEditingController confirmPasswordController;

/*Kyc */
  TextEditingController aadharCardController;
  TextEditingController panCardController;


  RxBool isLoading = false.obs;
  RxBool isReferLoading = false.obs;
  RxBool isMobileVerify = false.obs;

  /*Controller for verify referrals*/
  TextEditingController verifyReferralController;
  TextEditingController mobileNoController;

  @override
  void onInit() {
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    middleNameController = TextEditingController();
    verifyReferralController = TextEditingController();
    mobileNoController = TextEditingController();

    addressLineFirstController = TextEditingController();
    addressLineSecondController = TextEditingController();
    pinCodeController = TextEditingController();
    cityController = TextEditingController();
    districtController = TextEditingController();
    stateController = TextEditingController();
    billingAddressLineFirstController = TextEditingController();
    billingAddressLineSecondController = TextEditingController();
    billingPinCodeController = TextEditingController();
    billingCityController = TextEditingController();
    billingDistrictController = TextEditingController();
    billingStateController = TextEditingController();

    mobileNoController=TextEditingController();
    emailIdController=TextEditingController();
    setPasswordController=TextEditingController();
    confirmPasswordController=TextEditingController();


    aadharCardController=TextEditingController();
    panCardController=TextEditingController();

    super.onInit();
  }

  /*User login*/
  Future<void> userRegistration(BuildContext context) async {
    isLoading.value = true;
    Map<String, String> params = {
      "username": "emailTextController.text",
      "password": "passwordTextController.text"
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

  /// Add user details..registration process
  void addUserDetails(BuildContext context,String salutation,String mobileNo,String billingAdd,
      String shippingAdd,String dob) async {
    gender=='Male'?gender="1":gender="2";
    int refferedBy= ApiService.dataStorage.read('refer_user_id');

    Map<String, dynamic> params={
      "salutation":salutation,
      "firstName":firstNameController.text,
      "middleName":middleNameController.text,
      "lastName":lastNameController.text,
      "email":emailIdController.text,
      "password":setPasswordController.text,
      "phoneNumber":mobileNo,
      "gender":int.parse(gender),
      "billingAddress":billingAdd,
      "shippingAddress":shippingAdd==null ? 'Not Added': shippingAdd,
      "dateOfBirth":dob,
      "referredBy":refferedBy
      };
    isMobileVerify.value = true;
    print(params);
    var res = await ApiService.postWithoutToken(addUser, params,tokenOptional:false);
    print(res);
    if (res["message"] == Strings.register_success) {
      if(profileImage==null){
        uploadAadharFrontImage(context);
      }
      else{
        uploadProfileImage(context);
      }
      print(res['userId']);
    }
    else if(res['message']=='Emailid already exists'){
      ToastComponent.showDialog(res["message"], context);
    }
    else {
      isLoading.value = false;
      ToastComponent.showDialog(res["message"], context);
    }
  }
  /// Upload profile image
  Future<void> uploadProfileImage(BuildContext context) async {
    var res = await ApiService.upload(File(profileImage.path), uploadProfileImageUrl,'image');
    String response;
    res.listen((value) {
      response=value.toString();
      if (response.contains(Strings.profile_success)) {
        uploadAadharFrontImage(context);
      }
      else {
        isLoading.value = false;
        ToastComponent.showDialog(Strings.failed_message, context);
      }
    });
  }
  /// Upload aadhar card front image
  Future<void> uploadAadharFrontImage(BuildContext context) async {
    var res = await ApiService.upload(File(frontImagePath.path), uploadAadharFrontImageUrl,'image');
    String response;
    res.listen((value) {
      response=value.toString();
      if(response.contains(Strings.aadhar_card_front_success)){
       // uploadAadharBackImage(context);
        print('success');
      }
      else{
        isLoading.value = false;
        ToastComponent.showDialog(res["message"], context);
      }
    });
  }

  /// Upload aadhar card back image
  Future<void> uploadAadharBackImage(BuildContext context) async {
    var res = await ApiService.upload(File(backImagePath.path), uploadAadharBackImageUrl,'image');
    String response;
    res.listen((value) {
      response=value.toString();
      if(response.contains(Strings.aadhar_card_back_success)){
        showAlertDialog(context, Strings.mobile_verify, "Reg", "Registration Successfylly");
      }
      else{
        isLoading.value = false;
        ToastComponent.showDialog(res["message"], context);
      }
    });
  }

  @override
  void onClose() {
    firstNameController?.dispose();
    lastNameController?.dispose();
    verifyReferralController?.dispose();
    middleNameController?.dispose();
    mobileNoController?.dispose();

    addressLineFirstController?.dispose();
    addressLineSecondController?.dispose();
    pinCodeController?.dispose();
    cityController?.dispose();
    districtController?.dispose();
    stateController?.dispose();

    billingAddressLineFirstController?.dispose();
    billingAddressLineSecondController?.dispose();
    billingPinCodeController?.dispose();
    billingCityController?.dispose();
    billingDistrictController?.dispose();
    billingStateController?.dispose();

    mobileNoController?.dispose();
    emailIdController?.dispose();
    setPasswordController?.dispose();
    confirmPasswordController?.dispose();

    aadharCardController?.dispose();
    panCardController?.dispose();
    super.onClose();
  }
}

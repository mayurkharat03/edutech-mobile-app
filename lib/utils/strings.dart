import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Strings {
  Strings._();

  //General
  static const String appName = "Admin Panel";
  static const String montserrat = "Montserrat";
  static const String proximaNova = "ProximaNova";
  static const String varelaRound = "VarelaRound";
  static const String poppins = "Poppins";
  static const String currency = "₹ ";

  static const String reg_back = "assets/images/reg_background.png";
  static const String verify_refer = "assets/images/verify_refer.gif";
  static const String mobile_verify = "assets/images/mobile_verify.gif";
  static const String upload = "assets/images/upload.png";
  static const String app_icon = "assets/images/edutecklauncher.png";
  static const String confirm = "assets/images/confirm.gif";


  static String mobileNo = "";
  static String emailId = "";

//api status
  static const String statusOk = "OK";
  static const String status500 = "500";
  static const String status401 = "401";
  static const String statusFail = "BAD_REQUEST";
  static const String clickActionAdharFront = "adharFront";
  static const String clickActionAdharBack = "adharBack";

  static const String noImage =
      "https://comnplayscience.eu/app/images/notfound.png";

  /*Registration hint Strings*/
  static const String enter_referral = " Enter Referral Code";
  static const String enter_mobile = " Mobile Number";

  /*form label text*/
  static const String check_box_billing =
      "My Billing Address is same as My Shipping Address.";
  static const String login_details = "Login details: ";
  static const String kyc_title = "KYC Details: ";
  static const String terms_and_condition = "Terms & Conditions: ";
  static const String terms_and_condition_text =
      " is simply dummy text of the printing and typesetting industry. "
      "\n\nLorem Ipsum has been the industry's standard dummy text ever since the 1500s, \nwhen an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. \nIt was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum ";

/*API RESPONSE SUCCESS MESSAGE*/
  static const String login_success_message = "Login successfull";
  static const String referral_success = "Referral Code Verified";
  static const String register_success = "User added successfully";
  static const String otp_generated_success = "OTP generated successfully";
  static const String verified_dialog_message = "Your referral code is successfully verified!";
  static const String otp_dialog_message = "Your OTP is successfully verified!";
  static const String mobile_dialog_message = "OTP is successfully sent!";
  static const String get_board_list_success = "Boards List";
  static const String get_standard_list_success = "Standard List by Boards";
  static const String profile_success = "Profile uploaded successfully";
  static const String aadhar_card_front_success = "Aadhaar Front uploaded successfully";
  static const String aadhar_card_back_success = "Aadhaar Back uploaded successfully";
  static const String failed_message = "Failed to upload";
  static const String get_package_suceess = "Purchase Package by User";
  static const String added_package_suceess = "Package added successfully";
  static const String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6Im1heXVyMTJAZ21haWwuY29tIiwicGFzc3dvcmQiOiIxMjM0IiwiaWF0IjoxNjIwNDQ1NzQ5fQ.ncouRhbXfOtWhn_wjhyWL1ROI3Mw_p3FctKT5_9EZYg";
  static List<String> allBoards=[];
  static List<int> allBoardsId=[];
  static List<String> allStandardsName=[];
  static List<int> allStandardsId=[];
  static List<String> subjectList=[];
  static List<String> priceList=[];
  static int userId;
  static int showTotalPrice=0;
}

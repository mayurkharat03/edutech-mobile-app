import 'package:edutech/screen/common/dashboard_screen.dart';
import 'package:edutech/screen/forgot_password/enter_new_password_screen.dart';
import 'package:edutech/screen/login/login_screen.dart';
import 'package:edutech/screen/registration/user_info_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:edutech/navigation-Animator/navigation.dart';
import 'package:edutech/screen/package/add_package.dart';
import 'package:edutech/screen/registration/mobile_number_verification.dart';
import 'package:edutech/screen/registration/otp_screen.dart';
import 'package:edutech/utils/CustomAlertDialog.dart';
import 'package:edutech/utils/colors.dart';
import 'package:edutech/utils/strings.dart';

Widget commonAppBar(String title,
    {bool isTitle, double titleFont, Color colors, Color textTitleColor}) {
  return AppBar(
    title: Text(
      title,
      style: TextStyle(fontSize: titleFont, color: textTitleColor),
    ),
    elevation: 10,
    backgroundColor: colors,
    actions: [
      Padding(
        padding: EdgeInsets.all(8.0),
        child: Icon(Icons.more_vert),
      ),
    ],
  );
}

Widget textWidget(String value, Color color, double fontSize,
    {FontWeight weight, TextAlign align, double letterSpacing}) {
  return Text(
    value,
    textAlign: align,
    style: TextStyle(
        fontFamily: Strings.montserrat,
        color: color,
        fontSize: fontSize,
        fontWeight: weight),
  );
}

Widget button(String nameButton) {
  return Material(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.0)),
    color: AppColors.primaryColor,
    child: FlatButton(
      splashColor: Colors.white,
      height: 45,
      minWidth: Get.width,
      child: Text(
        nameButton,
        style: TextStyle(
            fontSize: 14, fontFamily: Strings.montserrat, color: Colors.white),
      ),
    ),
  );
}

Widget buttonRow(String nameButton, Color textColor, Color backColor) {
  return Material(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.0)),
    color: backColor,
    child: FlatButton(
      splashColor: Colors.white,
      child: Text(
        nameButton,
        style: TextStyle(
            fontSize: 14, fontFamily: Strings.montserrat, color: textColor),
      ),
    ),
  );
}

Widget buttonSell(String nameButton, Color textColor, Color backColor) {
  return Material(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
    color: backColor,
    child: FlatButton(
      splashColor: Colors.white,
      height: 35,
      minWidth: Get.width,
      child: Text(
        nameButton,
        style: TextStyle(
            fontSize: 16, fontFamily: Strings.montserrat, color: textColor),
      ),
    ),
  );
}

TextStyle styleForLabel(double fontSize, Color color) {
  return TextStyle(
    fontFamily: Strings.montserrat,
    fontSize: fontSize,
    color: color,
  );
}

TextFormField textFormField() {
  return TextFormField(
//    controller: ,

    decoration: InputDecoration(
      //    labelStyle: style,
      labelText: 'Pin Code',
      contentPadding: EdgeInsets.all(15.0),
      isDense: true,
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
      ),
    ),
  );
}

bool validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  return (!regex.hasMatch(value)) ? false : true;
}

bool validAdhar(String value) {
  Pattern pattern = r'^[0-9]{4}[ -]?[0-9]{4}[ -]?[0-9]{4}$';
  RegExp regex = new RegExp(pattern);
  return (!regex.hasMatch(value)) ? false : true;
}

void showAlertDialog(
    BuildContext context, String image, String dialogType, String message,
    {String intentValue}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.of(context).pop();
        if (dialogType == "refer") {
          Navigator.push(context, FadeNavigation(widget: MobileScreen()));
        } else if (dialogType == "Reg") {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => AddPackage()),
              (Route<dynamic> route) => false);
        } else {
          Navigator.push(
              context, FadeNavigation(widget: VerifyOtp(intentValue)));
        }
      });
      return CustomAlertDialog(
        content: Container(
          width: MediaQuery.of(context).size.width / 1.3,
          height: MediaQuery.of(context).size.height / 2.5,
          decoration: new BoxDecoration(
            shape: BoxShape.rectangle,
            color: const Color(0xFFFFFF),
            borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
          ),
          child: new Column(
            children: <Widget>[
              Image.asset(
                image,
                height: Get.height * 0.3,
                width: Get.height * 0.2,
                fit: BoxFit.contain,
              ),
              Text(
                message,
                style: TextStyle(
                  fontFamily: Strings.montserrat,
                  color: AppColors.labelColor,
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    },
  );
}

void showOtpAlertDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.of(context, rootNavigator: true).pop();
        Navigator.push(context, FadeNavigation(widget: UserStepperScreen()));
      });
      return CustomAlertDialog(
        content: Container(
          width: MediaQuery.of(context).size.width / 1.3,
          height: MediaQuery.of(context).size.height / 2.5,
          decoration: new BoxDecoration(
            shape: BoxShape.rectangle,
            color: const Color(0xFFFFFF),
            borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
          ),
          child: new Column(
            children: <Widget>[
              Image.asset(
                Strings.mobile_verify,
                height: Get.height * 0.3,
                width: Get.height * 0.2,
                fit: BoxFit.contain,
              ),
              Text(
                "Your mobile number is successfully verified!",
                style: TextStyle(
                  fontFamily: Strings.montserrat,
                  color: AppColors.labelColor,
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    },
  );
}

void showForgotOtpAlertDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.of(context, rootNavigator: true).pop();
        Navigator.push(context, FadeNavigation(widget: EnterNewPasswordScreen()));
      });
      return CustomAlertDialog(
        content: Container(
          width: MediaQuery.of(context).size.width / 1.3,
          height: MediaQuery.of(context).size.height / 2.5,
          decoration: new BoxDecoration(
            shape: BoxShape.rectangle,
            color: const Color(0xFFFFFF),
            borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
          ),
          child: new Column(
            children: <Widget>[
              Image.asset(
                Strings.mobile_verify,
                height: Get.height * 0.3,
                width: Get.height * 0.2,
                fit: BoxFit.contain,
              ),
              Text(
                "OTP is successfully verified!",
                style: TextStyle(
                  fontFamily: Strings.montserrat,
                  color: AppColors.labelColor,
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    },
  );
}

void showChangePassAlertDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.of(context, rootNavigator: true).pop();
        Navigator.push(context, FadeNavigation(widget: LoginScreen()));
      });
      return CustomAlertDialog(
        content: Container(
          width: MediaQuery.of(context).size.width / 1.3,
          height: MediaQuery.of(context).size.height / 2.5,
          decoration: new BoxDecoration(
            shape: BoxShape.rectangle,
            color: const Color(0xFFFFFF),
            borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
          ),
          child: new Column(
            children: <Widget>[
              Image.asset(
                Strings.mobile_verify,
                height: Get.height * 0.3,
                width: Get.height * 0.2,
                fit: BoxFit.contain,
              ),
              Text(
                "Password updated successfully!",
                style: TextStyle(
                  fontFamily: Strings.montserrat,
                  color: AppColors.labelColor,
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    },
  );
}
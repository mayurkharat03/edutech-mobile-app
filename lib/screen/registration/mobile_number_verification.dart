import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mlm/navigation-Animator/navigation.dart';
import 'package:mlm/screen/login/login_getx_controller.dart';
import 'package:mlm/screen/registration/otp_screen.dart';
import 'package:mlm/screen/registration/registration_controller.dart';
import 'package:mlm/utils/CustomAlertDialog.dart';
import 'package:mlm/utils/Functions.dart';
import 'package:mlm/utils/colors.dart';
import 'package:mlm/utils/strings.dart';
import 'package:mlm/utils/toast_component.dart';
import 'package:toast/toast.dart';

class MobileScreen extends StatefulWidget {
  @override
  _MobileScreenState createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
  final LoginController _loginController = Get.put(LoginController());

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: content(),
    );
  }

  Widget bodySection() {
    return Expanded(
      child: Container(
        child: new Stack(children: [
          Stack(
            children: [
              Container(
                height: Get.height * 0.22,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                ),
              ),
              Container(
                  margin: EdgeInsets.only(
                      top: Get.height * 0.1, left: Get.height * 0.06),
                  child: textWidget(
                      "Verify your mobile number", Colors.white, 22)),
            ],
          ),
          Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: Get.height * 0.22),
                decoration: BoxDecoration(
                  color: AppColors.backgroundColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  margin: EdgeInsets.only(top: Get.height * 0.16),
                  child: TextFormField(
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                    ],
                    controller: _loginController.mobileNoController,
                    keyboardType: TextInputType.number,
                    textCapitalization: TextCapitalization.characters,
                    decoration: InputDecoration(
                      labelText: Strings.enter_mobile,
                      labelStyle: TextStyle(
                          fontFamily: Strings.montserrat, fontSize: 12),
                      fillColor: Colors.white,
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      hintText: Strings.enter_mobile,
                      hintStyle: TextStyle(
                          fontFamily: Strings.montserrat, fontSize: 12),
                      contentPadding: EdgeInsets.all(15.0),
                      isDense: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: GoogleFonts.exo2(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
              Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: Get.height * 0.30),
                  child: Image.asset(
                    Strings.reg_back,
                    fit: BoxFit.fitWidth,
                  )),
            ],
          ),
        ]),
      ),
    );
  }

  Widget fixedBottomSection() {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Obx(
          () => _loginController.isMobileVerify == true
              ? Center(child: CupertinoActivityIndicator())
              : InkWell(
                  onTap: () {
                    String mobileNo = _loginController.mobileNoController.text;
                    if (mobileNo.isEmpty) {
                      ToastComponent.showDialog("Enter Mobile Number", context,
                          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
                      return;
                    } else if (mobileNo.length < 10) {
                      ToastComponent.showDialog(
                          "Enter Valid Mobile Number", context,
                          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
                      return;
                    } else {
                      _loginController.apiVerifyMobile(context);
                    }
                  },
                  child: button("Send Otp")),
        ));
  }

  Widget content() {
    return new Column(
      // This makes each child fill the full width of the screen
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        bodySection(),
        fixedBottomSection(),
      ],
    );
  }
}

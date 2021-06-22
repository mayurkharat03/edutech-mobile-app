import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:edutech/screen/login/login_getx_controller.dart';
import 'package:edutech/utils/Functions.dart';
import 'package:edutech/utils/colors.dart';
import 'package:edutech/utils/strings.dart';
import 'package:edutech/utils/toast_component.dart';
import 'package:toast/toast.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final LoginController _loginController = Get.put(LoginController());

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
                      "Do you have referral code?", Colors.white, 22)),
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
                  margin: EdgeInsets.only(top: Get.height * 0.16),
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: TextFormField(
                        controller: _loginController.verifyReferralController,
                        textCapitalization: TextCapitalization.characters,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(12),
                        ],
                        decoration: InputDecoration(
                          labelStyle: TextStyle(
                              fontFamily: Strings.montserrat, fontSize: 12),
                          labelText: 'Enter Referral Code',
                          contentPadding: EdgeInsets.all(15.0),
                          isDense: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                        onEditingComplete: (){
                          _loginController.apiVerifyReferral(context);
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                  width: Get.width * 0.9,
                  margin: EdgeInsets.only(top: Get.height * 0.30,),
                  child: Center(
                    child:Image.asset(
                      Strings.reg_back,
                      fit: BoxFit.fill,
                    )
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
          () => _loginController.isReferLoading == true
              ? Center(child: CupertinoActivityIndicator())
              : InkWell(
                  onTap: () {
                      if (_loginController
                          .verifyReferralController.text.isEmpty) {
                        ToastComponent.showDialog("Enter Referral Code", context,
                            gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
                        return;
                      } else if (_loginController
                              .verifyReferralController.text.length <
                          12) {
                        ToastComponent.showDialog(
                            "Enter 12 Digit Referral Code", context,
                            gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
                        return;
                      } else {
                        _loginController.apiVerifyReferral(context);
                      }
                  },
                  child: button("Verify")),
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
        //Center(child: textWidget("Need help?", AppColors.labelColor, 14))
      ],
    );
  }
}

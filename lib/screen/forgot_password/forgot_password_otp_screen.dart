import 'dart:async';

import 'package:edutech/navigation-Animator/navigation.dart';
import 'package:edutech/screen/forgot_password/enter_new_password_screen.dart';
import 'package:edutech/screen/forgot_password/forgot_password_controller.dart';
import 'package:edutech/utils/CustomAlertDialog.dart';
import 'package:edutech/utils/Functions.dart';
import 'package:edutech/utils/colors.dart';
import 'package:edutech/utils/strings.dart';
import 'package:edutech/utils/toast_component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:toast/toast.dart';

class ForgotPasswordOtpScreen extends StatefulWidget {
  String mobileNo;
  ForgotPasswordOtpScreen(this.mobileNo);
  @override
  _ForgotPasswordOtpScreenState createState() => _ForgotPasswordOtpScreenState();
}

class _ForgotPasswordOtpScreenState extends State<ForgotPasswordOtpScreen>with WidgetsBindingObserver {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  FocusNode pincodeFocus;
  bool autoFocus = true;
  TextEditingController pincodeController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  StreamController<ErrorAnimationType> errorController;
  final ForgotPasswordController _forgotPasswordController = Get.put(ForgotPasswordController());
  Timer _timer;
  int _start = 9;
  String otp="";

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    errorController.close();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    WidgetsBinding.instance.addObserver(this);
    // TODO: implement initState
    super.initState();
    startTimer();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: Palette.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: Get.height * 0.2,
                color: AppColors.primaryColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        new IconButton(
                          icon: new Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                    textWidget("Enter OTP", Colors.white, 18),

                    Padding(
                      padding: EdgeInsets.only(top:5.0),
                      child: Divider(
                        height: 2,
                        thickness: 3,
                        indent: 215,
                        endIndent: 155,
                        color: AppColors.colors,
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    textWidget("Enter OTP sends to " + widget.mobileNo,
                        Colors.white, 12),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      padding: EdgeInsets.only(left: 15),
                      width: Get.width * 0.7,
                      child: InkWell(
                        onTap: () {
                          FocusScope.of(context).requestFocus(pincodeFocus);
                        },
                        child: PinCodeTextField(
                          controller: otpController,
                          autoDisposeControllers: false,
                          focusNode: pincodeFocus,
                          length: 4,
                          backgroundColor: Palette.backgroundColor,
                          activeColor: AppColors.primaryColor,
                          obsecureText: false,
                          animationType: AnimationType.fade,
                          shape: PinCodeFieldShape.box,
                          selectedColor: Colors.grey,
                          animationDuration: Duration(milliseconds: 300),
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 50,
                          inactiveFillColor: Colors.white,
                          fieldWidth: 50,
                          textInputType: TextInputType.number,
                          inactiveColor: Colors.grey,
                          activeFillColor: Colors.white,
                          enableActiveFill: true,
                          autoFocus: autoFocus,
                          selectedFillColor: Colors.white,
                          autoDismissKeyboard: false,
                          errorAnimationController: errorController,
                          onChanged: (value) {
                            FocusScope.of(context).requestFocus(pincodeFocus);
                            if (value.length == 4) {
                              //autoValidateOTP();
                            }
                          },
                          onCompleted: (val){
                            otp = val;
                            _forgotPasswordController.otpController.text = val;
                          },
                        ),
                      )
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _start > 0
                      ? textWidget("0$_start", AppColors.labelColor, 14)
                      : Container(),
                  SizedBox(
                    width: 13,
                  ),
                  _start == 0
                      ? InkWell(
                      onTap: () {
                        _timer.cancel();
                        setState(() {
                          _start = 9;
                        });
                        startTimer();
                      },
                      child: textWidget(
                          "Resend OTP", AppColors.primaryColor, 14))
                      : Container(),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Obx(() =>_forgotPasswordController.isOtpLoading == true
                  ? Center(child: CupertinoActivityIndicator())
                  :
              InkWell(
                onTap: () {
                  if (otp.length < 4) {
                    ToastComponent.showDialog("Enter Valid OTP", context,
                        gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
                    return;
                  } else {
                     _forgotPasswordController.verifyOtpForgotPassword(context);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: button("Verify OTP"),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}

void showAlertDialog(BuildContext context) {
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

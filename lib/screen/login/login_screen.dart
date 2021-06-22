import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:edutech/navigation-Animator/navigation.dart';
import 'package:edutech/screen/forgot_password/forgot_password.dart';
import 'package:edutech/screen/login/login_getx_controller.dart';
import 'package:edutech/screen/registration/registration_screen.dart';
import 'package:edutech/utils/Functions.dart';
import 'package:edutech/utils/colors.dart';
import 'package:edutech/utils/strings.dart';
import 'package:edutech/utils/toast_component.dart';
import 'package:toast/toast.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController _loginController = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();
  bool _rememberMe = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: Get.height * 0.2),
                Image.asset(
                  Strings.app_icon,
                  fit: BoxFit.cover,
                  height: 60,
                ),
                textWidget("Welcome", Colors.black, 22),
                textWidget("Login to Continue.", Colors.black, 12),
                SizedBox(height: Get.height * 0.05),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        height: Get.height * 0.08 ,
                        child:Card(
                          elevation: 5,
                          child: Padding(
                            padding: EdgeInsets.only(top: 5.0),
                            child:TextFormField(
                              controller: _loginController.emailTextController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                labelText: 'Email',
                                labelStyle: TextStyle(
                                    fontFamily: Strings.montserrat, fontSize: 12),
                                filled: true,
                                hintText: 'Email',
                                hintStyle: TextStyle(
                                    fontFamily: Strings.montserrat, fontSize: 12),
                                contentPadding: EdgeInsets.all(15.0),
                                isDense: true,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              style: TextStyle(
                                  fontFamily: Strings.montserrat, fontSize: 15),
                            ),
                          )
                        ),
                      )
                    ),
                    SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                          height: Get.height * 0.08 ,
                        child:Card(
                          elevation: 5,
                          child: Padding(
                            padding: EdgeInsets.only(top: 5.0),
                            child:TextFormField(
                              controller: _loginController.passwordTextController,
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                labelStyle: TextStyle(
                                    fontFamily: Strings.montserrat, fontSize: 12),
                                fillColor: Colors.white,
                                filled: true,
                                contentPadding: EdgeInsets.all(15.0),
                                isDense: true,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                hintText: 'Password',
                                hintStyle: TextStyle(
                                    fontFamily: Strings.montserrat, fontSize: 12),
                              ),
                              validator: (value) =>
                              value.trim().isEmpty ? 'Password required' : null,
                              style: GoogleFonts.exo2(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          )
                        )
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildRememberMeCheckbox(),
                        _buildForgotPasswordBtn()
                      ],
                    ),
                    SizedBox(height: Get.height * 0.06),
                    Obx(() => _loginController.isLoading == true
                        ? Center(child: CupertinoActivityIndicator())
                        : InkWell(
                            onTap: () {
                              var email = _loginController
                                  .emailTextController.text
                                  .toString();
                              var password = _loginController
                                  .passwordTextController.text
                                  .toString();
                              if (email.isEmpty) {
                                ToastComponent.showDialog(
                                    "Enter email id", context,
                                    gravity: Toast.CENTER,
                                    duration: Toast.LENGTH_LONG);
                                return;
                              } else if (validateEmail(email) == false) {
                                ToastComponent.showDialog(
                                    "Enter valid email", context,
                                    gravity: Toast.CENTER,
                                    duration: Toast.LENGTH_LONG);
                                return;
                              } else if (password.isEmpty) {
                                ToastComponent.showDialog(
                                    "Please Enter password", context,
                                    gravity: Toast.CENTER,
                                    duration: Toast.LENGTH_LONG);
                                return;
                              } else {
                                _loginController.apiLogin(context);
                              }
                            },
                            child: button("Login"))),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    _buildSignUp(),
                    SizedBox(height: 16),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () {
          Navigator.push(context, FadeNavigation(widget: ForgotPassword()));
        },
        padding: EdgeInsets.only(right: 0.0),
        child: Text(
          'Forgot Password?',
          style: styleForLabel(12, AppColors.labelColor),
        ),
      ),
    );
  }

  Widget _buildRememberMeCheckbox() {
    return Container(
      height: Get.height * 0.02,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.black),
            child: Checkbox(
              value: _rememberMe,
              checkColor: AppColors.primaryColor,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value;
                });
              },
            ),
          ),
          Text(
            'Remember me',
            style: styleForLabel(12, AppColors.textColor),
          ),
        ],
      ),
    );
  }

  Widget _buildSignUp() {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, FadeNavigation(widget: RegisterScreen()));
        //Navigator.push(context, FadeNavigation(widget: AddPackage()));
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
                text: 'Don\'t have an Account? ',
                style: styleForLabel(12, AppColors.textColor)),
            TextSpan(
                text: 'Register Now.',
                style: styleForLabel(12, AppColors.primaryColor)),
          ],
        ),
      ),
    );
  }
}

import 'package:edutech/navigation-Animator/navigation.dart';
import 'package:edutech/screen/forgot_password/forgot_password_controller.dart';
import 'package:edutech/utils/Functions.dart';
import 'package:edutech/utils/colors.dart';
import 'package:edutech/utils/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EnterNewPasswordScreen extends StatefulWidget {
  @override
  _EnterNewPasswordScreenState createState() => _EnterNewPasswordScreenState();
}

class _EnterNewPasswordScreenState extends State<EnterNewPasswordScreen> {
  final ForgotPasswordController _forgotPasswordController = Get.put(ForgotPasswordController());
  TextEditingController forgotPasswordController= TextEditingController();
  TextEditingController confirmPasswordController= TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: textWidget("Change Password", Colors.white, 18),
        backgroundColor: AppColors.primaryColor,
      ),
      body: SafeArea(
        child:SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 16),
                  TextFormField(
                      controller: forgotPasswordController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        labelText: 'Password',
                        labelStyle:
                        TextStyle(fontFamily: Strings.montserrat, fontSize: 12),
                        filled: true,
                        hintText: 'Password',
                        hintStyle:
                        TextStyle(fontFamily: Strings.montserrat, fontSize: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                      ),
                      style:
                      TextStyle(fontFamily: Strings.montserrat, fontSize: 15),
                      validator: (value) {
                        String values = "";
                        if (value.trim().isEmpty) {
                          values = "Password Required";
                        }
                        return values;
                      }),
                  SizedBox(height: 16),
                  TextFormField(
                      controller: confirmPasswordController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        labelText: 'Confirm Password',
                        labelStyle:
                        TextStyle(fontFamily: Strings.montserrat, fontSize: 12),
                        filled: true,
                        hintText: 'Confirm Password',
                        hintStyle:
                        TextStyle(fontFamily: Strings.montserrat, fontSize: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                      ),
                      style:
                      TextStyle(fontFamily: Strings.montserrat, fontSize: 15),
                      validator: (value) {
                        String values = "";
                        if (value.trim().isEmpty) {
                          values = "Password Required";
                        }else if(forgotPasswordController.text!=confirmPasswordController.text){
                          values = "Please enter same password";
                        }
                        else{
                          _forgotPasswordController.confirmPasswordController.text=confirmPasswordController.text;
                          _forgotPasswordController.changePassword(context);
                        }
                        return values;
                      }),
                  SizedBox(height: Get.height * 0.06),
                  Obx(() => _forgotPasswordController.isChangePassLoading == true
                      ? Center(child: CupertinoActivityIndicator())
                      : InkWell(
                      onTap: () {
                        if (_formKey.currentState.validate()) {
                          _forgotPasswordController.confirmPasswordController.text=confirmPasswordController.text;
                          _forgotPasswordController.changePassword(context);
                        }
                      },
                      child: button("Change Password")),),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                ],
              ),
            )
          ),
        )
      ),
    );
  }
}

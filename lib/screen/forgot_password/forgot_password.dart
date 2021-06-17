import 'package:edutech/screen/login/login_getx_controller.dart';
import 'package:edutech/utils/Functions.dart';
import 'package:edutech/utils/colors.dart';
import 'package:edutech/utils/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final LoginController _loginController = Get.put(LoginController());

  Animation animation;
  Animation lateAnimation;
  AnimationController animationController;

  @override
  void initState() {
    // TODO: implement initState
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    animation = Tween(begin: -1.0, end: 0.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn),
    );

    lateAnimation = Tween(begin: -1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(0.2, 1.0, curve: Curves.fastOutSlowIn),
      ),
    );
    animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
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
                AnimatedBuilder(
                  animation: animation,
                  builder: (BuildContext context, Widget child) {
                    return Transform(
                      transform: Matrix4.translationValues(
                          animation.value * Get.width, 0.0, 0.0),
                      child: forgetPassword(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget forgetPassword() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            new IconButton(
              icon: new Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
        SizedBox(height: Get.height * 0.2),
        Image.asset(
          Strings.app_icon,
          fit: BoxFit.cover,
          height: 60,
        ),
        textWidget("Forgot Password", Colors.black, 22),
        textWidget(
            "Don’t worry ! You can reset your password", Colors.black, 12),
        SizedBox(height: Get.height * 0.05),
        textWidget(
            "Please, enter your email address. You will receive a link to create a new password via email.",
            Colors.black,
            12),
        SizedBox(height: Get.height * 0.05),
        Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                  controller: _loginController.forgotPasswordController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    labelText: 'Email',
                    labelStyle:
                        TextStyle(fontFamily: Strings.montserrat, fontSize: 12),
                    filled: true,
                    hintText: 'Email',
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
                    bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value);

                    String values = "";
                    if (value.trim().isEmpty) {
                      values = "Email Id Required";
                    } else if (!emailValid) {
                      values = "Enter Valid Email Id";
                    }

                    return values;
                  }),
              SizedBox(height: 16),
              SizedBox(height: Get.height * 0.06),
              _loginController.isLoading == true
                  ? Center(child: CupertinoActivityIndicator())
                  : InkWell(
                      onTap: () {
                        if (_formKey.currentState.validate()) {
                          // _loginController.apiLogin();
                        }
                      },
                      child: button("Send")),
              SizedBox(
                height: Get.height * 0.02,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

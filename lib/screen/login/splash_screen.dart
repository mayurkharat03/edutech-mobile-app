import 'package:flutter/material.dart';
import 'package:mlm/api/api_service.dart';
import 'package:mlm/navigation-Animator/navigation.dart';
import 'package:mlm/screen/dashboard_screen.dart';
import 'package:mlm/screen/login/login_screen.dart';
import 'package:mlm/utils/strings.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      int userId=ApiService.dataStorage.read("user_id");
      if(userId==null){
        Navigator.pushReplacement(context, FadeNavigation(widget: LoginScreen()));
      }else{
        Navigator.pushReplacement(context, FadeNavigation(widget: DashBoard()));
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Image.asset(Strings.app_icon,width: 100,height: 100,fit: BoxFit.contain,)
      ),
    );
  }
}
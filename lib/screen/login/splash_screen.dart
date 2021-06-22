import 'package:edutech/screen/common/bottom_navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:edutech/api/api_service.dart';
import 'package:edutech/navigation-Animator/navigation.dart';
import 'package:edutech/screen/common/dashboard_screen.dart';
import 'package:edutech/screen/login/login_screen.dart';
import 'package:edutech/utils/strings.dart';

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
      int userId = ApiService.dataStorage.read("user_id");
      if(userId == null){
        Navigator.pushReplacement(context, FadeNavigation(widget: LoginScreen()));
      }else{
        Navigator.pushReplacement(context, FadeNavigation(widget: BottomNavigationScreen()));
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
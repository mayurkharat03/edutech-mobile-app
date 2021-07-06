import 'package:edutech/screen/common/bottom_navigation_screen.dart';
import 'package:edutech/screen/splashscreen/getting_started_screen.dart';
import 'package:flutter/material.dart';
import 'package:edutech/api/api_service.dart';
import 'package:edutech/navigation-Animator/navigation.dart';
import 'package:edutech/screen/login/login_screen.dart';
import 'package:edutech/utils/strings.dart';
import 'package:flutter/scheduler.dart';
import 'package:get_storage/get_storage.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  final dataStorage = GetStorage();
  String appCheckValue="";

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 3), () {
      checkFirstSeen();
    });
    // Future.delayed(Duration(seconds: 3), () {
    //   int userId = ApiService.dataStorage.read("user_id");
    //   if(userId == null){
    //     Navigator.pushReplacement(context, FadeNavigation(widget: LoginScreen()));
    //   }else{
    //     Navigator.pushReplacement(context, FadeNavigation(widget: BottomNavigationScreen()));
    //   }
    // });
  }

   checkFirstSeen() {
       appCheckValue = ApiService.dataStorage.read("appAlreadyExists");
       if (appCheckValue == "yes") {
         int userId = dataStorage.read("user_id");
         if(userId == null){
           Navigator.pushReplacement(context, FadeNavigation(widget: LoginScreen()));
         }else{
           Navigator.pushReplacement(context, FadeNavigation(widget: BottomNavigationScreen()));
         }
       } else {
         ApiService.dataStorage.write("appAlreadyExists", "yes");
         Navigator.pushReplacement(context, FadeNavigation(widget: GettingStartedScreen()));
       }
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
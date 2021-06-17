import 'package:flutter/material.dart';
import 'package:edutech/api/api_service.dart';
import 'package:edutech/navigation-Animator/navigation.dart';
import 'package:edutech/screen/login/login_screen.dart';
import 'package:edutech/screen/package/add_package.dart';
import 'package:edutech/screen/package/add_package_controller.dart';
import 'package:edutech/utils/Functions.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            textWidget("Dashboard", Colors.black, 14),
            InkWell(
                onTap: () {
                  ApiService.dataStorage.remove("user_id");
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => AddPackage()),
                          (Route<dynamic> route) => false);
                },
                child: button("My Package")),
            SizedBox(height: 20.0,),
            InkWell(
                onTap: () {
                  ApiService.dataStorage.remove("user_id");
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                      (Route<dynamic> route) => false);
                },
                child: button("LogOut"))
          ],
        ),
      ),
    );
  }
}

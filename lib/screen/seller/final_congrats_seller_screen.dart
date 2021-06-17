import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:edutech/navigation-Animator/navigation.dart';
import 'package:edutech/utils/Functions.dart';
import 'package:edutech/utils/colors.dart';
import 'package:edutech/utils/strings.dart';
import '../common/bottom_navigation_screen.dart';

class FinalCongratsSellerScreen extends StatefulWidget{
  @override
  _FinalCongratsSellerScreenState createState() => _FinalCongratsSellerScreenState();
}

class _FinalCongratsSellerScreenState extends State<FinalCongratsSellerScreen>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => BottomNavigationScreen(),
            ),
          );
        },
        child: Stack(
          children: <Widget>[
            Positioned(
              top: Get.height * 0.32,
              left: 120.0,
              right: 120.0,
              child: Container(
                width: 100,
                height: 120,
                decoration: BoxDecoration(
                  // shape: BoxShape.circle,
                  image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/seller_congo.png'),
                  ),
                ),
              ),
            ),
            Positioned(
              top: Get.height * 0.31,
              left: 160.0,
              right: 100.0,
              child: Container(
                width: 100,
                height: 90,
                decoration: BoxDecoration(
                  // shape: BoxShape.circle,
                  image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/seller_congo1.png'),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(context,FadeNavigation(widget: BottomNavigationScreen()));
              },
            child:Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  // Stack(children: [
                  //   Container(
                  //     alignment: Alignment.center,
                  //     height: MediaQuery.of(context).size.height * 0.21,
                  //     width: MediaQuery.of(context).size.width * 0.4,
                  //     decoration: BoxDecoration(
                  //       image: DecorationImage(
                  //         image: AssetImage('assets/images/seller_congo.png'),
                  //         fit: BoxFit.contain,
                  //       ),
                  //     ),
                  //   ),
                  //   Padding(padding: const EdgeInsets.only(left: 45,top:30),
                  //   child:Image.asset('assets/images/seller_congo1.png'),),
                  // ],
                  // ),
                  SizedBox(height: Get.height * 0.15,),
                  textWidget("Congratulations!", Colors.white, 20,align: TextAlign.center,weight: FontWeight.bold,letterSpacing: 0.9),
                  SizedBox(height: Get.height * 0.03,),
                  textWidget(Strings.verified_profile_text1, Colors.white, 14,align: TextAlign.center),
                  SizedBox(height: 5,),
                  textWidget(Strings.verified_profile_text2, Colors.white, 14,align: TextAlign.center),
                ],
              ),
            ),
            ),
          ],
        ),
      ),
    );
  }

}
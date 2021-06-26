import 'package:edutech/api/api_service.dart';
import 'package:edutech/screen/common/bottom_navigation_screen.dart';
import 'package:edutech/screen/common/dashboard_controller.dart';
import 'package:edutech/screen/seller/add_bank_account_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:edutech/navigation-Animator/navigation.dart';
import 'package:edutech/screen/login/login_screen.dart';
import 'package:edutech/screen/seller/upload_photo_screen.dart';
import 'package:edutech/utils/Functions.dart';
import 'package:edutech/utils/colors.dart';
import 'package:get_storage/get_storage.dart';
import '../package/add_package.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  static final dataStorage = GetStorage();
  final DashboardController _dashboardController = Get.put(DashboardController());

  String user_first_name = "";
  String user_last_name = "";
  int isPhotoUploaded;

  @override
  void initState() {
    super.initState();
    _dashboardController.getDashboardData();

    isPhotoUploaded=ApiService.dataStorage.read("isProfileUploaded");
    user_first_name = dataStorage.read("first_name");
    user_last_name = dataStorage.read("last_name");
    if(user_first_name==null){
      user_first_name="";
    }
    if(user_last_name==null){
      user_last_name="";
    }
  }

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: roundedButton(
                    "No", const Color(0xFF167F67), const Color(0xFFFFFFFF)),
              ),
              new GestureDetector(
                onTap: () {
                  ApiService.dataStorage.remove("user_id");
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                      (Route<dynamic> route) => false);
                },
                child: roundedButton(
                    " Yes ", AppColors.primaryColor, Colors.white),
              ),
            ],
          ),
        ) ??
        false;
  }

  Widget roundedButton(String buttonLabel, Color bgColor, Color textColor) {
    var loginBtn = new Container(
      padding: EdgeInsets.all(5.0),
      alignment: FractionalOffset.center,
      decoration: new BoxDecoration(
        color: bgColor,
        borderRadius: new BorderRadius.all(const Radius.circular(10.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFF696969),
            offset: Offset(1.0, 6.0),
            blurRadius: 0.001,
          ),
        ],
      ),
      child: Text(
        buttonLabel,
        style: new TextStyle(
            color: textColor, fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
    );
    return loginBtn;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        backgroundColor: AppColors.formBackground,
        body: SafeArea(
            child:Stack(
              children: <Widget>[
                Positioned(
                  left: 0.0,
                  right: 0.0,
                  child: Card(
                    margin: EdgeInsets.zero,
                    elevation: 3.0,
                    color: AppColors.primaryColor,
                    child: Container(
                      width: double.infinity,
                      height: Get.height * 0.28,
                    ),
                  ),
                ),
                Positioned(
                  top: Get.height * 0.05,
                  left: 0.0,
                  right: 0.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                textWidget("Welcome, ", Colors.white, 20,
                                    weight: FontWeight.bold, letterSpacing: 1.0),
                                SizedBox(
                                  height: 6,
                                ),
                                textWidget(user_first_name+ " "+ user_last_name, Colors.white, 14,weight: FontWeight.w500),
                              ],
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(right: 35.0),
                            //   child: CircleAvatar(
                            //     radius: 44,
                            //     backgroundColor: Colors.white,
                            //     child: CircleAvatar(
                            //       radius: 42,
                            //       // backgroundImage: AssetImage('assets/images/profile.png'),
                            //       backgroundColor: AppColors.green,
                            //       child: Center(
                            //         child: textWidget("MLM", Colors.white, 12),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 11,
                      ),
                      becomeSellerButton(),
                      //  referralCodeDetails(),
                      SizedBox(
                        height: 7,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: Get.height * 0.05,
                  left: 250.0,
                  right: 35.0,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/images/profile.png'),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: Get.height * 0.26,
                  left: 0.0,
                  right: 0.0,
                  child: Card(
                    margin: EdgeInsets.zero,
                    elevation: 3.0,
                    color: AppColors.formBackground,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30.0),
                          topLeft: Radius.circular(30.0)),
                    ),
                    child: Container(
                      width: double.infinity,
                      height: Get.height,
                    ),
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: Get.height * 0.22,
                    ),
                    packageDetails(),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      height: Get.height * 0.40,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: walletDetails(),
                    ),
                  ],
                )
              ],
            )
        ),
      ),
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       textWidget("Dashboard", Colors.black, 14),
      //       InkWell(
      //           onTap: () {
      //             ApiService.dataStorage.remove("user_id");
      //             Navigator.of(context).pushAndRemoveUntil(
      //                 MaterialPageRoute(builder: (context) => LoginScreen()),
      //                 (Route<dynamic> route) => false);
      //           },
      //           child: button("LogOut"))
      //     ],
      //   ),
      // ),
    );
  }

  /* Become Seller Button*/
  Widget becomeSellerButton() {
    return Container(
      padding: EdgeInsets.only(left: 15),
      height: Get.height * 0.04,
      width: Get.width * 0.4,
      child: FloatingActionButton.extended(
        elevation: 4.0,
        backgroundColor: Colors.white,
        label: textWidget("Become A Seller", AppColors.primaryColor, 14,
            weight: FontWeight.bold),
        onPressed: () {

          if(isPhotoUploaded==0){
            Navigator.pushReplacement(
                context, FadeNavigation(widget: UploadPhotoScreen()));
          }
          else{
            Navigator.pushReplacement(
                context, FadeNavigation(widget: AddBankAccountScreen()));
          }

        },
      ),
    );
  }

  /*Referral Code Details*/
  Widget referralCodeDetails() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: textWidget("Referral Code", Colors.white, 14),
        ),
        SizedBox(
          height: 4,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Row(
            children: [
              textWidget("AA123FXXXX", Colors.white, 15,
                  weight: FontWeight.w600, letterSpacing: 0.15),
              Container(
                padding: EdgeInsets.only(left: 15),
                height: Get.height * 0.03,
                width: Get.width * 0.3,
                child: FloatingActionButton.extended(
                  elevation: 4.0,
                  backgroundColor: Colors.white,
                  label: textWidget("Share", AppColors.primaryColor, 14,
                      weight: FontWeight.bold),
                  icon: const Icon(
                    Icons.share_outlined,
                    size: 15,
                    color: const Color(0xff7658F9),
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /*Package Details GridView*/
  Widget packageDetails() {
    return Container(
      width: double.infinity,
      height: Get.height * 0.4,
      padding: const EdgeInsets.all(10.0),
      child: GridView.count(
        crossAxisCount: 3,
        crossAxisSpacing: 4,
        mainAxisSpacing: 8,
        children: [
          Container(
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 8,
              child: InkWell(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    textWidget("13", Colors.black, 18, weight: FontWeight.bold),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.015,
                    ),
                    textWidget("Active ", AppColors.buttonTextColor, 14),
                    textWidget("Package", AppColors.buttonTextColor, 14),
                  ],
                ),
                onTap: () {},
              ),
            ),
          ),
          Container(
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 8,
              child: InkWell(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    textWidget("00", Colors.black, 18, weight: FontWeight.bold),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.015,
                    ),
                    textWidget("Inactive", AppColors.buttonTextColor, 14),
                    textWidget("Package", AppColors.buttonTextColor, 14)
                  ],
                ),
                onTap: () {},
              ),
            ),
          ),
          Container(
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 8,
              child: InkWell(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    textWidget("Add ", AppColors.primaryColor, 16),
                    textWidget("Package", AppColors.primaryColor, 16),
                  ],
                ),
                onTap: () {
                  Navigator.pushReplacement(
                      context, FadeNavigation(widget: AddPackage()));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  /* Wallet Details*/
  Widget walletDetails() {
    return Container(
      child: Card(
        color: AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 4,
        child: InkWell(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        textWidget("Total Referrals : ", Colors.white, 13),
                        textWidget("1000", Colors.white, 14, weight: FontWeight.w600),
                      ],
                    ),
                    textWidget("30 April 2020", Colors.white, 13),
                  ],
                ),
              ),
              SizedBox(height: 30.0,),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(children: [
                      textWidget("MY WALLET",Colors.white, 13,),
                      SizedBox(height: 3,),
                      textWidget("Rs. 13,201.20", Colors.white, 14, weight: FontWeight.w600),
                    ],),
                    Column(children: [
                      textWidget("TOTAL EARNINGS",Colors.white, 13,),
                      SizedBox(height: 3,),
                      textWidget("Rs. 1023.74", Colors.white, 14, weight: FontWeight.w600),
                    ],),
                  ],
                ),
              ),
            ],
          ),
          onTap: () {},
        ),
      ),
    );
  }

  /*Profile Image*/
  Positioned profileImage(String images) {
    return Positioned(
      right: 35.0,
      child: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: new DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage('assets/images/profile.png'),
          ),
        ),
      ),
    );
  }
}

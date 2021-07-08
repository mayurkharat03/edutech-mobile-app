import 'package:edutech/api/api_service.dart';
import 'package:edutech/screen/common/dashboard_controller.dart';
import 'package:edutech/screen/seller/add_bank_account_screen.dart';
import 'package:edutech/utils/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:edutech/navigation-Animator/navigation.dart';
import 'package:edutech/screen/login/login_screen.dart';
import 'package:edutech/screen/seller/upload_photo_screen.dart';
import 'package:edutech/utils/Functions.dart';
import 'package:edutech/utils/colors.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
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
  int isPanUploaded;
  var walletAmount;
  var code;
  String total_earning="";
  int referral_count;
  bool isLoading=false;
  int kyc_completed;

  @override
  void initState() {
    super.initState();
    _dashboardController.getDashboardData();
    _dashboardController.getWalletData();
    isPhotoUploaded = dataStorage.read("isProfileUploaded");
    isPanUploaded = dataStorage.read("isPanUploaded");
    code = dataStorage.read("codeInWallet");
    user_first_name = dataStorage.read("first_name");
    user_last_name = dataStorage.read("last_name");
    user_last_name = dataStorage.read("last_name");
    total_earning = dataStorage.read("total_earning");
    walletAmount = dataStorage.read("wallet_amount");
    referral_count = dataStorage.read("immediateReferralCount");
    kyc_completed = dataStorage.read("kyc_completed");
    var user_id = dataStorage.read("user_id");
    print("Id");print(user_id);
    if(user_first_name==null){
      user_first_name="";
    }
    if(user_last_name==null){
      user_last_name="";
    }
  }

  Future<bool> _onBackPressed() {
    return confirmationPopup(context)
        ??
        false;
  }

  confirmationPopup(BuildContext dialogContext) {
    var alertStyle = AlertStyle(
      animationType: AnimationType.grow,
      overlayColor: Colors.black87,
      isCloseButton: true,
      isOverlayTapDismiss: true,
      titleStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,fontFamily: Strings.montserrat),
      descStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 16,fontFamily: Strings.montserrat),
      animationDuration: Duration(milliseconds: 400),
    );

    Alert(
        context: dialogContext,
        style: alertStyle,
        title: "Are you sure?",
        desc: "Do you want to exit an App",
        buttons: [
          DialogButton(
            child: Text(
              "No",
              style: TextStyle(color: Colors.white, fontSize: 18,fontFamily:Strings.montserrat ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            color: AppColors.primaryColor,
          ),
          DialogButton(
            child: Text(
              "Yes",
              style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: Strings.montserrat),
            ),
            onPressed: () {
              dataStorage.remove("user_id");
              Navigator.pop(context);
            },
            color: AppColors.primaryColor,
          )
        ]).show();
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
                      height: Get.height * 0.33,
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
                                SizedBox(height: 6,),
                                textWidget(user_first_name+ " "+ user_last_name, Colors.white, 14,weight: FontWeight.w500),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 11,
                      ),
                      kyc_completed == 0
                      ? becomeSellerButton()
                      : Opacity(opacity: 0.0),
                      SizedBox(
                        height: 7,
                      ),
                      referralCodeDetails(),
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
                  child: Stack(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 60.0,
                        child: CircleAvatar(
                          radius: 57.0,
                          backgroundColor: AppColors.primaryColor,
                          child:
                          Container(
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
                      ),
                      Transform(
                        transform: Matrix4.translationValues(45.0, 105.0, 0.0),
                        child:Container(
                            height: 25.0,width: 25.0,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25.0)
                            ),
                            child: Image(image: AssetImage("assets/images/correctSign.png"),
                              color: Colors.green,fit: BoxFit.fill,)
                        )
                      )
                    ],
                  )
                ),
                Positioned(
                  top: Get.height * 0.30,
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
                      height: Get.height * 0.25,
                    ),
                    packageDetails(),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      height: Get.height * 0.43,
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
        heroTag: 'unique_key',
        elevation: 4.0,
        backgroundColor: Colors.white,
        label: textWidget("Become A Seller", AppColors.primaryColor, 14,
            weight: FontWeight.bold),
        onPressed: () {
          if(isPhotoUploaded==1 || isPanUploaded==1){
            Navigator.pushReplacement(context, FadeNavigation(widget: AddBankAccountScreen()));
          }
          else{
            Navigator.pushReplacement(context, FadeNavigation(widget: UploadPhotoScreen()));
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
          padding: const EdgeInsets.only(left: 20.0,top: 15.0),
          child: textWidget("Referral Code", Colors.white, 14),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Row(
            children: [
              textWidget("${code}", Colors.white, 15,
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
                  onPressed: () {
                      share();
                  },
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
                        textWidget("${referral_count}", Colors.white, 14, weight: FontWeight.w600),
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
                      textWidget("Rs."+ "${walletAmount}", Colors.white, 14, weight: FontWeight.w600),
                    ],),
                    Column(children: [
                      textWidget("TOTAL EARNINGS",Colors.white, 13,),
                      SizedBox(height: 3,),
                      textWidget(total_earning, Colors.white, 14, weight: FontWeight.w600),
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

  /// Share reference code
  Future<void> share() async {
    await FlutterShare.share(
      title: 'Reference Code',
      text: 'You can use this referral code '+ code,
    );
  }
}

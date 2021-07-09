import 'package:edutech/screen/common/bottom_navigation_screen.dart';
import 'package:edutech/screen/login/login_getx_controller.dart';
import 'package:edutech/screen/wallet/wallet_controller.dart';
import 'package:edutech/utils/Functions.dart';
import 'package:edutech/utils/colors.dart';
import 'package:edutech/utils/strings.dart';
import 'package:edutech/utils/toast_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:toast/toast.dart';

class WalletScreen extends StatefulWidget {
  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  static final dataStorage = GetStorage();
  final WalletController _walletController = Get.put(WalletController());
  var walletAmount;
  bool showError = false;

  @override
  void initState() {
    super.initState();
    _walletController.getWalletHistory();
    walletAmount = dataStorage.read("wallet_amount");
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) =>
                                    BottomNavigationScreen()),
                                (Route<dynamic> route) => false);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    Transform(
                        transform:
                        Matrix4.translationValues(-5.0, 0.0, 0.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        BottomNavigationScreen()),
                                    (Route<dynamic> route) => false);
                          },
                          child: textWidget("Wallet", Colors.white, 20,
                              weight: FontWeight.bold),
                        )),
                  ],
                ),
              ),
            ],
          ),
          bottom: TabBar(
            tabs: [
              Tab(
                text: 'Wallet',
              ),
              Tab(
                text: 'History',
              ),
            ],
            labelColor: Colors.white,
            isScrollable: true,
            labelPadding: EdgeInsets.only( left:50.0,right:50.0),
            labelStyle: TextStyle(fontSize: 16.0),
            indicatorColor: Colors.white,
          ),
        ),
        body: TabBarView(
            children: [
              SingleChildScrollView(
                child: Container(
                    child:Padding(
                        padding: EdgeInsets.only(left:10.0,right:10.0),
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: Get.height * 0.05,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                textWidget("Wallet Amount: ", Colors.black, 16,
                                    weight: FontWeight.normal),
                                Spacer(),
                                textWidget(Strings.currency+"${walletAmount}", Colors.black, 14,
                                    weight: FontWeight.bold),
                              ],
                            ),
                            SizedBox(
                              height: Get.height * 0.05,
                            ),
                            textWidget("Withdraw:", Colors.black, 16, weight: FontWeight.normal),
                            SizedBox(
                              height: Get.height * 0.03,
                            ),
                            Container(
                                height: Get.height * 0.08,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(top: 5.0),
                                  child:TextFormField(
                                    controller: _walletController.walletAmountController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      labelStyle: TextStyle(
                                          fontFamily: Strings.montserrat, fontSize: 12),
                                      labelText: 'Add Withdrawal Amount '+Strings.currency,
                                      contentPadding: EdgeInsets.all(15.0),
                                      isDense: true,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),
                                )
                            ),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            showError == false
                                ? textWidget("Your wallet should contain minimum amount of " +Strings.currency+"2,000.", Colors.black, 12,
                                weight: FontWeight.normal)
                                : textWidget("Not a valid Amount ", Colors.red, 12,
                                weight: FontWeight.normal),
                            SizedBox(height: Get.height * 0.35,),
                            GestureDetector(
                                onTap: (){
                                  checkValidation(context);
                                },
                                child:button("Withdraw Money")
                            )
                          ],
                        )
                    )
                ),
              ),
              SingleChildScrollView(
                child: Container(
                    child:Padding(
                        padding: EdgeInsets.only(left:10.0,right:10.0),
                        child:
                        _walletController.getWalletDetails.isEmpty
                        ? Center(
                          child:Padding(
                            padding: EdgeInsets.only(top: 20.0),
                            child:textWidget("No data found",Colors.black,14.0,weight: FontWeight.bold)
                          )
                        )
                        :
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: _walletController.getWalletDetails.length,
                            itemBuilder: (context,index){
                          return Padding(
                            padding: EdgeInsets.all(3.0),
                            child:Card(
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child:Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                   Align(
                                     alignment:Alignment.topRight,
                                     child: textWidget("Date: "+_walletController.getWalletDetails[index].date,Colors.red,12.0,),
                                   ),
                                    textWidget("Name: "+ _walletController.getWalletDetails[index].name,
                                        Colors.black,14.0),
                                    textWidget("Amount: "+_walletController.getWalletDetails[index].amount,Colors.black,14.0,
                                    ),
                                  ],
                                ),
                              )
                            )
                          );
                        })
                    )
                ),
              )
            ],
        )
      ),
    );
  }

  /// Check validation
  checkValidation(BuildContext context){
    setState(() {
      if(walletAmount == "0"){
        showError = true;
      }
      else if(_walletController.walletAmountController.text=="0"){
        showError = true;
      }
      else if(_walletController.walletAmountController.text == walletAmount)
      {
        showError = true;
      }
      else{
        _walletController.withdrawMoney(context);
      }
    });
  }
}

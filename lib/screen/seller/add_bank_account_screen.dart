import 'package:edutech/navigation-Animator/navigation.dart';
import 'package:edutech/screen/common/term_and_conditions_screen.dart';
import 'package:edutech/screen/seller/add_bank_details_controller.dart';
import 'package:edutech/utils/Functions.dart';
import 'package:edutech/utils/strings.dart';
import 'package:edutech/utils/toast_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:edutech/screen/seller/upload_photo_screen.dart';
import 'package:edutech/utils/colors.dart';
import 'package:toast/toast.dart';

class AddBankAccountScreen extends StatefulWidget {
  @override
  _AddBankAccountScreenState createState() => _AddBankAccountScreenState();
}

class _AddBankAccountScreenState extends State<AddBankAccountScreen> {
  final AddBankDetailsController _addBankDetailsController = Get.put(AddBankDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.formBackground,
      body: SafeArea(
        child: Stack(
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
              top: Get.height * 0.04,
              left: 0.0,
              right: 0.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => UploadPhotoScreen()),
                                (Route<dynamic> route) => false);
                          },
                          icon: Icon(
                            Icons.arrow_back,
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
                                            UploadPhotoScreen()),
                                    (Route<dynamic> route) => false);
                              },
                              child: textWidget("Step 2", Colors.white, 16,
                                  weight: FontWeight.bold),
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                    ),
                    child: Text(
                      "Add bank account",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0),
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: textWidget(
                        "Adding your bank details help you to get your earnings",
                        Colors.white,
                        13),
                  ),
                ],
              ),
            ),
            Positioned(
              top: Get.height * 0.25,
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
                bankDetails(),
              ],
            ),
            Align(alignment: Alignment.bottomCenter, child: buttonForBottom()),
          ],
        ),
      ),
    );
  }

  Widget buttonForBottom() {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(11.0),
          child: InkWell(
              onTap: () {
               String bankName = _addBankDetailsController.bankNameController.text;
               String accountNo = _addBankDetailsController.accountNumberController.text;
               String ifscCode = _addBankDetailsController.ifscCodeController.text;
               String accountHolderName = _addBankDetailsController.accountNameController.text;

               if (accountNo.isEmpty) {
                 ToastComponent.showDialog("Please Enter account number", context,
                     gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
               } else if (ifscCode.isEmpty) {
                 ToastComponent.showDialog("Please Enter IFSC Code", context,
                     gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
               } else if (accountHolderName.isEmpty) {
                 ToastComponent.showDialog("Please Enter account holder's name ", context,
                     gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
               }else if (bankName.isEmpty) {
                 ToastComponent.showDialog("Please Enter bank name ", context,
                     gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
               }
               else{
                 Navigator.pushReplacement(context, FadeNavigation(widget: TermsAndConditionsScreen()));
               }
              },
              child: buttonSell("Next", Colors.white, AppColors.primaryColor)),
        ),
      ],
    );
  }

/*Bank Account details*/
  Widget bankDetails() {
    TextStyle style = TextStyle(fontFamily: Strings.montserrat, fontSize: 13);
    return Expanded(
        child: KeyboardAvoider(
           autoScroll: true,
         child: Form(
          child: Column(
             mainAxisSize: MainAxisSize.min,
           children: <Widget>[
             Padding(
               padding: const EdgeInsets.all(5.0),
               child: Card(
                 elevation: 5,
                 child: Padding(
                   padding: const EdgeInsets.only(top: 5),
                   child: TextFormField(
                     controller: _addBankDetailsController.bankNameController,
                     decoration: InputDecoration(
                       labelStyle: style,
                       labelText: 'Bank Name',
                       contentPadding: EdgeInsets.all(15.0),
                       isDense: true,
                       border: OutlineInputBorder(
                         borderSide: BorderSide.none,
                       ),
                     ),
                   ),
                 ),
               ),
             ),
           Padding(
            padding: const EdgeInsets.all(5.0),
            child: Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: TextFormField(
                  controller: _addBankDetailsController.accountNumberController,
                  decoration: InputDecoration(
                    labelStyle: style,
                    labelText: 'Bank Account Number',
                    contentPadding: EdgeInsets.all(15.0),
                    isDense: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: TextFormField(
                  controller: _addBankDetailsController.ifscCodeController,
                  decoration: InputDecoration(
                    labelStyle: style,
                    labelText: 'IFSC Code',
                    contentPadding: EdgeInsets.all(15.0),
                    isDense: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: TextFormField(
                  controller: _addBankDetailsController.accountNameController,
                  decoration: InputDecoration(
                    labelStyle: style,
                    labelText: 'Account Holder Name',
                    contentPadding: EdgeInsets.all(15.0),
                    isDense: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(11.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child:
                    textWidget("OR", Colors.black, 14, weight: FontWeight.bold),
              )),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: TextFormField(
                  controller: _addBankDetailsController.upiIdController,
                  decoration: InputDecoration(
                    labelStyle: style,
                    labelText: 'UPI ID',
                    contentPadding: EdgeInsets.all(15.0),
                    isDense: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      )),
    ));
  }
}

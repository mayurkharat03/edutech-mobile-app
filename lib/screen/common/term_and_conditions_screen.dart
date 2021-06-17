import 'package:edutech/screen/seller/add_bank_account_screen.dart';
import 'package:edutech/screen/seller/add_bank_details_controller.dart';
import 'package:edutech/utils/toast_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:edutech/utils/Functions.dart';
import 'package:edutech/utils/colors.dart';
import 'package:edutech/utils/strings.dart';
import 'package:toast/toast.dart';

class TermsAndConditionsScreen extends StatefulWidget {
  @override
  _TermsAndConditionsScreenState createState() =>
      _TermsAndConditionsScreenState();
}

class _TermsAndConditionsScreenState extends State<TermsAndConditionsScreen> {
  bool _termsAndConditions = false;
  final AddBankDetailsController _callToAddBankDetails = Get.put(AddBankDetailsController());
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
              top: Get.height * 0.05,
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
                                    builder: (context) =>
                                        AddBankAccountScreen()),
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
                                            AddBankAccountScreen()),
                                    (Route<dynamic> route) => false);
                              },
                              child: textWidget("Step 3", Colors.white, 16,
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
                      "Terms \& Conditions",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0),
                    ),
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
                  height: Get.height * 0.21,
                ),
                termsAndConditionsDetails(),
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
                if(_termsAndConditions)
                {
                  _callToAddBankDetails.addSellerBankDetails(context);
                }
                else{
                  ToastComponent.showDialog("Please accept Terms and Conditions", context,
                      gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
                }
                // Navigator.pushReplacement(context,
                //     FadeNavigation(widget: FinalCongratsSellerScreen()));
              },
              child: buttonSell(
                  "Become Seller", Colors.white, AppColors.primaryColor)),
        ),
      ],
    );
  }

  Widget _buildTermsAndConditionsCheckbox() {
    return Container(
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: AppColors.primaryColor),
            child: Checkbox(
              value: _termsAndConditions,
              checkColor: AppColors.primaryColor,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  _termsAndConditions = value;
                });
              },
            ),
          ),
          Text(
            'I accept all terms and conditions.',
            style: styleForLabel(15, AppColors.textColor),
          ),
        ],
      ),
    );
  }

/*Bank Account details*/
  Widget termsAndConditionsDetails() {
    return Expanded(
      child: KeyboardAvoider(
        autoScroll: true,
        child: Form(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 5.0, bottom: 10.0),
                    child: Column(
                      children: [
                        textWidget(Strings.terms_conditions_seller, AppColors.buttonTextColor, 14,),
                        SizedBox(height: 2,),
                        textWidget(Strings.terms_conditions_seller, AppColors.buttonTextColor, 14,),
                        SizedBox(height: 2,),
                        textWidget(Strings.terms_conditions_seller, AppColors.buttonTextColor, 14,),
                        SizedBox(height: 2,),
                        textWidget(Strings.terms_conditions_seller, AppColors.buttonTextColor, 14,),
                        SizedBox(height: 2,),
                        textWidget(Strings.terms_conditions_seller, AppColors.buttonTextColor, 14,),
                        SizedBox(height: 2,),
                        textWidget(Strings.terms_conditions_seller, AppColors.buttonTextColor, 14,),
                        SizedBox(height: 2,),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                ),
                child: _buildTermsAndConditionsCheckbox(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:io';
import 'package:edutech/screen/package/add_package.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:menu_button/menu_button.dart';
import 'package:edutech/api/api_service.dart';
import 'package:edutech/screen/registration/registration_controller.dart';
import 'package:edutech/utils/Functions.dart';
import 'package:edutech/utils/colors.dart';
import 'package:edutech/utils/strings.dart';
import 'package:edutech/utils/toast_component.dart';
import 'package:progress_indicator/progress_indicator.dart';
import 'package:toast/toast.dart';
import 'package:image_cropper/image_cropper.dart';

class UserStepperScreen extends StatefulWidget {
  @override
  _UserStepperScreenState createState() => _UserStepperScreenState();
}
enum AppState {
  free,
  picked,
  cropped,
}
class _UserStepperScreenState extends State<UserStepperScreen> {
  AppState state;
  int stepperCount = 1;
  double percentage = 20;
  bool billingAddressCheck = false;
  String _selectedDate = "";
  final RegistrationController _registrationController =
      Get.put(RegistrationController());

  /*login fields*/
  bool showPassword = true;
  bool showConfirmPassword = true;

/*Image Picker*/
  final ImagePicker picker = ImagePicker();
  var selectedImage;
  var picture, adharFront, adharBack;
  PickedFile _imageFile;
  PickedFile _imageFileAdharFront;
  PickedFile _imageFileAdharBack;
  File sendToApiFront;
  /*for first stepper*/
  String selectedKey = "Gender";
  List<String> keys = <String>[
    'Male',
    'Female',
  ];

  String selectedSalutation = "Mr.";
  List<String> salutation = <String>["Ms.", "Mrs.", "Miss"];
  String shippingAddress = "";
  String shippingAddressForServer = "";
  String billingAddress = "";
  String mobileNumber = "";

  File tryFrontImage;
  final _picker = ImagePicker();

  @override
  void initState() {
    // TODO: implement initState
    mobileNumber = ApiService.dataStorage.read("mobile");
    state = AppState.free;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      SafeArea(
        child:
        Stack(children: <Widget>[
          Positioned(
            left: 0.0,
            right: 0.0,
            child: Card(
              margin: EdgeInsets.zero,
              elevation: 3.0,
              color: AppColors.primaryColor,
              child: Container(
                width: double.infinity,
                height: Get.height * 0.7,
              ),
            ),
          ),
          Positioned(
            top: Get.height * 0.1,
            left: 0.0,
            right: 0.0,
            child: Column(
              children: [
                textWidget("Registration", Colors.white, 19,
                    weight: FontWeight.bold),
                SizedBox(
                  height: 7,
                ),
                textWidget("Step $stepperCount/5", Colors.white, 15),
                SizedBox(
                  height: 7,
                ),
                Container(
                  height: Get.height * 0.7,
                  width: Get.width * 0.8,
                  child: BarProgress(
                    color:
                        stepperCount == 1 ? Colors.grey[300] : AppColors.green,
                    backColor: Colors.white,
                    showPercentage: false,
                    percentage: percentage,
                    stroke: 8,
                    round: true,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: Get.height * 0.3,
            left: 0.0,
            right: 0.0,
            child: Card(
              margin: EdgeInsets.zero,
              elevation: 3.0,
              color: Colors.white,
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
              getIndexWidget(),
              fixedBottomSection(context)
            ],
          )
        ]),
      ),
    );
  }

  Widget getIndexWidget() {
    Expanded expanded;
    if (stepperCount == 1) {
      expanded = personalDetails();
    } else if (stepperCount == 2) {
      expanded = getShippingAddress();
    } else if (stepperCount == 3) {
      expanded = getLoginDetails();
    } else if (stepperCount == 4) {
      expanded = getKycDetails();
    } else if (stepperCount == 5) {
      expanded = getTermAndCondition();
    }
    return expanded;
  }

  Widget fixedBottomSection(BuildContext context) {
    Padding padding;
    if (stepperCount == 1) {
      padding = buttonForBottom(context);
    } else if (stepperCount == 2) {
      padding = bottomButton(context);
    } else if (stepperCount == 3) {
      padding = bottomButton(context);
    } else if (stepperCount == 4) {
      padding = bottomButton(context);
    } else if (stepperCount == 5) {
      padding = bottomButtonLast(context);
    }
    return padding;
  }

  /*Widget for button*/
  Widget buttonForBottom(BuildContext context) {
    return
      Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
          onTap: () {
            String firstName = _registrationController.firstNameController.text;
            String middleName = _registrationController.middleNameController.text;
            String lastName = _registrationController.lastNameController.text;
            if (firstName.isEmpty) {
              ToastComponent.showDialog("Please Enter FirstName", context,
                  gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
            } else if (middleName.isEmpty) {
              ToastComponent.showDialog("Please Enter MiddleName", context,
                  gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
            } else if (lastName.isEmpty) {
              ToastComponent.showDialog("Please Enter LastName", context,
                  gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
            } else if (_selectedDate.isEmpty) {
              ToastComponent.showDialog("Please Enter Date Of Birth", context,
                  gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
            } else if (selectedKey == "Gender") {
              ToastComponent.showDialog("Please Select Gender", context,
                  gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
            }
            else {
               setState(() {
                 stepperCount++;
                 percentage = percentage + 20;
               });
             }
          },
          child:
          button("Next")
      ),
    );
  }

  Widget bottomButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: ListTile(
        title: Row(
          children: <Widget>[
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: ElevatedButton(
                      child: Text(
                        "Back",
                        style: styleForLabel(12, Colors.black),
                      ),
                      onPressed: () {
                        setState(() {
                          stepperCount--;
                          percentage = percentage - 20;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        side: BorderSide(
                          color: Colors.black,
                        ),
                        onPrimary: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                      ),
                    ))),
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child:
                    ElevatedButton(
                      child: Text(
                        "Next",
                        style: styleForLabel(12, Colors.white),
                      ),
                      onPressed: () {
                        if (stepperCount == 2) {
                          String addressLine1 = _registrationController
                              .addressLineFirstController.text;
                          String addressLine2 = _registrationController
                              .addressLineSecondController.text;
                          String pinCode =
                              _registrationController.pinCodeController.text;
                          String city =
                              _registrationController.cityController.text;
                          String district =
                              _registrationController.districtController.text;
                          String state =
                              _registrationController.stateController.text;

                          shippingAddressForServer = addressLine1 +
                              " " +
                              addressLine2 +
                              " " +
                              pinCode +
                              " " +
                              city +
                              " " +
                              district +
                              " " +
                              state;
                          if (addressLine1.isEmpty) {
                            ToastComponent.showDialog(
                                "Please Enter Address Line 1", context,
                                gravity: Toast.CENTER,
                                duration: Toast.LENGTH_LONG);
                          } else if (pinCode.isEmpty || pinCode.length < 6) {
                            ToastComponent.showDialog(
                                "Please Enter valid Pin Code", context,
                                gravity: Toast.CENTER,
                                duration: Toast.LENGTH_LONG);
                          } else if (city.isEmpty) {
                            ToastComponent.showDialog(
                                "Please Enter City", context,
                                gravity: Toast.CENTER,
                                duration: Toast.LENGTH_LONG);
                          } else if (district.isEmpty) {
                            ToastComponent.showDialog(
                                "Please Enter District", context,
                                gravity: Toast.CENTER,
                                duration: Toast.LENGTH_LONG);
                          } else if (state.isEmpty) {
                            ToastComponent.showDialog(
                                "Please Enter State", context,
                                gravity: Toast.CENTER,
                                duration: Toast.LENGTH_LONG);
                          } else if (billingAddressCheck == false) {
                            String addressLine1 = _registrationController
                                .billingAddressLineFirstController.text;
                            String addressLine2 = _registrationController
                                .billingAddressLineSecondController.text;
                            String pinCode = _registrationController
                                .billingPinCodeController.text;
                            String city = _registrationController
                                .billingCityController.text;
                            String district = _registrationController
                                .billingDistrictController.text;
                            String state = _registrationController
                                .billingStateController.text;

                            if (addressLine1.isEmpty) {
                              ToastComponent.showDialog(
                                  "Please Enter Billing Address Line 1",
                                  context,
                                  gravity: Toast.CENTER,
                                  duration: Toast.LENGTH_LONG);
                            } else if (pinCode.isEmpty || pinCode.length < 6) {
                              ToastComponent.showDialog(
                                  "Please Enter Billing Pin Code", context,
                                  gravity: Toast.CENTER,
                                  duration: Toast.LENGTH_LONG);
                            } else if (city.isEmpty) {
                              ToastComponent.showDialog(
                                  "Please Enter Billing City", context,
                                  gravity: Toast.CENTER,
                                  duration: Toast.LENGTH_LONG);
                            } else if (district.isEmpty) {
                              ToastComponent.showDialog(
                                  "Please Enter Billing District", context,
                                  gravity: Toast.CENTER,
                                  duration: Toast.LENGTH_LONG);
                            } else if (state.isEmpty) {
                              ToastComponent.showDialog(
                                  "Please Enter Billing State", context,
                                  gravity: Toast.CENTER,
                                  duration: Toast.LENGTH_LONG);
                            } else {
                              String billingAddressfromServer = addressLine1 +
                                  " " +
                                  addressLine2 +
                                  " " +
                                  pinCode +
                                  " " +
                                  city +
                                  " " +
                                  district +
                                  " " +
                                  state;

                              setState(() {
                                billingAddress = billingAddressfromServer;
                                shippingAddress = shippingAddressForServer;
                                stepperCount++;
                                percentage = percentage + 20;
                              });
                            }
                          } else {
                            setState(() {
                              billingAddress = shippingAddressForServer;
                              shippingAddress = shippingAddressForServer;
                              stepperCount++;
                              percentage = percentage + 20;
                            });
                          }
                        } else if (stepperCount == 3) {
                          String emailId =
                              _registrationController.emailIdController.text;
                          String password = _registrationController
                              .setPasswordController.text;
                          String confirmPassword = _registrationController
                              .confirmPasswordController.text;
                          if (emailId.isEmpty) {
                            ToastComponent.showDialog(
                                "Please Enter Email Id", context,
                                gravity: Toast.CENTER,
                                duration: Toast.LENGTH_LONG);
                          } else if (validateEmail(emailId) == false) {
                            ToastComponent.showDialog(
                                "Please Enter Valid Email Id", context,
                                gravity: Toast.CENTER,
                                duration: Toast.LENGTH_LONG);
                          } else if (password.isEmpty) {
                            ToastComponent.showDialog(
                                "Enter Enter Password", context,
                                gravity: Toast.CENTER,
                                duration: Toast.LENGTH_LONG);
                          } else if (confirmPassword.isEmpty) {
                            ToastComponent.showDialog(
                                "Enter Confirm Password", context,
                                gravity: Toast.CENTER,
                                duration: Toast.LENGTH_LONG);
                          } else if (password != confirmPassword) {
                            ToastComponent.showDialog(
                                "Confirm password not matched", context,
                                gravity: Toast.CENTER,
                                duration: Toast.LENGTH_LONG);
                          } else {
                            setState(() {
                              // _registrationController.addUserDetails(
                              //     context, selectedSalutation, mobileNumber,
                              //     billingAddress, shippingAddress, _selectedDate);

                              _registrationController.checkUserEmail(context);
                              //_registrationController.goToNextScreen(stepperCount,percentage);
                            });
                          }
                        } else if (stepperCount == 4) {
                          if (_registrationController
                              .aadharCardController.text.isEmpty) {
                            ToastComponent.showDialog(
                                "Please enter Aadhar card number", context,
                                gravity: Toast.CENTER,
                                duration: Toast.LENGTH_LONG);
                          } else if (validAdhar(_registrationController
                                  .aadharCardController.text) ==
                              false) {
                            ToastComponent.showDialog(
                                "Please enter Valid Aadhar card number",
                                context,
                                gravity: Toast.CENTER,
                                duration: Toast.LENGTH_LONG);
                          }else if(_imageFileAdharFront==null){
                            ToastComponent.showDialog(
                                "Please Upload adhar image",
                                context,
                                gravity: Toast.CENTER,
                                duration: Toast.LENGTH_LONG);
                          }
                          else{
                            setState(() {
                              stepperCount++;
                              percentage = percentage + 20;
                              // _registrationController.uploadAadharFrontImage(context);
                              // if(_registrationController.stepper.value == 5){
                              //   stepperCount++;
                              //   percentage = percentage + 20;
                              // }
                            });
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: AppColors.primaryColor,
                        side: BorderSide(
                          color: Colors.transparent,
                        ),
                        onPrimary: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                      ),
                    ))),
          ],
        ),
      ),
    );
  }

  Widget bottomButtonLast(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: ListTile(
        title: Row(
          children: <Widget>[
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: ElevatedButton(
                      child: Text(
                        "Back",
                        style: styleForLabel(12, Colors.black),
                      ),
                      onPressed: () {
                        setState(() {
                          stepperCount--;
                          percentage = percentage - 20;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        side: BorderSide(
                          color: Colors.black,
                        ),
                        onPrimary: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                      ),
                    ))),
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Obx(()=>_registrationController.isRegistrationVerify == true
                        ? Center(child: CupertinoActivityIndicator())
                    : ElevatedButton(
                      child: Text(
                        "Finish",
                        style: styleForLabel(12, Colors.white),
                      ),
                      onPressed: () {
                        // _registrationController.addUserDetails(
                        //     context, selectedSalutation, mobileNumber,
                        //     billingAddress, shippingAddress, _selectedDate);
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => AddPackage()),
                                (Route<dynamic> route) => false);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: AppColors.primaryColor,
                        side: BorderSide(
                          color: Colors.transparent,
                        ),
                        onPrimary: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                      ),
                      )
                    )
                )),
          ],
        ),
      ),
    );
  }

  /*Personal Details*/
  Widget personalDetails() {
    TextStyle style = TextStyle(fontFamily: Strings.montserrat, fontSize: 13);
    return Expanded(
        child: KeyboardAvoider(
      autoScroll: true,
      child: Form(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
                alignment: Alignment.topLeft,
                child: textWidget("Personal Details:", Colors.white, 15)),
          ),
          Row(children: <Widget>[
            Expanded(
                child: Row(children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(9.0),
                child: Card(elevation: 5, child: getSalutation()),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: TextFormField(
                        controller: _registrationController.firstNameController,
                        decoration: InputDecoration(
                          labelStyle: style,
                          labelText: 'First Name',
                          contentPadding: EdgeInsets.all(15.0),
                          isDense: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                        keyboardType: TextInputType.text,
                      ),
                    ),
                  ),
                ),
              )
            ]))
          ]),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Card(
              elevation: 5,
              child: TextFormField(
                controller: _registrationController.middleNameController,
                decoration: InputDecoration(
                  labelStyle: style,
                  labelText: 'Middle Name',
                  contentPadding: EdgeInsets.all(15.0),
                  isDense: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
                keyboardType: TextInputType.text,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Card(
              elevation: 5,
              child: TextFormField(
                controller: _registrationController.lastNameController,
                decoration: InputDecoration(
                  labelStyle: style,
                  labelText: 'Last Name',
                  contentPadding: EdgeInsets.all(15.0),
                  isDense: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
                keyboardType: TextInputType.text,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              _selectDate(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Card(
                elevation: 5,
                child: TextFormField(
                  readOnly: true,
                  enabled: false,
                  decoration: InputDecoration(
                    labelStyle: style,
                    suffixIcon: Icon(
                      Icons.date_range,
                      size: 18.0,
                      color: Colors.black,
                    ),
                    labelText:
                        _selectedDate.isEmpty ? 'Date Of Birth' : _selectedDate,
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
            child: Card(elevation: 5, child: genderDropDown()),
          ),
          InkWell(
            onTap: () {
              _showChoiceDialog(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Card(
                elevation: 5,
                child: TextFormField(
                  readOnly: true,
                  enabled: false,
                  decoration: InputDecoration(
                    labelStyle: style,
                    suffixIcon: _imageFile == null
                        ? Container(
                            margin: EdgeInsets.all(4),
                            height: 70,
                            decoration: new BoxDecoration(
                                color: Colors.grey[400],
                                borderRadius: BorderRadius.circular(90)),
                            width: 70,
                            child: Center(
                                child: textWidget("Upload", Colors.white, 13)),
                          )
                        : CircleAvatar(
                            backgroundImage: FileImage(File(_imageFile.path)),
                            maxRadius: 30,
                            backgroundColor: Colors.transparent,
                          ),
                    labelText: 'Profile Photo(Optional)',
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

/*shipping address*/
  Widget getShippingAddress() {
    TextStyle style = TextStyle(fontFamily: Strings.montserrat, fontSize: 13);
    return Expanded(
        child: KeyboardAvoider(
      autoScroll: true,
      child: Form(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
                alignment: Alignment.topLeft,
                child:
                    textWidget("Shipping Address Details:", Colors.white, 15)),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: TextFormField(
                  controller:
                      _registrationController.addressLineFirstController,
                  decoration: InputDecoration(
                    labelStyle: style,
                    labelText: 'Address Line 1',
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
              child: TextFormField(
                controller: _registrationController.addressLineSecondController,
                decoration: InputDecoration(
                  labelStyle: style,
                  labelText: 'Address Line 2(Optional)',
                  contentPadding: EdgeInsets.all(15.0),
                  isDense: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Card(
              elevation: 5,
              child: TextFormField(
                inputFormatters: [
                  LengthLimitingTextInputFormatter(6),
                ],
                keyboardType: TextInputType.number,
                controller: _registrationController.pinCodeController,
                decoration: InputDecoration(
                  labelStyle: style,
                  labelText: 'Pin Code',
                  contentPadding: EdgeInsets.all(15.0),
                  isDense: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Card(
              elevation: 5,
              child: TextFormField(
                controller: _registrationController.cityController,
                decoration: InputDecoration(
                  labelStyle: style,
                  labelText: 'Town/City',
                  contentPadding: EdgeInsets.all(15.0),
                  isDense: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
                keyboardType: TextInputType.text,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Card(
              elevation: 5,
              child: TextFormField(
                controller: _registrationController.districtController,
                decoration: InputDecoration(
                  labelStyle: style,
                  labelText: 'District',
                  contentPadding: EdgeInsets.all(15.0),
                  isDense: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Card(
              elevation: 5,
              child: TextFormField(
                controller: _registrationController.stateController,
                decoration: InputDecoration(
                  labelStyle: style,
                  labelText: 'State',
                  contentPadding: EdgeInsets.all(15.0),
                  isDense: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: [
              Checkbox(
                value: billingAddressCheck,
                onChanged: (bool value) {
                  setState(() {
                    billingAddressCheck = value;
                  });
                },
              ),
              Text(
                Strings.check_box_billing,
                style: TextStyle(fontFamily: Strings.montserrat, fontSize: 11),
              ),
            ],
          ),
          billingAddressCheck == false ? getBillingAddress() : Container(),
        ],
      )),
    ));
  }

/*billing address*/
  Widget getBillingAddress() {
    TextStyle style = TextStyle(fontFamily: Strings.montserrat, fontSize: 13);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: TextFormField(
                controller:
                    _registrationController.billingAddressLineFirstController,
                decoration: InputDecoration(
                  labelStyle: style,
                  labelText: 'Address Line 1',
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
            child: TextFormField(
              controller:
                  _registrationController.billingAddressLineSecondController,
              decoration: InputDecoration(
                labelStyle: style,
                labelText: 'Address Line 2(Optional)',
                contentPadding: EdgeInsets.all(15.0),
                isDense: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Card(
            elevation: 5,
            child: TextFormField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(6),
              ],
              keyboardType: TextInputType.number,
              controller: _registrationController.billingPinCodeController,
              decoration: InputDecoration(
                labelStyle: style,
                labelText: 'Pin Code',
                contentPadding: EdgeInsets.all(15.0),
                isDense: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Card(
            elevation: 5,
            child: TextFormField(
              controller: _registrationController.billingCityController,
              decoration: InputDecoration(
                labelStyle: style,
                labelText: 'Town/City',
                contentPadding: EdgeInsets.all(15.0),
                isDense: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Card(
            elevation: 5,
            child: TextFormField(
              controller: _registrationController.billingDistrictController,
              decoration: InputDecoration(
                labelStyle: style,
                labelText: 'District',
                contentPadding: EdgeInsets.all(15.0),
                isDense: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Card(
            elevation: 5,
            child: TextFormField(
              controller: _registrationController.billingStateController,
              decoration: InputDecoration(
                labelStyle: style,
                labelText: 'State',
                contentPadding: EdgeInsets.all(15.0),
                isDense: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

/*Dropdown for gender*/
  Widget genderDropDown() {
    final Widget normalChildButton = Container(
      width: double.infinity,
      height: 45,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 11),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: textWidget(selectedKey, Colors.black54, 12),
            ),
            const SizedBox(
              width: 12,
              height: 17,
              child: FittedBox(
                fit: BoxFit.fill,
                child: Icon(
                  Icons.keyboard_arrow_down_sharp,
                  size: 18,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        MenuButton<String>(
          child: normalChildButton,
          items: keys,
          crossTheEdge: true,
          // Use edge margin when you want the menu button don't touch in the edges
          edgeMargin: 10,
          itemBuilder: (String value) => Container(
            height: 40,
            width: double.infinity,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16),
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          toggledChild: Container(
            child: normalChildButton,
          ),
          divider: Container(
            height: 1,
            color: Colors.white,
          ),
          onItemSelected: (String value) {
            setState(() {
              selectedKey = value;
              _registrationController.gender=selectedKey;
            });
          },
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]),
              borderRadius: const BorderRadius.all(
                Radius.circular(3.0),
              )),
          onMenuButtonToggle: (bool isToggle) {
            print(isToggle);
          },
        ),
      ],
    );
  }

  /*Step 3 Login Details*/
  Widget getLoginDetails() {
    TextStyle style = TextStyle(fontFamily: Strings.montserrat, fontSize: 13);
    return Expanded(
        child: KeyboardAvoider(
      autoScroll: true,
      child: Form(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
                alignment: Alignment.topLeft,
                child: textWidget(Strings.login_details, Colors.white, 15)),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Card(
              elevation: 5,
              child: TextFormField(
                readOnly: false,
                enabled: false,
                decoration: InputDecoration(
                  labelStyle: style,
                  labelText: mobileNumber,
                  contentPadding: EdgeInsets.all(15.0),
                  isDense: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Card(
              elevation: 5,
              child: TextFormField(
                controller: _registrationController.emailIdController,
                decoration: InputDecoration(
                  labelStyle: style,
                  labelText: 'Email address',
                  contentPadding: EdgeInsets.all(15.0),
                  isDense: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Card(
              elevation: 5,
              child: TextFormField(
                controller: _registrationController.setPasswordController,
                obscureText: showPassword,
                decoration: InputDecoration(
                  labelStyle: style,
                  labelText: 'Set Password',
                  contentPadding: EdgeInsets.all(15.0),
                  isDense: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: IconButton(
                      icon: Icon(Icons.remove_red_eye),
                      onPressed: () => setState(() {
                            showPassword = !showPassword;
                          })),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Card(
              elevation: 5,
              child: TextFormField(
                controller: _registrationController.confirmPasswordController,
                decoration: InputDecoration(
                  labelStyle: style,
                  labelText: 'Confirm Password',
                  contentPadding: EdgeInsets.all(15.0),
                  isDense: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
        ],
      )),
    ));
  }

  /*Step 4 KYC Documents*/
  Widget getKycDetails() {
    TextStyle style = TextStyle(fontFamily: Strings.montserrat, fontSize: 13);
    return Expanded(
        child: KeyboardAvoider(
      autoScroll: true,
      child: Form(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
                alignment: Alignment.topLeft,
                child: textWidget(Strings.kyc_title, Colors.white, 15)),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Card(
              elevation: 5,
              child: Container(
                margin: EdgeInsets.only(top: 3),
                child: TextFormField(
                  controller: _registrationController.panCardController,
                  decoration: InputDecoration(
                    labelStyle: style,
                    labelText: 'Pancard Number(optional)',
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
          Card(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Card(
                    elevation: 5,
                    child: TextFormField(
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(12),
                      ],
                      controller: _registrationController.aadharCardController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelStyle: style,
                        labelText: 'Aadhar Card Number',
                        contentPadding: EdgeInsets.all(15.0),
                        isDense: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    width: double.infinity,
                    height: Get.height * 0.2,
                    child: Card(
                        color: Colors.grey[300],
                        elevation: 5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            adharPhotoFront(),
                            adharPhotoBack(),
                            //
                            // Image.asset(Strings.upload),
                            // textWidget("Upload", Colors.black, 13),
                            // textWidget(
                            //     "Maximum File Size", Colors.black, 10)
                          ],
                        )),
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    ));
  }

  /*Step 5 get Terms And condition*/
  Widget getTermAndCondition() {
    TextStyle style = TextStyle(fontFamily: Strings.montserrat, fontSize: 13);
    return Expanded(
        child: KeyboardAvoider(
      autoScroll: true,
      child: Form(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
                alignment: Alignment.topLeft,
                child:
                    textWidget(Strings.terms_and_condition, Colors.white, 15)),
          ),
          Padding(
            padding: const EdgeInsets.all(9.0),
            child: Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: textWidget(
                      Strings.terms_and_condition_text, Colors.black, 13),
                )),
          ),
        ],
      )),
    ));
  }

  /*Dropdown For Salutation*/
  Widget getSalutation() {
    final Widget normalChildButton = SizedBox(
      width: 80,
      height: 50,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 11),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
                child:
                    Text(selectedSalutation, overflow: TextOverflow.ellipsis)),
            const SizedBox(
              width: 12,
              height: 17,
              child: FittedBox(
                fit: BoxFit.fill,
                child: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );

    return Container(
      child: MenuButton<String>(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(9)),
        child: normalChildButton,
        items: salutation,
        topDivider: true,
        itemBuilder: (String value) => Container(
          height: 50,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16),
          child: Text(value),
        ),
        toggledChild: Container(
          child: normalChildButton,
        ),
        divider: Container(
          height: 1,
          color: Colors.grey,
        ),
        onItemSelected: (String value) {
          setState(() {
            selectedSalutation = value;
            _registrationController.salutation=selectedSalutation;
          });
        },
        onMenuButtonToggle: (bool isToggle) {
          print(isToggle);
        },
      ),
    );
  }

  /*Camera and Gallery*/
  Future<void> _showChoiceDialog(BuildContext context, {String clickAction}) {
    return showDialog(
        context: context,
        builder: (BuildContext popupContext) {
          return AlertDialog(
            title: Text(
              'Select Profile Photo From:',
              style: TextStyle(
                  fontFamily: Strings.montserrat,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0),
            ),
            content: SingleChildScrollView(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// To upload from camera
                  GestureDetector(
                    onTap: () {
                      openCamera(popupContext, true, clickAction: clickAction);
                    },
                    child: Column(
                      children: [
                        Container(
                            height: 50.0,
                            width: 50.0,
                            decoration: BoxDecoration(
                                color: Color(0xffd7d0c8),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25))),
                            child: Icon(
                              Icons.camera_alt_outlined,
                              color: AppColors.primaryColor,
                            )),
                        SizedBox(height: 10),
                        Text(
                          'Camera',
                          style: TextStyle(
                              fontFamily: Strings.montserrat, fontSize: 12.0),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 30.0,
                  ),
                  /// To upload from gallery
                  GestureDetector(
                    onTap: () {
                     // openCamera(popupContext, false, clickAction: clickAction);
                      if (state == AppState.free)
                        openCamera(popupContext, false, clickAction: clickAction);
                      else if (state == AppState.picked)
                        _cropImage();
                      else if (state == AppState.cropped) _clearImage();
                    },
                    child: Column(
                      children: [
                        Container(
                          height: 50.0,
                          width: 50.0,
                          decoration: BoxDecoration(
                              color: Color(0xffd7d0c8),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25))),
                          child: Icon(
                            Icons.photo_album,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Gallery',
                          style: TextStyle(
                              fontFamily: Strings.montserrat, fontSize: 12.0),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  /*Open Camera*/
  openCamera(BuildContext buildContext, bool isCamera, {String clickAction}) async {
    if (isCamera) {
      selectedImage = await picker.getImage(source: ImageSource.camera);
    } else {
      selectedImage = await picker.getImage(source: ImageSource.gallery);
    }
    _cropImage(clickAction: clickAction);
    // if (clickAction == Strings.clickActionAdharFront) {
    //   setState(() {
    //     _imageFileAdharFront = selectedImage;
    //     adharFront = selectedImage;
    //     _registrationController.frontImagePath=_imageFileAdharFront;
    //   });
    // }
    // else if (clickAction == Strings.clickActionAdharBack) {
    //   setState(() {
    //     _imageFileAdharBack = selectedImage;
    //     adharBack = selectedImage;
    //     _registrationController.backImagePath=_imageFileAdharBack;
    //   });
    // }
    // else {
    //   setState(() {
    //     _imageFile = selectedImage;
    //      picture = selectedImage;
    //     if (_imageFile != null) {
    //       setState(() {
    //         state = AppState.picked;
    //       });
    //     //  var result = await Navigator.push(context, MaterialPageRoute(builder: (context) => ImageCropView(file: _imageFile)));
    //     }
    //     _registrationController.profileImage=_imageFile;
    //   });
    // }
    //Navigator.pop(context);
  }

  /*Crop Image*/
  Future<Null> _cropImage({String clickAction}) async {

    File fl=File(selectedImage.path);

    File croppedFile = await ImageCropper.cropImage(
        sourcePath: fl.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: AppColors.primaryColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        )
    );
    if (croppedFile != null) {
      _imageFile = PickedFile(croppedFile.path);
      setState(() {
        state = AppState.cropped;
      });
      if (clickAction == Strings.clickActionAdharFront) {
        setState(() {
          _imageFileAdharFront = _imageFile;
          adharFront = _imageFile;
          _registrationController.frontImagePath=_imageFileAdharFront;
        });
      }
      else if (clickAction == Strings.clickActionAdharBack) {
        setState(() {
          _imageFileAdharBack = _imageFile;
          adharBack = _imageFile;
          _registrationController.backImagePath=_imageFileAdharBack;
        });
      }
      else {
        setState(() {
         // _imageFile = _imageFile;
          picture = _imageFile;
          _registrationController.profileImage=_imageFile;
        });
      }
      Navigator.pop(context);
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }

  void _clearImage() {
    _imageFile = null;
    setState(() {
      state = AppState.free;
    });
  }
  Future<void> _selectDate(BuildContext context) async {
    final DateTime d = await showDatePicker(
      //we wait for the dialog to return
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (d != null) //if the user has selected a date
      setState(() {
        var displayFormatter = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
        var serverFormatter = DateFormat('yyyy-MM-dd');
        DateTime displayDate = displayFormatter.parse(d.toString());
        String formatted = serverFormatter.format(displayDate);
        _selectedDate = formatted;
        _registrationController.dateOfBirthController=_selectedDate;
        FocusScope.of(context).requestFocus(FocusNode());
      });
  }

  Widget adharPhotoFront() {
    return _imageFileAdharFront == null
        ? InkWell(
            onTap: () {
              _showChoiceDialog(context,clickAction: Strings.clickActionAdharFront);
            },
            child: Container(
              margin: EdgeInsets.all(4),
              height: 70,
              decoration: new BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(9)),
              width: 70,
              child: Center(
                  child: textWidget("Upload Aadhar Front", Colors.white, 12,
                      align: TextAlign.center)),
            ),
          )
        : Stack(
            children: <Widget>[
              Image(
                image: FileImage(File(_imageFileAdharFront.path)),
                height: Get.height * 0.3,
                width: Get.width * 0.3,
                fit: BoxFit.contain,
              ),
              Positioned(
                top: 0,
                right: 16,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _imageFileAdharFront = null;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xffd7d0c8),
                        borderRadius: BorderRadius.all(Radius.circular(90))),
                    child: Icon(
                      Icons.close,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          );
  }

  Widget adharPhotoBack() {
    return _imageFileAdharBack == null
        ? InkWell(
            onTap: () {
              _showChoiceDialog(context,clickAction: Strings.clickActionAdharBack);
            },
            child: Container(
              margin: EdgeInsets.all(4),
              height: 70,
              decoration: new BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(9)),
              width: 70,
              child: Center(
                  child: textWidget(
                      "Upload Adhar BackSide(Optional)", Colors.white, 12,
                      align: TextAlign.center)),
            ),
          )
        : Stack(
            children: <Widget>[
              Image(
                image: FileImage(File(_imageFileAdharBack.path)),
                height: Get.height * 0.3,
                width: Get.width * 0.3,
                fit: BoxFit.contain,
              ),
              Positioned(
                top: 0,
                right: 16,
                child: GestureDetector(
                  onTap: () {
                    print('delete image from List');
                    setState(() {
                      // ignore: unnecessary_statements
                      _imageFileAdharBack = null;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xffd7d0c8),
                        borderRadius: BorderRadius.all(Radius.circular(90))),
                    child: Icon(
                      Icons.close,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          );
  }
}

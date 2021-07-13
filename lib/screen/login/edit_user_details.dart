import 'package:edutech/screen/common/bottom_navigation_screen.dart';
import 'package:edutech/screen/login/login_getx_controller.dart';
import 'package:edutech/utils/Functions.dart';
import 'package:edutech/utils/colors.dart';
import 'package:edutech/utils/strings.dart';
import 'package:edutech/utils/toast_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class EditUserDetails extends StatefulWidget {
  @override
  _EditUserDetailsState createState() => _EditUserDetailsState();
}

class _EditUserDetailsState extends State<EditUserDetails> {
  final LoginController _loginController = Get.put(LoginController());
  TextEditingController billingAddressController = TextEditingController();
  TextEditingController shippingAddressController = TextEditingController();
  static final dataStorage = GetStorage();
  String user_name;
  String user_email;
  String user_phone_no;
  String user_billing_address;
  String user_shipping_address;

  @override
  void initState() {
    super.initState();
    user_name = dataStorage.read("first_name") +" "+ dataStorage.read("last_name");
    user_email = dataStorage.read("email");
    user_phone_no = dataStorage.read("phone_number");
    user_billing_address = dataStorage.read("billing_address");
    user_shipping_address = dataStorage.read("shipping_address");

    if(user_billing_address !=null){
      billingAddressController.text = user_billing_address;
    }
    if(user_shipping_address !=null){
      shippingAddressController.text = user_shipping_address;
    }
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
                            child: textWidget("Profile", Colors.white, 20,
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
                  text: 'Update Student',
                ),
                Tab(
                  text: 'Student Details',
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
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child:Column(
                      children: [
                        SizedBox(height: 20,),
                        Container(
                            height: Get.height * 0.08,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(top: 5.0),
                              child:TextFormField(
                                enabled: false,
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(
                                      fontFamily: Strings.montserrat, fontSize: 12,color: Colors.black),
                                  labelText: user_name,
                                  contentPadding: EdgeInsets.all(15.0),
                                  isDense: true,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            )
                        ),
                        SizedBox(height: 20,),
                        Container(
                            height: Get.height * 0.08,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(top: 5.0),
                              child:TextFormField(
                                enabled: false,
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(
                                      fontFamily: Strings.montserrat, fontSize: 12,color: Colors.black),
                                  labelText: user_email,
                                  contentPadding: EdgeInsets.all(15.0),
                                  isDense: true,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            )
                        ),
                        SizedBox(height: 20,),
                        Container(
                            height: Get.height * 0.08,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(top: 5.0),
                              child:TextFormField(
                                enabled: false,
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(
                                      fontFamily: Strings.montserrat, fontSize: 12,color: Colors.black),
                                  labelText: user_phone_no,
                                  contentPadding: EdgeInsets.all(15.0),
                                  isDense: true,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            )
                        ),
                        SizedBox(height: 20,),
                        Container(
                            height: Get.height * 0.08,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(top: 5.0),
                              child:TextFormField(
                                controller: billingAddressController,
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(
                                      fontFamily: Strings.montserrat, fontSize: 12, color: Colors.black),
                                  labelText: 'Billing address',
                                  contentPadding: EdgeInsets.all(15.0),
                                  isDense: true,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            )
                        ),
                        SizedBox(height: 20,),
                        Container(
                            height: Get.height * 0.08,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(top: 5.0),
                              child:TextFormField(
                                controller: shippingAddressController,
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(
                                      fontFamily: Strings.montserrat, fontSize: 12,color: Colors.black),
                                  labelText: 'Shipping address',
                                  contentPadding: EdgeInsets.all(15.0),
                                  isDense: true,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            )
                        ),
                        SizedBox(height: 50,),
                        GestureDetector(
                            onTap: (){
                              checkValidation(context);
                            },
                            child:button("Update")
                        )
                      ],
                    ),
                  )
              ),
              SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child:Card(
                      child:Padding(
                        padding: EdgeInsets.all(10.0),
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(height: 5.0,),
                            textWidget("Name : "+user_name??"NA", Colors.black, 14.0),
                            SizedBox(height: 5.0,),
                            textWidget("Email : "+user_email??"NA", Colors.black, 14.0),
                            SizedBox(height: 5.0,),
                            textWidget("Phone number : "+user_phone_no??"NA", Colors.black, 14.0),
                            SizedBox(height: 5.0,),
                            textWidget("Billing address : "+user_billing_address??"NA", Colors.black, 14.0),
                            SizedBox(height: 5.0,),
                            textWidget("Shipping address : "+user_shipping_address??"NA", Colors.black, 14.0),
                            SizedBox(height: 5.0,),
                          ],
                        ),
                      )
                    )
                  )
              ),
            ],
          )
        ));
  }

  /// Check validation
  checkValidation(BuildContext context){
    if(shippingAddressController.text.isEmpty || billingAddressController.text.isEmpty){
      ToastComponent.showDialog("Please enter all fields",context);
    }
    else{
      _loginController.updateUserDetails(shippingAddressController.text,billingAddressController.text,context);
    }
  }
}

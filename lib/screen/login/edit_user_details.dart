import 'package:edutech/screen/common/bottom_navigation_screen.dart';
import 'package:edutech/screen/login/login_getx_controller.dart';
import 'package:edutech/utils/Functions.dart';
import 'package:edutech/utils/colors.dart';
import 'package:edutech/utils/strings.dart';
import 'package:edutech/utils/toast_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditUserDetails extends StatefulWidget {
  @override
  _EditUserDetailsState createState() => _EditUserDetailsState();
}

class _EditUserDetailsState extends State<EditUserDetails> {
  final LoginController _loginController = Get.put(LoginController());
  TextEditingController billingAddressController = TextEditingController();
  TextEditingController shippingAddressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  textWidget("Edit address", Colors.white, 18),
        backgroundColor: AppColors.primaryColor,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) =>
                        BottomNavigationScreen()),
                    (Route<dynamic> route) => false);
          },
          child:Icon(Icons.arrow_back_ios,color: Colors.white, size: 28,),
        )
      ),
      body: SingleChildScrollView(
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
                      controller: billingAddressController,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                            fontFamily: Strings.montserrat, fontSize: 12),
                        labelText: 'New billing address',
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
                            fontFamily: Strings.montserrat, fontSize: 12),
                        labelText: 'New shipping address',
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
    );
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

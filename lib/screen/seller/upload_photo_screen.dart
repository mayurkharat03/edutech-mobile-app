import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:edutech/screen/seller/add_bank_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:edutech/navigation-Animator/navigation.dart';
import 'package:edutech/screen/common/bottom_navigation_screen.dart';
import 'package:edutech/screen/seller/add_bank_account_screen.dart';
import 'package:edutech/utils/Functions.dart';
import 'package:edutech/utils/colors.dart';
import 'package:image_picker/image_picker.dart';

class UploadPhotoScreen extends StatefulWidget {
  @override
  _UploadPhotoScreenState createState() => _UploadPhotoScreenState();
}

class _UploadPhotoScreenState extends State<UploadPhotoScreen> {
  final AddBankDetailsController _addBankDetailsController = Get.put(AddBankDetailsController());
  PickedFile _imageFile;
  var picture;
  final ImagePicker picker = ImagePicker();

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
                  height: Get.height * 0.24,
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
                                    builder: (context) => BottomNavigationScreen()),
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
                                        builder: (context) => BottomNavigationScreen()),
                                    (Route<dynamic> route) => false);
                              },
                              child: textWidget("Step 1", Colors.white, 16, weight: FontWeight.bold),
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0,),
                    child: Text("Take your photo",
                      style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold,letterSpacing: 1.0),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: Get.height * 0.21,
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
                SizedBox(height: Get.height * 0.26,),
                cameraIconProfile(),
                // selectedProfile(),
              ],
            ),
            Align(alignment: Alignment.bottomCenter, child: buttonForBottom()),
          ],
        ),
      ),
    );
  }

  /*step 1 buttons for bottom*/
  Widget buttonForBottom() {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(
              onTap: () {
               // Navigator.pushReplacement(context, FadeNavigation(widget: AddBankAccountScreen()));

              },
              child: buttonSell("Take a Photo", Colors.white, AppColors.textColor)),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(
            onTap: () {
              openGallery(context);
            },
            child: DottedBorder(
              dashPattern: [7, 3,],
              borderType: BorderType.RRect,
              radius: Radius.circular(10),
              color: Colors.grey,
              strokeWidth: 1,
              child: buttonSell("Choose Photo", AppColors.buttonTextColor,Colors.transparent),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(
              onTap: () {
                Navigator.pushReplacement(context, FadeNavigation(widget: AddBankAccountScreen()));
              },
              child: buttonSell("Next", Colors.grey, AppColors.primaryColor.withOpacity(0.2))),
        ),
      ],
    );
  }

  /*step2 buttons for bottom*/
  Widget buttonForBottomLast() {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(
            onTap: () {},
            child: DottedBorder(
              dashPattern: [7, 3],
              borderType: BorderType.RRect,
              radius: Radius.circular(10),
              color: Colors.grey,
              strokeWidth: 1,
              child: buttonSell("Take Another Photo", AppColors.buttonTextColor, Colors.transparent),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(
              onTap: () {
                Navigator.pushReplacement(context, FadeNavigation(widget: AddBankAccountScreen()));
              },
              child: buttonSell("Next", Colors.grey, AppColors.primaryColor.withOpacity(0.2))),
        ),
      ],
    );
  }

  /*Step 2 select profile*/
  Widget selectedProfile() {
    return Container(
      height: Get.height * 0.4,
      child: Center(
        child: Stack(
          children: [
            Container(
              width: Get.width * 0.6,
              height: Get.height * 0.32,
              // width: 300,
              // height: 300,
              decoration: BoxDecoration(
                // shape: BoxShape.circle,
                image: new DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/images/profile1.png'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /*Step 1 camera icon profile*/
  Widget cameraIconProfile() {
    return Container(
      height: Get.height * 0.4,
      child: Center(
        child: Stack(
          children: [
            Container(
              width: Get.width * 0.5,
              height: Get.height * 0.18,
              // width: 300,
              // height: 300,
              decoration: BoxDecoration(
                // shape: BoxShape.circle,
                image: new DecorationImage(
                  fit: BoxFit.fill,
                  image:
                  _imageFile == null
                  ? AssetImage('assets/images/camera_main.png')
                  : FileImage(File(_imageFile.path))
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /*Camera icon*/
  Widget cameraIcon() {
    return Container(
      height: Get.height * 0.4,
      child: Center(
        child: Stack(
          children: [
            Container(
              height: Get.height * 0.21,
              decoration: BoxDecoration(
                // shape: BoxShape.rectangle,
                image: new DecorationImage(
                  fit: BoxFit.contain,
                  image: AssetImage('assets/images/camera_bac_main.png'),
                ),
              ),
            ),
            Positioned(
              left: 90,
              top: 75,
              child: Container(
                width: 215,
                height: 110,
                decoration: BoxDecoration(
                  // shape: BoxShape.rectangle,
                  image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/camera_bac2.png'),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 203,
              top: 9,
              child: Container(
                width: 45,
                height: 20,
                decoration: BoxDecoration(
                  // shape: BoxShape.rectangle,
                  image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/camera3.png'),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 110,
              top: 8,
              child: Container(
                width: 10,
                height: 30,
                decoration: BoxDecoration(
                  // shape: BoxShape.rectangle,
                  image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/camera1.png'),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 108,
              top: 8,
              child: Container(
                width: 10,
                height: 30,
                decoration: BoxDecoration(
                  // shape: BoxShape.rectangle,
                  image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/camera4.png'),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 150,
              top: 50,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  // shape: BoxShape.rectangle,
                  image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/camera_lens1.png'),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 155,
              top: 53,
              child: Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  // shape: BoxShape.rectangle,
                  image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/camera_lens2.png'),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 200,
              top: 62,
              child: Container(
                width: 40,
                height: 45,
                decoration: BoxDecoration(
                  // shape: BoxShape.rectangle,
                  image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/camera_lens3.png')
                  ),
                ),
              ),
            ),
            Positioned(
              left: 159,
              top: 90,
              child: Container(
                width: 40,
                height: 45,
                decoration: BoxDecoration(
                  // shape: BoxShape.rectangle,
                  image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/camera_lens3.png'),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 185,
              top: 83,
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  // shape: BoxShape.rectangle,
                  image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/camera_lens4.png'),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 110,
              top: 120,
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  // shape: BoxShape.rectangle,
                  image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/camera_lens4.png'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  openGallery(BuildContext buildContext) async {
    var selectedImage;
    selectedImage = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = selectedImage;
      picture = selectedImage;
      _addBankDetailsController.profileImage=_imageFile;
    });
  }
}

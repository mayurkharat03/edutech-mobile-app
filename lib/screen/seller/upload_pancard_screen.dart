// class UploadPanCardScreen extends StatefulWidget {
//   const UploadPanCardScreen({Key? key}) : super(key: key);
//
//   @override
//   _UploadPanCardScreenState createState() => _UploadPanCardScreenState();
// }
//
// class _UploadPanCardScreenState extends State<UploadPanCardScreen> {
//   PickedFile _imageFile;
//   var picture;
//   final ImagePicker picker = ImagePicker();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.formBackground,
//       body: SafeArea(
//         child: Stack(
//           children: <Widget>[
//             Positioned(
//               left: 0.0,
//               right: 0.0,
//               child: Card(
//                 margin: EdgeInsets.zero,
//                 elevation: 3.0,
//                 color: AppColors.primaryColor,
//                 child: Container(
//                   width: double.infinity,
//                   height: Get.height * 0.24,
//                 ),
//               ),
//             ),
//             Positioned(
//               top: Get.height * 0.04,
//               left: 0.0,
//               right: 0.0,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(left: 10.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         IconButton(
//                           onPressed: () {
//                             Navigator.of(context).pushAndRemoveUntil(
//                                 MaterialPageRoute(
//                                     builder: (context) => BottomNavigationScreen()),
//                                     (Route<dynamic> route) => false);
//                           },
//                           icon: Icon(
//                             Icons.arrow_back,
//                             color: Colors.white,
//                             size: 28,
//                           ),
//                         ),
//                         Transform(
//                             transform:
//                             Matrix4.translationValues(-5.0, 0.0, 0.0),
//                             child: GestureDetector(
//                               onTap: () {
//                                 Navigator.of(context).pushAndRemoveUntil(
//                                     MaterialPageRoute(
//                                         builder: (context) => BottomNavigationScreen()),
//                                         (Route<dynamic> route) => false);
//                               },
//                               child: textWidget("Step 1", Colors.white, 16, weight: FontWeight.bold),
//                             )),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: 7,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 20.0,),
//                     child: Text("Take your photo",
//                       style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold,letterSpacing: 1.0),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Positioned(
//               top: Get.height * 0.21,
//               left: 0.0,
//               right: 0.0,
//               child: Card(
//                 margin: EdgeInsets.zero,
//                 elevation: 3.0,
//                 color: AppColors.formBackground,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.only(
//                       topRight: Radius.circular(30.0),
//                       topLeft: Radius.circular(30.0)),
//                 ),
//                 child: Container(
//                   width: double.infinity,
//                   height: Get.height,
//                 ),
//               ),
//             ),
//             Column(
//               children: [
//                 SizedBox(height: Get.height * 0.26,),
//                 cameraIconProfile(),
//                 // selectedProfile(),
//               ],
//             ),
//             Align(alignment: Alignment.bottomCenter, child: buttonForBottom()),
//           ],
//         ),
//       ),
//     );
//   }
//
//   /*step 1 buttons for bottom*/
//   Widget buttonForBottom() {
//     return new Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       mainAxisSize: MainAxisSize.max,
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: InkWell(
//               onTap: () {
//                 // Navigator.pushReplacement(context, FadeNavigation(widget: AddBankAccountScreen()));
//
//               },
//               child: buttonSell("Take a Photo", Colors.white, AppColors.textColor)),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: InkWell(
//             onTap: () {
//               openGallery(context);
//             },
//             child: DottedBorder(
//               dashPattern: [7, 3,],
//               borderType: BorderType.RRect,
//               radius: Radius.circular(10),
//               color: Colors.grey,
//               strokeWidth: 1,
//               child: buttonSell("Choose Photo", AppColors.buttonTextColor,Colors.transparent),
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: InkWell(
//               onTap: () {
//                 Navigator.pushReplacement(context, FadeNavigation(widget: AddBankAccountScreen()));
//               },
//               child: buttonSell("Next", Colors.grey, AppColors.primaryColor.withOpacity(0.2))),
//         ),
//       ],
//     );
//   }
//
//   /*step2 buttons for bottom*/
//   Widget buttonForBottomLast() {
//     return new Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       mainAxisSize: MainAxisSize.max,
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: InkWell(
//             onTap: () {},
//             child: DottedBorder(
//               dashPattern: [7, 3],
//               borderType: BorderType.RRect,
//               radius: Radius.circular(10),
//               color: Colors.grey,
//               strokeWidth: 1,
//               child: buttonSell("Take Another Photo", AppColors.buttonTextColor, Colors.transparent),
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: InkWell(
//               onTap: () {
//                 Navigator.pushReplacement(context, FadeNavigation(widget: AddBankAccountScreen()));
//               },
//               child: buttonSell("Next", Colors.grey, AppColors.primaryColor.withOpacity(0.2))),
//         ),
//       ],
//     );
//   }
//
//   /*Step 2 select profile*/
//   Widget selectedProfile() {
//     return Container(
//       height: Get.height * 0.4,
//       child: Center(
//         child: Stack(
//           children: [
//             Container(
//               width: Get.width * 0.6,
//               height: Get.height * 0.32,
//               // width: 300,
//               // height: 300,
//               decoration: BoxDecoration(
//                 // shape: BoxShape.circle,
//                 image: new DecorationImage(
//                   fit: BoxFit.fill,
//                   image: AssetImage('assets/images/profile1.png'),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   /*Step 1 camera icon profile*/
//   Widget cameraIconProfile() {
//     return Container(
//       height: Get.height * 0.4,
//       child: Center(
//         child: Stack(
//           children: [
//             Container(
//               width: Get.width * 0.5,
//               height: Get.height * 0.18,
//               // width: 300,
//               // height: 300,
//               decoration: BoxDecoration(
//                 // shape: BoxShape.circle,
//                 image: new DecorationImage(
//                     fit: BoxFit.fill,
//                     image:
//                     _imageFile == null
//                         ? AssetImage('assets/images/camera_main.png')
//                         : FileImage(File(_imageFile.path))
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

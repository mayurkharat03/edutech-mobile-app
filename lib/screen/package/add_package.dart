import 'package:crypto/crypto.dart';
import 'package:edutech/screen/common/bottom_navigation_screen.dart';
import 'package:edutech/screen/common/dashboard_screen.dart';
import 'package:edutech/screen/package/payment_controller.dart';
import 'package:edutech/utils/toast_component.dart';
import 'dart:convert'; // for the utf8.encode method
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:menu_button/menu_button.dart';
import 'package:edutech/screen/package/add_package_controller.dart';
import 'package:edutech/utils/Functions.dart';
import 'package:edutech/utils/colors.dart';
import 'package:edutech/utils/strings.dart';

class AddPackage extends StatefulWidget {
  @override
  _AddPackageState createState() => _AddPackageState();
}

class _AddPackageState extends State<AddPackage> {
  var controller=Get.put(AddPackageController());
  final PaymentController _paymentController = Get.put(PaymentController());
  String category="";
  String selectedKey = "Standard";
  int selectedStandardIndex;
  String board = "Board";
  int selectedBoardIndex;
  String price="";

  String subjects="";
  int totalPrice=0;
  static MethodChannel channel = MethodChannel('easebuzz');

  Future<bool> _onBackPressed() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => BottomNavigationScreen()),
            (Route<dynamic> route) => false);

    // return showDialog(
    //   context: context,
    //   builder: (context) =>
    //   new AlertDialog(
    //     title: new Text('Are you sure?'),
    //     content: new Text('Do you want to exit an App'),
    //     actions: <Widget>[
    //       new GestureDetector(
    //         onTap: () => Navigator.of(context).pop(false),
    //         child: roundedButton(
    //             "No", const Color(0xFF167F67), const Color(0xFFFFFFFF)),
    //       ),
    //       new GestureDetector(
    //         onTap: () {
    //           Navigator.of(context).pushAndRemoveUntil(
    //               MaterialPageRoute(builder: (context) => LoginScreen()),
    //                   (Route<dynamic> route) => false);
    //         },
    //         child: roundedButton(
    //             " Yes ", AppColors.primaryColor, Colors.white),
    //       ),
    //     ],
    //   ),
    // ) ??
    //     false;
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
  void initState() {
    // TODO: implement initState
    // Future.delayed(Duration(seconds: 0)).then((_) {
    //   mainBottomSheet1(context);
    // });
    super.initState();
    controller.getBoardList();
    controller.getPackagesList();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        body: SafeArea(
          child: Stack(children: <Widget>[
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
              top: Get.height * 0.07,
              left: 0.0,
              right: 0.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: textWidget("My Packages", Colors.white, 22,
                        weight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: textWidget(
                        "You can customize and add multiple package",
                        Colors.white,
                        10),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 8),
                    height: Get.height * 0.07,
                    width: Get.width * 0.5,
                    child: FloatingActionButton.extended(
                      elevation: 4.0,
                      backgroundColor: Colors.white,
                      icon: const Icon(
                        Icons.add,
                        color: Colors.black,
                      ),
                      label: textWidget("Add Package", Colors.black, 12),
                      onPressed: () {
                        board = "Board";
                        selectedKey = 'Standard';
                        price = "";
                        Strings.subjectList.clear();
                        Strings.allStandardsName.clear();
                        //Strings.allBoards.clear();
                        mainBottomSheet1(context);
                      },
                    ),
                  ),
                  //textWidget("Step $stepperCount/5", Colors.white, 15),
                  SizedBox(
                    height: 7,
                  ),
                ],
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: Get.height * 0.30,
                ),
                Expanded(
                  child:Obx((){
                    return
                      controller.showAddPackagesStdName.isEmpty
                      ? Align(alignment: Alignment.topCenter,child:textWidget("Package Not Added", Colors.black, 15))
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.showAddPackagesStdName.length,
                          itemBuilder: (context,index){
                            return
                              SingleChildScrollView(
                                physics: ScrollPhysics(),
                                child: Container(
                                    height: Get.height * 0.4,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Card(elevation: 4, child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                textWidget(controller.showAddPackagesStdName[index]+ " + " +
                                                    controller.showAddPackagesBoardName[index],
                                                    Colors.black, 15, weight: FontWeight.bold),
                                                textWidget("Price: "  + Strings.currency + "${controller.showAddPackagesPrice[index]}"??'', Colors.black, 15),
                                              ],
                                            ),
                                          ),
                                          Divider(height: 1, thickness: 1, color: Colors.grey,),
                                          Expanded(child: InkWell(
                                            onTap: (){
                                              controller.deletePackage(context, Strings.packagePurchaseList[index].toString());
                                            },
                                            child:_myAddedListView(context,controller.showAddPackagesSubName[index]
                                          )),),
                                        ],
                                      )),
                                    )),
                              );
                          });
                  }),
                ),
                SizedBox(
                  height: Get.height * 0.11,
                ),
              ],
            ),
            Align(alignment: Alignment.bottomCenter, child: buttonForBottom(context)),
          ]),
        ),
        //bottomSheet: mainBottomSheet1(context),
      ),
    );
  }

  Widget buttonForBottom(BuildContext context) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(child:textWidget("Total amount:", Colors.grey, 14),),
              // textWidget("Price: " + Strings.currency + "${controller.totalPrice}", Colors.black, 14)
                GetBuilder<AddPackageController>(
                init: AddPackageController(),
                builder: (pressController) {
                return pressController.totalPrice==0 || pressController.totalPrice==null
                ? textWidget("Price: " + Strings.currency + "0", Colors.black, 14)
                : textWidget("Price: " + Strings.currency + "${controller.totalPrice}", Colors.black, 14);
                  }
                ),
            ],
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
                onTap: (){
                  controller.totalPrice==0
                      ? ToastComponent.showDialog("Please add package", context)
                      : _paymentController.userPayment(context);
                },
                child:button("Proceed For Payment")
            )
        ),
      ],
    );
  }

  Widget welcomeCard(BuildContext context, StateSetter setter) {
    return new Container(
        height: Get.height * 9,
        child: new Column(children: <Widget>[
          SizedBox(
            height: 6,
          ),
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
              ),
              child: Divider(
                height: 4,
                thickness: 5,
                color: Colors.grey,
                indent: 140,
                endIndent: 140,
              )),
          Padding(
              padding: new EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 3.0),
              child: textWidget("Add Package", Colors.black, 16)),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getBoard(setter),
              SizedBox(
                width: 5,
              ),
              getClass(setter),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(elevation: 4, child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textWidget(board + " + " + selectedKey, Colors.black, 15,
                            weight: FontWeight.bold),
                        textWidget("Price: "  + Strings.currency + price??'',
                            Colors.black, 15),
                      ],
                    ),
                  ),
                  Divider(height: 1, thickness: 1, color: Colors.grey,),
                  Expanded(child: _myListView(context)),
                  Divider(height: 1, thickness: 1, color: Colors.grey,),
                ],
              )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: (){
                  controller.addPackage(context);
                  controller.getPackagesList();
                  controller.calculateTotalPrice();
              },
              child:button("Add Package")
            ),
          ),
        ]));
  }

  mainBottomSheet1(BuildContext context) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState
                  /*You can rename this!*/) {
                return welcomeCard(context, setState);
              });
        });
  }

  Widget getBoard(StateSetter setState) {
    final Widget normalChildButton = Container(
      decoration:
      BoxDecoration(border: Border.all(width: 1, color: Colors.grey[200])),
      width: Get.width * 0.4,
      height: Get.width * 0.14,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 11),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(child: Text(board, overflow: TextOverflow.ellipsis)),
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
        items: Strings.allBoards,
        topDivider: true,
        itemBuilder: (String value) =>
            Container(
              height: Get.width * 0.1,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(
                  vertical: 0.0, horizontal: 16),
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
            board = value;
            Strings.subjectList.clear();
            selectedKey='Standard';
            price="";

            selectedBoardIndex = Strings.allBoards.indexOf(board);
            controller.boardId = Strings.allBoardsId[selectedBoardIndex];
            controller.getStandardList(Strings.allBoardsId[selectedBoardIndex].toString());
          });
        },
        onMenuButtonToggle: (bool isToggle) {
          print(isToggle);
        },
      ),
    );
  }

  Widget getClass(StateSetter setState) {
    final Widget normalChildButton = Container(
      decoration:
      BoxDecoration(border: Border.all(width: 1, color: Colors.grey[200])),
      width: Get.width * 0.4,
      height: Get.width * 0.14,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 11),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(child: Text(selectedKey, overflow: TextOverflow.ellipsis)),
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
        items: Strings.allStandardsName,
        topDivider: true,
        itemBuilder: (String value) =>
            Container(
              height: Get.width * 0.1,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(
                  vertical: 0.0, horizontal: 16),
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
            selectedKey = value;
            selectedStandardIndex=Strings.allStandardsName.indexOf(selectedKey);
            subjects=controller.getStandardDetails[selectedStandardIndex].subject_list;
            if(controller.getStandardDetails[selectedStandardIndex].subject_list.contains('\n')) {
              subjects = controller.getStandardDetails[selectedStandardIndex].subject_list.replaceAll('\n', "");
              Strings.subjectList = subjects.split(",");
            }
            else{
              Strings.subjectList = subjects.split(",");
            }
            price=Strings.priceList[selectedStandardIndex];
            controller.standardId=Strings.allStandardsId[selectedStandardIndex];
            controller.packagePrice=price;
          });
        },
        onMenuButtonToggle: (bool isToggle) {
          print(isToggle);
        },
      ),
    );
  }

  Widget _myListView(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(6),
      itemCount: Strings.subjectList.length,
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.all(5),
          child: Row(
            children: [
              Icon(
                Icons.assignment_turned_in_sharp,
                color: Colors.green,
                size: 15,
              ),
              SizedBox(width: 5),
              textWidget(Strings.subjectList[index], Colors.black, 14),
            ],
          ),
        );
      },
    );
  }

  Widget _myAddedListView(BuildContext context,String addedSubjectsList) {
    List<String> showSepearateList = [];
     String showSubjectList = "";
     if(addedSubjectsList.contains('\n')){
       showSubjectList = addedSubjectsList.replaceAll("\n", "");
     }
     else{
       showSubjectList = addedSubjectsList;
     }
     showSepearateList = showSubjectList.split(',');
    return ListView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      padding: EdgeInsets.all(6),
      itemCount: showSepearateList.length,
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.all(5),
          child: Row(
            children: [
              Icon(
                Icons.assignment_turned_in_sharp,
                color: Colors.green,
                size: 15,
              ),
              SizedBox(width: 5),
              textWidget(showSepearateList[index], Colors.black, 14),
            ],
          ),
        );
      },
    );
  }

  void _showResponseDialog(Map response)
  {
    String title = "";
    if(response['result']=="payment_successfull")
    {
      title="Success";
    }else
    {
      title="Failed";
    }
    showDialog(context: context,
        builder:(BuildContext context)
        {
          return AlertDialog(
            title: new Text(title),
            content:new Text(response['result']),
          );
        }
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menu_button/menu_button.dart';
import 'package:mlm/model/get_board_list_model.dart';
import 'package:mlm/screen/login/login_screen.dart';
import 'package:mlm/screen/package/add_package_controller.dart';
import 'package:mlm/utils/Functions.dart';
import 'package:mlm/utils/colors.dart';
import 'package:mlm/utils/strings.dart';

class AddPackage extends StatefulWidget {
  @override
  _AddPackageState createState() => _AddPackageState();
}

class _AddPackageState extends State<AddPackage> {
 // final AddPackageController addPackageController = Get.put(AddPackageController());
  var controller=Get.put(AddPackageController());
  String category="";
  String selectedKey = "Standard";
  String board = "Board";
  int selectedBoardIndex;
  List<String> keys = <String>[
    '9 th',
    '8 th',
  ];

  List<String> boardList = <String>[
    'Supplementary',
    'State Board',
    'CBSE',
  ];

  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) =>
      new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit an App'),
        actions: <Widget>[
          new GestureDetector(
            onTap: () => Navigator.of(context).pop(false),
            child: roundedButton(
                "No", const Color(0xFF167F67), const Color(0xFFFFFFFF)),
          ),
          new GestureDetector(
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                      (Route<dynamic> route) => false);
            },
            child: roundedButton(
                " Yes ", AppColors.primaryColor, Colors.white),
          ),
        ],
      ),
    ) ??
        false;
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
                Container(
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
                                textWidget("CBSE + 9 th Class", Colors.black, 15,
                                    weight: FontWeight.bold),
                                textWidget("Price: "  + Strings.currency + "1500",
                                    Colors.black, 15),
                              ],
                            ),
                          ),
                          Divider(height: 1, thickness: 1, color: Colors.grey,),
                          Expanded(child: _myListView(context)),
                        ],
                      )),
                    )),
              ],
            ),
            Align(alignment: Alignment.bottomCenter, child: buttonForBottom()),
          ]),
        ),
        //bottomSheet: mainBottomSheet1(context),
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
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              textWidget("Total amount:", Colors.grey, 14),
              textWidget(Strings.currency + "1500", Colors.black, 14)
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(onTap: () {}, child: button("Proceed For Payment")),
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
                        textWidget("CBSE + 9 th Class", Colors.black, 15,
                            weight: FontWeight.bold),
                        textWidget("Price: "  + Strings.currency + "1500",
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
            child: button("Add Package"),
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
           selectedBoardIndex=Strings.allBoards.indexOf(board);
           print(Strings.allBoardsId[selectedBoardIndex]);
          });
        },
        onMenuButtonToggle: (bool isToggle) {
          print(isToggle);
        },
      ),
    );

  }
//  ListView.builder(
//  shrinkWrap: true,
//  itemCount: controller.getlist.length,
//  itemBuilder: (context,index){
//  var item=controller.getlist[index];
//  return Text(item.boardName);
//  })
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
        items: boardList,
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
          });
        },
        onMenuButtonToggle: (bool isToggle) {
          print(isToggle);
        },
      ),
    );
  }

  Widget _myListView(BuildContext context) {
    // backing data
    final subjectList = [
      'Cursive Writing',
      'Pixie Dust',
      'Drawing and Colouring',
      'Drawing and Colouring',
      'Drawing and Colouring',
      'Computer',
      'General Knowledge'
    ];

    return ListView.builder(
      padding: EdgeInsets.all(6),
      itemCount: subjectList.length,
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
              textWidget(subjectList[index], Colors.black, 14),
            ],
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:menu_button/menu_button.dart';
import 'package:mlm/screen/student/bottom_navigation_screen.dart';
import 'package:mlm/utils/Functions.dart';
import 'package:mlm/utils/colors.dart';
import 'package:mlm/utils/strings.dart';
import 'package:intl/intl.dart';

class StudentDetailsScreen extends StatefulWidget {
  @override
  _StudentDetailsScreenState createState() => _StudentDetailsScreenState();
}

class _StudentDetailsScreenState extends State<StudentDetailsScreen> {
  String _selectedDate = "";
  String selectedSalutation = "Mr.";
  List<String> salutation = <String>["Ms.", "Mrs.", "Miss"];

  String selectedKey = "Gender";
  List<String> keys = <String>[
    'Male',
    'Female',
  ];

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
              top: Get.height * 0.07,
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
                                        BottomNavigationScreen()),
                                (Route<dynamic> route) => false);
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 26,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(
                        left: 20.0,
                      ),
                      child: Row(
                        children: [
                          Text(
                            "Student Details ",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.0),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: Text(
                              "(optional)",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0),
                            ),
                          ),
                        ],
                      )),
                  SizedBox(
                    height: 4,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: textWidget("Add Student Detail for CBSE + 9th Class",
                        Colors.white, 13),
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
                studentDetails(),
              ],
            ),
            Align(alignment: Alignment.bottomCenter, child: bottomButton()),
          ],
        ),
      ),
    );
  }

  Widget bottomButton() {
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
                        "Cancle",
                        style: styleForLabel(12, AppColors.primaryColor),
                      ),
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        side: BorderSide(
                          color: AppColors.primaryColor,
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
                    child: ElevatedButton(
                      child: Text(
                        "Save",
                        style: styleForLabel(12, Colors.white),
                      ),
                      onPressed: () {},
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

/*Student details*/
  Widget studentDetails() {
    TextStyle style = TextStyle(fontFamily: Strings.montserrat, fontSize: 13);
    return Expanded(
        child: KeyboardAvoider(
      autoScroll: true,
      child: Form(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
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
                        // controller: _registrationController.firstNameController,
                        decoration: InputDecoration(
                          labelStyle: style,
                          labelText: 'First Name',
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
              )
            ]))
          ]),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: TextFormField(
                  // controller: _registrationController.middleNameController,
                  decoration: InputDecoration(
                    labelStyle: style,
                    labelText: 'Middle Name',
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
                  // controller: _registrationController.lastNameController,
                  decoration: InputDecoration(
                    labelStyle: style,
                    labelText: 'Last Name',
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
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: TextFormField(
                  // controller: _registrationController.middleNameController,
                  decoration: InputDecoration(
                    labelStyle: style,
                    labelText: 'School Name',
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
                  // controller: _registrationController.middleNameController,
                  decoration: InputDecoration(
                    labelStyle: style,
                    labelText: 'Board',
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
          });
        },
        onMenuButtonToggle: (bool isToggle) {
          print(isToggle);
        },
      ),
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
      });
  }
}

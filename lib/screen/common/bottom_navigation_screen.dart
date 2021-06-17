import 'package:flutter/material.dart';
import 'package:edutech/screen/common/dashboard_screen.dart';
import 'package:edutech/utils/colors.dart';
import 'package:edutech/utils/strings.dart';

class BottomNavigationScreen extends StatefulWidget {
  @override
  _BottomNavigationScreenState createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  int _selectedTabIndex = 0;

  List _pages = [
    DashBoard(),
    DashBoard(),
    DashBoard(),
    DashBoard(),
    DashBoard(),
  ];

  _changeIndex(int index) {
    setState(() {
      _selectedTabIndex = index;
       var currentpage = _pages[index];
      print("index..." + index.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _pages[_selectedTabIndex]),
      bottomNavigationBar: bottomNavigationBar,
    );
  }

  Widget get bottomNavigationBar {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedTabIndex,
            onTap: _changeIndex,
            type: BottomNavigationBarType.fixed,
            // selectedFontSize: 12,
            // unselectedFontSize: 12,
            // selectedItemColor: AppColors.primaryColor,
            // unselectedItemColor: Colors.grey[500],
           // showUnselectedLabels: true,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: new Icon(Icons.home_filled,color: _selectedTabIndex == 0 ? AppColors.primaryColor : Colors.grey,),
                title: Text('Home',style:TextStyle(fontSize: 11.0,fontFamily: Strings.montserrat, color: _selectedTabIndex == 0 ?  AppColors.primaryColor : Colors.grey,)),
              ),

              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('assets/images/rupees_nav.png'), color: _selectedTabIndex == 1 ? AppColors.primaryColor : Colors.grey,),
                title: Text('Wallet',style:TextStyle(fontSize: 11.0,fontFamily: Strings.montserrat, color: _selectedTabIndex == 1 ? AppColors.primaryColor : Colors.grey,)),
              ),

              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('assets/images/referral_nav.png'), color: _selectedTabIndex == 2 ? AppColors.primaryColor : Colors.grey,),
                title: Text('Referrals',style:TextStyle(fontSize: 11.0,fontFamily: Strings.montserrat, color: _selectedTabIndex == 2 ? AppColors.primaryColor : Colors.grey,)),
              ),

              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('assets/images/share_nav.png'), color: _selectedTabIndex == 3 ? AppColors.primaryColor : Colors.grey,),
                title: Text('Share',style:TextStyle(fontSize: 11.0,fontFamily: Strings.montserrat, color: _selectedTabIndex == 3 ? AppColors.primaryColor : Colors.grey,)),
                ),

              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('assets/images/person_nav.png'), color: _selectedTabIndex == 4 ? AppColors.primaryColor : Colors.grey,),
                title: Text('Profile',style:TextStyle(fontSize: 11.0,fontFamily: Strings.montserrat, color: _selectedTabIndex == 4 ? AppColors.primaryColor : Colors.grey,)),
              ),
            ],
          ),
        ));
  }
}

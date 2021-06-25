import 'dart:async';
import 'package:edutech/screen/splashscreen/slide_dots.dart';
import 'package:edutech/screen/splashscreen/slide_item.dart';
import 'package:edutech/screen/splashscreen/slide_model.dart';
import 'package:flutter/material.dart';
import 'package:edutech/navigation-Animator/navigation.dart';
import 'package:edutech/screen/login/login_screen.dart';
import 'package:edutech/utils/Functions.dart';
import 'package:edutech/utils/colors.dart';

class GettingStartedScreen extends StatefulWidget {
  @override
  _GettingStartedScreenState createState() => _GettingStartedScreenState();
}

class _GettingStartedScreenState extends State<GettingStartedScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      if(_pageController.hasClients){
        _pageController.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Stack(
                  alignment: Alignment.bottomLeft,
                  // alignment: AlignmentDirectional.bottomCenter,
                  children: <Widget>[
                    PageView.builder(
                      scrollDirection: Axis.horizontal,
                      controller: _pageController,
                      onPageChanged: _onPageChanged,
                      itemCount: slideList.length,
                      itemBuilder: (ctx, i) => SlideItem(i),
                    ),
                    Stack(
                      alignment: Alignment.bottomLeft,
                      // alignment: AlignmentDirectional.topStart,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(bottom: 20,left: 15),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              for(int i = 0; i<slideList.length; i++)
                                if( i == _currentPage )
                                  SlideDots(true)
                                else
                                  SlideDots(false)
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Align(alignment: Alignment.bottomCenter,child: buttonForBottom(),),

              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.stretch,
              //   children: <Widget>[
              //     FlatButton(
              //       child: Text(
              //         'Getting Started',
              //         style: TextStyle(
              //           fontSize: 18,
              //         ),
              //       ),
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(5),
              //       ),
              //       padding: const EdgeInsets.all(15),
              //       color: Theme.of(context).primaryColor,
              //       textColor: Colors.white,
              //       onPressed: () {
              //         Navigator.of(context).pushNamed(SignupScreen.routeName);
              //       },
              //     ),
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: <Widget>[
              //         Text(
              //           'Have an account?',
              //           style: TextStyle(
              //             fontSize: 18,
              //           ),
              //         ),
              //         FlatButton(
              //           child: Text(
              //             'Login',
              //             style: TextStyle(fontSize: 18),
              //           ),
              //           onPressed: () {
              //             Navigator.of(context).pushNamed(LoginScreen.routeName);
              //           },
              //         ),
              //       ],
              //     ),
              //   ],
              // )

            ],
          ),
        ),
      ),
    );
  }

  Widget buttonForBottom() {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(context, FadeNavigation(widget: LoginScreen()));
               //  Navigator.of(context).pushAndRemoveUntil(
               //      MaterialPageRoute(builder: (context) => LoginScreen()),
               //          (route) => false);
              },
              child: buttonSell("Get Started", Colors.white, AppColors.primaryColor)),
        ),
      ],
    );
  }

}
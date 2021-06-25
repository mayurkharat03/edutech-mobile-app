import 'package:edutech/screen/splashscreen/slide_model.dart';
import 'package:flutter/material.dart';

class SlideItem extends StatelessWidget {

  final int index;
  SlideItem(this.index);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Center(
          child: Container(
            width: 240,
            height: 240,
            decoration: BoxDecoration(
              // shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(slideList[index].imageUrl),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        SizedBox(height: 30,),
        Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 20.0),
          child: Text(
            slideList[index].title,
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.black,
              fontFamily: "Montserrat",
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 20.0),
          child: Text(
            slideList[index].description,
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.grey,
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w400,
              fontSize: 14,
              height: 1.47059,
              letterSpacing: 0.7,
            ),
          ),
        ),
      ],
    );
  }
}

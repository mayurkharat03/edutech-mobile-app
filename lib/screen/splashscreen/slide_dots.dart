import 'package:flutter/material.dart';
import 'package:edutech/utils/colors.dart';

class SlideDots extends StatelessWidget {
  bool isActive;
  SlideDots(this.isActive);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 250),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      height: isActive ? 6 : 8,
      width: isActive ? 70 : 9,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: isActive ? AppColors.yellow : AppColors.yellow.withOpacity(0.3),
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
    );
  }
}
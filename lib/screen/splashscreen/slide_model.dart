import 'package:flutter/material.dart';

class Slide {
  final String imageUrl;
  final String title;
  final String description;

  Slide({
    @required this.imageUrl,
    @required this.title,
    @required this.description,
  });
}

final slideList = [
  Slide(
    imageUrl: 'assets/images/getting_started2.png',
    title: 'Buy Packages',
    description: 'While working the app reminds you to smile, laugh, walk and talk with those who matters.',
  ),
  Slide(
    imageUrl: 'assets/images/getting_started1.png',
    title: 'Easy Learning',
    description: 'Nobody likes to be alone and the built-in easy feature helps you learning.',
  ),
  Slide(
    imageUrl: 'assets/images/getting_started.png',
    title: 'Start Referral and Earn Money',
    description: 'Earn Money by referring to your friends and family.',
  ),
];
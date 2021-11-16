import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        child: Image.asset('assets/images/logos.png'),
        // Icon(Icons.favorite_border,color: Colors.red,),//  Image.asset('assets/images/logo.jpg'),
      ),
    );
  }
}

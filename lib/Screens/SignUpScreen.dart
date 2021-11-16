import 'package:flutter/material.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/services.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

import '../Forms/SignUpForm.dart';
//import 'UserScreens/MainUserScreen.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/SignUp';
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  bool _isLoading = false;



  @override
  void didUpdateWidget(SignUpScreen oldSignUpScreen) {
    super.didUpdateWidget(oldSignUpScreen);
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
     // body: SignUpForm(_submitSignUp, _isLoading),
     body: SignUpForm(_isLoading),
    );
  }
}


import 'package:flutter/material.dart';


import '../Forms/SignInForm.dart';


class SignInScreen extends StatefulWidget {
  static const routeName = '/SignIn';

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
 /* void _signInWithErrorEmailOrPassword(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Cannot sign in'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }*/

 // final _signIn = FirebaseAuth.instance;

 

  @override
  void didUpdateWidget(SignInScreen oldSignInScreen) {
    super.didUpdateWidget(oldSignInScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SignInForm(),
    );
  }
}

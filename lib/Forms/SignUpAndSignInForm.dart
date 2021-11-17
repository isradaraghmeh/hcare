import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';

import '../Screens/SignUpScreen.dart';
import '../Screens/SignInScreen.dart';

class SignUpAndSignInForm extends StatefulWidget {
  @override
  _SignUpAndSignInFormState createState() => _SignUpAndSignInFormState();
}

class _SignUpAndSignInFormState extends State<SignUpAndSignInForm>
    with TickerProviderStateMixin {
  // bool _isStillLoaddingSignIn = false;
  // bool _isStillLoaddingSignUp = false;

  AnimationController _controller;
  Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.ease);

    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var getWidth = MediaQuery.of(context).size.width;
    var getHeight = MediaQuery.of(context).size.height;
    final isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return ScaleTransition(
      scale: _animation,
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/school.png'),
                  fit: BoxFit.fill),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.transparent,
                Colors.transparent,
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                // Text(
                //   "welcome to School Managment System",
                //   style: TextStyle(fontStyle: FontStyle.italic,
                //       color: Colors.black87,
                //       fontSize: 15.0,
                //       fontWeight: FontWeight.bold
                //       ),
                // ),
                SizedBox(
                  height: isLandScape ? getHeight * 0.015 : getHeight * 0.01,
                ),
                // Text(
                //   "Through our application, you can see the information about each student in terms of grades, attendance, absence and exam dates",
                //   style: TextStyle(
                //     color: Colors.black,
                //     fontSize:14.0,
                //   ),
                // ),
                SizedBox(
                  height: isLandScape ? getHeight * 0.05 : getHeight * 0.03,
                ),
                Container(
                  height: isLandScape ? getHeight * 0.12 : getHeight * 0.08,
                  width: double.infinity,
                  margin: EdgeInsets.only(
                    left: getWidth * 0.1,
                    right: getWidth * 0.1,
                  ),
                  child: FlatButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, SignUpScreen.routeName);
                      // pushSignUpAfterLoading();
                    },
                    color: Colors.brown,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        getWidth * 0.1,
                      ),
                    ),
                    child: Text(
                      "Sign up",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: isLandScape ? getHeight * 0.05 : getHeight * 0.03,
                ),
                /////////////////////
                ///
                ///
                ///
                ///
                ///
                ///
                ///

                Container(
                  height: isLandScape ? getHeight * 0.12 : getHeight * 0.08,
                  width: double.infinity,
                  margin: EdgeInsets.only(
                    left: getWidth * 0.1,
                    right: getWidth * 0.1,
                  ),
                  child: FlatButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, SignInScreen.routeName);
                      //pushSignInAfterLoading();
                    },
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        getWidth * 0.1,
                      ),
                    ),
                    child: Text(
                      "Sign in",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: getWidth * 0.04,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: isLandScape ? getHeight * 0.05 : getHeight * 0.03,
                ),
                SizedBox(
                  height: isLandScape ? getHeight * 0.05 : getHeight * 0.045,
                ),
                /////
                ///
                ///
                ///
                Container(
                  height: isLandScape ? getHeight * 0.12 : getHeight * 0.08,
                  width: double.infinity,
                  margin: EdgeInsets.only(
                    left: getWidth * 0.1,
                    right: getWidth * 0.1,
                  ),
                  // child: FlatButton(
                  //   onPressed: () {
                  //     Navigator.pushReplacementNamed(context, SignUpScreen.routeName);
                  //    // pushSignUpAfterLoading();
                  //   },
                  //     color: Colors.white70,
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(
                  //       getWidth * 0.1,
                  //     ),
                  //   ),
                  //    child:

                  //     //  Text(
                  //     //       "About us ",
                  //     //       style: TextStyle(
                  //     //         color: Colors.black,
                  //     //         fontWeight: FontWeight.bold,
                  //     //         fontSize:24.0,
                  //     //       ),
                  //     //     ),
                  // ),
                ),

                ////jnjn m
                SizedBox(
                  height: isLandScape ? getHeight * 0.05 : getHeight * 0.03,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

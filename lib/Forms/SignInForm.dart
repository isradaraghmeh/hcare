import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../Screens/SignUpScreen.dart';
import '../Screens/UserScreens/MainUserScreen.dart';
import '../Screens/EmployeeScreens/EmployeePageSeeAppointment.dart';
import '../Screens/AdminScreens/MainAdminScreen.dart';
import './ConstantIP.dart';

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  var _isToggle = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailToForgotPasswordController = TextEditingController();
  var myToken;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  var _email = '';
  var _password = '';

  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  AnimationController _controller;
  Animation<double> _animation;

  savePrefrences(
      String firstname, String lastname, String email, String password,String screen) async {
    SharedPreferences prefrences = await SharedPreferences.getInstance();
    prefrences.setString("firstname", firstname);
    prefrences.setString("lastname", lastname);
    prefrences.setString("email", email);
    prefrences.setString("password", password);
    prefrences.setString("screen", screen);
  }
  Future<void> _pressSignin() async {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState.save();
      try {
        showLoaddingDialog(context);
        print(_email);
        print(_password);
        print(myToken);
        var data = {
          "email": _email,
          "password": sha1.convert(utf8.encode(_password)).toString(),
          "token":myToken
        };
        var url = Uri.parse("http://"+ipAdressValue+"/HCare/SignIn.php");
        var response = await http.post(url,body: data);
        var responsebody = jsonDecode(response.body);
        print(responsebody['status']);
        if (responsebody['status'] == "success") {
          Navigator.of(context).pop();
          _emailController..text="";
          _passwordController..text="";
          savePrefrences(responsebody['firstname'], responsebody['lastname'],
              responsebody['email'], responsebody['password'],"MainUserScreen");
          Navigator.pushReplacement(context,
            MaterialPageRoute(
              builder: (context) => MainUserScreen(),
            ),
          );
          //print("YES");
        }
        else if (responsebody['status'] == "success2") {
          Navigator.of(context).pop();
          savePrefrences(responsebody['firstname'], responsebody['lastname'],
              responsebody['email'], responsebody['password'],"MainEmployeeScreen");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => EmployeePageSeeAppointment(),
            ),
          );
        } else if (responsebody['status'] == "success3") {
          Navigator.of(context).pop();
          savePrefrences(responsebody['firstname'], responsebody['lastname'],
              responsebody['email'], responsebody['password'],"MainAdminScreen");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MainAdminScreen(),
            ),
          );
        }
        else {
          Navigator.of(context).pop();
          showFailedDialog(
              context, "Login Failed", "Invalid email or password");
          //print("NO");
        }
      } on PlatformException catch (e) {
        print(e.toString());
      } catch (e) {
        print(e.toString());
      }

    }
  }

  Future getDataCheckEnd() async {
    try {
      var url = Uri.parse("http://"+ipAdressValue+"/HCare/EndedAppointmentchecktime.php");
      var response = await http.post(url);
      var responsebody = jsonDecode(response.body);
      if (responsebody['status'] == "success") return responsebody;
    } catch (e) {
      print(e.toString());
    }
  }

  bool isEmail(String string) {
    const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    final regExp = RegExp(pattern);

    return regExp.hasMatch(string);
  }

  showFailedDialog(context, String title, String str) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(str),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK"))
            ],
          );
        });
  }

  showLoaddingDialog(context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Row(
              children: <Widget>[
                Text("Loadding..."),
                CircularProgressIndicator(),
              ],
            ),
          );
        });
  }

  void _showForgotResult(BuildContext ctx, String str) {
    showModalBottomSheet(
      context: ctx,
      builder: (context) {
        return GestureDetector(
          onTap: () {},
          child: Container(
            child: Text(
              str,
              style: TextStyle(
                color: Colors.red,
              ),
            ),
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
          ),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _showForgotPassword() {
    showDialog(
      context: context,
      builder: (ctx) => SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 100),
          child: AlertDialog(
            title: Text('Please enter your email'),
            content: TextField(
              autocorrect: false,
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.emailAddress,
              controller: _emailToForgotPasswordController,
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  if (!isEmail(_emailToForgotPasswordController.text) ||
                      _emailToForgotPasswordController.text.isEmpty) {
                    _showForgotResult(context, "The input is invalid email or empty");
                  } else {
                    checkValidForgotPassword(_emailToForgotPasswordController.text);
                  }


                },
              ),
              FlatButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future checkValidForgotPassword(femail) async {
    try {
      var data={"email":femail};
      var url = Uri.parse("http://"+ipAdressValue+"/HCare/checkForgrtPassword.php");
      var response = await http.post(url,body: data);
      var responsebody = jsonDecode(response.body);
      if (responsebody['status'] == "success"){ updateForgotPassword(femail);return responsebody;}
      else{ _showForgotResult(context, "Entered email not used");}
    } catch (e) {
      print(e.toString());
    }
  }

  Future updateForgotPassword(femail)async{
    try {
      sendMail(femail);
    } catch (e) {
      print(e.toString());
    }
  }


  sendMail(femail)async{
    var gmal="LearningCityNablus@gmail.com";
    var passw="LearningCity@1999";
    final smtpServer = gmail(gmal, passw);
    var link="http://localhost/HCare/checkUpdatePassword.php?email="+femail;
    final message = new Message()
      ..from = new Address(femail,"HCare Technical Center")
      ..recipients.add(femail)
    // ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
    // ..bccRecipients.add(new Address('bccAddress@example.com'))
      ..subject = 'Password recover link from HCare  ${new DateTime.now()}'
    // ..text = 'This is the plain text.\nThis is line 2 of the text part.'
      ..html = "<h4>Please click this link  to reset your password</h4>\n<p><a href='$link'>Click here to reset</a></p>";

    try{
      final sendReports = await send(message, smtpServer);
      _showForgotResult(context, "Check your email to reset password");
      return sendReports;
    }catch (e){
      _showForgotResult(context, e.toString()+"message not sent. \n");
    }
  }


//////
///
///
///
///
///
///

  






  @override
  void initState() {
    getDataCheckEnd();
    _isToggle = false;
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.ease);

    _controller.forward();


    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      setState(() {
        myToken = token;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();

    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

////
///
///
///
///
  





    var getWidth = MediaQuery.of(context).size.width;
    var getHeight = MediaQuery.of(context).size.height;
    final isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return SizeTransition(
      sizeFactor: _animation,
      axis: Axis.horizontal,
      axisAlignment: -1.5,
      child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          color: Colors.white,
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.only(
              left: getWidth * 0.05,
            ),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                    left: getWidth * 0.05,
                    top: getHeight * 0.1,
                    bottom: getHeight * 0.02,
                  ),
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                        fontSize: isLandScape == true
                            ? getWidth * 0.07
                            : getWidth * 0.09,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    bottom: getHeight * 0.03,
                    left: getWidth * 0.05,
                  ),
                  child: Text(
                    'Login in your account',
                    style: TextStyle(
                      fontSize: isLandScape == true
                          ? getWidth * 0.03
                          : getWidth * 0.04,
                          fontStyle:FontStyle.italic ,
                          
                    ),
                  ),
                  
                ),
                Container(
                  width: getWidth,
                  //margin: EdgeInsets.only(bottom: getHeight * 0.1),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                            right: getWidth * 0.15,
                            left: getWidth * 0.05,
                            top: getHeight * 0.02,
                          ),
                          child: TextFormField(
                            // focusNode: _focusNodeEmail,
                            // onTap: _checkFocusEmail,

                            controller: _emailController,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            keyboardType: TextInputType.emailAddress,
                            enableSuggestions: true,

                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Email field required';
                              }
                              return null;
                            },

                            textInputAction: TextInputAction.next,
                            focusNode: _emailFocusNode,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_passwordFocusNode);
                            },
                            decoration: InputDecoration(
                              errorStyle: TextStyle(
                                fontSize: getWidth * 0.025,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.green[200],
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              labelText: 'Email',
                              prefixIcon: Container(
                                width: 0,
                                alignment: Alignment(-0.99, 0),
                                child: Icon(
                                  Icons.email,
                                ),
                              ),
                            ),
                            onSaved: (value) {
                              _email = value.trim();
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            right: getWidth * 0.15,
                            left: getWidth * 0.05,
                            top: getHeight * 0.02,
                          ),
                          child: TextFormField(
                            controller: _passwordController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Password field required';
                              }
                              return null;
                            },
                            focusNode: _passwordFocusNode,
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (_) {
                              _pressSignin();
                            },
                            decoration: InputDecoration(
                              errorStyle: TextStyle(
                                fontSize: getWidth * 0.025,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.green[200],
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              labelText: 'Password',
                              prefixIcon: Container(
                                width: 0,
                                alignment: Alignment(-0.99, 0),
                                child: Icon(
                                  Icons.lock,
                                ),
                              ),
                              suffixIcon: IconButton(
                                icon: Container(
                                  width: 0,
                                  alignment: Alignment(0.99, 0),
                                  child: Icon(
                                    _isToggle
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                ),
                                onPressed: (() {
                                  setState(() {
                                    _isToggle = !_isToggle;
                                  });
                                }),
                              ),
                            ),
                            onSaved: (value) {
                              _password = value;
                            },
                            obscureText: _isToggle ? false : true,
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          margin: EdgeInsets.only(
                            right: getWidth * 0.1,
                          ),
                          height: isLandScape == true
                              ? getHeight * 0.15
                              : getHeight * 0.1,
                          child: FlatButton(
                            materialTapTargetSize:
                            MaterialTapTargetSize.shrinkWrap,
                            onPressed: () {
                              _emailToForgotPasswordController..text = "";
                              _showForgotPassword();
                            },
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: isLandScape == true
                                    ? getWidth * 0.02
                                    : getWidth * 0.03,
                                color: Colors.black12,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              right: getWidth * 0.1, top: getHeight * 0.04),
                          width: getWidth * 0.75,
                          height: isLandScape == true
                              ? getHeight * 0.15
                              : getHeight * 0.1,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                isLandScape == true
                                    ? getHeight * 0.1
                                    : getHeight * 0.05,
                              ),
                            ),
                            highlightColor: Colors.black,
                            color: Theme.of(context).accentColor,
                            textColor: Colors.white,
                            child: Text(
                              'Sign in',
                              style: TextStyle(
                                fontSize: isLandScape == true
                                    ? getWidth * 0.04
                                    : getWidth * 0.05,
                              ),
                            ),
                            onPressed: _pressSignin,
                            //onPressed:() {Navigator.pushReplacementNamed(context, MainAdminScreen.routeName);},
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: getWidth * 0.1, top: getHeight * 0.05),
                          child: Row(
                            children: <Widget>[
                              Container(
                                child: Text(
                                  'Do not have an account?',
                                  style: TextStyle(
                                    fontSize: isLandScape == true
                                        ? getWidth * 0.03
                                        : getWidth * 0.04,
                                  ),
                                ),
                                // width: getWidth * 0.4,
                              ),
                              Container(
                                child: FlatButton(
                                  materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(context, SignUpScreen.routeName);
                                  },
                                  child: Text(
                                    'Sign up',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: isLandScape == true
                                            ? getWidth * 0.03
                                            : getWidth * 0.04,
                                        color: Theme.of(context).accentColor
                                    ),
                                  ),
                                ),
                              ),
    //                        //Size size = MediaQuery.of(context).size;
    //  Container(
    //   width: double.infinity,
    //   height: double.infinity,
    //   child: Stack(
    //     alignment: Alignment.center,
    //     children: <Widget>[
    //       Positioned(
    //         top: 0,
    //         left: 0,
    //         child: Image.asset(
    //           "assets/images/main_top.png",
    //           width: double.infinity,
    //         ),
    //       ),
    //       Positioned(
    //         bottom: 0,
    //         right: 0,
    //         child: Image.asset(
    //           "assets/images/login_bottom.png",
    //           width: double.infinity,
    //         ),
    //       ),
         
    //     ],
    //   ),
    // )
 



          



                              
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],







              
            ),
          ),
        ),
      ),
    );
  
  
  
  }







  
}

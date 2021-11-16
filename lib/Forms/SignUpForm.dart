import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../Screens/SignInScreen.dart';
import '../Screens/Onboarding.dart';
import './ConstantIP.dart';
// import '../Screens/UserScreens/MainUserScreen.dart';

class SignUpForm extends StatefulWidget {
  SignUpForm(
    // this.pressSignUp,
    this.isLoading,
  );

  final bool isLoading;
  /*final void Function(
    String fName,
    String lName,
    String email,
    String password,
    String confirmPassword,
    BuildContext ctx,
  ) pressSignUp;*/

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  var _isToggle = false;
  var _isToggleConfirm = false;
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  var _firstName = '';
  var _lastName = '';
  var _email = '';
  var _password = '';
  //var _confirmPassword = '';
  final _firstNameFocusNode = FocusNode();
  final _lastNameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();
  var myToken;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  AnimationController _controller;
  Animation<double> _animation;

  savePrefrences(String firstname, String lastname, String email,
      String password, String screen) async {
    SharedPreferences prefrences = await SharedPreferences.getInstance();
    prefrences.setString("firstname", firstname);
    prefrences.setString("lastname", lastname);
    prefrences.setString("email", email);
    prefrences.setString("password", password);
    prefrences.setString("screen", screen);
  }

  showFailedDialog(context, String title, String str) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(str),
            actions: <Widget>[
              TextButton(
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

  Future<void> _pressSignup() async {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState.save();
      try {
        showLoaddingDialog(context);
        var data = {
          "firstname": _firstName,
          "lastname": _lastName,
          "password": sha1.convert(utf8.encode(_password)).toString(),
          "email": _email,
          "token": myToken
        };
        var url = Uri.parse("http://"+ipAdressValue+"/HCare/SignUp.php");
        var response = await http.post(url, body: data);
        var responsebody = jsonDecode(response.body);
        print(responsebody);
        if (responsebody['status'] == "success") {
          Navigator.of(context).pop();
          //print("YES");
          savePrefrences(
              responsebody['firstname'],
              responsebody['lastname'],
              responsebody['email'],
              responsebody['password'],
              "MainUserScreen");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Onboarding(),
            ),
          );
        } else {
          Navigator.of(context).pop();
          showFailedDialog(
              context, "Register Failed", "Email is already in use");
          //print("NO");
        }
      } catch (e) {
        print(e.toString());
      }
    }
  }

  Future getDataCheckEnd() async {
    try {
      var url = Uri.parse(
          "http://" + ipAdressValue + "/HCare/EndedAppointmentchecktime.php");
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

  bool validatePasword(String string) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~/*-+^_]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(string);
  }

  @override
  void initState() {
    getDataCheckEnd();
    _isToggle = false;
    _isToggleConfirm = false;
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
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();

    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                    left: getWidth * 0.05,
                    top: getHeight * 0.06,
                    bottom: getHeight * 0.02,
                  ),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                        fontSize: isLandScape == true
                            ? getWidth * 0.07
                            : getWidth * 0.09,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).accentColor),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    bottom: getHeight * 0.03,
                    left: getWidth * 0.05,
                  ),
                  child: Text(
                    'Create your account',
                    style: TextStyle(
                      fontSize: isLandScape == true
                          ? getWidth * 0.03
                          : getWidth * 0.04,
                    ),
                  ),
                ),
                Container(
                  width: getWidth,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                            right: getWidth * 0.15,
                            left: getWidth * 0.05,
                            top: getHeight * 0.02,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: getWidth * 0.34,
                                margin: EdgeInsets.only(),
                                child: TextFormField(
                                  key: ValueKey('firstname'),
                                  controller: _firstNameController,
                                  autocorrect: true,
                                  textCapitalization: TextCapitalization.words,
                                  enableSuggestions: false,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    FocusScope.of(context)
                                        .requestFocus(_lastNameFocusNode);
                                  },
                                  decoration: InputDecoration(
                                    errorStyle: TextStyle(
                                      fontSize: getWidth * 0.025,
                                    ),
                                    labelText: 'First Name',
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
                                  ),
                                  onSaved: (value) {
                                    _firstName = value.trim();
                                  },
                                  validator: (value) {
                                    if (value.isEmpty ||
                                        value.trim().length < 3) {
                                      return 'At least 3 characters';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Container(
                                width: getWidth * 0.34,
                                child: TextFormField(
                                  key: ValueKey('lastname'),
                                  controller: _lastNameController,
                                  autocorrect: true,
                                  textCapitalization: TextCapitalization.words,
                                  enableSuggestions: false,
                                  validator: (value) {
                                    if (value.isEmpty ||
                                        value.trim().length < 3) {
                                      return 'At least 3 characters';
                                    }
                                    return null;
                                  },
                                  textInputAction: TextInputAction.next,
                                  focusNode: _lastNameFocusNode,
                                  onFieldSubmitted: (_) {
                                    FocusScope.of(context)
                                        .requestFocus(_emailFocusNode);
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
                                    labelText: 'Last Name',
                                  ),
                                  onSaved: (value) {
                                    _lastName = value.trim();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            right: getWidth * 0.15,
                            left: getWidth * 0.05,
                            top: getHeight * 0.02,
                          ),
                          child: TextFormField(
                            key: ValueKey('email'),
                            controller: _emailController,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            keyboardType: TextInputType.emailAddress,
                            enableSuggestions: true,
                            validator: (value) {
                              if (!isEmail(value.trim()) || value.isEmpty) {
                                return 'Invalid email';
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
                            key: ValueKey('password'),
                            controller: _passwordController,
                            validator: (value) {
                              if (!validatePasword(value)) {
                                return 'Password should contain at least one upper case, lower case,\nnumber and spacial character and minimum length 8.';
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            focusNode: _passwordFocusNode,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_confirmPasswordFocusNode);
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
                          margin: EdgeInsets.only(
                              right: getWidth * 0.15,
                              left: getWidth * 0.05,
                              top: getHeight * 0.02,
                              bottom: getHeight * 0.01),
                          child: TextFormField(
                            key: ValueKey('confirmpassword'),
                            // focusNode: _focusNodeConfPass,
                            // onTap: _checkFocusConfPass,
                            controller: _confirmPasswordController,
                            validator: (value) {
                              if (value.isEmpty ||
                                  _confirmPasswordController.text !=
                                      _passwordController.text) {
                                return 'Should be same password';
                              }
                              return null;
                            },

                            textInputAction: TextInputAction.done,
                            focusNode: _confirmPasswordFocusNode,
                            onFieldSubmitted: (_) {
                              _pressSignup();
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

                              labelText: 'Confirm Password',
                              prefixIcon: Container(
                                width: 0,
                                alignment: Alignment(-0.99, 0),
                                child: Icon(
                                  Icons.lock,
                                ),
                              ),
                              // labelStyle: TextStyle(
                              //   color: _focusNodeConfPass.hasFocus == null
                              //       ? Colors.yellow
                              //       : _focusNodeConfPass.hasFocus
                              //           ? Colors.black
                              //           : Colors.blueAccent,
                              // ),
                              suffixIcon: IconButton(
                                // color: _focusNodeConfPass.hasFocus == null
                                //     ? Colors.yellow
                                //     : _focusNodeConfPass.hasFocus
                                //         ? Colors.black
                                //         : Colors.blueAccent,
                                icon: Container(
                                  width: 0,
                                  alignment: Alignment(0.99, 0),
                                  child: Icon(
                                    _isToggleConfirm
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                ),
                                onPressed: (() {
                                  setState(() {
                                    _isToggleConfirm = !_isToggleConfirm;
                                  });
                                }),
                              ),
                            ),
                            onSaved: (value) {
                              //    _confirmPassword = value;
                            },
                            obscureText: _isToggleConfirm ? false : true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: getWidth * 0.05, top: getHeight * 0.05),
                  width: getWidth * 0.75,
                  height:
                      isLandScape == true ? getHeight * 0.15 : getHeight * 0.1,
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
                    child: widget.isLoading == true
                        ? Container(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.white,
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                Colors.blueAccent,
                              ),
                            ),
                          )
                        : Text(
                            'Sign up',
                            style: TextStyle(
                              fontSize: isLandScape == true
                                  ? getWidth * 0.04
                                  : getWidth * 0.05,
                            ),
                          ),
                    onPressed: _pressSignup,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: getWidth * 0.1, top: getHeight * 0.05),
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Text(
                          'Do you have an account?',
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
                            Navigator.pushReplacementNamed(
                                context, SignInScreen.routeName);
                          },
                          child: Text(
                            'Sign in',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: isLandScape == true
                                  ? getWidth * 0.03
                                  : getWidth * 0.04,
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

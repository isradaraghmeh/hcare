// @dart=2.9
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:crypto/crypto.dart';
// import '../UserScreens/EditUserProfile.dart';
// import '../../Screens/SignInScreen.dart';
import '../../Forms/ConstantIP.dart';

class EditPasswordScreen extends StatefulWidget {
  final currentpassword;
  final currentEmail;
  EditPasswordScreen(
      {Key key, @required this.currentpassword, @required this.currentEmail})
      : super(key: key);
  @override
  _EditPasswordScreenState createState() => _EditPasswordScreenState();
}

class _EditPasswordScreenState extends State<EditPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  //var _password = '';
  var _isToggle = false;
  final _newPasswordController = TextEditingController();
  var _newPassword = '';
  var _isNewToggle = false;
  final _newConfirmPasswordController = TextEditingController();
  //var _newConfirmPassword = '';
  var _isNewConfirmToggle = false;

  // var _currentEmail,  _currentPassword;
  bool isSignIn = false;

  final _currentPasswordFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();

  //   getPrefrences() async {
  //   SharedPreferences prefrences = await SharedPreferences.getInstance();
  //   if ( prefrences.getString("firstname") == null && prefrences.getString("lastname") == null) {
  //     Navigator.push(
  //                     context,
  //                     MaterialPageRoute(
  //                       builder: (context) => SignInScreen(),
  //                     ),
  //                   );
  //   }

  // }

  @override
  void initState() {
    _isToggle = false;
    _isNewToggle = false;
    _isNewConfirmToggle = false;
    // getPrefrences();
    super.initState();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _newPasswordController.dispose();
    _newConfirmPasswordController.dispose();
    _currentPasswordFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  bool validatePasword(String string) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~/*-+^_]).{8,}$';
    RegExp regExp = new RegExp(pattern);
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

  completeDonecorrect(context, String title, String str) {
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
                    // Navigator.pop(context);
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => EditUserProfile(),
                    //   ),
                    // );
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

  Future<void> _pressEditPassword() async {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState.save();

      try {
        showLoaddingDialog(context);
        var data = {
          "password": sha1.convert(utf8.encode(_newPassword)).toString(),
          "email": widget.currentEmail,
        };
        var url = "http://"+ipAdressValue+"/HCare/EditPasswordUser.php";
        var response = await http.post(Uri.parse(url), body: data);
        var responsebody = jsonDecode(response.body);

        if (responsebody['status'] == "success") {
          //print("YES");
          SharedPreferences prefrences = await SharedPreferences.getInstance();
          prefrences.setString(
            "password",
            sha1.convert(utf8.encode(_newPassword)).toString(),
          );
          Navigator.of(context).pop();
          completeDonecorrect(
              context, "Edit password", "Edit password done successfully");
        } else {
          Navigator.of(context).pop();
          showFailedDialog(context, "Edit password", "Edit password failed");
          //print("NO");
        }
      } catch (e) {
        Navigator.of(context).pop();
        print("Exception");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var getAppHeight = AppBar().preferredSize.height;
    var getWidth = MediaQuery.of(context).size.width;
    var getHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
                titleSpacing: 0,
        elevation: 0,
        title: Text('Edit password'),
        backgroundColor: Theme.of(context).accentColor,
        actions: <Widget>[
          IconButton(
            iconSize: getAppHeight * 0.5,
            icon: Icon(Icons.save),
            onPressed: () {
              _pressEditPassword();
              setState(() {});
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: getWidth * 0.05, top: getHeight * 0.03),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: getHeight * 0.02,
                ),
                ListTile(
                  title: Text(
                    "Current password",
                    style: TextStyle(color: Theme.of(context).accentColor),
                  ),
                  subtitle: Container(
                    margin: EdgeInsets.only(top: getHeight * 0.02),
                    height: getHeight * 0.1,
                    child: TextFormField(
                      key: ValueKey('password'),
                      controller: _passwordController,
                      validator: (value) {
                        if (widget.currentpassword !=
                            sha1.convert(utf8.encode(value)).toString()) {
                          //print(widget.currentpassword );print();
                          return 'This current password not correct';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      focusNode: _currentPasswordFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_passwordFocusNode);
                      },
                      decoration: InputDecoration(
                        errorStyle: TextStyle(
                          fontSize: getWidth * 0.025,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
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
                        //   _password = value;
                      },
                      obscureText: _isToggle ? false : true,
                    ),
                  ),
                ),
                // SizedBox(
                //   height: getHeight * 0.01,
                // ),
                ListTile(
                  title: Text(
                    "New password",
                    style: TextStyle(color: Theme.of(context).accentColor),
                  ),
                  subtitle: Container(
                    margin: EdgeInsets.only(top: getHeight * 0.01),
                    height: getHeight * 0.1,
                    child: TextFormField(
                      key: ValueKey('newPassword'),
                      controller: _newPasswordController,
                      validator: (value) {
                        if (!validatePasword(value) || value.length < 8) {
                          return 'Password should contain at least one upper case, lower case,\nnumber and spacial character and minimum length 8.';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      focusNode: _passwordFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_confirmPasswordFocusNode);
                      },
                      decoration: InputDecoration(
                        errorStyle: TextStyle(
                          fontSize: getWidth * 0.025,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                          ),
                        ),
                        suffixIcon: IconButton(
                          icon: Container(
                            width: 0,
                            alignment: Alignment(0.99, 0),
                            child: Icon(
                              _isNewToggle
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                          onPressed: (() {
                            setState(() {
                              _isNewToggle = !_isNewToggle;
                            });
                          }),
                        ),
                      ),
                      onSaved: (value) {
                        _newPassword = value;
                      },
                      obscureText: _isNewToggle ? false : true,
                    ),
                  ),
                ),
                // SizedBox(
                //   height: getHeight * 0.01,
                // ),
                ListTile(
                  title: Text(
                    "Confirm new password",
                    style: TextStyle(color: Theme.of(context).accentColor),
                  ),
                  subtitle: Container(
                    margin: EdgeInsets.only(top: getHeight * 0.01),
                    height: getHeight * 0.1,
                    child: TextFormField(
                      key: ValueKey('newConfirmPassword'),
                      controller: _newConfirmPasswordController,
                      validator: (value) {
                        if (value.isEmpty ||
                            _newConfirmPasswordController.text !=
                                _newPasswordController.text) {
                          return 'Should be same new password and not empty';
                        }
                        return null;
                        // if (!validatePasword(value) || value.length < 8) {
                        //   return 'Password should contain at least one upper case, lower case,\nnumber and spacial character and minimum length 8.';
                        // }
                        // return null;
                      }, 
                       
                      focusNode: _confirmPasswordFocusNode,
                      onFieldSubmitted: (_) {
                        // FocusScope.of(context).requestFocus(_confirmPasswordFocusNode);
                      },
                      decoration: InputDecoration(
                        errorStyle: TextStyle(
                          fontSize: getWidth * 0.025,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                          ),
                        ),
                        suffixIcon: IconButton(
                          icon: Container(
                            width: 0,
                            alignment: Alignment(0.99, 0),
                            child: Icon(
                              _isNewConfirmToggle
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                          onPressed: (() {
                            setState(() {
                              _isNewConfirmToggle = !_isNewConfirmToggle;
                            });
                          }),
                        ),
                      ),
                      onSaved: (value) {
                        //       _newConfirmPassword = value;
                      },
                      obscureText: _isNewConfirmToggle ? false : true,
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

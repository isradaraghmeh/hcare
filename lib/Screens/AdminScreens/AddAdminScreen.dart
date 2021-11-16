// @dart=2.9
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import '../../Forms/ConstantIP.dart';

class AddAdminScreen extends StatefulWidget {
  @override
  _AddAdminScreenState createState() => _AddAdminScreenState();
}

class _AddAdminScreenState extends State<AddAdminScreen> {
  final _formKey = GlobalKey<FormState>();
    // var _isToggle = false;

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  // final _passwordController = TextEditingController();
  var _firstName = '';
  var _lastName = '';
  var _email = '';
  // var _password = '';

  final _firstNameFocusNode = FocusNode();
  final _lastNameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode(); 
  // final _passwordFocusNode = FocusNode();


  bool isEmail(String string) {
    const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    final regExp = RegExp(pattern);

    return regExp.hasMatch(string);
  }

  // bool validatePasword(String string) {
  //   String pattern =
  //       r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~/*-+^_]).{8,}$';
  //   RegExp regExp = new RegExp(pattern);
  //   return regExp.hasMatch(string);
  // }

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
// print(femail);
    try{
      final sendReports = await send(message, smtpServer);
      return sendReports;
    }catch (e){
      _showForgotResult(context, "message not sent. \n");
    }
  }


  Future updateForgotPassword(femail)async{
     try {
       sendMail(femail);
        } catch (e) {
          print(e.toString());
        }
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
  Future<void> _pressSignup() async {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState.save();
        try{
        var data={"firstname":_firstName,"lastname":_lastName, "password":'',"email":_email};
        var url= Uri.parse("http://"+ipAdressValue+"/HCare/SignUpAdmin.php");
        var response=await http.post(url,body:data);
        var responsebody=jsonDecode(response.body);
        if(responsebody['status']=="success"){
          showFailedDialog(context, "Add admin", "Add admin done successfully");
           updateForgotPassword(_email);
        }else{
          showFailedDialog(context, "Add admin failed", "Email is already in use");
          //print("NO");
        }
      }catch(e){
          print("Exception");
      }

    }
  }

 showFailedDialog(context,String title, String str){
    showDialog(context: context,builder:(context){
      return AlertDialog(title:Text(title), content:Text(str),actions: <Widget>[FlatButton(onPressed: (){Navigator.of(context).pop();}, child: Text("OK"))],);
    });
  }

@override
  void initState() {
    // _isToggle = false;
   
    super.initState();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    // _passwordController.dispose();   
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    _emailFocusNode.dispose();
    // _passwordFocusNode.dispose();
    super.dispose();
  }  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        elevation: 0,
        titleSpacing: 0,
        title: Text(
          "Add Admin",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              height: 30,
              color:Theme.of(context).accentColor,
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: 70,
                width: MediaQuery.of(context).size.width,
                color:Theme.of(context).accentColor,
              ),
            ),
            Form(
              key: _formKey,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    color: Colors.white),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.85,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "To",
                            style: TextStyle(fontSize: 18),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                color: Colors.grey.withOpacity(0.2)),
                            child: Text(
                              "Set him",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "In",
                            style: TextStyle(fontSize: 18),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                color: Colors.grey.withOpacity(0.2)),
                            child: Text(
                              "Our App",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        color: Colors.grey.withOpacity(0.2),
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
                          decoration: InputDecoration(
                              hintText: "First Name", border: InputBorder.none),
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        color: Colors.grey.withOpacity(0.2),
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
                                   onSaved: (value) {
                                    _lastName = value.trim();
                                  },
                          decoration: InputDecoration(
                            hintText: "Second Name",
                            border: InputBorder.none,
                          ),
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        color: Colors.grey.withOpacity(0.2),
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
                            textInputAction: TextInputAction.done,
                            focusNode: _emailFocusNode,
                            onFieldSubmitted: (_) {
                                _pressSignup();
                            },
                              onSaved: (value) {
                              _email = value.trim();
                            },
                          decoration: InputDecoration(
                              hintText: "Email", border: InputBorder.none),
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      // Container(
                      //   padding: EdgeInsets.all(10),
                      //   color: Colors.grey.withOpacity(0.2),
                      //   child: TextFormField(
                      //     key: ValueKey('password'),
                      //       controller: _passwordController,
                      //       validator: (value) {
                      //         if (!validatePasword(value) || value.length < 8) {
                      //           return 'Password should contain at least one upper case, lower case,\nnumber and spacial character and minimum length 8.';
                      //         }
                      //         return null;
                      //       },
                      //       focusNode: _passwordFocusNode,
                      //        onSaved: (value) {
                      //         _password = value;
                      //       },
                      //       textInputAction: TextInputAction.done,
                      //       onFieldSubmitted: (_) {
                      //                _pressSignup();
                      //       },
                      //     decoration: InputDecoration(
                      //       hintText: "Password",
                      //       border: InputBorder.none,
                      //         suffixIcon: IconButton(

                      //           icon: Container(
                      //             width: 0,
                      //             alignment: Alignment(0.99, 0),
                      //             child: Icon(
                      //               _isToggle
                      //                   ? Icons.visibility
                      //                   : Icons.visibility_off,
                      //             ),
                      //           ),
                      //           onPressed: (() {
                      //             setState(() {
                      //               _isToggle = !_isToggle;
                      //             });
                      //           }),
                      //         ),
                      //     ),
                      //     style: TextStyle(fontSize: 18),
                      //        obscureText: _isToggle ? false : true,
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 15,
                      // ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 50,
                                                          child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                                color: Theme.of(context).accentColor,
                                child: Center(
                                  child: Text(
                                    "Submit",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ),
                                onPressed: () {
                                   _pressSignup();
                                },
                              ),
                            ),
                            // )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

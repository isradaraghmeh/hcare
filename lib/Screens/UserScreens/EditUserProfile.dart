// @dart=2.9
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../UserScreens/EditFirstNameScreen.dart';
import '../UserScreens/EditLastNameScreen.dart';
import '../UserScreens/EditPasswordScreen.dart';
import '../../Forms/ConstantIP.dart';
// import '../../Screens/SignInScreen.dart'; 

class EditUserProfile extends StatefulWidget {
  @override
  _EditUserProfileState createState() => _EditUserProfileState();
}

class _EditUserProfileState extends State<EditUserProfile> {
  var _currentEmail, _currentFirstname, _currentLastname, _currentPassword;
  bool isSignIn = false;

  _pressSignin() async {
    getPrefrences();
    try {
      if (_currentEmail != null) {
        var data = {"email": _currentEmail};
        var url = "http://"+ipAdressValue+"/HCare/getAuthenticationPage.php";
        var response = await http.post(Uri.parse(url), body: data);
        var responsebody = jsonDecode(response.body);
        if (responsebody['status'] == "success") {
          return responsebody;
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
  }

  getPrefrences() async {
    SharedPreferences prefrences = await SharedPreferences.getInstance();
    setState(
      () {
        _currentEmail = prefrences.getString("email");
        _currentFirstname = prefrences.getString("firstname");
        _currentLastname = prefrences.getString("lastname");
        _currentPassword = prefrences.getString("password");
      },
    );
    if (_currentEmail != null &&
        _currentFirstname != null &&
        _currentLastname != null &&
        _currentPassword != null) {
      setState(
        () {
          isSignIn = true;
          _currentEmail = prefrences.getString("email");
          _currentFirstname = prefrences.getString("firstname");
          _currentLastname = prefrences.getString("lastname");
          _currentPassword = prefrences.getString("password");
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var getHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit profile"),
        backgroundColor: Theme.of(context).accentColor,
        titleSpacing: 0,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: _pressSignin(),
            builder: (context, snapshot) {
                  // if (snapshot.connectionState ==
                  //                 ConnectionState.waiting)
                  //               return Text("   Loadding ...    ");
              if (snapshot.hasData) {
                return Container(
                  margin: EdgeInsets.only(top: getHeight * 0.04),
                  child: Column(
                    children: <Widget>[
                      FlatButton(
                        onPressed: () {
                          if (snapshot.data['firstname'] != null)
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditFirstNameScreen(
                                  currentFirstname: snapshot.data['firstname'],
                                  currentEmail: _currentEmail,
                                ),
                              ),
                            );
                        },
                        child: ListTile(
                          title: Text("First name"),
                          subtitle: snapshot.data['firstname'] == null
                              ? Text("")
                              : Text(snapshot.data['firstname']),
                          trailing: Icon(Icons.edit),
                        ),
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                      FlatButton(
                        onPressed: () {
                          if (snapshot.data['lastname'] != null)
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditLastNameScreen(
                                  currentLastname: snapshot.data['lastname'],
                                  currentEmail: _currentEmail,
                                ),
                              ),
                            );
                        },
                        child: ListTile(
                          title: Text("Last name"),
                          subtitle: snapshot.data['lastname'] == null
                              ? Text("")
                              : Text(snapshot.data['lastname']),
                          trailing: Icon(Icons.edit),
                        ),
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                      FlatButton(
                        onPressed: () {
                          if (snapshot.data['lastname'] != null)
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditPasswordScreen(
                                    currentpassword: snapshot.data['password'],
                                    currentEmail: _currentEmail),
                              ),
                            );
                        },
                        child: ListTile(
                          title: Text("Password"),
                          subtitle: Text("Change your password"),
                          trailing: Icon(Icons.edit),
                        ),
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                    ],
                  ),
                );
              }
              return Text("");
            }),
      ),
    );
  }
}

// @dart=2.9
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../Screens/AdminScreens/MainAdminScreen.dart';
import '../../Screens/SignInScreen.dart';
import '../../Screens/UserScreens/EditUserProfile.dart';
import '../../Screens/AdminScreens/EditContactUs.dart';
import '../../Screens/AdminScreens/EditAboutCategory.dart';
import '../../Screens/AdminScreens/EditAboutUs.dart';
import '../ConstantIP.dart';


class MainAdminDrawer extends StatefulWidget {
  @override
  _MainAdminDrawerState createState() => _MainAdminDrawerState();
}

class _MainAdminDrawerState extends State<MainAdminDrawer> {

    var _currentEmail;
  bool isSignIn = false;

  @override
  void initState() {
    getPrefrences();
    super.initState();
  }
  
   getCurrentName() async {
    getPrefrences();
    try {
      if (_currentEmail != null) {
        var data = {"email": _currentEmail};
        var url = Uri.parse("http://"+ipAdressValue+"/HCare/getAuthenticationPage.php");
        var response = await http.post(url, body: data);
        var responsebody = jsonDecode(response.body);
        if (responsebody['status'] == "success") {
          return responsebody;
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }


logOutToken() async {
    getPrefrences();
    try {
      if (_currentEmail != null) {
        var data = {"email": _currentEmail};
        var url = Uri.parse("http://"+ipAdressValue+"/HCare/LogoutToken.php");
        var response = await http.post(url, body: data);
        var responsebody = jsonDecode(response.body);
          return responsebody;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  getPrefrences() async {
    SharedPreferences prefrences = await SharedPreferences.getInstance();
    setState(
      () {
        _currentEmail = prefrences.getString("email");
      },
    );
    if ( _currentEmail != null) {
      setState(
        () {
          isSignIn = true;
           _currentEmail = _currentEmail;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
     var getWidth = MediaQuery.of(context).size.width;
    var getHeight = MediaQuery.of(context).size.height;
    var getAppBarHeight = AppBar().preferredSize.height;
    var topHeight = MediaQuery.of(context).padding.top;
    final isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Drawer(
    child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                    left: getAppBarHeight * 0.2, top: topHeight),
                height: getAppBarHeight + topHeight,
                width: double.infinity,
                alignment: Alignment.centerLeft,
                color: Theme.of(context).accentColor,
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: getAppBarHeight * 0.5,
                      ),
                      onPressed: () {
                          Navigator.of(context).pop();
                       // Navigator.pop(context);
                    //      Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) =>  MainAdminScreen(),
                    //   ),
                    // );
                      },
                    ),
                    isSignIn
                        ?  FutureBuilder(
                          future: getCurrentName(),
                          builder: (context, snapshot) {
                            if(!snapshot.hasData)return Text("");
                            return Text(
                                snapshot.data['firstname']+' '+snapshot.data['lastname'],
                                style: TextStyle(
                                  fontSize: isLandScape
                                      ? getAppBarHeight * 0.6
                                      : getAppBarHeight * 0.3,
                                  //fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              );
                          }
                        )
                        : Text(""),
                  ],
                ),
              ),
              SizedBox(
                height: getHeight * 0.04,
              ),
              Container(
                child: FlatButton(
                  padding: EdgeInsets.only(
                    left: getAppBarHeight * 0.4,
                    bottom: getHeight * 0.02,
                    top: getHeight * 0.02,
                  ),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.white,
                      width: 0,
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.home),
                      Container(
                        margin: EdgeInsets.only(
                          left: getWidth * 0.02,
                        ),
                        child: Text(
                          'Homepage',
                          style: TextStyle(
                            fontSize: isLandScape
                                ? getHeight * 0.05
                                : getHeight * 0.03,
                            //  fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  onPressed: (() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainAdminScreen(),
                      ),
                    );
                  }),
                ),
              ),
              Divider(
                color: Theme.of(context).accentColor,
              ),
              Container(
                child: FlatButton(
                  padding: EdgeInsets.only(
                    left: getAppBarHeight * 0.4,
                    bottom: getHeight * 0.02,
                    top: getHeight * 0.02,
                  ),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.white,
                      width: 0,
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.settings),
                      Container(
                        margin: EdgeInsets.only(
                          left: getWidth * 0.02,
                        ),
                        child: Text(
                          'Edit profile',
                          style: TextStyle(
                            fontSize: isLandScape
                                ? getHeight * 0.05
                                : getHeight * 0.03,
                          ),
                        ),
                      ),
                    ],
                  ),
                  onPressed: (() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditUserProfile(),
                      ),
                    );
                  }),
                ),
              ),
              Divider(
                color: Theme.of(context).accentColor,
              ),
              Container(
                child: FlatButton(
                  padding: EdgeInsets.only(
                    left: getAppBarHeight * 0.4,
                    bottom: getHeight * 0.02,
                    top: getHeight * 0.02,
                  ),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.white,
                      width: 0,
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.contacts),
                      Container(
                        margin: EdgeInsets.only(
                          left: getWidth * 0.02,
                        ),
                        child: Text(
                          'Application contact us',
                          style: TextStyle(
                            fontSize: isLandScape
                                ? getHeight * 0.05
                                : getHeight * 0.03,
                          ),
                        ),
                      ),
                    ],
                  ),
                  onPressed: (() {
                     Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditContactUs(),
                      ),
                    );
                  }),
                ),
              ),
               Divider(
                color:Theme.of(context).accentColor,
              ),
              Container(
                child: FlatButton(
                  padding: EdgeInsets.only(
                    left: getAppBarHeight * 0.4,
                    bottom: getHeight * 0.02,
                    top: getHeight * 0.02,
                  ),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.white,
                      width: 0,
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.category),
                      Container(
                        margin: EdgeInsets.only(
                          left: getWidth * 0.02,
                        ),
                        child: Text(
                          'Categores about us',
                          style: TextStyle(
                            fontSize: isLandScape
                                ? getHeight * 0.05
                                : getHeight * 0.03,
                          ),
                        ),
                      ),
                    ],
                  ),
                  onPressed: (() {
                     Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditAboutCategory(),
                      ),
                    );
                  }),
                ),
              ),
                Divider(
                color: Theme.of(context).accentColor,
              ),
              Container(
                child: FlatButton(
                  padding: EdgeInsets.only(
                    left: getAppBarHeight * 0.4,
                    bottom: getHeight * 0.02,
                    top: getHeight * 0.02,
                  ),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.white,
                      width: 0,
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.help),
                      Container(
                        margin: EdgeInsets.only(
                          left: getWidth * 0.02,
                        ),
                        child: Text(
                          'Application about us',
                          style: TextStyle(
                            fontSize: isLandScape
                                ? getHeight * 0.05
                                : getHeight * 0.03,
                          ),
                        ),
                      ),
                    ],
                  ),
                  onPressed: (() {
                       Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditAboutUs(),
                      ),
                    );
                  }),
                ),
              ),
              Divider(
                color: Theme.of(context).accentColor,
              ),
              Container(
                child: FlatButton(
                  padding: EdgeInsets.only(
                    left: getAppBarHeight * 0.4,
                    bottom: getHeight * 0.02,
                    top: getHeight * 0.02,
                  ),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.white,
                      width: 0,
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.exit_to_app),
                      Container(
                        margin: EdgeInsets.only(
                          left: getWidth * 0.02,
                        ),
                        child: Text(
                          'Logout',
                          style: TextStyle(
                            fontSize: isLandScape
                                ? getHeight * 0.05
                                : getHeight * 0.03,
                          ),
                        ),
                      ),
                    ],
                  ),
                  onPressed: (() async {
                    SharedPreferences preferences =
                        await SharedPreferences.getInstance();
                    preferences.remove("firstname");
                    preferences.remove("lastname");
                    preferences.remove("email");
                     preferences.setString("screen", "login");
                    logOutToken();
   Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
    SignInScreen()), (Route<dynamic> route) => false);
                //    Navigator.of(context).popUntil(ModalRoute.withName(MainAdminScreen.routeName));
                //  Navigator.pushReplacement(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => SignInScreen(),
                //       ),
                //     );
                   
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => SignInScreen(),
                    //   ),
                    // );
                  }),
                ),
              ),
              Divider(
                color: Theme.of(context).accentColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
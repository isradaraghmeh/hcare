// @dart=2.9
import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import '../../Forms/UserForms/MainDrawer.dart';
import '../../Forms/UserForms/MainMedicalServices.dart';
// import '../../Screens/SignInScreen.dart';


class MainUserScreen extends StatefulWidget {
  static const routeName = '/MainUserScreen';

  @override
  _MainUserScreenState createState() => _MainUserScreenState();
}

class _MainUserScreenState extends State<MainUserScreen> {

  @override
  void initState(){
    // getPrefrences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      appBar: AppBar(
        elevation:0,
        titleSpacing: 0,
        title: Text('Homepage'),
        backgroundColor: Theme.of(context).accentColor,
      ),
      drawer: MainDrawer(),
      body: MainMedicalServices(),
    );
  }
}

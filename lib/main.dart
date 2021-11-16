// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
 import 'package:shared_preferences/shared_preferences.dart';
import './Screens/SignUpScreen.dart';
import './Screens/SignInScreen.dart';
import './Screens/SignUpAndSignInScreen.dart';
import './Screens/SplashScreen.dart';
//import 'package:firebase_core/firebase_core.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import './Screens/UserScreens/MainUserScreen.dart';
import './Screens/EmployeeScreens/EmployeePageSeeAppointment.dart';
import './Screens/AdminScreens/MainAdminScreen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isSplash = true;
  String screen="login";


  void checkSplash() async {
    await Future.delayed(Duration(seconds: 5));
    setState(() {
      isSplash = false;
    });
  }

  


 
  getPrefrences() async {
    SharedPreferences prefrences = await SharedPreferences.getInstance();
    setState(
      () {
        screen = prefrences.getString("screen");
      },
    );
    if ( screen != null) {
      setState(
        () {
         screen=screen;
        },
      );
    }
  }

  @override
  void initState() {
    checkSplash();
    getPrefrences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) { 
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return MaterialApp(
      title: 'HCare',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'LeonSans',
          accentColor: Colors.green),
      home: Scaffold(
       // body: SignUpScreen(),
      body:   isSplash?SplashScreen():
      
        screen=="MainUserScreen"?MainUserScreen():
        screen=="MainEmployeeScreen"?EmployeePageSeeAppointment():
        screen=="MainAdminScreen"?MainAdminScreen():SignUpAndSignInScreen(),
      ),
      routes: {
        SignUpScreen.routeName: (ctx) => SignUpScreen(),
        SignInScreen.routeName: (ctx) => SignInScreen(),
        MainUserScreen.routeName:(ctx)=>MainUserScreen(),
        EmployeePageSeeAppointment.routeName:(ctx)=>EmployeePageSeeAppointment(),
        MainAdminScreen.routeName:(ctx)=>MainAdminScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

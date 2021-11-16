// @dart=2.9
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../../Forms/EmployeeForms/MainEmployeeDrawer.dart';
import '../EmployeeScreens/AcceptedAppointmentScreen.dart';
import '../EmployeeScreens/DeletedAppointmentScreen.dart';
import '../EmployeeScreens/EndedAppointmentScreen.dart';
import '../EmployeeScreens/AcceptedAppointmentFromDoctorScreen.dart';
import '../../Forms/ConstantIP.dart';
 
class EmployeePageSeeAppointment extends StatefulWidget {
    static const routeName = '/EmployeePageSeeAppointment';

  @override
  _EmployeePageSeeAppointmentState createState() => _EmployeePageSeeAppointmentState();
}

class _EmployeePageSeeAppointmentState extends State<EmployeePageSeeAppointment> {
    var _currentEmail;
     bool isSignIn = false;
           final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();



     getPrefrences() async {
    SharedPreferences prefrences = await SharedPreferences.getInstance();
    setState(
      () {
        _currentEmail = prefrences.getString("email");
      },
    );
    if (_currentEmail != null) {
      setState(
        () {
          isSignIn = true;
          _currentEmail = prefrences.getString("email");
        },
      );
    }
  }

  Future getWorkingHours() async {
    getPrefrences();
    try {
      if(_currentEmail!=null){
      var data = {"email": _currentEmail};
      var url = "http://"+ipAdressValue+"/HCare/getNumberOfPatients.php";
      var response = await http.post(Uri.parse(url), body: data);
      var responsebody = jsonDecode(response.body);
      if (responsebody['status'] == "success") {
        return responsebody;
      }
      }
    } catch (e) {
      print("Exception");
    }
  }


  @override
  void initState(){
  getPrefrences();
  /*FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //print('Got a message whilst in the foreground!');
    //print('Message data: ${message.data}');

    if (message.notification != null) {
      //print('Message also contained a notification: ${message.notification}');
      completeDonecorrect(context, "", message.notification.toString());
    }
  });*/




  _firebaseMessaging.configure(

      onMessage: (Map<String, dynamic> message) async {
        // print("onMessage: $message");
        // print(message['notification']['title']);
        completeDonecorrect(context, message['notification']['title'], message['notification']['body']);
        // _showItemDialog(message);
      },
      // onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        // _navigateToItemDetail(message);
      },
      // onResume: (Map<String, dynamic> message) async {
      //   print("onResume: $message");
      //   // _navigateToItemDetail(message);
      // },
    );
  super.initState();
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
                   
                  },
                  child: Text("OK"))
            ],
          );
        });
  }



  @override
  Widget build(BuildContext context) {
      //  var getWidth = MediaQuery.of(context).size.width;
      //  var getHeight = MediaQuery.of(context).size.height;
    return Scaffold(
       backgroundColor: Color(0xffF3F6FF),
      appBar: AppBar(
        title: Text('Homepage'),
        backgroundColor: Theme.of(context).accentColor,
        elevation: 0.0,
        titleSpacing: 0,
        actions: <Widget>[
          FutureBuilder(
            future: getWorkingHours(),
            builder: (context, snapshot) {
              if(!snapshot.hasData)return Text("");
              return Container(
               margin: EdgeInsets.only(right: 8),
                child: Column(children: <Widget>[
                  
                  Text("Students"),

                  snapshot.data['patients']==null?Text(""):Text(snapshot.data['patients'].toString()),
                ],),
              );
            }
          )
        ],
      ),
        drawer: MainEmployeeDrawer(),
        body: SingleChildScrollView(
              child: Stack(
          children: <Widget>[

           Positioned(
              top: -100.0,
              left: -10.0,
              child: Transform.rotate(
                angle: 15.0,
                child: Container(
                  height: 350.0,
                  width: 350.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60.0),
                    gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [Colors.green, Colors.blue]),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 18.0, right: 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                
                  Container(
                    padding: EdgeInsets.only(top: 16.0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 30),
                        Row(
                          children: <Widget>[
                            Expanded(
                              
                              child: Stack(
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: (){
                                        Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) {
                                  return AcceptedAppointmentScreen();
                                },
                              ),
                            ); 
                                    },
                                                                      child: ClipRect(
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                          sigmaX: 10.0,
                                          sigmaY: 10.0,
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                              color: Color(0x89545782)),
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.only(
                                              left: 40.0, right: 40.0),
                                          child: Column(
                                            children: <Widget>[
                                              SizedBox(
                                                height: 40.0,
                                              ),
                                              CircleAvatar(
                                                radius: 30.0,
                                                backgroundColor: Color(0xFF1fa2f5),
                                                child: Icon(
                                                  Icons.feedback,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              Text(
                                                'Requested Private sessions',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13.0,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20.0,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            Expanded(
                              child: Stack(
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: (){
                                        Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) {
                                  return AcceptedAppointmentFromDoctorScreen();
                                },
                              ),
                            );  
                                    },
                                                                      child: ClipRect(
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                          sigmaX: 10.0,
                                          sigmaY: 10.0,
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                              color: Color(0x89545782)),
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.only(
                                              left: 40.0, right: 40.0),
                                          child: Column(
                                            children: <Widget>[
                                              SizedBox(
                                                height: 40.0,
                                              ),
                                              CircleAvatar(
                                                radius: 30.0,
                                                backgroundColor: Colors.yellow[800],
                                                child: Icon(
                                                  Icons.feedback,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              Text(
                                                'Accepted Private sessions',
                                                style: TextStyle(
                                                   color: Colors.white,
                                                  fontSize: 13.0,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20.0,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.0),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Stack(
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: (){
                                        Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) {
                                  return DeletedAppointmentScreen();
                                },
                              ),
                            );
                                    },
                                                                      child: ClipRect(
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                          sigmaX: 10.0,
                                          sigmaY: 10.0,
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                              color: Color(0x89545782)),
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.only(
                                              left: 40.0, right: 40.0),
                                          child: Column(
                                            children: <Widget>[
                                              SizedBox(
                                                height: 40.0,
                                              ),
                                              CircleAvatar(
                                                radius: 30.0,
                                                backgroundColor: Color(0xFFff47e1),
                                                child: Icon(
                                                  Icons.feedback,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              Text(
                                                'Deleted Private sessions',
                                                style: TextStyle(
                                                   color: Colors.white,
                                                  fontSize: 13.0,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20.0,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 20.0),
                            Expanded(
                              child: Stack(
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: (){
                                        Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) {
                                  return EndedAppointmentScreen();
                                },
                              ),
                            );
                                    },
                                                                      child: ClipRect(
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                          sigmaX: 10.0,
                                          sigmaY: 10.0,
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                              color: Color(0x89545782)),
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.only(
                                              left: 40.0, right: 40.0),
                                          child: Column(
                                            children: <Widget>[
                                              SizedBox(
                                                height: 40.0,
                                              ),
                                              CircleAvatar(
                                                radius: 30.0,
                                                backgroundColor: Colors.cyan,
                                                child: Icon(
                                                  Icons.feedback,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              Text(
                                                'Expired Requests',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13.0,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20.0,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.0),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

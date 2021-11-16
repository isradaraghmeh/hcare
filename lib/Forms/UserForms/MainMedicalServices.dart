// @dart=2.9
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// import '../UserWidgets/doctor_details.dart';
import '../../Screens/UserScreens/HomeNursingScreen.dart';
import '../../Screens/UserScreens/GeneralMedicineScreen.dart';
import '../../Screens/UserScreens/NaturalTherpayScreen.dart';
import '../../Screens/UserScreens/OccupationalTherpayScreen.dart';


class MainMedicalServices extends StatefulWidget {
  @override
  _MainMedicalServicesState createState() => _MainMedicalServicesState();
}

class _MainMedicalServicesState extends State<MainMedicalServices> {
      final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();




  @override
  void initState() {
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
    var getWidth = MediaQuery.of(context).size.width;
    var getHeight = MediaQuery.of(context).size.height;

    final isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(
          left: getWidth * 0.1,
          top: isLandScape ? getHeight * 0.08 : getHeight * 0.04,
        ),
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              child: FlatButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder:(context)=>HomeNursingScreen(),),);
                },
                padding: EdgeInsets.all(0),
                child: Stack(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(getWidth * 0.05),
                      ),
                      child: Image.asset(
                        'assets/images/English.jpg',
                        height: isLandScape ? getWidth * 0.4 : getHeight * 0.3,
                        width: isLandScape ? getWidth * 0.7 : getWidth * 0.8,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(getWidth * 0.05),
                          bottomRight: Radius.circular(getWidth * 0.05),
                        ),
                        child: Container(
                          color: Colors.black54,
                          padding: EdgeInsets.symmetric(
                            vertical: getHeight * 0.02,
                            //  horizontal: getWidth*0.1,
                          ),
                          child: Center(
                            child: Text(
                              'English',
                              style: TextStyle(
                                fontSize: isLandScape
                                    ? getWidth * 0.04
                                    : getWidth * 0.06,
                                color: Colors.white,
                              ),
                              softWrap: true,
                              overflow: TextOverflow.fade,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: isLandScape ? getWidth * 0.04 : getHeight * 0.02,
            ),
            Container(
              child: FlatButton(
                onPressed: () {
                   Navigator.push(context, MaterialPageRoute(builder:(context)=>OccupationalTherpayScreen(),),);
                },
                padding: EdgeInsets.all(0),
                child: Stack(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(getWidth * 0.05),
                      ),
                      child: Image.asset(
                        'assets/images/Math.jpg',
                        height: isLandScape ? getWidth * 0.4 : getHeight * 0.3,
                        width: isLandScape ? getWidth * 0.7 : getWidth * 0.8,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(getWidth * 0.05),
                          bottomRight: Radius.circular(getWidth * 0.05),
                        ),
                        child: Container(
                          color: Colors.black54,
                          padding: EdgeInsets.symmetric(
                            vertical: getHeight * 0.02,
                            //  horizontal: getWidth*0.1,
                          ),
                          child: Center(
                            child: Text(
                              'Math',
                              style: TextStyle(
                                fontSize: isLandScape
                                    ? getWidth * 0.04
                                    : getWidth * 0.06,
                                color: Colors.white,
                              ),
                              softWrap: true,
                              overflow: TextOverflow.fade,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: isLandScape ? getWidth * 0.04 : getHeight * 0.02,
            ),
            Container(
              child: FlatButton(
                onPressed: () {
                   Navigator.push(context, MaterialPageRoute(builder:(context)=>NaturalTherpayScreen(),),);
                },
                padding: EdgeInsets.all(0),
                child: Stack(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(getWidth * 0.05),
                      ),
                      child: Image.asset(
                        'assets/images/Arabic.jpg',
                        height: isLandScape ? getWidth * 0.4 : getHeight * 0.3,
                        width: isLandScape ? getWidth * 0.7 : getWidth * 0.8,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(getWidth * 0.05),
                          bottomRight: Radius.circular(getWidth * 0.05),
                        ),
                        child: Container(
                          color: Colors.black54,
                          padding: EdgeInsets.symmetric(
                            vertical: getHeight * 0.02,
                            //  horizontal: getWidth*0.1,
                          ),
                          child: Center(
                            child: Text(
                              'Arabic',
                              style: TextStyle(
                                fontSize: isLandScape
                                    ? getWidth * 0.04
                                    : getWidth * 0.06,
                                color: Colors.white,
                              ),
                              softWrap: true,
                              overflow: TextOverflow.fade,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: isLandScape ? getWidth * 0.04 : getHeight * 0.02,
            ),
            Container(
              child: FlatButton(
                onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder:(context)=>GeneralMedicineScreen(),),);
                },
                padding: EdgeInsets.all(0),
                child: Stack(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(getWidth * 0.05),
                      ),
                      child: Image.asset(
                        'assets/images/Science.jpg',
                        height: isLandScape ? getWidth * 0.4 : getHeight * 0.3,
                        width: isLandScape ? getWidth * 0.7 : getWidth * 0.8,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(getWidth * 0.05),
                          bottomRight: Radius.circular(getWidth * 0.05),
                        ),
                        child: Container(
                          color: Colors.black54,
                          padding: EdgeInsets.symmetric(
                            vertical: getHeight * 0.02,
                            //  horizontal: getWidth*0.1,
                          ),
                          child: Center(
                            child: Text(
                              'Science',
                              style: TextStyle(
                                fontSize: isLandScape
                                    ? getWidth * 0.04
                                    : getWidth * 0.06,
                                color: Colors.white,
                              ),
                              softWrap: true,
                              overflow: TextOverflow.fade,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: isLandScape ? getWidth * 0.04 : getHeight * 0.02,
            ),
          ],
        ),
      ),
    );
  }
}

// @dart=2.9
import 'package:HCare/Screens/AdminScreens/StudentsWallet.dart';
import 'package:flutter/material.dart';
import '../../Forms/AdminForms/MainAdminDrawer.dart';
import '../../Screens/AdminScreens/DeleteEmployeeScreen.dart';
import '../../Screens/AdminScreens/SelectAllCustomers.dart';
import '../../Screens/AdminScreens/AddAdminScreen.dart';
import '../../Screens/AdminScreens/AddEmployeeScreen.dart';
import '../../Screens/AdminScreens/AddCourseScreen.dart';
import '../../Screens/AdminScreens/DeleteAcceptedAppointmentsScreen.dart';
import 'DeleteCourseScreen.dart';

class MainAdminScreen extends StatefulWidget {
      static const routeName = '/MainAdminScreen';

  @override
  _MainAdminScreenState createState() => _MainAdminScreenState();
}

class _MainAdminScreenState extends State<MainAdminScreen> {
  @override
  Widget build(BuildContext context) {
    var getWidth = MediaQuery.of(context).size.width;
    var getHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        backgroundColor: Theme.of(context).accentColor,
        elevation: 0,
        titleSpacing: 0,
      ),
      drawer: MainAdminDrawer(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: getHeight * 0.05),
                width: getWidth * 0.8,
                child: FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SelectAllCustomers(),
                      ),
                    );
                  },
                  child: Text(
                    "Students",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                color:Colors.black26,
              ),
              Container(
                margin: EdgeInsets.only(top: getHeight * 0.05),
                width: getWidth * 0.8,
                child: FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DeleteEmployeeScreen(),
                      ),
                    );
                  },
                  child: Text(
                    "Teachers",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                color: Theme.of(context).accentColor,
              ),
              Container(
                margin: EdgeInsets.only(top: getHeight * 0.05),
                width: getWidth * 0.8,
                child: FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddEmployeeScreen(),
                      ),
                    );
                  },
                  child: Text(
                    "Add Teacher",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                color:Colors.black26,
              ),
                Container(
                margin: EdgeInsets.only(top: getHeight * 0.05),
                width: getWidth * 0.8,
                child: FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddAdminScreen(),
                      ),
                    );
                  },
                  child: Text(
                    "Add Admin",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                color: Theme.of(context).accentColor,
              ),
                 Container(
                margin: EdgeInsets.only(top: getHeight * 0.05),
                width: getWidth * 0.8,
                child: FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DeleteAcceptedAppointmentsScreen(),
                      ),
                    );
                  },
                  child: Text(
                    "Delete Accepted Private Session",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                color:Colors.black26,
              ),
              Container(
                margin: EdgeInsets.only(top: getHeight * 0.05),
                width: getWidth * 0.8,
                child: FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddCoursesScreen(),
                      ),
                    );
                  },
                  child: Text(
                    "Add Course",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                color:Theme.of(context).accentColor,
                //Colors.greenAccent[400],
                //Theme.of(context).accentColor,
              ),
              Container(
                margin: EdgeInsets.only(top: getHeight * 0.05),
                width: getWidth * 0.8,
                child: FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DeleteCourseScreen(),
                      ),
                    );
                  },
                  child: Text(
                    "Course",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                color:Colors.black26,
                //color: Theme.of(context).accentColor,
              ),
              Container(
                margin: EdgeInsets.only(top: getHeight * 0.05),
                width: getWidth * 0.8,
                child: FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StudentWalletScreens(),
                      ),
                    );
                  },
                  child: Text(
                    "Students Wallet",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                color: Theme.of(context).accentColor,
                //color:Colors.black26,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// @dart=2.9
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../EmployeeScreens/AcceptedAppointmentDetailsScreen.dart';
import '../../Forms/ConstantIP.dart';

class AcceptedAppointmentScreen extends StatefulWidget {
  @override
  _AcceptedAppointmentScreenState createState() =>
      _AcceptedAppointmentScreenState();
}

class _AcceptedAppointmentScreenState extends State<AcceptedAppointmentScreen> {
  var _currntemail = '';
  bool isSignIn = false;
  getPrefrences() async {
    SharedPreferences prefrences = await SharedPreferences.getInstance();
    setState(
      () {
        //
        _currntemail = prefrences.getString("email");
      },
    );
    if (_currntemail != null) {
      setState(
        () {
          isSignIn = true;
          _currntemail = _currntemail;
        },
      );
    }
  }

  @override
  void initState() {
    getPrefrences();
    //  getDataAbout();
    super.initState();
  }

  Future getDataAbout() async {
    try {
      var data = {"email": _currntemail};
      var url = "http://"+ipAdressValue+"/HCare/RequestedAppointment.php";
      var response = await http.post(Uri.parse(url), body: data);
      var responsebody = jsonDecode(response.body);
      if (responsebody['status'] == "success") {
        return responsebody['appintmetdelete'];
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future getDataAboutName(var email) async {
    try {
      var data = {"email": email};
      var url = "http://"+ipAdressValue+"/HCare/getDeleteName.php";
      var response = await http.post(Uri.parse(url), body: data);
      var responsebody = jsonDecode(response.body);
      if (responsebody['status'] == "success") {
        return responsebody;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future incrementpatients() async {
    try {
      var data = {"email": _currntemail};
      var url = "http://"+ipAdressValue+"/HCare/incrementpationt.php";
      var response = await http.post(Uri.parse(url), body: data);
      var responsebody = jsonDecode(response.body);
      if (responsebody['status'] == "success") {
        return;
        // print(responsebody['id']);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future sendAccept(id) async {
    try {
      //print(_currntemail);
      var data = {"id": id};
      var url = "http://"+ipAdressValue+"/HCare/SendFromRequestToConfirm.php";
      var response = await http.post(Uri.parse(url), body: data);
      var responsebody = jsonDecode(response.body);
      if (responsebody['status'] == "success") {
        completeDonecorrect(context, "Accept Private Session",
            "Accept Private Session done successfully");
        incrementpatients();
        // print(responsebody);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future sendDelete(id) async {
    try {
      //print(_currntemail);
      var data = {"id": id};
      var url = "http://"+ipAdressValue+"/HCare/SendFromRequestToDelete.php";
      var response = await http.post(Uri.parse(url), body: data);
      var responsebody = jsonDecode(response.body);
      if (responsebody['status'] == "success") {
        completeDonecorrect(context, "Delete Private Session",
            "Delete Private Session done successfully");
        // print(responsebody);
      }
    } catch (e) {
      print(e.toString());
    }
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
                  },
                  child: Text("OK"))
            ],
          );
        });
  }

  checkIfAccept(context, String title, String str,id) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(str),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                       sendAccept(id);
                                                              setState(() {});
                                                                 Navigator.of(context).pop();
                  // Navigator.pop(context);
                },
                child: Text("OK"),
              ),
               FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // Navigator.pop(context);
                },
                child: Text("Cancel"),
              ),
            ],

          );
        });
  }


    checkIfDelete(context, String title, String str,id) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(str),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                       sendDelete(id);
                                                              setState(() {});
                                                                 Navigator.of(context).pop();
                  // Navigator.pop(context);
                },
                child: Text("OK"),
              ),
               FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // Navigator.pop(context);
                },
                child: Text("Cancel"),
              ),
            ],

          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var getWidth = MediaQuery.of(context).size.width;
    var getHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      // resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Requested Private Session'),
        elevation: 0,
        titleSpacing: 0,
        backgroundColor: Theme.of(context).accentColor,
      ),

      body: SingleChildScrollView(
        child: Container(
          height: getHeight * 0.8,
          margin:
              EdgeInsets.only(top: getHeight * 0.05, bottom: getHeight * 0.05),
          child: FutureBuilder(
              future: getDataAbout(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, i) {
                      // return Text(snapshot.data[i]['date'] + "\n");
                      return FutureBuilder(
                          future: getDataAboutName(
                              snapshot.data[i]['customeremail']),
                          builder: (context, snapshot2) {
                            if (snapshot2.hasData) {
                              return Column(
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) {
                                            return PageDetail(
                                              dremail: snapshot.data[i]
                                                  ['dremail'],
                                              customeremail: snapshot.data[i]
                                                  ['customeremail'],
                                              date: snapshot.data[i]['date'],
                                              time: snapshot.data[i]['time'],
                                              city: snapshot.data[i]['city'],
                                              region: snapshot.data[i]
                                                  ['region'],
                                              locationdesc: snapshot.data[i]
                                                  ['locationdesc'],
                                              phone: snapshot.data[i]['phone'],
                                              casedesc: snapshot.data[i]
                                                  ['cases'],
                                              id: snapshot.data[i]['id'],
                                              customername:
                                                  snapshot2.data['name'],
                                            );
                                          },
                                        ),
                                      );
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          top: getHeight * 0.05),
                                      width: getWidth * 0.8,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            color:
                                                Theme.of(context).accentColor),
                                        boxShadow: [
                                          BoxShadow(
                                              blurRadius: 5,
                                              spreadRadius: -6,
                                              offset: Offset(0, 8),
                                              color:
                                                  Colors.white.withOpacity(0.4))
                                        ],
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Column(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Theme.of(context).accentColor,),
                                              padding: EdgeInsets.all(20),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                          "Private Session Request",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white70)),
                                                      //   Spacer(),
                                                      //   Icon(
                                                      //   Icons.details,
                                                      //   color: Colors.white,
                                                      //  )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(Icons.access_time,
                                                          color: Colors.white),
                                                      Text(
                                                          snapshot.data[i]
                                                                      ['date']
                                                                  .toString() +
                                                              ",    ",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white)),
                                                      Text(
                                                          snapshot.data[i]
                                                              ['time'],
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white)),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              color: Colors.white,
                                              padding: EdgeInsets.only(
                                                  bottom: 20,
                                                  left: 10,
                                                  right: 10,
                                                  top: 20),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 10.0),
                                                        child: Text(
                                                          snapshot2
                                                              .data['name'],
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ),
                                                      Spacer(),
                                                      Icon(
                                                        Icons.info,
                                                        color:
                                                          Theme.of(context).accentColor,
                                                      )
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 15.0),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          width: getWidth * 0.3,
                                                          child: FlatButton(
                                                            color:  Theme.of(context).accentColor,
                                                            onPressed: () {
                                                                checkIfAccept(context, "Accepted request", "You want to accept this request?",snapshot.data[i]['id']);
                                                                // setState(() {
                                                                  
                                                                // });
                                                            },
                                                            child: Text(
                                                                "Accept",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white)),
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15)),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 50,
                                                        ),
                                                        Container(
                                                          width: getWidth * 0.3,
                                                          child: FlatButton(
                                                            color:
                                                                Colors.black26,
                                                            onPressed: () {
                                                              checkIfDelete(context, "Deleted request", "You want to delete this request?",  snapshot.data[i]['id']);
                                                              // setState(() {});
                                                            },
                                                            child: Text(
                                                                "Decline",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white)),
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15)),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 15,),
                                  Divider(
                                    color: Colors.black45,
                                  ),
                                ],
                              );
                            }
                            return Text("");
                          });
                    },
                  );
                }
                return Container(
                  child: Text(""),
                  alignment: Alignment.topLeft,
                );
              }),
        ),
      ),
    );
  }
}

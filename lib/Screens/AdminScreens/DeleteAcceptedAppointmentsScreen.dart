// @dart=2.9
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../Forms/ConstantIP.dart';

class DeleteAcceptedAppointmentsScreen extends StatefulWidget {
  @override
  _DeleteAcceptedAppointmentsScreenState createState() =>
      _DeleteAcceptedAppointmentsScreenState();
}

class _DeleteAcceptedAppointmentsScreenState
    extends State<DeleteAcceptedAppointmentsScreen> {
  Future getDataAbout() async {
    try {
      var url = Uri.parse("http://" +
          ipAdressValue +
          "/HCare/GetAcceptedAppointmentToAdminDelete.php");
      var response = await http.post(url);
      var responsebody = jsonDecode(response.body);
      if (responsebody['status'] == "success") return responsebody['abouts'];
    } catch (e) {
      print(e.toString());
    }
  }

  Future sendAppointmentAcceptedToAdminDelete(dremail,customeremail,date,time) async {
    try {
      var data={'dremail':dremail,'customeremail':customeremail,'date':date,'time':time};
      var url = Uri.parse("http://" +
          ipAdressValue +
          "/HCare/AdminDeleteAppointmentAccepted.php");
      var response = await http.post(url,body: data);
      var responsebody = jsonDecode(response.body);
      if (responsebody['status'] == "success") {
        completeDonecorrect(context, "Delete Private session", "Delete private session done successfully");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  checkIfAccept(context, String title, String str, dremail,customeremail,date,time) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(str),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  setState(() {});
                  Navigator.of(context).pop();
                  sendAppointmentAcceptedToAdminDelete(dremail,customeremail,date,time);
                },
                child: Text("OK"),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Cancel"),
              ),
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
                  },
                  child: Text("OK"))
            ],
          );
        });
  }


  @override
  Widget build(BuildContext context) {
    // var getHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Delete Accepted Private Session"),
        titleSpacing: 0,
        elevation: 0,
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 30),
        child: FutureBuilder(
          future: getDataAbout(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Text("");
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, i) {
                return SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text(
                            "Student: " + snapshot.data[i]['customeremail']),
                        subtitle:
                        Container(
                          // alignment: Alignment.topLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                            
                             Text("Teacher: " + snapshot.data[i]['dremail']),
                             Text(snapshot.data[i]['date'].toString()),
                               Text(snapshot.data[i]['time'].toString()),
                          ],),
                        ),
                           
                        trailing: IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                              size: 30,
                            ),
                            onPressed: () {

                              checkIfAccept(context, "Delete Private Session", "Do you want to delete this private session", snapshot.data[i]['dremail'],snapshot.data[i]['customeremail'],snapshot.data[i]['date'],snapshot.data[i]['time']);
                        setState(() {});
                            }),
                      ),
                      Divider(
                        color: Theme.of(context).accentColor,
                      )
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

// @dart=2.9s
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../Forms/ConstantIP.dart';

class EndedAppointmentScreen extends StatefulWidget {
  @override
  _EndedAppointmentScreenState createState() =>
      _EndedAppointmentScreenState();
}

class _EndedAppointmentScreenState extends State<EndedAppointmentScreen> {
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
    //print(_currntemail);
    try {
      //print(_currntemail);
      var data = {"email": _currntemail};
      var url = "http://"+ipAdressValue+"/HCare/EndedAppointment.php";
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
    //print(_currntemail);
    try {
      //print(_currntemail);
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

  @override
  Widget build(BuildContext context) {
    var getHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Expiresd Requests'),
        titleSpacing: 0,
        elevation: 0,
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: SingleChildScrollView(
        child: Container(
            height: getHeight-getHeight*0.25,
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(top: getHeight * 0.05),
          padding: EdgeInsets.all(10),
        
        
          child: FutureBuilder(
              future: getDataAbout(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, i) {
                      // return Text(snapshot.data[i]['date'] + "\n");
                      return FutureBuilder(
                        future: getDataAboutName(snapshot.data[i]['customeremail']),
                        builder: (context,snapshot2){
                          if(snapshot2.hasData){
                              return    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // RaisedButton(onPressed: (){getDataAbout();},child:Text("HIIIIIIIIIIIIIII")),
 Container(
                                decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: Colors.grey[100]),  padding: EdgeInsets.only(top: 15,bottom: 15,right: 60,left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Name: "+snapshot2.data['name'],style: TextStyle(color: Theme.of(context).accentColor),),
                                  Text("Appointment date: " +
                                      snapshot.data[i]['date'].toString() +
                                      " " +
                                      snapshot.data[i]['time'],style: TextStyle(color: Theme.of(context).accentColor),),
                                  
                                ],
                              ),
                            ),
                          
                          //   Spacer(),

                          SizedBox(
                            height: 15,
                          ),
                          Divider(color: Colors.black),
                        ],
                      );
                          }
                          return Text("");
                        }
                        
                        );
                    },
                  );
                }
                return Container(child: Text(""),alignment: Alignment.topLeft,);
              }),

     
        ),
      ),
    );
  }
}

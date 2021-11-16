// @dart=2.9
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../Forms/ConstantIP.dart';

class PageDetailAccepted extends StatefulWidget {
  final dremail;
  final customeremail;
  final date;
  final time;
  final city;
  final region;
  final locationdesc;
  final phone;
  final casedesc;
  final id;
  final customername;
  PageDetailAccepted({Key key,@required this.dremail,@required this.customeremail,@required this.date,@required this.time, @required this.city, @required this.region, @required this.locationdesc, @required this.phone,@required this.casedesc,@required this.id,@required this.customername}):super(key:key);

  @override
  _PageDetailAcceptedState createState() => _PageDetailAcceptedState();
}

class _PageDetailAcceptedState extends State<PageDetailAccepted> {

  
  void userLauncher(command) async {
    try {
      if (await canLaunch(command)) {
        await launch(command);
      }
    } catch (e) {
      print(e.toString());
    }
  }
  Future getDataCheckEnd() async {
    try {
      var url = "http://"+ipAdressValue+"/HCare/EndedAppointmentchecktime.php";
        var response = await http.post(Uri.parse(url));
      var responsebody = jsonDecode(response.body);
      if(responsebody['status']=="success")return responsebody;
    } catch (e) {
      print(e.toString());
    }
  }
  @override
  void initState(){
    getDataCheckEnd();

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    //  var getWidth = MediaQuery.of(context).size.width;
    // var getHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
        titleSpacing: 0,
        backgroundColor:Theme.of(context).accentColor,
        title:
            Text("Private Session Request", style: TextStyle(color: Colors.white)),
        // actions: [
        //   IconButton(
        //       icon: Icon(Icons.details, color: Colors.white), onPressed: (){}),
        // ],
      ),
      body: SingleChildScrollView(
              child: Container(

          
          child: Column(
           // shrinkWrap: true,
            children: [
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 50.0),
                    child: Container(
                      padding: EdgeInsets.all(40),
                      height: 220,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(90))),
                      child: Text(
                        ((widget.date!=null) && (widget.time!=null))? widget.date.toString()+"\n"+widget.time:"",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 40,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Color(0Xff03DAF1)),
                            child: IconButton(icon: Icon(Icons.call, color: Colors.white),onPressed: (){
 var phoneToSend="tel:";
                  if(widget.phone!=null){phoneToSend=phoneToSend+widget.phone;}
                  userLauncher(phoneToSend);
                            },),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ), 
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.customername==null?"":widget.customername,
                        style:
                            TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
                  SizedBox(height: 20,),
                      
                   Row(children: <Widget>[
                     Icon(Icons.mail,color: Theme.of(context).accentColor,),
                     SizedBox(width: 10,),
                                       Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Text(widget.customeremail==null?"":widget.customeremail,
                            style: TextStyle(color: Colors.black87)),
                      ),],
                   ),
                   Row(children: <Widget>[  Icon(Icons.location_city,color: Theme.of(context).accentColor,),
                     SizedBox(width: 10,),
                                        Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Text(widget.city==null?"":"City: "+widget.city,
                            style: TextStyle(color: Colors.black87)),
                      ),],
                   ),
                     Row(children: <Widget>[
                        Icon(Icons.location_on,color: Theme.of(context).accentColor,),
                     SizedBox(width: 10,),
                                    Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Text(widget.region==null?"":"Region: "+widget.region,
                            style: TextStyle(color: Colors.black87)),
                    ),],
                     ),
                     Row(children: <Widget>[
                   Icon(Icons.description,color: Theme.of(context).accentColor,),
                     SizedBox(width: 10,),
                                         Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Text(widget.locationdesc==null?"":"Determine the location in detail: \n"+widget.locationdesc,
                            style: TextStyle(color: Colors.black87)),
                    ),],
                     ),
                     Row(children: <Widget>[
                         Icon(Icons.phone,color: Theme.of(context).accentColor,),
                     SizedBox(width: 10,),
                                             Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Text(widget.phone==null?"":"Phone: "+  widget.phone,
                            style: TextStyle(color: Colors.black87)),
                    ),],
                     ),
                     Row(children: <Widget>[
                            Icon(Icons.description,color: Theme.of(context).accentColor,),
                     SizedBox(width: 10,),
                                             Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Text(widget.casedesc==null?"":"Case description: \n"+ widget.casedesc,
                            style: TextStyle(color: Colors.black87)),
                    ),],
                     ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

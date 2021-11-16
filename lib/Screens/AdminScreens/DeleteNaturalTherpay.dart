// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../Forms/ConstantIP.dart';


class DeleteNaturalTherpay extends StatefulWidget {
  @override
  _DeleteNaturalTherpayState createState() => _DeleteNaturalTherpayState();
}

class _DeleteNaturalTherpayState extends State<DeleteNaturalTherpay> {
  
Future getDataAbout() async {
    try {
       var data={"id":"4"};
      var url = Uri.parse("http://"+ipAdressValue+"/HCare/SelectAllHomeNursing.php");
      var response = await http.post(url,body: data);
      var responsebody = jsonDecode(response.body);
      if (responsebody['status'] == "success") return responsebody['abouts'];
    } catch (e) {
      print(e.toString());
    }
  }

  Future getMoreDataAbout(email) async {
    try {
       var data={"email":email};
      var url = Uri.parse("http://"+ipAdressValue+"/HCare/SelectMoreHomeNursing.php");
      var response = await http.post(url,body: data);
      var responsebody = jsonDecode(response.body);
      if (responsebody['status'] == "success") return responsebody['abouts'];
    } catch (e) {
      print(e.toString());
    }
  }

   Future deleteDataAbout(email) async {
    try {
      var data={"email":email};
      var url = Uri.parse("http://"+ipAdressValue+"/HCare/DeleteCustomer.php");
      var response = await http.post(url,body: data);
      var responsebody = jsonDecode(response.body);
      if (responsebody['status'] == "success") {
        
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("All Arabic Teachers"),
       titleSpacing: 0,
      elevation: 0,
      backgroundColor: Theme.of(context).accentColor,),

      body:FutureBuilder(
        future:  getDataAbout(),
        builder: (context, snapshot) {
          if(!snapshot.hasData)return Text("");
              return ListView.builder(
                itemCount: snapshot.data.length,  
                itemBuilder: (context, i) {
                    return FutureBuilder(
                      future: getMoreDataAbout(snapshot.data[i]['email']),
                      builder: (context, snapshot2) {
                       if(!snapshot2.hasData)return Text("");
                              
          return Column(
                    children: <Widget>[
                      Slidable(
                          child: ListTile(
                           title: Text(snapshot.data[i]['firstname']+' '+snapshot.data[i]['lastname']),
                            subtitle: Text(snapshot.data[i]['email']),
                            leading: CircleAvatar(
                    radius: 30.0,
                    backgroundImage:
                        NetworkImage('http://'+ipAdressValue+'/HCare/upload/'+snapshot2.data['image']),
                    backgroundColor: Colors.transparent,
                  ),
                            trailing: Text("students="+snapshot2.data['patients'].toString()),
                            
                          ),
                          actionPane: SlidableDrawerActionPane(),
                          actionExtentRatio: 1 / 5,
                          secondaryActions: <Widget>[
                            IconSlideAction(
                              caption: "Delete",
                              color: Colors.redAccent,
                              icon: Icons.delete,
                              onTap: () {
                                deleteDataAbout(snapshot.data[i]['email']);
                                setState(() {
                                  
                                });
                              },
                            ),
                          ]),
                      Divider(
                        color: Theme.of(context).accentColor,
                        height: 1,
                      ),
                    ],
                  );

                      }
                    );
                }

              );


        }
      ),
    );
  }
}
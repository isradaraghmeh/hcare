// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../Forms/ConstantIP.dart';

class SelectAllCustomers extends StatefulWidget {
  @override
  _SelectAllCustomersState createState() => _SelectAllCustomersState();
}

class _SelectAllCustomersState extends State<SelectAllCustomers> {
Future getDataAbout() async {
    try {
       var data={"id":"1"};
      var url = Uri.parse("http://"+ipAdressValue+"/HCare/SelectAllHomeNursing.php");
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
    var getHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Students"),
        titleSpacing: 0,
        elevation: 0,
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: getHeight * 0.9,
          child: FutureBuilder(
            future: getDataAbout(),
            builder: (context, snapshot) {
              if(!snapshot.hasData)return Text("");
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, i) {
                     return Column(
                children: <Widget>[
                  Slidable(
                      child: ListTile(
                        title: Text(snapshot.data[i]['firstname']+' '+snapshot.data[i]['lastname']),
                        subtitle: Text(snapshot.data[i]['email']),
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
          ),
        ),
      ),
    );
  }
}

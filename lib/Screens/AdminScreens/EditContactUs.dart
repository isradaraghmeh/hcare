// @dart=2.9
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../Screens/AdminScreens/EditEmailContact.dart';
import '../../Screens/AdminScreens/EditJawwalContact.dart';
import '../../Screens/AdminScreens/EditOoredooContact.dart';
import '../../Screens/AdminScreens/EditPhoneContactUs.dart';
import '../../Forms/ConstantIP.dart';

class EditContactUs extends StatefulWidget {
  @override
  _EditContactUsState createState() => _EditContactUsState();
}

class _EditContactUsState extends State<EditContactUs> {
  // var _emailContact, _jawwalContact, _ooredooContact, _phoneContact, _idContact;

  Future getDataContact() async {
    try {
      
      var url = Uri.parse("http://"+ipAdressValue+"/HCare/ContactUsUser.php");
      var response = await http.post(url);
      var responsebody = jsonDecode(response.body);
      return responsebody;
    } catch (e) {
      print("Exception");
    }
  }

  @override
  void initState() {
    getDataContact();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var getHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Contact us information"),
        titleSpacing: 0,
        elevation: 0,
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: getDataContact(),
          builder: (context, snapshot) {
            if(snapshot.hasData){
            return Container(
              margin: EdgeInsets.only(top: getHeight * 0.04),
              child: Column(
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditEmailContact(
                              currentEmail: snapshot.data['email'], currentID: snapshot.data['id']),
                        ),
                      );
                    },
                    child: ListTile(
                      title: Text("Email"),
                      subtitle:
                          snapshot.data['email'] == null ? Text("") : Text(snapshot.data['email']),
                      trailing: Icon(Icons.edit),
                    ),
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditJawwalContact(
                              currentJawwal: snapshot.data['jawwal'],
                              currentID: snapshot.data['id']),
                        ),
                      );
                    },
                    child: ListTile(
                      title: Text("Jawwal"),
                      subtitle: snapshot.data['jawwal'] == null
                          ? Text("")
                          : Text(snapshot.data['jawwal']),
                      trailing: Icon(Icons.edit),
                    ),
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditOoredooContact(
                                currentOoredoo: snapshot.data['ooredoo'],
                                currentID: snapshot.data['id'])),
                      );
                    },
                    child: ListTile(
                      title: Text("Ooredoo"),
                      subtitle: snapshot.data['ooredoo'] == null
                          ? Text("")
                          : Text(snapshot.data['ooredoo']),
                      trailing: Icon(Icons.edit),
                    ),
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditPhoneContactUs(
                                currentPhone: snapshot.data['phone'],
                                currentID: snapshot.data['id'])),
                      );
                    },
                    child: ListTile(
                      title: Text("Phone"),
                      subtitle:
                           snapshot.data['phone'] == null ? Text("") : Text( snapshot.data['phone']),
                      trailing: Icon(Icons.edit),
                    ),
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                ],
              ),
            );
            }
            return Text("");
          }
        ),
      ),
    );
  }
}

// @dart=2.9
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../Screens/AdminScreens/Edithomenursingabout.dart';
import '../../Screens/AdminScreens/EditnaturaltherpayAbout.dart';
import '../../Screens/AdminScreens/Editoccuptionaltherpay.dart';
import '../../Screens/AdminScreens/EditGeneralMedicine.dart';
import '../../Forms/ConstantIP.dart';


class EditAboutCategory extends StatefulWidget {
  @override
  _EditAboutCategoryState createState() => _EditAboutCategoryState();
}


class _EditAboutCategoryState extends State<EditAboutCategory> {
  // var _homenursing, _occuptionaltherpay, _naturaltherpay, _generalmedicine;

  Future getDataContact() async {
    try {
      var url = Uri.parse("http://"+ipAdressValue+"/HCare/GetAllAboutCategory.php");
      var response = await http.post(url);
      var responsebody = jsonDecode(response.body);
     return responsebody;
      // print(responsebody);
      // setState(() {
      //   _homenursing = responsebody['hn'];
      //   _occuptionaltherpay = responsebody['ot'];
      //   _naturaltherpay = responsebody['nt'];
      //   _generalmedicine = responsebody['gm'];

      // });
    } catch (e) {
      print("Exception");
    }
  }

  @override
  void initState() {
    setState(() {
      
    });
    getDataContact();
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var getHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Edit category information"),
          titleSpacing: 0,
        elevation: 0,
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: getDataContact(),
          builder: (context, snapshot) {
            if(!snapshot.hasData)return Text("");
            return Container(
              margin: EdgeInsets.only(top: getHeight * 0.04),
              child: Column(
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                         setState(() {
                        
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Edithomenursingabout(currentValue: snapshot.data['hn'])
                        ),
                      );
                    },
                    child: ListTile(
                      title: Text("English"),
                     
                      trailing: Icon(Icons.edit),
                    ),
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  FlatButton(
                    onPressed: () {
                         setState(() {
                        
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>Editoccuptionaltherpay(currentValue:  snapshot.data['ot']),
                        ),
                      );
                    },
                    child: ListTile(
                      title: Text("Math"),
                    
                      trailing: Icon(Icons.edit),
                    ),
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  FlatButton(
                    onPressed: () {
                         setState(() {
                        
                      });
                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                            builder: (context) =>Editnaturaltherpay(currentValue:  snapshot.data['nt']),),
                      );
                    },
                    child: ListTile(
                      title: Text("Arabic"),
                    
                      trailing: Icon(Icons.edit),
                    ),
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  FlatButton(
                    onPressed: () {
                      setState(() {
                        
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>EditGeneralMedicine(currentValue:  snapshot.data['gm']),),
                      );
                    },
                    child: ListTile(
                      title: Text("Science"),
                     
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
        ),
      ),
    );
  }
}

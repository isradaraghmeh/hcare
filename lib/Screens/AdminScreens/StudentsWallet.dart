// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../Forms/ConstantIP.dart';

class StudentWalletScreens extends StatefulWidget {
  @override
  _StudentWalletScreensState createState() => _StudentWalletScreensState();
}

class _StudentWalletScreensState extends State<StudentWalletScreens> {
  int money = 20;
  var name,
      email,
      status;

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


  Future _saveMony() async {
    try {
      var data={"email":email,"coin":money.toString()};
      print(data);
      var url = Uri.parse("http://"+ipAdressValue+"/HCare/AddForWallet.php");
      var response = await http.post(url,body: data);
      var responsebody = jsonDecode(response.body);
      if (responsebody['status'] == "success") {
        status = responsebody['status'];
        Navigator.pop(context);
        setState(() {

        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void _settingModalBottomSheet(context, name){
    var getWidth = MediaQuery.of(context).size.width;
    var getHeight = MediaQuery.of(context).size.height;
    final isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc){
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState /*You can rename this!*/)
          {
            return Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(20),
                      topLeft: Radius.circular(20))
              ),
              child: new Wrap(
                children: <Widget>[

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center
                    , children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(radius: 25,
                          backgroundImage: NetworkImage(
                              'http://' + ipAdressValue +
                                  '/HCare/upload/user.png'),
                          backgroundColor: Colors.transparent),
                    ),
                  ],),
                  Container(
                    alignment: Alignment.center,
                    child: Text(name, style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text("Amount to save in wallet"),
                  ),
                  SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: InkWell(
                            onTap: () {
                              setState(() {
                                if (money != 0) {
                                  money -= 20;
                                }
                              });
                            },
                            child: CircleAvatar(
                              child: Icon(Icons.remove, color: Colors.white,),
                              radius: 20,
                              backgroundColor: Colors.grey,)),
                      ),
                      SizedBox(width: 10,),
                      Text("$money", style: TextStyle(
                          fontSize: 38, fontWeight: FontWeight.bold),),
                      SizedBox(width: 10,),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: InkWell(
                            onTap: (){
                              setState(() {
                                money += 20;
                              });
                            },
                            child: CircleAvatar(child: Icon(Icons.add, color: Colors.white,), radius: 20, backgroundColor: Colors.grey,)),
                      ),

                    ],
                  ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: getWidth * 0.1,
                            right: getWidth * 0.1, top: getHeight * 0.04),
                        width: getWidth * 0.75,
                        height: isLandScape == true
                            ? getHeight * 0.15
                            : getHeight * 0.1,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              isLandScape == true
                                  ? getHeight * 0.1
                                  : getHeight * 0.05,
                            ),
                          ),
                          highlightColor: Colors.black,
                          color: Theme.of(context).accentColor,
                          textColor: Colors.white,
                          child: Text(
                            'Save Money',
                            style: TextStyle(
                              fontSize: isLandScape == true
                                  ? getWidth * 0.04
                                  : getWidth * 0.05,
                            ),
                          ),
                          onPressed: _saveMony,

                          //onPressed:() {Navigator.pushReplacementNamed(context, MainAdminScreen.routeName);},
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          });
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    var getHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Students Wallet"),
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
                              ListTile(
                                onTap: (){
                                  name=snapshot.data[i]['firstname']+' '+snapshot.data[i]['lastname'];
                                  email = snapshot.data[i]['email'];
                                  _settingModalBottomSheet(context,name);
                                },
                                leading: CircleAvatar(backgroundImage: NetworkImage('http://'+ipAdressValue+'/HCare/upload/user.png'),backgroundColor: Colors.transparent),
                                title: RichText(text: TextSpan(children: [
                                  TextSpan(text: snapshot.data[i]['firstname']+' '+snapshot.data[i]['lastname']+'\n'),
                                  TextSpan(text: snapshot.data[i]['email'], style: TextStyle(fontSize: 14, color: Colors.grey))
                                ], style: TextStyle(color: Colors.black, fontSize: 18))),
                                trailing: Text("- \$"+snapshot.data[i]['wallet'], style: TextStyle(fontSize: 20),),
                              ),


                              /*ListTile(
                                title: Text(snapshot.data[i]['firstname']+' '+snapshot.data[i]['lastname']),
                                subtitle: Text(snapshot.data[i]['email']),
                              ),*/

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

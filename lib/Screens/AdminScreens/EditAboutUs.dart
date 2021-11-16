// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../Screens/AdminScreens/AddParagraph.dart';
import '../../Screens/AdminScreens/EditParagraphAbout.dart';
import '../../Forms/ConstantIP.dart';

class EditAboutUs extends StatefulWidget {
  @override
  _EditAboutUsState createState() => _EditAboutUsState();
}

class _EditAboutUsState extends State<EditAboutUs> {
  Future getDataAbout() async {
    try {
      var url = Uri.parse("http://"+ipAdressValue+"/HCare/AboutUsUser.php");
      var response = await http.post(url);
      var responsebody = jsonDecode(response.body);

      if (responsebody['status'] == "success") return responsebody['abouts'];
    } catch (e) {
      print(e.toString());
    }
  }
  Future deleteDataAbout(id) async {
    try {
      var data={"id":id};
      var url = Uri.parse("http://"+ipAdressValue+"/HCare/deleteIdAboutUs.php");
      var response = await http.post(url,body: data);
      var responsebody = jsonDecode(response.body);

      if (responsebody['status'] == "success") {
        setState(() {
          
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    var getWidth = MediaQuery.of(context).size.width;
    var getHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("About us text"),
          titleSpacing: 0,
        elevation: 0,
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: getHeight * 0.9,
           margin: EdgeInsets.only(top: getHeight * 0.05),
          child: FutureBuilder(
              future: getDataAbout(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Text("");
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, i) {
                    return Slidable(
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: getWidth * 0.05),
                              child: ListTile(
                                title: Text(snapshot.data[i]['aboutdetail']),
                              ),
                            ),
                            Divider(
                              color: Colors.black,
                              height: 1,
                            ),
                          ],
                        ),
                      ),
                      actionPane: SlidableDrawerActionPane(),
                      actionExtentRatio: 1 / 5,
                      secondaryActions: <Widget>[
                        IconSlideAction(
                          caption: "Edit",
                          color: Colors.black26,
                          icon: Icons.edit,
                          onTap: () {
                                 Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditParagraphAbout(currentValue: snapshot.data[i]['aboutdetail'], id: snapshot.data[i]['id'])
                      ),
                    );
                          },
                        ),
                        IconSlideAction(
                          caption: "Delete",
                          color: Colors.redAccent,
                          icon: Icons.delete,
                          onTap: () {
                            deleteDataAbout(snapshot.data[i]['id']);
                          },
                        ),
                      ],
                    );
                  },
                );
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddParagraph(),
                      ),
                    );
        },
        child: const Icon(Icons.add),
        backgroundColor: Theme.of(context).accentColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

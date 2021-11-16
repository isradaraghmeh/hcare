// @dart=2.9
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../Forms/ConstantIP.dart';



class AboutUsUserScreen extends StatefulWidget {
  @override
  _AboutUsUserScreenState createState() => _AboutUsUserScreenState();
}

class _AboutUsUserScreenState extends State<AboutUsUserScreen> {
  Future getDataAbout() async {
    try {
      var url = "http://"+ipAdressValue+"/HCare/AboutUsUser.php";
      var response = await http.post(Uri.parse(url));
      var responsebody = jsonDecode(response.body);
      if(responsebody['status']=="success")return responsebody['abouts'];
    } catch (e) {
      print(e.toString());
    }
  }


    @override
  void initState(){
    // getPrefrences();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var getWidth = MediaQuery.of(context).size.width;
    var getHeight = MediaQuery.of(context).size.height;
    var getAppHeight = AppBar().preferredSize.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('About us'),
        titleSpacing: 0,
        elevation: 0,
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(getHeight*0.05),),
              border: Border.all(width: getWidth*0.005,
                color: Theme.of(context).accentColor,
              ),
              
            ),
            margin: EdgeInsets.only(top: (getHeight - getAppHeight) * 0.05),
            padding: EdgeInsets.all(getHeight * 0.03),
            width: getWidth * 0.8,
            height: (getHeight - getAppHeight) * 0.8,
            child: FutureBuilder(
                future: getDataAbout(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, i) {
                        return Text(snapshot.data[i]['aboutdetail'] + "\n");
                      },
                    );
                  }
                  return Text("");
                }),
          ),
        ),
      ),
    );
  }
}

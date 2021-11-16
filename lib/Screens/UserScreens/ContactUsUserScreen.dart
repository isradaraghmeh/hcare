import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:shared_preferences/shared_preferences.dart';


// import '../../Screens/SignInScreen.dart';

class ContactUsUserScreen extends StatefulWidget {
  final emailContact,jawwalContact,ooredoocontact,phonecontact;
  ContactUsUserScreen({Key key,@required this.emailContact,@required this.jawwalContact,@required this.ooredoocontact,@required this.phonecontact}):super(key:key);
  @override
  _ContactUsUserScreenState createState() => _ContactUsUserScreenState();
}

class _ContactUsUserScreenState extends State<ContactUsUserScreen> {



    @override
  void initState(){
    super.initState();
  }



  void userLauncher(command) async {
    try {
      if (await canLaunch(command)) {
        await launch(command);
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
        title: Text('Contact us'),
           titleSpacing: 0,
        elevation: 0,
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: getHeight * 0.05),
          child: Column(
            children: <Widget>[
              RaisedButton(
                elevation: 0,
                hoverElevation: 0,
                focusElevation: 0,
                highlightElevation: 0,
                color: Colors.white,
                child: Container(
                  child: ListTile(
                    leading: Icon(
                      Icons.email,
                      color: Theme.of(context).accentColor,
                    ),
                    title: Text("Email"),
                    subtitle: widget.emailContact==null?Text(""): Text(widget.emailContact),
                  ),
                ),
                onPressed: () {
                  var emailToSend="mailto:";
                  if(widget.emailContact!=null){emailToSend=emailToSend+widget.emailContact;}
                  
                  userLauncher(emailToSend);
                },
              ),
              RaisedButton(
                elevation: 0,
                hoverElevation: 0,
                focusElevation: 0,
                highlightElevation: 0,
                color: Colors.white,
                child: Container(
                  child: ListTile(
                    leading: Icon(
                      Icons.phone_android,
                      color: Theme.of(context).accentColor,
                    ),
                    title: Text("Jawwal"),
                    subtitle: widget.jawwalContact==null?Text(""): Text(widget.jawwalContact),
                  ),
                ),
                onPressed: () {
                  var jawwalToSend="tel:";
                  if(widget.jawwalContact!=null){jawwalToSend=jawwalToSend+widget.jawwalContact;}
                  userLauncher(jawwalToSend);
                },
              ),
              RaisedButton(
                elevation: 0,
                hoverElevation: 0,
                focusElevation: 0,
                highlightElevation: 0,
                color: Colors.white,
                child: Container(
                  child: ListTile(
                    leading: Icon(
                      Icons.phone_android,
                      color: Theme.of(context).accentColor,
                    ),
                    title: Text("Ooredoo"),
                    subtitle: widget.ooredoocontact==null?Text(""): Text(widget.ooredoocontact),
                  ),
                ),
                onPressed: () {
                   var ooredooToSend="tel:";
                  if(widget.ooredoocontact!=null){ooredooToSend=ooredooToSend+widget.ooredoocontact;}
                  userLauncher(ooredooToSend);
                },
              ),
              RaisedButton(
                elevation: 0,
                hoverElevation: 0,
                focusElevation: 0,
                highlightElevation: 0,
                color: Colors.white,
                child: Container(
                  child: ListTile(
                    leading: Icon(
                      Icons.phone,
                      color: Theme.of(context).accentColor,
                    ),
                    title: Text("Phone"),
                    subtitle:widget.phonecontact==null?Text(""): Text(widget.phonecontact),
                  ),
                ),
                onPressed: () {
                  var phoneToSend="tel:";
                  if(widget.phonecontact!=null){phoneToSend=phoneToSend+widget.phonecontact;}
                  userLauncher(phoneToSend);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

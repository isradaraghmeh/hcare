// @dart=2.9
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import '../../Screens/SignInScreen.dart';
import '../../Forms/ConstantIP.dart';


class EditLastNameScreen extends StatefulWidget {
  final currentLastname;
  final currentEmail;
  EditLastNameScreen(
      {Key key, @required this.currentLastname, @required this.currentEmail})
      : super(key: key);
  @override
  _EditLastNameScreenState createState() => _EditLastNameScreenState();
}

class _EditLastNameScreenState extends State<EditLastNameScreen> {
   final _formKey = GlobalKey<FormState>();

  final _lastNameController = TextEditingController();
  var _lastName = '';


  //   getPrefrences() async {
  //   SharedPreferences prefrences = await SharedPreferences.getInstance();
  //   if ( prefrences.getString("firstname") == null && prefrences.getString("lastname") == null) {
  //     Navigator.push(
  //                     context,
  //                     MaterialPageRoute(
  //                       builder: (context) => SignInScreen(),
  //                     ),
  //                   );
  //   }

  // }



  @override
  void initState() {
    _lastNameController
      ..text = widget.currentLastname == null ? "" : widget.currentLastname;
      // getPrefrences();
    super.initState();
  }

  @override
  void dispose() {
    _lastNameController.dispose();
    super.dispose();
  }

  showFailedDialog(context, String title, String str) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(str),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK"))
            ],
          );
        });
  }

  completeDonecorrect(context, String title, String str) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(str),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                   
                  },
                  child: Text("OK"))
            ],
          );
        });
  }

  showLoaddingDialog(context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Row(
              children: <Widget>[
                Text("Loadding..."),
                CircularProgressIndicator(),
              ],
            ), 
          );
        });
  }

 Future<void> _pressSaveLastname() async {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState.save();
      try {
        showLoaddingDialog(context);
        var data = {
          "lastname": _lastName,
          "email": widget.currentEmail,
        };
        var url = "http://"+ipAdressValue+"/HCare/EdiLastnameUser.php";
        var response = await http.post(Uri.parse(url), body: data);
        var responsebody = jsonDecode(response.body);
        if (responsebody['status'] == "success") {
          SharedPreferences prefrences = await SharedPreferences.getInstance();
          prefrences.setString("lastname", _lastName);
          Navigator.of(context).pop();
          completeDonecorrect(
              context, "Edit lastname", "Edit lastname done successfully");
        } else {
          Navigator.of(context).pop();
          showFailedDialog(context, "Edit lastname", "Edit lastname failed");
        }
      } catch (e) {
        Navigator.of(context).pop();
        print(e.toString());
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    var getAppHeight = AppBar().preferredSize.height;
    var getWidth = MediaQuery.of(context).size.width;
    var getHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
                titleSpacing: 0,
        elevation: 0,
        title: Text("Edit last name"),
           backgroundColor: Theme.of(context).accentColor,
        actions: <Widget>[
          IconButton(
            iconSize: getAppHeight * 0.5,
            icon: Icon(Icons.save),
            onPressed: (){_pressSaveLastname();setState(() {
              
            });},
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(
          top: getHeight * 0.05,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text(
                  "Last name",
                  style: TextStyle(color: Theme.of(context).accentColor),
                ),
                subtitle: Container(
                  margin: EdgeInsets.only(top: getHeight * 0.02),
                  height: getHeight * 0.09,
                  child: TextFormField(
                    key: ValueKey('lastname'),
                    controller: _lastNameController,
                    textCapitalization: TextCapitalization.words,
                    enableSuggestions: false,
                    decoration: InputDecoration(
                      errorStyle: TextStyle(
                        fontSize: getWidth * 0.025,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                        ),
                      ),
                    ),
                    onSaved: (value) {
                      _lastName = value.trim();
                    },
                    validator: (value) {
                      if (value.isEmpty || value.trim().length < 3) {
                        return 'At least 3 characters';
                      }
                      return null;
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
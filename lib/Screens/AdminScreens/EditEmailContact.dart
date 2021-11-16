// @dart=2.9
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../Forms/ConstantIP.dart';

class EditEmailContact extends StatefulWidget {
  final currentEmail;
  final currentID;
  EditEmailContact(
      {Key key, @required this.currentEmail, @required this.currentID})
      : super(key: key);
  @override
  _EditEmailContactState createState() => _EditEmailContactState();
}

class _EditEmailContactState extends State<EditEmailContact> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  var _email = '';



  @override
  void initState() {
    _emailController
      ..text = widget.currentEmail == null ? "" : widget.currentEmail;
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
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

  Future<void> _pressSavePhone() async {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState.save();
      try {
        showLoaddingDialog(context);
        var data = {
          "id": widget.currentID,
          "email": _email,
        };
        var url = Uri.parse("http://"+ipAdressValue+"/HCare/EditContactUsEmail.php");
        var response = await http.post(url, body: data);
        var responsebody = jsonDecode(response.body);
        if (responsebody['status'] == "success") {
          Navigator.of(context).pop();
          completeDonecorrect(
              context, "Edit email", "Edit email done successfully");
        } else {
          Navigator.of(context).pop();
          showFailedDialog(context, "Edit email", "Edit email failed");
        }
      } catch (e) {
        Navigator.of(context).pop();
        print(e.toString());
      }
    }
  }
bool isEmail(String string) {
    const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    final regExp = RegExp(pattern);

    return regExp.hasMatch(string);
  }
  

  @override
  Widget build(BuildContext context) {
    var getAppHeight = AppBar().preferredSize.height;
    var getWidth = MediaQuery.of(context).size.width;
    var getHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit email"),
          titleSpacing: 0,
        elevation: 0,
        backgroundColor: Theme.of(context).accentColor,
        actions: <Widget>[
          IconButton(
            iconSize: getAppHeight * 0.5,
            icon: Icon(Icons.save),
            onPressed: (){_pressSavePhone();setState(() {
              
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
                  "Email",
                  style: TextStyle(color: Theme.of(context).accentColor),
                ),
                subtitle: Container(
                  margin: EdgeInsets.only(top: getHeight * 0.02),
                  height: getHeight * 0.09,
                  child: TextFormField(
                    key: ValueKey('phone'),
                    controller: _emailController,
                    textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.emailAddress,
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
                      _email = value.trim();
                    },
                    validator: (value) {
                      if (!isEmail(value.trim()) ||value.isEmpty ) {
                        return 'Email should not empty';
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
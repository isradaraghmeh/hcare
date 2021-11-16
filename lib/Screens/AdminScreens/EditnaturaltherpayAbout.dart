// @dart=2.9
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../Forms/ConstantIP.dart';

class Editnaturaltherpay extends StatefulWidget {
  final currentValue;
  Editnaturaltherpay({Key key, @required this.currentValue}) : super(key: key);
  @override
  _EditnaturaltherpayState createState() => _EditnaturaltherpayState();
}

class _EditnaturaltherpayState extends State<Editnaturaltherpay> {
  final _formKey = GlobalKey<FormState>();
  final _valueController = TextEditingController();
  var _value = '';

  @override
  void initState() {
    _valueController
      ..text = widget.currentValue == null ? "" : widget.currentValue;
    super.initState();
  }

  @override
  void dispose() {
    _valueController.dispose();
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
          "value": _value,
        };
        var url = "http://"+ipAdressValue+"/HCare/EditNaturalTherpay.php";
        var response = await http.post(Uri.parse(url), body: data);
        var responsebody = jsonDecode(response.body);
        if (responsebody['status'] == "success") {
          Navigator.of(context).pop();
          completeDonecorrect(context, "Edit Arabic about",
              "Edit Arabic about done successfully");
        } else {
          Navigator.of(context).pop();
          showFailedDialog(context, "Edit Arabic about",
              "Edit Arabic about failed");
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
        title: Text("Edit Arabic about"),
          titleSpacing: 0,
        elevation: 0,
        backgroundColor: Theme.of(context).accentColor,
        actions: <Widget>[
          IconButton(
            iconSize: getAppHeight * 0.5,
            icon: Icon(Icons.save),
            onPressed: () {
              _pressSavePhone();
              setState(() {});
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
            top: getHeight * 0.05,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    "Arabic about",
                    style: TextStyle(color: Theme.of(context).accentColor),
                  ),
                  subtitle: Container(
                    margin: EdgeInsets.only(top: getHeight * 0.02),
                    // height: getHeight * 0.09,

                    child: TextFormField(
                      key: ValueKey('arabicabout'),
                      controller: _valueController,
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
                      maxLines: 15,
                      onSaved: (value) {
                        _value = value.trim();
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Arabic about should not empty';
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
      ),
    );
  }
}

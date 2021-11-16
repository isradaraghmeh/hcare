// @dart=2.9
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import '../../Screens/SignInScreen.dart';

// import '../../Screens/EmployeeScreens/EditEmployeeProfile.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import '../../Forms/ConstantIP.dart';


class EditEmployeePhoneNumber extends StatefulWidget {
   final currentPhone;
  final currentEmail;
  EditEmployeePhoneNumber(
      {Key key, @required this.currentPhone, @required this.currentEmail})
      : super(key: key);
  @override
  _EditEmployeePhoneNumberState createState() => _EditEmployeePhoneNumberState();
}

class _EditEmployeePhoneNumberState extends State<EditEmployeePhoneNumber> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  var _phone = '';


//  getPrefrences() async {
//     SharedPreferences prefrences = await SharedPreferences.getInstance();
//     if ( prefrences.getString("firstname") == null && prefrences.getString("lastname") == null) {
//       Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => SignInScreen(),
//                       ),
//                     );
//     }

//   }


  @override
  void initState() {
    _phoneController
      ..text = widget.currentPhone == null ? "" : widget.currentPhone;
      // getPrefrences();
    super.initState();
  }

  @override
  void dispose() {
    _phoneController.dispose();
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
                  //  Navigator.pop(context);
                  //   // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder:(c)=>EditUserProfile()), (route) => false);
                  //   Navigator.pushReplacement(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => EditEmployeeProfile(),
                  //     ),
                  //   );
                   // Navigator.pop(context);
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
          "phone": _phone,
          "email": widget.currentEmail,
        };
        var url = "http://"+ipAdressValue+"/HCare/EditEmployeePhoneNumber.php";
        var response = await http.post(Uri.parse(url), body: data);
        var responsebody = jsonDecode(response.body);
        if (responsebody['status'] == "success") {
          Navigator.of(context).pop();
          completeDonecorrect(
              context, "Edit phone", "Edit phone number done successfully");
        } else {
          Navigator.of(context).pop();
          showFailedDialog(context, "Edit phone", "Edit phone number failed");
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
        backgroundColor: Theme.of(context).accentColor,
        elevation: 0,
        titleSpacing: 0,
        title: Text("Edit phone number"),
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
                  "Phone number",
                  style: TextStyle(color: Theme.of(context).accentColor),
                ),
                subtitle: Container(
                  margin: EdgeInsets.only(top: getHeight * 0.02),
                  height: getHeight * 0.09,
                  child: TextFormField(
                    key: ValueKey('phone'),
                    controller: _phoneController,
                    textCapitalization: TextCapitalization.words,
                    keyboardType: TextInputType.number,
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
                      _phone = value.trim();
                    },
                    validator: (value) {
                      if (value.isEmpty ) {
                        return 'Phone number should not empty';
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
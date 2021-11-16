// @dart=2.9
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
import '../../Forms/ConstantIP.dart';
// import '../../Screens/EmployeeScreens/EditEmployeeProfile.dart';
// import '../../Screens/SignInScreen.dart';


class EditEmployeeSpecialist extends StatefulWidget {
   final currenSpecialist;
  final currentEmail;
  EditEmployeeSpecialist(
      {Key key, @required this.currenSpecialist, @required this.currentEmail})
      : super(key: key);
  @override
  _EditEmployeeSpecialistState createState() => _EditEmployeeSpecialistState();
}

class _EditEmployeeSpecialistState extends State<EditEmployeeSpecialist> {
   final _formKey = GlobalKey<FormState>();
  final _specialistController = TextEditingController();
  var _specialist = '';



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
    _specialistController
      ..text = widget.currenSpecialist == null ? "" : widget.currenSpecialist;
          // getPrefrences();
    super.initState();
  }

  @override
  void dispose() {
    _specialistController.dispose();
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

  Future<void> _pressSaveSpecialist() async {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState.save();
      try {
        showLoaddingDialog(context);
        var data = {
          "specialist": _specialist,
          "email": widget.currentEmail,
        };
        var url = "http://"+ipAdressValue+"/HCare/EditEmployeeSpecialist.php";
        var response = await http.post(Uri.parse(url), body: data);
        var responsebody = jsonDecode(response.body);
        if (responsebody['status'] == "success") {
          Navigator.of(context).pop();
          completeDonecorrect(
              context, "Edit specialist", "Edit specialist done successfully");
        } else {
          Navigator.of(context).pop();
          showFailedDialog(context, "Edit specialist", "Edit specialist failed");
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
        title: Text("Edit specialist"),
        backgroundColor: Theme.of(context).accentColor,
        elevation: 0,
        titleSpacing: 0,
        actions: <Widget>[
          IconButton(
            iconSize: getAppHeight * 0.5,
            icon: Icon(Icons.save),
            onPressed: (){_pressSaveSpecialist();setState(() {
              
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
                  "Specialist",
                  style: TextStyle(color: Theme.of(context).accentColor),
                ),
                subtitle: Container(
                  margin: EdgeInsets.only(top: getHeight * 0.02),
                  //height: getHeight * 0.09,
                  child: TextFormField(
                    maxLines: 4,
                    key: ValueKey('phone'),
                    controller: _specialistController,
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
                      _specialist = value.trim();
                    },
                    validator: (value) {
                      if (value.isEmpty ) {
                        return 'Specialist should not empty';
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
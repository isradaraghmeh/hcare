// @dart=2.9
import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../Forms/UserClasses/constants.dart';
import '../../Forms/ConstantIP.dart';




class ChangeAppointmentDetails2 extends StatefulWidget {
  final date,time,city,region,locationdesc,phonenumber,casedesc,name,id,cusphone;
  ChangeAppointmentDetails2({this.date,this.time,this.city,this.region,this.locationdesc,this.phonenumber,this.casedesc,this.name,this.cusphone,this.id});

  @override
  _ChangeAppointmentDetails2State createState() => _ChangeAppointmentDetails2State();
}

class _ChangeAppointmentDetails2State extends State<ChangeAppointmentDetails2> {
   List<String> list = ["Press to select sutible time"];
  // var _starValue, _endValue;
  var selectedDate;
  String dropdownValue;
  final _formKey = GlobalKey<FormState>();
  final _cityController = TextEditingController();
   final _regionController = TextEditingController();
   final _descController = TextEditingController(); 
   final _phoneController = TextEditingController();
    final _descCaseController = TextEditingController();
  var _city = '';
  var _region = '';
  var _description = '';
  var _phone='';   
  var _descriptionCase = '';
  var currentID;

  final _cityfocus = FocusNode();
  final _regionfocus = FocusNode();
  final _descfocus = FocusNode();
  final _phonefocus = FocusNode();
  final _desccasefocus = FocusNode();



  @override
  void initState() {
    setState(() {

    _cityController..text=widget.city==null?"":widget.city;
    _regionController..text=widget.region==null?"":widget.region;
    _descController..text=widget.locationdesc==null?"":widget.locationdesc;
     _phoneController..text=widget.phonenumber==null?"":widget.cusphone;

    _descCaseController..text=widget.casedesc==null?"":widget.casedesc;
          
    });
    setState(() {
      currentID= widget.id;
    });
    super.initState();
  
  }

  @override
  void dispose() {
    _cityController.dispose();
    _regionController.dispose();
    _descController.dispose();
    _phoneController.dispose();
    _descCaseController.dispose();
    _cityfocus.dispose();
    _regionfocus.dispose();
    _descfocus.dispose();
    _phonefocus.dispose();
    _desccasefocus.dispose();
    super.dispose();
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


 
  pressSaveChange()async{
     final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState.save();
   try {
      //print(_currntemail);
      var data = {"id": currentID, "city": _city,"region":_region,"locationdesc":_description,"phone":_phone,"cases":_descriptionCase};
      var url = "http://"+ipAdressValue+"/HCare/EditRequestAppointmentInfo2.php";
      var response = await http.post(Uri.parse(url), body: data);
      var responsebody = jsonDecode(response.body);
      if (responsebody['status'] == "success") {
                // print(responsebody);
        completeDonecorrect(context, "Edit request", "Edit request done successfully");

      //  return responsebody;
      }
    } catch (e) {
      print(e.toString());
    }
    }
  }


    
  @override
  Widget build(BuildContext context) {
    //  var getAppHeight = AppBar().preferredSize.height;
    var getWidth = MediaQuery.of(context).size.width;
    var getHeight = MediaQuery.of(context).size.height;
    final isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      appBar: AppBar(title: Text("Edit appointment"),backgroundColor: Theme.of(context).accentColor,titleSpacing: 0,elevation: 0,),
      
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.white,Color(0xFFBCCBF3)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                            SizedBox(height: getHeight*0.05,),
                    Text(widget.name==null?"":widget.name,style: TextStyle(color: mTitleTextColor, fontSize: 18,
                        fontWeight: FontWeight.bold,),),
                      SizedBox(height:10),
                      Container(
                        padding: EdgeInsets.only(top:5),
                        alignment: Alignment.centerLeft,
                        width: getWidth,
                        height: getHeight*0.08,
                        decoration:BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(getHeight*0.05),),
              border: Border.all(width: getWidth*0.005,
                color: Theme.of(context).accentColor,
              ),
              
            ),
            child: Column(children: <Widget>[
Text("Appointment date"+widget.date==null?"":"          Appointment date: "+widget.date.toString(),      style: TextStyle(color: mTitleTextColor, fontSize: 14, fontWeight: FontWeight.bold,),  ),
                    Text("Appointment time"+widget.time==null?"":"Appointment time: "+widget.time.toString(),  style: TextStyle(color: mTitleTextColor, fontSize: 14, fontWeight: FontWeight.bold,), ),
                  
            ],),
                      ),
                   
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Location',
                      style: TextStyle(
                        color: mTitleTextColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                            },
                            child: Column(
                              children: <Widget>[
                                Container(
                                  child: TextFormField(
                                    key: ValueKey('city'),
                                    controller: _cityController,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    enableSuggestions: false,
                                    decoration: InputDecoration(
                                    
                                      errorStyle: TextStyle(
                                        fontSize: getWidth * 0.025,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color:Theme.of(context).accentColor,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Theme.of(context).accentColor,
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
                                    textInputAction: TextInputAction.next,
                                    focusNode: _cityfocus,
                                    onFieldSubmitted: (_) {
                                      FocusScope.of(context)
                                          .requestFocus(_regionfocus);
                                    },
                                    onSaved: (value) {
                                      _city = value.trim();
                                    },
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter city';
                                      }
                                      return null;
                                    },
                                  ),
                                  height: getHeight * 0.1,
                                ),

                                SizedBox(
                                  height: 15,
                                ),

                                ///////////////////////////////////////////2
                                Container(
                                  child: TextFormField(
                                    key: ValueKey('region'),
                                    controller: _regionController,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    enableSuggestions: false,
                                    decoration: InputDecoration(
                                   
                                      errorStyle: TextStyle(
                                        fontSize: getWidth * 0.025,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Theme.of(context).accentColor,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color:Theme.of(context).accentColor,
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
                                    textInputAction: TextInputAction.next,
                                    focusNode: _regionfocus,
                                    onFieldSubmitted: (_) {
                                      FocusScope.of(context)
                                          .requestFocus(_descfocus);
                                    },
                                    onSaved: (value) {
                                      _region = value.trim();
                                    },
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter region';
                                      }
                                      return null;
                                    },
                                  ),
                                  height: getHeight * 0.1,
                                ),
                                SizedBox(
                                  height: 15,
                                ),

                                /////////////////////////////////////////3

                                Container(
                                  child: TextFormField(
                                    key: ValueKey('description'),
                                    controller: _descController,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    enableSuggestions: false,
                                    decoration: InputDecoration(
                                      
                                      errorStyle: TextStyle(
                                        fontSize: getWidth * 0.025,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color:Theme.of(context).accentColor,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Theme.of(context).accentColor,
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
                                    textInputAction: TextInputAction.next,
                                    focusNode: _descfocus,
                                    onFieldSubmitted: (_) {
                                      FocusScope.of(context)
                                          .requestFocus(_phonefocus);
                                    },
                                    onSaved: (value) {
                                      _description = value.trim();
                                    },
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter full description about your location';
                                      }
                                      return null;
                                    },
                                    maxLines: 3,
                                  ),
                                  // height: getHeight * 0.1,
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    ' Phone or mobile number',
                                    style: TextStyle(
                                      color: mTitleTextColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  child: TextFormField(
                                    key: ValueKey('phone'),
                                    controller: _phoneController,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    enableSuggestions: false,
                                    decoration: InputDecoration(
                                  
                                      errorStyle: TextStyle(
                                        fontSize: getWidth * 0.025,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Theme.of(context).accentColor,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color:Theme.of(context).accentColor,
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
                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.next,
                                    focusNode: _phonefocus,
                                    onFieldSubmitted: (_) {
                                      FocusScope.of(context)
                                          .requestFocus(_desccasefocus);
                                    },
                                    onSaved: (value) {
                                      _phone = value.trim();
                                    },
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter your phone to contact with us';
                                      }
                                      return null;
                                    },
                                  ),
                                  height: getHeight * 0.1,
                                ),

                                SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  child: Text(
                                    'Case Description',
                                    style: TextStyle(
                                      color: mTitleTextColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  alignment: Alignment.centerLeft,
                                ),
                                SizedBox(
                                  height: 20,
                                ),

                                Container(
                                  child: TextFormField(
                                    key: ValueKey('casedesc'),
                                    controller: _descCaseController,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    enableSuggestions: false,
                                    decoration: InputDecoration(
                                   
                                      errorStyle: TextStyle(
                                        fontSize: getWidth * 0.025,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Theme.of(context).accentColor,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Theme.of(context).accentColor,
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
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.done,
                                    focusNode: _desccasefocus,
                                    onFieldSubmitted: (_) {
                                     pressSaveChange();
                                     setState(() {});
                                    },
                                    onSaved: (value) {
                                      _descriptionCase = value.trim();
                                    },
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter full case description';
                                      }
                                      return null;
                                    },
                                    maxLines: 4,
                                  ),
                                  //     height: getHeight * 0.1,
                                ),
                                SizedBox(height: 30,),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          RaisedButton(
            color:  Color(0xFFBCCBF3),
            child: Container(
              color: Color(0xFFBCCBF3),
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(15),
                margin: isLandScape
                    ? EdgeInsets.only(right: 30, left: 30)
                    : EdgeInsets.only(bottom: 20, right: 30, left: 30),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Theme.of(context).accentColor,Theme.of(context).accentColor],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  color: Colors.blue,
                ),
                child: Center(
                  child: Text(
                    "Save changes",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'circe',
                        fontWeight: FontWeight.w700,
                        fontSize: 18),
                  ),
                ),
              ),
            ),
            onPressed:(){pressSaveChange();setState(() {});},
          ),
        ],
      ),
    );
  }
  }

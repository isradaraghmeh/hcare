// @dart=2.9
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import '../../Forms/UserClasses/constants.dart';
import '../../Forms/UserClasses/my_appbar.dart';
import '../../Forms/UserClasses/user_info.dart';
import '../../Forms/UserClasses/my_header.dart';
import '../../Forms/ConstantIP.dart';
// import '../../Screens/SignInScreen.dart';

class ReverseAppoinment extends StatefulWidget {
  final name,
      email,
      firsthour,
      lasthour,
      firsthour2,
      lasthour2,
      firsthour3,
      lasthour3,
      firsthour4,
      lasthour4,
      firsthour5,
      lasthour5,
      firsthour6,
      lasthour6,
      firsthour7,
      lasthour7,
      image;

  ReverseAppoinment(
      {this.name,
      this.email,
      this.firsthour,
      this.lasthour,
      this.firsthour2,
      this.lasthour2,
      this.firsthour3,
      this.lasthour3,
      this.firsthour4,
      this.lasthour4,
      this.firsthour5,
      this.lasthour5,
      this.firsthour6,
      this.lasthour6,
      this.firsthour7,
      this.lasthour7,
      this.image});
  @override
  _ReverseAppoinmentState createState() => _ReverseAppoinmentState();
}

class _ReverseAppoinmentState extends State<ReverseAppoinment> {
 

  List<String> list = ["Press to select sutible time"];
  var _starValue, _endValue;
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
  var _phone = '';
  var _descriptionCase = '';

  final _cityfocus = FocusNode();
  final _regionfocus = FocusNode();
  final _descfocus = FocusNode();
  final _phonefocus = FocusNode();
  final _desccasefocus = FocusNode();

  var _currentEmail;

  @override
  void initState() {
    list = ["Press to select sutible time"];
    getPrefrences();
    super.initState();
    //  print(_city);
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

  getPrefrences() async {
    SharedPreferences prefrences = await SharedPreferences.getInstance();
    setState(
      () {
        _currentEmail = prefrences.getString("email");
      },
    );
    if (_currentEmail != null) {
      setState(
        () {
          _currentEmail = _currentEmail;
        },
      );
    }
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

  Future<void> _pressMakeAppoinment() async {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (selectedDate == null) {
      showFailedDialog(context, "Error Date", "Error you should select date");
    } else if (list.length == 1) {
      showFailedDialog(context, "Error Date",
          "Choose other day because teacher not work in this day");
    } else if (dropdownValue == "Press to select sutible time" ||
        dropdownValue == '') {
      showFailedDialog(context, "Error Time", "Error you should select time");
    } else if (isValid) {
      _formKey.currentState.save();

      try {
        showLoaddingDialog(context);
        var data = {
          "dremail": widget.email,
          "customeremail": _currentEmail,
          "city": _city,
          "region": _region,
          "description": _description,
          "phone": _phone,
          "descriptionCase": _descriptionCase,
          'date': selectedDate,
          'time': dropdownValue
        };
        var url = "http://" + ipAdressValue + "/HCare/addappoinment.php";
        var response = await http.post(Uri.parse(url), body: data);
        var responsebody = jsonDecode(response.body);

        if (responsebody['status'] == "success") {
          Navigator.of(context).pop();
          showFailedDialog(
              context, "Private session success", "Private session done successfully");
          //print("YES");
          // savePrefrences(responsebody['firstname'], responsebody['lastname'], responsebody['email'], responsebody['password']);
          // Navigator.push(context, MaterialPageRoute(builder:(context)=>MainUserScreen(),),);
        } else if (responsebody['status'] == "failed") {
          Navigator.of(context).pop();
          showFailedDialog(context, "Private Session Failed",
              "Make Private Session failed because you have private session or you requested in this day and time");
        } else {
          Navigator.of(context).pop();
          showFailedDialog(
              context, "Private Session Failed", "Make Private Session failed becous not enough mony in your wallet");
          //print("NO");
        }
      } catch (e) {
        print("Exception");
      }

      // print(_city);
      // print(_region);
      // print(_description);
      // print(_phone);
      // print(_descriptionCase);
      // print(widget.email);

    }
  }

  String convertToTimeFormat(String str) {
    String resultConvert = '';
    if (str == '') return "";

    switch (str) {
      case "0.0":
        resultConvert = "00:00";
        break;
      case "0":
        resultConvert = "00:00";
        break;
      case "0.5":
        resultConvert = "00:30";
        break;
      case "1.0":
        resultConvert = "01:00";
        break;
      case "1":
        resultConvert = "01:00";
        break;
      case "1.5":
        resultConvert = "01:30";
        break;
      case "2.0":
        resultConvert = "02:00";
        break;
      case "2":
        resultConvert = "02:00";
        break;
      case "2.5":
        resultConvert = "02:30";
        break;
      case "3.0":
        resultConvert = "03:00";
        break;
      case "3":
        resultConvert = "03:00";
        break;
      case "3.5":
        resultConvert = "03:30";
        break;
      case "4.0":
        resultConvert = "04:00";
        break;
      case "4":
        resultConvert = "04:00";
        break;
      case "4.5":
        resultConvert = "04:30";
        break;
      case "5.0":
        resultConvert = "05:00";
        break;
      case "5":
        resultConvert = "05:00";
        break;
      case "5.5":
        resultConvert = "05:30";
        break;
      case "6.0":
        resultConvert = "06:00";
        break;
      case "6":
        resultConvert = "06:00";
        break;
      case "6.5":
        resultConvert = "06:30";
        break;
      case "7.0":
        resultConvert = "07:00";
        break;
      case "7":
        resultConvert = "07:00";
        break;
      case "7.5":
        resultConvert = "07:30";
        break;
      case "8.0":
        resultConvert = "08:00";
        break;
      case "8":
        resultConvert = "08:00";
        break;
      case "8.5":
        resultConvert = "08:30";
        break;
      case "9.0":
        resultConvert = "09:00";
        break;
      case "9":
        resultConvert = "09:00";
        break;
      case "9.5":
        resultConvert = "09:30";
        break;
      case "10.0":
        resultConvert = "10:00";
        break;
      case "10":
        resultConvert = "10:00";
        break;
      case "10.5":
        resultConvert = "10:30";
        break;
      case "11.0":
        resultConvert = "11:00";
        break;
      case "11":
        resultConvert = "11:00";
        break;
      case "11.5":
        resultConvert = "11:30";
        break;
      case "12.0":
        resultConvert = "12:00";
        break;
      case "12":
        resultConvert = "12:00";
        break;
      case "12.5":
        resultConvert = "12:30";
        break;
      case "13.0":
        resultConvert = "13:00";
        break;
      case "13":
        resultConvert = "13:00";
        break;
      case "13.5":
        resultConvert = "13:30";
        break;
      case "14.0":
        resultConvert = "14:00";
        break;
      case "14":
        resultConvert = "14:00";
        break;
      case "14.5":
        resultConvert = "14:30";
        break;
      case "15.0":
        resultConvert = "15:00";
        break;
      case "15":
        resultConvert = "15:00";
        break;
      case "15.5":
        resultConvert = "15:30";
        break;
      case "16.0":
        resultConvert = "16:00";
        break;
      case "16":
        resultConvert = "16:00";
        break;
      case "16.5":
        resultConvert = "16:30";
        break;
      case "17.0":
        resultConvert = "17:00";
        break;
      case "17":
        resultConvert = "17:00";
        break;
      case "17.5":
        resultConvert = "17:30";
        break;
      case "18.0":
        resultConvert = "18:00";
        break;
      case "18":
        resultConvert = "18:00";
        break;
      case "18.5":
        resultConvert = "18:30";
        break;
      case "19.0":
        resultConvert = "19:00";
        break;
      case "19":
        resultConvert = "19:00";
        break;
      case "19.5":
        resultConvert = "19:30";
        break;
      case "20.0":
        resultConvert = "20:00";
        break;
      case "20":
        resultConvert = "20:00";
        break;
      case "20.5":
        resultConvert = "20:30";
        break;
      case "21.0":
        resultConvert = "21:00";
        break;
      case "21":
        resultConvert = "21:00";
        break;
      case "21.5":
        resultConvert = "21:30";
        break;
      case "22.0":
        resultConvert = "22:00";
        break;
      case "22":
        resultConvert = "22:00";
        break;
      case "22.5":
        resultConvert = "22:30";
        break;
      case "23.0":
        resultConvert = "23:00";
        break;
      case "23":
        resultConvert = "23:00";
        break;
      case "23.5":
        resultConvert = "23:30";
        break;
    }
    return resultConvert;
  }

  @override
  Widget build(BuildContext context) {
    //  var getAppHeight = AppBar().preferredSize.height;
    var getWidth = MediaQuery.of(context).size.width;
    var getHeight = MediaQuery.of(context).size.height;
    final isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.white, Color(0xFFFFCC80)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MyHeader(
                      height: 250,
                      imageUrl: widget.image,
                      child: Column(
                        children: <Widget>[
                          MyAppbar(),
                          UserInfo(
                            name: widget.name,
                            image: widget.image,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            'Choose Date',
                            style: TextStyle(
                              color: mTitleTextColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              RaisedButton(
                                color: Colors.indigo[50],
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      "Select date",
                                      style: TextStyle(),
                                    ),
                                    SizedBox(width: 4),
                                    Icon(Icons.calendar_today),
                                  ],
                                ),
                                onPressed: () async {
                                  showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime(2023))
                                      .then(
                                    (value) {
                                      if (value != null) {
                                        setState(
                                          () {
                                            selectedDate =
                                                value.year.toString() +
                                                    '-' +
                                                    value.month.toString() +
                                                    '-' +
                                                    value.day.toString();

                                            if (value.weekday == 7) {
                                              setState(
                                                () {
                                                  _starValue = widget.firsthour;
                                                  _endValue = widget.lasthour;
                                                },
                                              );
                                            } else if (value.weekday == 1) {
                                              setState(
                                                () {
                                                  _starValue =
                                                      widget.firsthour2;
                                                  _endValue = widget.lasthour2;
                                                },
                                              );
                                            } else if (value.weekday == 2) {
                                              setState(
                                                () {
                                                  _starValue =
                                                      widget.firsthour3;
                                                  _endValue = widget.lasthour3;
                                                },
                                              );
                                            } else if (value.weekday == 3) {
                                              setState(
                                                () {
                                                  _starValue =
                                                      widget.firsthour4;
                                                  _endValue = widget.lasthour4;
                                                },
                                              );
                                            } else if (value.weekday == 4) {
                                              setState(
                                                () {
                                                  _starValue =
                                                      widget.firsthour5;
                                                  _endValue = widget.lasthour5;
                                                },
                                              );
                                            } else if (value.weekday == 5) {
                                              setState(
                                                () {
                                                  _starValue =
                                                      widget.firsthour6;
                                                  _endValue = widget.lasthour6;
                                                },
                                              );
                                            } else if (value.weekday == 6) {
                                              setState(
                                                () {
                                                  _starValue =
                                                      widget.firsthour7;
                                                  _endValue = widget.lasthour7;
                                                },
                                              );
                                            }

                                            dropdownValue = '';
                                          },
                                        );
                                        var start = double.parse(_starValue);
                                        var endr = double.parse(_endValue);

                                        list = [
                                          "Press to select sutible time"
                                        ]; //selectedDate='';
                                        //Navigator.pushRe(context, MaterialPageRoute(builder:(context)=>MakeAppoinment(),),);
                                        if (double.parse(_starValue) <
                                            double.parse(_endValue)) {
                                          for (double i = start;
                                              i <= endr;
                                              i = i + 0.5) {
                                            var result = i;
                                            // list.add(result.toString());
                                            if (convertToTimeFormat(
                                                    result.toString()) !=
                                                null) {
                                              list.add(convertToTimeFormat(
                                                  result.toString()));
                                            }
                                            list.sort();
                                          }
                                        } else if (double.parse(_starValue) >
                                            double.parse(_endValue)) {
                                          for (double i = start;
                                              i <= 23.5;
                                              i = i + 0.5) {
                                            var result = i;
                                            //  list.add(result.toString());
                                            if (convertToTimeFormat(
                                                    result.toString()) !=
                                                null) {
                                              list.add(convertToTimeFormat(
                                                  result.toString()));
                                            }
                                            list.sort();
                                          }
                                          for (double i = 0;
                                              i <= endr;
                                              i = i + 0.5) {
                                            var result = i;

                                            if (convertToTimeFormat(
                                                    result.toString()) !=
                                                null) {
                                              list.add(convertToTimeFormat(
                                                  result.toString()));
                                            }

                                            list.sort();
                                          }
                                        } else if (double.parse(_starValue) >
                                            double.parse(_endValue)) {
                                          list = [
                                            "Press to select sutible time"
                                          ];
                                        }

                                        list.removeWhere(
                                            (element) => element == '');
                                        list.sort();
                                        // print(list.length);

                                        //  setState(() {
                                        //    dropdownValue=_starValue;
                                        //  });
                                        //if(list.contains(dropdownValue))
                                        // print(list.contains(dropdownValue));
                                      }
                                    },
                                  );
                                },
                              ),
                              SizedBox(width: 8),
                              selectedDate == null
                                  ? Text("")
                                  : Text(selectedDate),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Choose Time',
                      style: TextStyle(
                        color: mTitleTextColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: <Widget>[
                        //         dropdownValue == null)
                        (list.length == 0 ||
                                list.isEmpty ||
                                list == null ||
                                dropdownValue == null ||
                                selectedDate == null)
                            ? Container(
                                width: 200,
                                color: Colors.white,
                                child: DropdownButton<String>(
                                  items: null,
                                  onChanged: null,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  iconSize: 24,
                                  elevation: 16,
                                ),
                              )
                            : Container(
                                width: 200,
                                color: Colors.indigo[50],
                                child: DropdownButton<String>(
                                  isExpanded: true,

                                  dropdownColor: Colors.white,
                                  //value: "Press to select sutible time",
                                  value: list.contains(dropdownValue)
                                      ? dropdownValue
                                      : "Press to select sutible time",
                                  icon: const Icon(Icons.arrow_drop_down),
                                  iconSize: 24,
                                  elevation: 16,
                                  style: const TextStyle(color: Colors.black),
                                  onChanged: (String newValue) {
                                    setState(() {
                                      // print(dropdownValue);
                                      dropdownValue = newValue;
                                    });
                                  },
                                  items: list.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text("" + value),
                                    );
                                  }).toList(),
                                ),
                              ),
                        dropdownValue == null ||
                                dropdownValue == "Press to select sutible time"
                            ? Text("")
                            : Text("   " + dropdownValue,
                                style: TextStyle(color: Colors.black)),
                      ],
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
                                      labelText: 'Enter your city',
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
                                      labelText:
                                          'Enter your region eg village name',
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
                                      labelText:
                                          'Enter full description about your location',
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
                                      labelText: 'Enter your phone number',
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
                                      labelText: 'Enter description case',
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
                                      _pressMakeAppoinment();
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
                                SizedBox(
                                  height: 30,
                                ),
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
            color: Color(0xFFFFCC80),
            child: Container(
              color: Color(0xFFFFCC80),
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(15),
                margin: isLandScape
                    ? EdgeInsets.only(right: 30, left: 30)
                    : EdgeInsets.only(bottom: 20, right: 30, left: 30),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).accentColor,
                      Theme.of(context).accentColor
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  color: Colors.blue,
                ),
                child: Center(
                  child: Text(
                    "Make an Private Session",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'circe',
                        fontWeight: FontWeight.w700,
                        fontSize: 18),
                  ),
                ),
              ),
            ),
            onPressed: _pressMakeAppoinment,
          ),
        ],
      ),
    );
  }
}

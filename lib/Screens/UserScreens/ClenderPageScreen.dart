// @dart=2.9
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import '../../Screens/UserScreens/ChangeAppointmentDetails2.dart';
import '../../Forms/ConstantIP.dart';


class CalenderPageScreen extends StatefulWidget {
  @override
  _CalenderPageScreenState createState() => _CalenderPageScreenState();
}

class _CalenderPageScreenState extends State<CalenderPageScreen> {
  var _currentDate;
  var _currntemail = '';
  // var _currentPhone = '';
  bool isRed = false;
  bool isSignIn = false;
  getPrefrences() async {
    SharedPreferences prefrences = await SharedPreferences.getInstance();
    setState(
      () {
        //
        _currntemail = prefrences.getString("email");
      },
    );
    if (_currntemail != null) {
      setState(
        () {
          isSignIn = true;
          _currntemail = _currntemail;
        },
      );
    }
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

  Future getDataAbout() async {
    try {
      //print(_currntemail);
      var data = {"email": _currntemail, "date": _currentDate};
      var url = "http://"+ipAdressValue+"/HCare/getAppointmentReserved.php";
      var response = await http.post(Uri.parse(url), body: data);
      var responsebody = jsonDecode(response.body);
      if (responsebody['status'] == "success") {
        return responsebody['abouts'];
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future getDataAboutEnd() async {
    try {
      //print(_currntemail);
      var data = {"email": _currntemail, "date": _currentDate};
      var url = "http://"+ipAdressValue+"/HCare/getAppointmentReservedEnd.php";
      var response = await http.post(Uri.parse(url), body: data);
      var responsebody = jsonDecode(response.body);
      if (responsebody['status'] == "success") {
        return responsebody['abouts'];
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future getDataAboutName(var email) async {
    try {
      var data = {"email": email};
      var url = "http://"+ipAdressValue+"/HCare/getDeleteName.php";
      var response = await http.post(Uri.parse(url), body: data);
      var responsebody = jsonDecode(response.body);
      if (responsebody['status'] == "success") {
        return responsebody;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  getDataPhoneNumber(var email) async {
    try {
      var data = {"email": email};
      var url = "http://"+ipAdressValue+"/HCare/getEditEmployeeInfo.php";
      var response = await http.post(Uri.parse(url), body: data);
      var responsebody = jsonDecode(response.body);
      if (responsebody['status'] == "success") {
        return responsebody;
        // setState(() {
        //   _currentPhone = responsebody['phone'];
        // });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future getDataCheckEnd() async {
    try {
      var url = "http://"+ipAdressValue+"/HCare/EndedAppointmentchecktime.php";
        var response = await http.post(Uri.parse(url));
      var responsebody = jsonDecode(response.body);
      if(responsebody['status']=="success")return responsebody;
    } catch (e) {
      print(e.toString());
    }
  }
 

  CalendarController _calendarController;
  @override
  void initState() {
    var now = new DateTime.now();
    setState(() {
      _currentDate = now.year.toString() +
          '-' +
          now.month.toString() +
          '-' +
          now.day.toString();
    });
    getPrefrences();
    super.initState();
        getDataCheckEnd();
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var getHeight = MediaQuery.of(context).size.height;
    var getWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor:   Theme.of(context).accentColor,
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0,
        
        backgroundColor: Colors.transparent,
        title: Text(
          "Select Date",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TableCalendar(
              calendarController: _calendarController,
              initialCalendarFormat: CalendarFormat.week,
              startingDayOfWeek: StartingDayOfWeek.sunday,
              formatAnimation: FormatAnimation.slide,
              headerStyle: HeaderStyle(
                centerHeaderTitle: true,
                formatButtonVisible: false,
                titleTextStyle: TextStyle(color: Colors.white, fontSize: 16),
                leftChevronIcon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 15,
                ),
                rightChevronIcon: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 15,
                ),
                leftChevronMargin: EdgeInsets.only(left: 70),
                rightChevronMargin: EdgeInsets.only(right: 70),
              ),
              calendarStyle: CalendarStyle(
                  weekendStyle: TextStyle(color: Colors.white),
                  weekdayStyle: TextStyle(color: Colors.white)),
              daysOfWeekStyle: DaysOfWeekStyle(
                  weekendStyle: TextStyle(color: Colors.white),
                  weekdayStyle: TextStyle(color: Colors.white)),
              onDaySelected: (day, events, holidays) {
                setState(() {
                  _currentDate = day.year.toString() +
                      '-' +
                      day.month.toString() +
                      '-' +
                      day.day.toString();
                });
              },
            ),
            SizedBox(
              height: 5,
            ),
            SingleChildScrollView(
                          child: Container(
                height: getHeight * 0.6,
                width: getWidth * 0.9,
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40)),
                      color: Colors.white),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: [
                            Text(
                              "Selected date " + _currentDate,
                              style: TextStyle(color: Theme.of(context).accentColor),
                            ),
                          ],
                        ),
                        Container(
                          height: getHeight * 0.5,
                          child: FutureBuilder(
                            future: getDataAbout(),
                            builder: (context, snapshot) {
                              // print(_currentDate);
                              if (snapshot.hasData) {
                                return ListView.builder(
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, i) {
                                    return FutureBuilder(
                                      future: getDataAboutName(
                                          snapshot.data[i]['dremail']),
                                      builder: (context, snapshot2) {
                                        if (snapshot2.hasData) {
                                          return FutureBuilder(
                                            future: getDataPhoneNumber(
                                                snapshot.data[i]['dremail']),
                                            builder: (context, snapshot3) {
                                              if (snapshot3.hasData) {

                                                return Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    Column(
                                                      children: [
                                                        dayTask(
                                                            snapshot.data[i]
                                                                ['time'],
                                                            snapshot2
                                                                .data['name'],
                                                        Theme.of(context).accentColor,
                                                            snapshot3.data[
                                                                'phone'],
                                                                 snapshot.data[i]
                                                              ['id'],
                                                          snapshot.data[i]
                                                              ['date'],
                                                          snapshot.data[i]
                                                              ['city'],
                                                          snapshot.data[i]
                                                              ['region'],
                                                          snapshot.data[i]
                                                              ['locationdesc'],
                                                          snapshot.data[i]
                                                              ['cases'],
                                                               snapshot.data[i]
                                                              ['phone'],
                                                                ),
                                                      ],
                                                    )
                                                  ],
                                                );
                                              }
                                              return Text("");
                                            },
                                          );
                                        }
                                        return Text("");
                                      },
                                    );
                                  },
                                );
                              }
                              return Text("");
                            },
                          ),
                        ),
              

                      ],
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  Row dayTask(String time, String name, Color color2, String phone, var id,
      var date, var city, var region, var locationdesc, var casedesc,String cusphone) {
    Color color=Colors.blue[50];
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       
        Expanded(
          child: Container(
            margin: EdgeInsets.only(bottom: 20),
            padding: EdgeInsets.all(20),
            color: color2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(color: color, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Appointment time',
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.timer,
                      color: color,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "$time",
                      style: TextStyle(
                          color: color,
                          fontSize: 13,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),

                SizedBox(
                  height: 5,
                ),
                Container(
                  height: 0.5,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 30,
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.call,
                          color: color,
                        ),
                        onPressed: () {
                          var phoneToSend = "tel:";
                          if (phone.toString() != null) {
                            phoneToSend = phoneToSend + phone.toString();
                          }
                          userLauncher(phoneToSend);
                        },
                      ),
                      // SizedBox(
                      //   width: 5,
                      // ),
                      IconButton(
                        icon: Icon(
                          Icons.mail_outline,
                          color: color,
                        ),
                        onPressed: () {
                          var smsToSend = "sms:";
                          if (phone.toString() != null) {
                            smsToSend = smsToSend + phone.toString();
                          }
                          userLauncher(smsToSend);
                        },
                      ),
                      Expanded(
                        child: Container(),
                      ),

                      
                      IconButton(icon: Icon(Icons.edit,color: color,), onPressed: (){
                       DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
                      DateTime dateTime = dateFormat.parse(date.toString()+" "+time+":00");
                      
                      if(!dateTime.isBefore(DateTime.now())){
                         Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChangeAppointmentDetails2(
                                name: name,
                                time: time,
                                region: region,
                                city: city,
                                date: date,
                                phonenumber: phone,
                                casedesc: casedesc,
                                locationdesc: locationdesc,
                                cusphone: cusphone,
                                id: id,
                              ),
                            ),
                          );
                      }
                      
                      
                      
                    
                       
                      }),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

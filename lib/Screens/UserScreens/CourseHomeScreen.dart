// @dart=2.9
/*import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

class CourseHomeScreen extends StatefulWidget {
  @override
  _CourseHomeScreenState createState() => _CourseHomeScreenState();
}

class _CourseHomeScreenState extends State<CourseHomeScreen> {
  int bottomTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned(
              left: 0,
              bottom: 0,
              right: 0,
              top: 0,
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
                      Colors.white,
                      Colors.green[50],
                      Colors.green[100],
                    ])),
              )),
          Positioned(
              left: 0,
              top: 64,
              right: 0,
              bottom: 64,
              child: Column(
                children: [
                  Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        /*child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "April, 21",
                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 16),
                                ),
                                Text(
                                  "Hi, Dreamwalker",
                                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Stack(children: [
                              CircleAvatar(
                                radius: 28,
                                backgroundImage: NetworkImage("https://avatars.githubusercontent.com/u/19484515?v=4"),
                              ),
                              Positioned(
                                  right: 0,
                                  top: 0,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.pink,
                                    radius: 8,
                                  )),
                            ])
                          ],
                        ),*/
                      )),
                  Expanded(
                      flex: 10,
                      child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: 240,
                                child: Card(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Row(
                                            children: [
                                              Text(
                                                "18:30",
                                                style: GoogleFonts.montserrat(fontSize: 36),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 4),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    //Text("Monday"),
                                                    Text(
                                                      "Today",
                                                      ),
                                                  ],
                                                ),
                                              ),
                                              Spacer(),
                                              Text.rich(TextSpan(children: [
                                                TextSpan(
                                                    text: "2",
                                                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                                                TextSpan(
                                                    text: "/12", style: TextStyle(fontSize: 16, color: Colors.grey))
                                              ]))
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 16),
                                          child: Row(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.green, borderRadius: BorderRadius.circular(4)),
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                                                  child: Text(
                                                    "Upcoming",
                                                    style: TextStyle(color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.green, borderRadius: BorderRadius.circular(4)),
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                                                  child: Text(
                                                    "Group",
                                                    style: TextStyle(color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.green, borderRadius: BorderRadius.circular(4)),
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                                                  child: Text(
                                                    "Today",
                                                    style: TextStyle(color: Colors.white),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 16, top: 8),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Our Brain And Empathy",
                                                style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.bold),
                                              ),
                                              Text(
                                                "OP group",
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                                          child: Row(
                                            children: [
                                              Expanded(child: Stack(
                                                children: [
                                                  Positioned(child: CircleAvatar()),
                                                  Positioned(
                                                      left: 24,
                                                      child: CircleAvatar()),
                                                  Positioned(
                                                      left: 48,
                                                      child: CircleAvatar()),
                                                  Positioned(
                                                      left: 72,
                                                      child: CircleAvatar()),
                                                ],
                                              )),
                                              Expanded(child: Align(
                                                alignment: Alignment.centerRight,
                                                child: Text(
                                                  "18:30 - 20:00",style: GoogleFonts.montserrat(
                                                    color: Colors.grey
                                                ),
                                                ),
                                              )),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          })),
                ],
              ))
        ],
      ),
    );
  }
}
*/
// @dart=2.9
import 'package:HCare/Forms/UserWidgets/course.dart';
import 'package:HCare/Forms/UserWidgets/flutter_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Forms/UserClasses/constants.dart';
import '../../Forms/UserWidgets/doctor.dart';
import '../../Forms/UserWidgets/doctor_card.dart';
import '../../Forms/ConstantIP.dart';
// import '../../Screens/SignInScreen.dart';

class CourseHomeScreen extends StatefulWidget{
  final doctorEmail;
  CourseHomeScreen({Key key, @required this.doctorEmail}):super(key:key);
  @override
  _CourseHomeScreenState createState() => _CourseHomeScreenState();
}

class _CourseHomeScreenState extends State<CourseHomeScreen> {
  var id,
      _currentEmail,
      name,
      startdate,
      enddate,
      admainemail,
      teacheremail,
      time,
      grade,
      roomname,
      casedescription,
      numberofstudent;

  var filterBy = 0;
  var filterStr = [ "By patients","By name    "];



  getPrefrences() async {
    SharedPreferences prefrences = await SharedPreferences.getInstance();
    setState(
          () {
        _currentEmail = prefrences.getString("email");
      },
    );
    if (_currentEmail != null ) {
      setState(
            () {
          _currentEmail = prefrences.getString("email");
        },
      );
    }
  }

  Future getCourseinfo() async {
    try {
      var data = {"teacheremail" : widget.doctorEmail};
      print(data);
      var url = "http://" + ipAdressValue + "/HCare/getcourse.php";
      var response = await http.post(Uri.parse(url),body: data);
      var responsebody = jsonDecode(response.body);
      print(responsebody['status']);
      if (responsebody['status'] == "success") {
        return responsebody['abouts'];
      }
      //  return responsebody;
    } catch (e) {
      print(e.toString());
    }
  }

  Future getHomeNursingDoctorMoreInfo(var emailf, var name) async {
    try {
      var data = {"emailf": emailf, "name": name, "types": "english"};
      var url = "http://" + ipAdressValue + "/HCare/NurseDoctorDetail.php";
      var response = await http.post(Uri.parse(url), body: data);
      var responsebody = jsonDecode(response.body);
      //print(responsebody['about']);
      return responsebody;
    } catch (e) {
      print(e.toString());
    }
  }
  Future getHomeNursingDoctorInfo() async {
    try {
      var url = "http://" + ipAdressValue + "/HCare/NurseDoctor.php";
      var response = await http.post(Uri.parse(url));
      var responsebody = jsonDecode(response.body);
      // print(responsebody);
      if (responsebody['status'] == "success") return responsebody['abouts'];
      //  return responsebody;
    } catch (e) {
      print(e.toString());
    }
  }
  getCurrentName(email) async {
    try {
      var data = {"email": email};
      var url = "http://" + ipAdressValue + "/HCare/getAuthenticationPage.php";
      var response = await http.post(Uri.parse(url), body: data);
      var responsebody = jsonDecode(response.body);
      if (responsebody['status'] == "success") {
        return responsebody;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    filterBy = 0;
    getPrefrences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var getWidth = MediaQuery.of(context).size.width;
    //var getHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Courses"),
        titleSpacing: 0,
        elevation: 0,
        backgroundColor: Theme.of(context).accentColor,
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 25.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.0),
                child: Row(
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "Learning City Services\n",
                            style: kTitleStyle.copyWith(
                              fontSize: 26.0,
                              color: kGrey2Color,
                            ),
                          ),
                          TextSpan(
                            text: "course",
                            style: kTitleStyle.copyWith(
                              fontSize: 26.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                width: double.infinity,
                height: 150.0,
                margin: EdgeInsets.symmetric(horizontal: 18.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.green[50],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 10.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "If you are having difficulty picking up outside your home.",
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                  fontSize: getWidth * 0.05,
                                  // fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                    ),
                    Image.asset(
                      "assets/teacher2.png",
                      fit: BoxFit.contain,
                    ),
                    SizedBox(width: 15.0),
                  ],
                ),
              ),
              SizedBox(height: 25.0),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0),
                  ),
                  color: Theme.of(context).accentColor,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("All Courses", style: kTitleStyle),
                        Spacer(),
                        /*FlatButton(
                          onPressed: () {
                            setState(() {
                              filterBy = 1 - filterBy;
                            });
                          },
                          child: Text(filterStr[filterBy]),
                          color: Colors.black26,
                          shape: RoundedRectangleBorder(side: BorderSide(color: Colors.white)),
                        ),*/
                        //    Text("See all", style: kSubtitleStyle),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //filterBy == 1
                        //?
                  FutureBuilder(
                      future: getCourseinfo(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) return Text("");
                        if (snapshot.connectionState ==
                            ConnectionState.waiting)
                          return Text("  Loadding ...  ");
                        //  return Text(snapshot.data.length.toString());
                        return ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, i) {
                            id= snapshot.data[i]['id'];
                            startdate= snapshot.data[i]['startdate'];
                            enddate= snapshot.data[i]['enddate'];
                            admainemail= snapshot.data[i]['admainemail'];
                            teacheremail= snapshot.data[i]['teacheremail'];
                            time= snapshot.data[i]['time'];
                            grade= snapshot.data[i]['grade'];
                            roomname= snapshot.data[i]['roomname'];
                            casedescription= snapshot.data[i]['casedescription'];
                            numberofstudent= snapshot.data[i]['numberofstudent'];


                            return FutureBuilder(
                              future: getCurrentName(widget.doctorEmail),
                              builder: (context, snapshot2) {
                                if (snapshot2.hasData) {
                                  name = snapshot2.data['firstname'] +
                                      " " +
                                      snapshot2.data['lastname'];
                                  print(name);
                                  print(startdate);
                                  print(enddate);
                                  print(admainemail);
                                  print(teacheremail);
                                  print(time);
                                  print(grade);
                                  print(roomname);
                                  print(casedescription);
                                  print(numberofstudent);

                                  var course = Course(
                                      name: name,
                                      startdate: startdate,
                                      enddate: enddate,
                                      admainemail: admainemail,
                                      teacheremail: teacheremail,
                                      time: time,
                                      grade: grade,
                                      roomname: roomname,
                                      casedescription: casedescription,
                                      numberofstudent: numberofstudent);

                                  if (startdate == null ||
                                      enddate == null ||
                                      name == null ||
                                      admainemail == null ||
                                      teacheremail == null ||
                                      time == null || roomname == null || casedescription == null ||
                                      grade == null) return Text("");
                                  return InkWell(
                                    child: CourseCard(course: course, studentemail: _currentEmail, courseid: id),
                                  );
                                }
                                return Text("");
                              },
                            );
                          },
                        );
                      },
                    )
                        /*: FutureBuilder(
                        future: getHomeNursingDoctorInfo(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting)
                            return Text("   Loadding ...    ");

                          if (snapshot.hasData) {
                            //Doctor doctor;

                            return ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, i) {
                                // setState(() {
                                name = snapshot.data[i]['firstname'] +
                                    " " +
                                    snapshot.data[i]['lastname'];
                                var email = snapshot.data[i]['email'];
                                //   print(email);
                                //});
                                //    return Text(name);
                                return FutureBuilder(
                                  future: getHomeNursingDoctorMoreInfo(
                                      email, name),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      //  setState(() {
                                      //        print(email);
                                      var namess = snapshot
                                          .data['name']; // print(namess);
                                      var emailff = snapshot.data['emailf'];

                                      // print(patients.runtimeType);
                                      //   print(about);

                                      //   });
                                      var course = Course(
                                          name: name,
                                          startdate: startdate,
                                          enddate: enddate,
                                          admainemail: admainemail,
                                          teacheremail: teacheremail,
                                          time: time,
                                          grade: grade,
                                          roomname: roomname,
                                          casedescription: casedescription,
                                          numberofstudent: numberofstudent);

                                      if (startdate == null ||
                                          enddate == null ||
                                          name == null ||
                                          admainemail == null ||
                                          teacheremail == null ||
                                          time == null || roomname == null || casedescription == null ||
                                          grade == null) return Text("");
                                      return InkWell(
                                        child: CourseCard(course: course),
                                      );
                                    }
                                    return Text("");
                                  },
                                );
                              },
                            );
                          }
                          return Text("");
                        }),*/
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

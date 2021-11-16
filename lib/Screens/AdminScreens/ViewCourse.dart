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
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
import '../../Forms/UserClasses/constants.dart';
import '../../Forms/UserWidgets/doctor.dart';
import '../../Forms/UserWidgets/doctor_card.dart';
import '../../Forms/ConstantIP.dart';
// import '../../Screens/SignInScreen.dart';

class ViewCourse extends StatefulWidget{
  final doctorEmail;
  ViewCourse({Key key, @required this.doctorEmail}):super(key:key);
  @override
  _ViewCourseState createState() => _ViewCourseState();
}

class _ViewCourseState extends State<ViewCourse> {
  var name,
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


  Future deleteDataAbout(email,casedescription) async {
    try {
      var data={"email":email , "casedescription":casedescription};
      var url = Uri.parse("http://"+ipAdressValue+"/HCare/DeleteCourse.php");
      print(data);
      var response = await http.post(url,body: data);
      var responsebody = jsonDecode(response.body);
      if (responsebody['status'] == "success") {

      }
    } catch (e) {
      print(e.toString());
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var getWidth = MediaQuery.of(context).size.width;
    //var getHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("View Course"),
        titleSpacing: 0,
        elevation: 0,
        backgroundColor: Theme.of(context).accentColor,
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder(
                        future:  getCourseinfo(),
                        builder: (context, snapshot) {
                          if(!snapshot.hasData)return Text("");
                          print(snapshot.data.length);
                          return ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, i) {
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
                                      if(!snapshot2.hasData)return Text("");
                                      name = snapshot2.data['firstname'] +
                                          " " +
                                          snapshot2.data['lastname'];

                                      return
                                        Column(
                                        children: <Widget>[
                                          Slidable(
                                              child: Card(
                                                elevation: 1.0,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(2.0)
                                                ),
                                                child: Container(
                                                  width: MediaQuery.of(context).size.width,
                                                  padding: EdgeInsets.symmetric(horizontal:3.0 ,vertical: 12.0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: <Widget>[
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Container(
                                                            width: 55,
                                                            height: 55,
                                                            child: CircleAvatar(
                                                              radius: 30.0,
                                                              backgroundImage: NetworkImage("http://"+ipAdressValue+"/HCare/upload/Teacher2.png"),
                                                              backgroundColor: Colors.green,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 5.0,
                                                          ),
                                                          Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                name,
                                                                style: TextStyle(
                                                                    fontSize: 16,
                                                                    fontWeight: FontWeight.bold,
                                                                    color: Colors.black),
                                                              ),
                                                              SizedBox(
                                                                height: 4.0,
                                                              ),
                                                              Text(
                                                                casedescription,
                                                                style:
                                                                TextStyle(fontSize: 12, color: Colors.black87),
                                                              ),
                                                              SizedBox(
                                                                height: 4.0,
                                                              ),
                                                              Text(
                                                                "number of Student: "+ numberofstudent ,
                                                                style:
                                                                TextStyle(fontSize: 12, color: Colors.black87),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      Container(
                                                        alignment: Alignment.center,
                                                        padding:
                                                        EdgeInsets.symmetric( vertical: 12.0),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: <Widget>[
                                                            FlatButton(
                                                              onPressed: () {
                                                                AwesomeDialog(
                                                                  context: context,
                                                                  dialogType: DialogType.INFO_REVERSED,
                                                                  borderSide:
                                                                  BorderSide(color: Colors.green, width: 2),
                                                                  width: 400,
                                                                  buttonsBorderRadius: BorderRadius.all(
                                                                    Radius.circular(2),
                                                                  ),
                                                                  headerAnimationLoop: false,
                                                                  animType: AnimType.BOTTOMSLIDE,
                                                                  title: 'Course information',
                                                                  desc:
                                                                  " Room : "+ roomname +"\n Grade : " + grade + "th \n start hour : " + time + "\n start date : " + startdate + " \n end date :  " + enddate ,
                                                                  showCloseIcon: true,
                                                                  btnOkOnPress: () {},
                                                                )..show();
                                                              },
                                                              shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(12),
                                                              ),
                                                              color: Colors.white,
                                                              child: Icon(
                                                                Icons.remove_red_eye_sharp,
                                                                size: 30,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              /*child: ListTile(
                                                title: Text(casedescription+'  '+roomname),
                                                subtitle: Text(grade+'  '+startdate+' -  '+enddate),
                                                leading: CircleAvatar(
                                                  radius: 30.0,
                                                  backgroundImage:
                                                  NetworkImage('http://'+ipAdressValue+'/HCare/upload/teacher2.png'),
                                                  backgroundColor: Colors.transparent,
                                                ),
                                                trailing: Text("students="+numberofstudent),

                                              ),*/
                                              actionPane: SlidableDrawerActionPane(),
                                              actionExtentRatio: 1 / 5,
                                              secondaryActions: <Widget>[
                                                IconSlideAction(
                                                  caption: "Delete",
                                                  color: Colors.redAccent,
                                                  icon: Icons.delete,
                                                  onTap: () {
                                                    deleteDataAbout(teacheremail,casedescription);
                                                    setState(() {

                                                    });
                                                  },
                                                ),
                                              ]),
                                          Divider(
                                            color: Theme.of(context).accentColor,
                                            height: 1,
                                          ),
                                        ],
                                      );

                                    }
                                );
                              }

                          );


                        }
                    ),

                    /*FutureBuilder(
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
                                    child: CourseCard(course: course),
                                  );
                                }
                                return Text("");
                              },
                            );
                          },
                        );
                      },
                    )*/
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
    );
  }
}

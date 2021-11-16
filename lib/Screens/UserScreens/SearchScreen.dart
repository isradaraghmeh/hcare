// @dart=2.9
import 'dart:convert';
import 'package:HCare/Forms/UserClasses/constants.dart';
import 'package:HCare/Forms/UserWidgets/course.dart';
import 'package:HCare/Forms/UserWidgets/flutter_card.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import 'package:HCare/Forms/ConstantIP.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class SearchCourse extends StatefulWidget {

  @override
  _SearchCourseState createState() => _SearchCourseState();
}

class _SearchCourseState extends State<SearchCourse> {
  var name,
      id,
      searchgrade,
      courseid,
      _currentEmail,
      startdate,
      enddate,
      admainemail,
      teacheremail,
      time,
      grade,
      roomname,
      casedescription,
      numberofstudent;

  Future getcoursegrade(searchgrade) async {
    try {
      var data = {"grade" : searchgrade};
      var url = "http://" + ipAdressValue + "/HCare/getcoursegrade.php";
      var response = await http.post(Uri.parse(url),body: data);
      var responsebody = jsonDecode(response.body);
      //print(responsebody['status']);
      if (responsebody['status'] == "success") {
        return responsebody['abouts'];
      }
      //  return responsebody;
    } catch (e) {
      print(e.toString());
    }
  }

  Future getCourseinfo(courseid) async {
    try {
      var data = {"id" : courseid};
      //print(data);
      var url = "http://" + ipAdressValue + "/HCare/getcoursestudentinfo.php";
      var response = await http.post(Uri.parse(url),body: data);
      var responsebody = jsonDecode(response.body);
      //print(responsebody['startdate']);
      //print(responsebody['status']);
      if (responsebody['status'] == "success") {
        return responsebody;
      }
      //  return responsebody;
    } catch (e) {
      print(e.toString());
    }
  }

  getCurrentName(email) async {
    try {
      var data = {"email": email};
      print(data);
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


  final myController = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var getWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          "Search",
          style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              fontFamily: ' Horizon'),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               //SizedBox(height: 25.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
              ),
              SizedBox(height: 25.0),
              Container(
                width: double.infinity,
                height: 40,
                margin: EdgeInsets.symmetric(horizontal: 18.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[100]),
                child: Stack(
                  children: <Widget>[
                    TextField(
                      controller: myController,
                      maxLengthEnforced: true,
                      style: GoogleFonts.openSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                      decoration: InputDecoration(
                        contentPadding:
                        EdgeInsets.only(left: 20, right: 50, bottom: 10),
                        border: InputBorder.none,
                        hintText: 'Enter your grade ',
                        hintStyle: GoogleFonts.openSans(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 2,
                      bottom: 2,
                      left: 290,
                      child: IconButton(
                        icon: const Icon(
                          Icons.search,
                          size: 32,
                        ),
                        onPressed: () {
                          setState(() {
                            searchgrade=myController.text;
                            print(searchgrade);
                          });
                        },
                      ),
                    )
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
                      future: getcoursegrade(searchgrade),
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
                              future: getCurrentName(teacheremail),
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
      /*body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/images/background.jpg',
                ),
                fit: BoxFit.fill)),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 25, top: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Choose your appointment course",
                    style: GoogleFonts.openSans(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                ],
              ),
            ),
            Container(
              height: 40,
              margin: EdgeInsets.only(top: 15, left: 22, right: 22),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[100]),
              child: Stack(
                children: <Widget>[
                  TextField(
                    controller: myController,
                    maxLengthEnforced: true,
                    style: GoogleFonts.openSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                    decoration: InputDecoration(
                      contentPadding:
                      EdgeInsets.only(left: 20, right: 50, bottom: 10),
                      border: InputBorder.none,
                      hintText: 'Enter your grade ',
                      hintStyle: GoogleFonts.openSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 2,
                    bottom: 2,
                    left: 290,
                    child: IconButton(
                      icon: const Icon(
                        Icons.search,
                        size: 32,
                      ),
                      onPressed: () {
                        setState(() {
                          searchgrade=myController.text;
                          print(searchgrade);
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              padding: EdgeInsets.only(left: 20),
              child: DefaultTabController(
                length: 1,
                child: TabBar(
                    labelPadding: EdgeInsets.all(0),
                    indicatorPadding: EdgeInsets.all(0),
                    isScrollable: true,
                    labelColor: Colors.green,
                    unselectedLabelColor: Colors.grey,
                    labelStyle: GoogleFonts.openSans(
                        fontSize: 19, fontWeight: FontWeight.w900),
                    unselectedLabelStyle: GoogleFonts.openSans(
                        fontSize: 19, fontWeight: FontWeight.w900),
                    tabs: [
                      Tab(
                        child: Container(
                          margin: EdgeInsets.only(right: 20),
                          child: Text(
                            "Course",
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
            FutureBuilder(
                future:  getcoursegrade(searchgrade),
                builder: (context, snapshot) {
                  if(!snapshot.hasData)return Text("");
                  print(snapshot.data[0]['teacheremail']);
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, i) {
                         /*FutureBuilder(
                            future: getCurrentName("Mohamed@gmail.com"),
                            builder: (context, snapshot2) {*/
                              /*if(!snapshot2.hasData)return Text("");
                              //print(snapshot2.data.lengt);

                                name = snapshot2.data['firstname'] +
                                    " " +
                                    snapshot2.data['lastname'];
                              print(name);*/
                              startdate= snapshot.data[i]['startdate'];
                              //print(startdate);
                              enddate= snapshot.data[i]['enddate'];
                              admainemail= snapshot.data[i]['admainemail'];
                              teacheremail= snapshot.data[i]['teacheremail'];
                              time= snapshot.data[i]['time'];
                              grade= snapshot.data[i]['grade'];
                              roomname= snapshot.data[i]['roomname'];
                              casedescription= snapshot.data[i]['casedescription'];
                              numberofstudent= snapshot.data[i]['numberofstudent'];
                              //print(numberofstudent);

                              return  Card(
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
                              );
                              /*ListTile(
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



                      }

                  );


                }
            ),
          ],
        ),
      ),*/
    );
  }
}

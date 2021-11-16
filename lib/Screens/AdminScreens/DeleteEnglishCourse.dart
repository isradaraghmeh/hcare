// @dart=2.9
import 'package:HCare/Forms/UserClasses/constants.dart';
import 'package:HCare/Forms/UserWidgets/admain_course_card.dart';
import 'package:HCare/Forms/UserWidgets/doctor.dart';
import 'package:HCare/Forms/UserWidgets/teacher_Admin_card.dart';
import 'package:HCare/Screens/AdminScreens/BookingCourseScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../Forms/ConstantIP.dart';

/*class AddEnglishCourse extends StatefulWidget {
  @override
  _AddEnglishCourseState createState() => _AddEnglishCourseState();
}

class _AddEnglishCourseState extends State<AddEnglishCourse> {

  var name,
      email,
      phone,
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
      specialist,
      experienceandcertifications,
      image,
      about,
      patients;

  var filterBy = 0;

  Future getHomeNursingInfo() async {
    try {
      var data = {"CategoryName": "English"};
      var url = "http://" + ipAdressValue + "/HCare/GetCategoryDescription.php";
      var response = await http.post(Uri.parse(url), body: data);
      var responsebody = jsonDecode(response.body);
      //print(responsebody['CategoryName'][0]);
      if (responsebody['status'] == "success") return responsebody['contacts'];
    } catch (e) {
      print("Exception");
    }
  }

  Future getHomeNursingDoctorInfo() async {
    try {
      var data = {"CategoryName": "English"};
      var url = "http://" + ipAdressValue + "/HCare/NurseDoctor.php";
      var response = await http.post(Uri.parse(url), body: data);
      var responsebody = jsonDecode(response.body);
      // print(responsebody);
      if (responsebody['status'] == "success") return responsebody['abouts'];
      //  return responsebody;
    } catch (e) {
      print(e.toString());
    }
  }

  Future getHomeNursingDoctorInfo2() async {
    try {
      var url = "http://" + ipAdressValue + "/HCare/NurseDoctor2.php";
      var response = await http.post(Uri.parse(url));
      var responsebody = jsonDecode(response.body);
      // print(responsebody);
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

  Future getDataAbout() async {
    try {
      var data={"id":"2"};
      var url = Uri.parse("http://"+ipAdressValue+"/HCare/SelectAllHomeNursing.php");
      var response = await http.post(url,body: data);
      var responsebody = jsonDecode(response.body);
      if (responsebody['status'] == "success") return responsebody['abouts'];
    } catch (e) {
      print(e.toString());
    }
  }

  Future getMoreDataAbout(email) async {
    try {
      var data={"email":email};
      var url = Uri.parse("http://"+ipAdressValue+"/HCare/SelectMoreHomeNursing.php");
      var response = await http.post(url,body: data);
      var responsebody = jsonDecode(response.body);
      if (responsebody['status'] == "success") return responsebody['abouts'];
    } catch (e) {
      print(e.toString());
    }
  }

  Future deleteDataAbout(email) async {
    try {
      var data={"email":email};
      var url = Uri.parse("http://"+ipAdressValue+"/HCare/DeleteCustomer.php");
      var response = await http.post(url,body: data);
      var responsebody = jsonDecode(response.body);
      if (responsebody['status'] == "success") {

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
    return Scaffold(
      appBar: AppBar(title:Text("All English Teachers"),
        titleSpacing: 0,
        elevation: 0,
        backgroundColor: Theme.of(context).accentColor,),

      body:FutureBuilder(
          future:  getDataAbout(),
          builder: (context, snapshot) {
            if(!snapshot.hasData)return Text("");
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, i) {
                  return FutureBuilder(
                      future: getMoreDataAbout(snapshot.data[i]['email']),
                      builder: (context, snapshot2) {
                        if(!snapshot2.hasData)return Text("");
                        return Column(
                          children: [
                            Row(
                              children: [
                                //Text("All Teachers", style: kTitleStyle),
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
                            filterBy == 1
                                ? FutureBuilder(
                              future: getHomeNursingDoctorInfo2(),
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
                                    var emailff = snapshot.data[i]['emailf'];

                                    return FutureBuilder(
                                      future: getCurrentName(emailff),
                                      builder: (context, snapshot2) {
                                        if (snapshot2.hasData) {
                                          name = snapshot2.data['firstname'] +
                                              " " +
                                              snapshot2.data['lastname'];

                                          email = snapshot2.data['email'];
                                          phone = snapshot.data[i]['phone'];
                                          firsthour =
                                          snapshot.data[i]['firsthour'];
                                          lasthour = snapshot.data[i]['lasthour'];
                                          firsthour2 =
                                          snapshot.data[i]['firsthour2'];
                                          lasthour2 =
                                          snapshot.data[i]['lasthour2'];
                                          firsthour3 =
                                          snapshot.data[i]['firsthour3'];
                                          lasthour3 =
                                          snapshot.data[i]['lasthour3'];
                                          firsthour4 =
                                          snapshot.data[i]['firsthour4'];
                                          lasthour4 =
                                          snapshot.data[i]['lasthour4'];
                                          firsthour5 =
                                          snapshot.data[i]['firsthour5'];
                                          lasthour5 =
                                          snapshot.data[i]['lasthour5'];
                                          firsthour6 =
                                          snapshot.data[i]['firsthour6'];
                                          lasthour6 =
                                          snapshot.data[i]['lasthour6'];
                                          firsthour7 =
                                          snapshot.data[i]['firsthour7'];
                                          lasthour7 =
                                          snapshot.data[i]['lasthour7'];

                                          specialist =
                                          snapshot.data[i]['specialist'];
                                          experienceandcertifications =
                                          snapshot.data[i]
                                          ['experienceandcertifications'];
                                          image = snapshot.data[i]['image'];
                                          about = snapshot.data[i]['about'];
                                          patients = snapshot.data[i]['patients'];
                                          var doctor = Doctor(
                                              name: name,
                                              phone: phone,
                                              email: emailff,
                                              specialist: specialist,
                                              experienceandcertifications:
                                              experienceandcertifications,
                                              firsthour: firsthour,
                                              lasthour: lasthour,
                                              firsthour2: firsthour2,
                                              lasthour2: lasthour2,
                                              firsthour3: firsthour3,
                                              lasthour3: lasthour3,
                                              firsthour4: firsthour4,
                                              lasthour4: lasthour4,
                                              firsthour5: firsthour5,
                                              lasthour5: lasthour5,
                                              firsthour6: firsthour6,
                                              lasthour6: lasthour6,
                                              firsthour7: firsthour7,
                                              lasthour7: lasthour7,
                                              patients: int.parse(patients),
                                              image: image,
                                              about: about);

                                          if (email == null ||
                                              phone == null ||
                                              name == null ||
                                              specialist == null ||
                                              experienceandcertifications ==
                                                  null ||
                                              image == null ||
                                              about == null) return Text("");
                                          return InkWell(
                                            child: TeacherAdminCard(doctor: doctor),
                                          );
                                        }
                                        return Text("");
                                      },
                                    );
                                  },
                                );
                              },
                            )
                                //:
                        /*FutureBuilder(
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
                                        email = snapshot.data[i]['email'];
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
                                              phone = snapshot.data['phone'];

                                              firsthour =
                                              snapshot.data['firsthour'];
                                              lasthour = snapshot.data['lasthour'];
                                              firsthour2 =
                                              snapshot.data['firsthour2'];
                                              lasthour2 =
                                              snapshot.data['lasthour2'];
                                              firsthour3 =
                                              snapshot.data['firsthour3'];
                                              lasthour3 =
                                              snapshot.data['lasthour3'];
                                              firsthour4 =
                                              snapshot.data['firsthour4'];
                                              lasthour4 =
                                              snapshot.data['lasthour4'];
                                              firsthour5 =
                                              snapshot.data['firsthour5'];
                                              lasthour5 =
                                              snapshot.data['lasthour5'];
                                              firsthour6 =
                                              snapshot.data['firsthour6'];
                                              lasthour6 =
                                              snapshot.data['lasthour6'];
                                              firsthour7 =
                                              snapshot.data['firsthour7'];
                                              lasthour7 =
                                              snapshot.data['lasthour7'];

                                              specialist =
                                              snapshot.data['specialist'];
                                              experienceandcertifications = snapshot
                                                  .data[
                                              'experienceandcertifications'];
                                              image = snapshot.data['image'];
                                              about = snapshot.data['about'];
                                              patients = snapshot.data['patients'];

                                              // print(patients.runtimeType);
                                              //   print(about);

                                              //   });
                                              var doctor = Doctor(
                                                  name: namess,
                                                  phone: phone,
                                                  email: emailff,
                                                  specialist: specialist,
                                                  experienceandcertifications:
                                                  experienceandcertifications,
                                                  firsthour: firsthour,
                                                  lasthour: lasthour,
                                                  firsthour2: firsthour2,
                                                  lasthour2: lasthour2,
                                                  firsthour3: firsthour3,
                                                  lasthour3: lasthour3,
                                                  firsthour4: firsthour4,
                                                  lasthour4: lasthour4,
                                                  firsthour5: firsthour5,
                                                  lasthour5: lasthour5,
                                                  firsthour6: firsthour6,
                                                  lasthour6: lasthour6,
                                                  firsthour7: firsthour7,
                                                  lasthour7: lasthour7,
                                                  patients: int.parse(patients),
                                                  image: image,
                                                  about: about);

                                              if (email == null ||
                                                  phone == null ||
                                                  name == null ||
                                                  specialist == null ||
                                                  experienceandcertifications ==
                                                      null ||
                                                  image == null ||
                                                  about == null) return Text("");
                                              return InkWell(
                                                child: TeacherAdminCard(doctor: doctor),
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
                        );
                        /*return Column(
                          children: <Widget>[
                            //Slidable(
                               // child:
                        ListTile(
                                  title: Text(snapshot.data[i]['firstname']+' '+snapshot.data[i]['lastname']),
                                  subtitle: Text(snapshot.data[i]['email']),
                                  leading: CircleAvatar(
                                    radius: 30.0,
                                    backgroundImage:
                                    NetworkImage('http://'+ipAdressValue+'/HCare/upload/'+snapshot2.data['image']),
                                    backgroundColor: Colors.transparent,
                                  ),
                                  //trailing: Text("students="+snapshot2.data['patients'].toString()),

                                ),
                                /*actionPane: SlidableDrawerActionPane(),
                                actionExtentRatio: 1 / 5,
                                secondaryActions: <Widget>[
                                  IconSlideAction(
                                    caption: "Delete",
                                    color: Colors.redAccent,
                                    icon: Icons.delete,
                                    onTap: () {
                                      deleteDataAbout(snapshot.data[i]['email']);
                                      setState(() {

                                      });
                                    },
                                  ),
                                ]),*/
                            FlatButton(
                              onPressed: (){
                                //print(doctor.image);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BookingCourseScreen()
                                    ),

                                );

                              },
                              child: Text(
                                "Open",
                                style: kButtonStyle.copyWith(color: kGreen2Color),
                              ),
                            ),
                            Divider(
                              color: Theme.of(context).accentColor,
                              height: 1,
                            ),
                          ],
                        );*/

                      }
                  );
                }

            );


          }
      ),
    );
  }
}*/

class DeleteEnglishCourse extends StatefulWidget {
  @override
  _DeleteEnglishCourseState createState() => _DeleteEnglishCourseState();
}

class _DeleteEnglishCourseState extends State<DeleteEnglishCourse> {
  var name,
      email,
      phone,
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
      specialist,
      experienceandcertifications,
      image,
      about,
      patients;

  var filterBy = 0;
  var filterStr = [ "By patients","By name    "];

  Future getHomeNursingInfo() async {
    try {
      var data = {"CategoryName": "English"};
      var url = "http://" + ipAdressValue + "/HCare/GetCategoryDescription.php";
      var response = await http.post(Uri.parse(url), body: data);
      var responsebody = jsonDecode(response.body);
      //print(responsebody['CategoryName'][0]);
      if (responsebody['status'] == "success") return responsebody['contacts'];
    } catch (e) {
      print("Exception");
    }
  }

  Future getHomeNursingDoctorInfo() async {
    try {
      var data = {"CategoryName": "English"};
      var url = "http://" + ipAdressValue + "/HCare/NurseDoctor.php";
      var response = await http.post(Uri.parse(url), body: data);
      var responsebody = jsonDecode(response.body);
      // print(responsebody);
      if (responsebody['status'] == "success") return responsebody['abouts'];
      //  return responsebody;
    } catch (e) {
      print(e.toString());
    }
  }

  Future getHomeNursingDoctorInfo2() async {
    try {
      var url = "http://" + ipAdressValue + "/HCare/NurseDoctor2.php";
      var response = await http.post(Uri.parse(url));
      var responsebody = jsonDecode(response.body);
      // print(responsebody);
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
      appBar: AppBar(title:Text("All English Teachers"),
        titleSpacing: 0,
        elevation: 0,
        backgroundColor: Theme.of(context).accentColor,),
      backgroundColor: Colors.white,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                //padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 20.0),
                child: Column(
                  children: [
                    filterBy == 1
                        ? FutureBuilder(
                      future: getHomeNursingDoctorInfo2(),
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
                            var emailff = snapshot.data[i]['emailf'];

                            return FutureBuilder(
                              future: getCurrentName(emailff),
                              builder: (context, snapshot2) {
                                if (snapshot2.hasData) {
                                  name = snapshot2.data['firstname'] +
                                      " " +
                                      snapshot2.data['lastname'];

                                  email = snapshot2.data['email'];
                                  phone = snapshot.data[i]['phone'];
                                  firsthour =
                                  snapshot.data[i]['firsthour'];
                                  lasthour = snapshot.data[i]['lasthour'];
                                  firsthour2 =
                                  snapshot.data[i]['firsthour2'];
                                  lasthour2 =
                                  snapshot.data[i]['lasthour2'];
                                  firsthour3 =
                                  snapshot.data[i]['firsthour3'];
                                  lasthour3 =
                                  snapshot.data[i]['lasthour3'];
                                  firsthour4 =
                                  snapshot.data[i]['firsthour4'];
                                  lasthour4 =
                                  snapshot.data[i]['lasthour4'];
                                  firsthour5 =
                                  snapshot.data[i]['firsthour5'];
                                  lasthour5 =
                                  snapshot.data[i]['lasthour5'];
                                  firsthour6 =
                                  snapshot.data[i]['firsthour6'];
                                  lasthour6 =
                                  snapshot.data[i]['lasthour6'];
                                  firsthour7 =
                                  snapshot.data[i]['firsthour7'];
                                  lasthour7 =
                                  snapshot.data[i]['lasthour7'];

                                  specialist =
                                  snapshot.data[i]['specialist'];
                                  experienceandcertifications =
                                  snapshot.data[i]
                                  ['experienceandcertifications'];
                                  image = snapshot.data[i]['image'];
                                  about = snapshot.data[i]['about'];
                                  patients = snapshot.data[i]['patients'];
                                  var doctor = Doctor(
                                      name: name,
                                      phone: phone,
                                      email: emailff,
                                      specialist: specialist,
                                      experienceandcertifications:
                                      experienceandcertifications,
                                      firsthour: firsthour,
                                      lasthour: lasthour,
                                      firsthour2: firsthour2,
                                      lasthour2: lasthour2,
                                      firsthour3: firsthour3,
                                      lasthour3: lasthour3,
                                      firsthour4: firsthour4,
                                      lasthour4: lasthour4,
                                      firsthour5: firsthour5,
                                      lasthour5: lasthour5,
                                      firsthour6: firsthour6,
                                      lasthour6: lasthour6,
                                      firsthour7: firsthour7,
                                      lasthour7: lasthour7,
                                      patients: int.parse(patients),
                                      image: image,
                                      about: about);

                                  if (email == null ||
                                      phone == null ||
                                      name == null ||
                                      specialist == null ||
                                      experienceandcertifications ==
                                          null ||
                                      image == null ||
                                      about == null) return Text("");
                                  return InkWell(
                                    child: TeacherAdminCard(doctor: doctor),
                                  );
                                }
                                return Text("");
                              },
                            );
                          },
                        );
                      },
                    )
                        : FutureBuilder(
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
                                email = snapshot.data[i]['email'];
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
                                      phone = snapshot.data['phone'];

                                      firsthour =
                                      snapshot.data['firsthour'];
                                      lasthour = snapshot.data['lasthour'];
                                      firsthour2 =
                                      snapshot.data['firsthour2'];
                                      lasthour2 =
                                      snapshot.data['lasthour2'];
                                      firsthour3 =
                                      snapshot.data['firsthour3'];
                                      lasthour3 =
                                      snapshot.data['lasthour3'];
                                      firsthour4 =
                                      snapshot.data['firsthour4'];
                                      lasthour4 =
                                      snapshot.data['lasthour4'];
                                      firsthour5 =
                                      snapshot.data['firsthour5'];
                                      lasthour5 =
                                      snapshot.data['lasthour5'];
                                      firsthour6 =
                                      snapshot.data['firsthour6'];
                                      lasthour6 =
                                      snapshot.data['lasthour6'];
                                      firsthour7 =
                                      snapshot.data['firsthour7'];
                                      lasthour7 =
                                      snapshot.data['lasthour7'];

                                      specialist =
                                      snapshot.data['specialist'];
                                      experienceandcertifications = snapshot
                                          .data[
                                      'experienceandcertifications'];
                                      image = snapshot.data['image'];
                                      about = snapshot.data['about'];
                                      patients = snapshot.data['patients'];

                                      // print(patients.runtimeType);
                                      //   print(about);

                                      //   });
                                      var doctor = Doctor(
                                          name: namess,
                                          phone: phone,
                                          email: emailff,
                                          specialist: specialist,
                                          experienceandcertifications:
                                          experienceandcertifications,
                                          firsthour: firsthour,
                                          lasthour: lasthour,
                                          firsthour2: firsthour2,
                                          lasthour2: lasthour2,
                                          firsthour3: firsthour3,
                                          lasthour3: lasthour3,
                                          firsthour4: firsthour4,
                                          lasthour4: lasthour4,
                                          firsthour5: firsthour5,
                                          lasthour5: lasthour5,
                                          firsthour6: firsthour6,
                                          lasthour6: lasthour6,
                                          firsthour7: firsthour7,
                                          lasthour7: lasthour7,
                                          patients: int.parse(patients),
                                          image: image,
                                          about: about);

                                      if (email == null ||
                                          phone == null ||
                                          name == null ||
                                          specialist == null ||
                                          experienceandcertifications ==
                                              null ||
                                          image == null ||
                                          about == null) return Text("");
                                      return InkWell(
                                        child: AdmainCourseCard(doctor: doctor),
                                      );
                                    }
                                    return Text("");
                                  },
                                );
                              },
                            );
                          }
                          return Text("");
                        }),
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

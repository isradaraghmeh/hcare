// @dart=2.9
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
import '../../Forms/UserClasses/constants.dart';
import '../../Forms/UserWidgets/doctor.dart';
import '../../Forms/UserWidgets/doctor_card.dart';
import '../../Forms/ConstantIP.dart';
// import '../../Screens/SignInScreen.dart';


class GeneralMedicineScreen extends StatefulWidget {
  @override
  _GeneralMedicineScreenState createState() => _GeneralMedicineScreenState();
}

class _GeneralMedicineScreenState extends State<GeneralMedicineScreen> {
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
  //var filterStr = [ "By patients","By name    "];
  Future getHomeNursingInfo() async {
    try {
      var data = {"CategoryName": "Science"};
      var url = "http://"+ipAdressValue+"/HCare/GetCategoryDescription.php";
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
      var data = {"CategoryName": "Science"};
      var url = "http://"+ipAdressValue+"/HCare/GeneralDoctor.php";
      var response = await http.post(Uri.parse(url), body: data);
      var responsebody = jsonDecode(response.body);
      // print(responsebody);
      if (responsebody['status'] == "success") return responsebody['abouts'];
    } catch (e) {
      print(e.toString());
    }
  }

Future getHomeNursingDoctorInfo2() async {
    try {
      var url = "http://" + ipAdressValue + "/HCare/GeneralDoctor2.php";
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
      var data = {"emailf": emailf, "name": name, "types": "science"};
      var url = "http://"+ipAdressValue+"/HCare/NurseDoctorDetail.php";
      var response = await http.post(Uri.parse(url), body: data);
      var responsebody = jsonDecode(response.body);
      // print(responsebody);
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
  void initState(){
    filterBy = 0;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var getWidth = MediaQuery.of(context).size.width;
    //var getHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Science"),
        elevation: 0,
        titleSpacing: 0,
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
                            text: "Learning City\n",
                            style: kTitleStyle.copyWith(
                              fontSize: 26.0,
                              color: kGrey2Color,
                            ),
                          ),
                          TextSpan(
                            text: "Science",
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
                              "If you are having a hard time getting out of the house",
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
              Padding(
                padding: EdgeInsets.only(left: 18.0),
                child: Text("About this category", style: kTitleStyle),
              ),
              SizedBox(height: 5.0),
              Padding(
                padding: EdgeInsets.only(left: 18.0),
                child: FutureBuilder(
                    future: getHomeNursingInfo(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(snapshot.data[0]['AboutThisCategory'],
                            //  "Home health nursing is a nursing specialty in which nurses provide multidimensional home care to patients of all ages. Home health care is a cost-efficient way to deliver quality care in the convenience of the client's home",
                            style: kSubtitleStyle);
                      }
                      return Text("");
                    }),
              ),
              SizedBox(height: 20.0),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 20.0),
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
                        Text("All Teachers", style: kTitleStyle),
                        Spacer(),
                        /*FlatButton(
                          onPressed: () {
                            setState(() {
                              filterBy = 1 - filterBy;
                            });
                          },
                          child: Text(filterStr[filterBy]),
                          color: Colors.black26,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.white)),
                        ),*/
                      
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
                                          child: DoctorCard(doctor: doctor),
                                        );
                                      }
                                      return Text("");
                                    },
                                  );
                                },
                              );
                            },
                          )
                        :


                    FutureBuilder(
                        future: getHomeNursingDoctorInfo(),
                        builder: (context, snapshot) {
                                                     //Doctor doctor;
  if (snapshot.connectionState ==
                                  ConnectionState.waiting)
                                return Text("  Loadding ...  ");
                          if (snapshot.hasData) {
 
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
                                  future:
                                      getHomeNursingDoctorMoreInfo(email, name),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      //  setState(() {
                                      //        print(email);
                                    var namess = snapshot
                                          .data['name']; // print(namess);
                                      var emailff = snapshot.data['emailf'];
                                      phone = snapshot.data['phone'];

                                      firsthour = snapshot.data['firsthour'];
                                      lasthour = snapshot.data['lasthour'];
                                      firsthour2 = snapshot.data['firsthour2'];
                                      lasthour2 = snapshot.data['lasthour2'];
                                      firsthour3 = snapshot.data['firsthour3'];
                                      lasthour3 = snapshot.data['lasthour3'];
                                      firsthour4 = snapshot.data['firsthour4'];
                                      lasthour4 = snapshot.data['lasthour4'];
                                      firsthour5 = snapshot.data['firsthour5'];
                                      lasthour5 = snapshot.data['lasthour5'];
                                      firsthour6 = snapshot.data['firsthour6'];
                                      lasthour6 = snapshot.data['lasthour6'];
                                      firsthour7 = snapshot.data['firsthour7'];
                                      lasthour7 = snapshot.data['lasthour7'];

                                      specialist = snapshot.data['specialist'];
                                      experienceandcertifications = snapshot
                                          .data['experienceandcertifications'];
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
                                          experienceandcertifications == null ||
                                         
                                          image == null ||
                                          about == null) return Text("");
                                      return InkWell(
                                        child: DoctorCard(doctor: doctor),
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
                    // ListView.builder(
                    //   itemCount: doctorList.length,
                    //   scrollDirection: Axis.vertical,
                    //   shrinkWrap: true,
                    //   physics: ScrollPhysics(),
                    //   itemBuilder: (context, index) {
                    //     var doctor = doctorList[index];

                    //     return InkWell(
                    //       child: DoctorCard(doctor: doctor),
                    //     );
                    //   },
                    // ),
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
/*
class CategoriesItem extends StatelessWidget {
  final String title;
  final Color color;
  final IconData icon;
  CategoriesItem({this.title, this.color, this.icon});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 15.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: kGrey2Color,
              width: 1.0,
            )),
        child: Row(
          children: [
            Container(
              width: 50.0,
              height: 50.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: color,
              ),
              child: Center(
                child: Icon(
                  icon,
                  size: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(width: 12.0),
            Text(title, style: kCategoryStyle),
          ],
        ),
      ),
    );
  }
}
*/

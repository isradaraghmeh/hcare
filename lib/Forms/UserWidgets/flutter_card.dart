import 'package:HCare/Screens/UserScreens/CourseHomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../UserClasses/constants.dart';
import './doctor.dart';
import './rating_icon.dart';
import '../../Forms/UserWidgets/doctor_details.dart';
import '../ConstantIP.dart';
import 'course.dart';




class CourseCard extends StatelessWidget {
  var status;
  final Course course;
  final String studentemail;
  final String courseid;
  CourseCard({this.course,this.studentemail,this.courseid});

  Future joincourse(BuildContext context) async {
    try {
      var data = {"studentemail": studentemail, "courseid":courseid};
      var url = "http://" + ipAdressValue + "/HCare/coursestudent.php";
      var response = await http.post(Uri.parse(url), body: data);
      var responsebody = jsonDecode(response.body);
      status = responsebody['status'];
      print(status);
      //print(responsebody['CategoryName'][0]);
      if (responsebody['status'] == "success"){
        AwesomeDialog(
          context: context,
          dialogType: DialogType.SUCCES,
          borderSide:
          BorderSide(color: Colors.green, width: 2),
          width: 400,
          buttonsBorderRadius: BorderRadius.all(
            Radius.circular(2),
          ),
          headerAnimationLoop: false,
          animType: AnimType.BOTTOMSLIDE,
          title: 'Course Join Success',
          desc:"join to this course success",
          //   //" Room : "+ course.roomname +"\n Grade : " + course.grade + "th \n start hour : " + course.time + "\n start date : " + course.startdate + " \n end date :  " + course.enddate ,
          showCloseIcon: true,
          btnOkOnPress: () {
          },
        )..show();
        return;
      }
      else if (responsebody['status'] == "failed"){
        AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          borderSide:
          BorderSide(color: Colors.green, width: 2),
          width: 400,
          buttonsBorderRadius: BorderRadius.all(
            Radius.circular(2),
          ),
          headerAnimationLoop: false,
          animType: AnimType.BOTTOMSLIDE,
          title: 'Course Join Failed',
          desc:"you are already joined to this course",
          //   //" Room : "+ course.roomname +"\n Grade : " + course.grade + "th \n start hour : " + course.time + "\n start date : " + course.startdate + " \n end date :  " + course.enddate ,
          showCloseIcon: true,
          btnOkOnPress: () {},
        )..show();
        return;
      }
      else if(responsebody['status'] == "failed2"){
        AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          borderSide:
          BorderSide(color: Colors.green, width: 2),
          width: 400,
          buttonsBorderRadius: BorderRadius.all(
            Radius.circular(2),
          ),
          headerAnimationLoop: false,
          animType: AnimType.BOTTOMSLIDE,
          title: 'Course Join Failed',
          desc:"no space in this course",
          //   //" Room : "+ course.roomname +"\n Grade : " + course.grade + "th \n start hour : " + course.time + "\n start date : " + course.startdate + " \n end date :  " + course.enddate ,
          showCloseIcon: true,
          btnOkOnPress: () {},
        )..show();
        return;
      }
      else{
        AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          borderSide:
          BorderSide(color: Colors.green, width: 2),
          width: 400,
          buttonsBorderRadius: BorderRadius.all(
            Radius.circular(2),
          ),
          headerAnimationLoop: false,
          animType: AnimType.BOTTOMSLIDE,
          title: 'Course Join Failed',
          desc:"no enough money in your wallet",
          //   //" Room : "+ course.roomname +"\n Grade : " + course.grade + "th \n start hour : " + course.time + "\n start date : " + course.startdate + " \n end date :  " + course.enddate ,
          showCloseIcon: true,
          btnOkOnPress: () {},
        )..show();
        return;
      }
    } catch (e) {
      print(e.toString());
    }
  }




  @override
  Widget build(BuildContext context) {
    context =context;
    return Card(
      elevation: 1.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
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
                children: <Widget>[
                  Container(
                    width: 55.0,
                    height: 55.0,
                    child: CircleAvatar(
                      radius: 30.0,
                      backgroundImage: NetworkImage("http://"+ipAdressValue+"/HCare/upload/Teacher2.png"),
                      backgroundColor: Colors.green,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13.0),
                      color: Colors.green[50],
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                      course.name,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                      Text(
                        course.casedescription,
                        style:
                        TextStyle(fontSize: 12, color: Colors.black87),
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                      Text(
                        "number of Student("+ course.numberofstudent+ ")",
                        style:
                        TextStyle(fontSize: 12, color: Colors.black87),
                      ),
                    ],
                  )
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
                          " Room : "+ course.roomname +"\n Grade : " + course.grade + "th \n start hour : " + course.time + "\n start date : " + course.startdate + " \n end date :  " + course.enddate ,
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
                    FlatButton(
                      onPressed: () {
                        joincourse(context);
                        //print(status);
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.add,
                        size: 32,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    /*return Card(
      elevation: 1.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        padding: EdgeInsets.all(12.0),
        width: double.infinity,
        height: 120.0,
        child: Row(
          children: [
            Container(
              width: 80.0,
              child: Image.network("http://"+ipAdressValue+"/HCare/upload/Teacher2.png",fit: BoxFit.cover ,),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13.0),
                color: kBlue2Color,

                // image: DecorationImage(
                //   image: AssetImage(doctor.image),
                //   fit: BoxFit.cover,
                // ),
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course.casedescription,
                      style: kTitleStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'Grade: '+course.grade,
                      overflow: TextOverflow.ellipsis,
                      style: kCategoryStyle.copyWith(color: kGrey2Color),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                'Start Date: '+course.startdate,
                overflow: TextOverflow.ellipsis,
                style: kCategoryStyle.copyWith(color: kGrey2Color),
              ),
                    SizedBox(height: 4.0),
                    Text(
                      'End Date: '+course.enddate,
                      overflow: TextOverflow.ellipsis,
                      style: kCategoryStyle.copyWith(color: kGrey2Color),
                    ),
                    Spacer(),
                    Text(
                      'Students'+
                          "(${course.numberofstudent})",
                      style: kRatingStyle,
                    ),
                    /*Row(
                      children: [
                        RatingIcon(employeeEmail: course.roomname,),
                        Spacer(),
                        // doctor.patients==null?
                        // Text('Patients(0)'):
                        // Text(
                        //   'Patients'+
                        //   "(${doctor.patients})",
                        //   style: kRatingStyle,
                        // ),
                      ],
                    )*/
                  ],
                ),
              ),
            ),
            SizedBox(width: 8.0),
            Container(
              width: 70.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(height: 12.0),
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFDBF3E8),
                        borderRadius: BorderRadius.circular(7.0),
                      ),
                      child: FlatButton(

                        child: Text(
                          "Join",
                          style: kButtonStyle.copyWith(color: kGreen2Color),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );*/
  }

}

import 'package:HCare/Screens/UserScreens/CourseHomeScreen.dart';
import 'package:flutter/material.dart';
import '../UserClasses/constants.dart';
import './doctor.dart';
import './rating_icon.dart';
import '../../Forms/UserWidgets/doctor_details.dart';
import '../ConstantIP.dart';


class DoctorCard extends StatelessWidget {
  final Doctor doctor;
  DoctorCard({this.doctor});



  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        padding: EdgeInsets.all(12.0),
        width: double.infinity,
        height: 100.0,
        child: Row(
          children: [
            Container(
              width: 80.0,
              child: doctor.image==null?Image.network("http://"+ipAdressValue+"/HCare/upload/Teacher11.png",fit: BoxFit.cover ,):Image.network("http://"+ipAdressValue+"/HCare/upload/"+doctor.image,fit: BoxFit.cover ,),
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
                      doctor.name,
                      style: kTitleStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 6.0),
                    Text(
                      doctor.specialist,
                      overflow: TextOverflow.ellipsis,
                      style: kCategoryStyle.copyWith(color: kGrey2Color),
                    ),
                    Spacer(),
                        Text(
                          'Students'+
                          "(${doctor.patients})",
                          style: kRatingStyle,
                        ),
                    Row(
                      children: [
                       RatingIcon(employeeEmail: doctor.email,),
                        Spacer(),
                        // doctor.patients==null?
                        // Text('Patients(0)'):
                        // Text(
                        //   'Patients'+
                        //   "(${doctor.patients})",
                        //   style: kRatingStyle,
                        // ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(width: 8.0),
            Container(
              width: 120.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      //width: 35.0,
                      //height: 35.0,
                      decoration: BoxDecoration(
                        color: Color(0xFFDBF3E8),
                        borderRadius: BorderRadius.circular(7.0),
                        //borderRadius: BorderRadius.circular(12.0),
                        //border: Border.all(
                          //width: 1.0,
                         // color: kGrey1Color,
                         ),
                       //),
                       child: Center(
                         child: FlatButton(
                           onPressed: (){
                             Navigator.push(
                                 context,
                                 MaterialPageRoute(
                                     builder: (context) => CourseHomeScreen(doctorEmail: doctor.email,                                     ),
                                 ),
                             );
                           },
                           child: Text(
                               "View Courses",
                             style: kButtonStyle.copyWith(color: kGreen2Color),
                           ),
                         ),
                       ),
                    ),
                  ),
                  SizedBox(height: 12.0),
                  Expanded(
                    flex: 1,
                     child: Container(
                       width: 250,
                      height: 200,
                      decoration: BoxDecoration(
                         color: Color(0xFFDBF3E8),
                         borderRadius: BorderRadius.circular(7.0),
                      ),
                      child: FlatButton(
                        
                        onPressed: (){
  //print(doctor.image);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DoctorDetail(
                                    doctor: doctor,
                                  ),
                                ),
                              );

                        },
                          child: Text(
                          "Private Session",
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
    );
  }
}
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../UserClasses/constants.dart';
import './doctor.dart';
// import './rating_icon.dart';
import '../../Screens/UserScreens/MakeAppoinment.dart';
import '../ConstantIP.dart';

class DoctorDetail extends StatelessWidget {
  final Doctor doctor;
  DoctorDetail({this.doctor});

  void userLauncher(command) async {
    try {
      if (await canLaunch(command)) {
        await launch(command);
      }
    } catch (e) {
      print(e.toString());
    }
  }


  String convertToTimeFormat(String str) {
    
    String resultConvert = '';
    if (str == '') return "";
    
    switch (str) {
      case "0.0":
        resultConvert = "00:00";
        break; case "0":
        resultConvert = "00:00";
        break;
      case "0.5":
        resultConvert = "00:30";
        break;
      case "1.0":
        resultConvert = "01:00";
        break;case "1":
        resultConvert = "01:00";
        break;
      case "1.5":
        resultConvert = "01:30";
        break;
      case "2.0":
        resultConvert = "02:00";
        break;case "2":
        resultConvert = "02:00";
        break;
      case "2.5":
        resultConvert = "02:30";
        break;
      case "3.0":
        resultConvert = "03:00";
        break;case "3":
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
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [

            Container(
             height: 300.0,
              // decoration: BoxDecoration(
              //   image: DecorationImage(
              //     image: AssetImage(doctor.image),
              //     fit: BoxFit.cover,
              //   ),
              // ),
              child: Stack(
                children: [

                   Container(
               height: 300.0,
               width: double.infinity,
              child:    doctor.image==null?Image.network("http://"+ipAdressValue+"/HCare/upload/doctor11.png",fit: BoxFit.cover ,):Image.network("http://"+ipAdressValue+"/HCare/upload/"+doctor.image,fit: BoxFit.cover ,),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13.0),
                color: kBlue2Color,
                
                // image: DecorationImage(
                //   image: AssetImage(doctor.image),
                //   fit: BoxFit.cover,
                // ),
              ),
            ),
                  Positioned(
                    top: 30.0,
                    left: 20.0,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: kGrey2Color,
                          ),
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          )),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      height: 30.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25.0),
                          topRight: Radius.circular(25.0),
                        ),
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              color: Colors.white,
              margin: EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // color: Colors.white,
                    child: Row(
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "${doctor.name}\n",
                                style: kTitleStyle,
                              ),
                               TextSpan(
                                text: "${doctor.email}\n",
                                style: kTitleStyle,
                              ),
                              TextSpan(
                                text: doctor.specialist,
                                style: kSubtitleStyle,
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
    
                        FloatingActionButton(
                          heroTag: 'btn1',
                          backgroundColor: kYellowColor,
                          child: Icon(Icons.mail,color: Colors.white,),
                          onPressed: () {
                          
                            var smsToSend = "sms:";
                            if (doctor.phone != null) {
                              smsToSend = smsToSend + doctor.phone;
                            }
                            userLauncher(smsToSend);
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),

                        //      SizedBox(width: 14.0),
                        //       FlatButton(
                        //         color: Colors.white,
                        //         onPressed: () {
                        //           var phoneToSend="tel:";
                        // if(doctor.phone!=null){phoneToSend=phoneToSend+doctor.phone;}
                        // userLauncher(phoneToSend);
                        //         },
                        //         child: ButtonAction(
                        //           color: kGreen2Color,
                        //           icon: Icons.phone,
                        //         ),
                        //       ),

                        FloatingActionButton(
                          heroTag: 'btn2',
                          backgroundColor: kGreen2Color,
                          child: Icon(Icons.phone,color: Colors.white,),
                          onPressed: () {
                            var phoneToSend = "tel:";
                            if (doctor.phone != null) {
                              phoneToSend = phoneToSend + doctor.phone;
                            }
                            userLauncher(phoneToSend);
                          },
                        ),

                        // FlatButton(
                        //   onPressed: (){},
                        //                           child: ButtonAction(
                        //     color: kGreen2Color,
                        //     icon: Icons.phone,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15.0),
                  Row(
                    children: [
                   //   RatingIcon(),
                      SizedBox(width: 12.0),
                      // Text("(${doctor.review} reviews)", style: kRatingStyle),
                      Spacer(),
                      // Text(
                      //   "See all reviews",
                      //   style: kSubtitle2Style.copyWith(color: kBlue1Color),
                      // ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Divider(color: kGrey2Color),
                  SizedBox(height: 20.0),
                  Text("About", style: kTitleStyle),
                  SizedBox(height: 5.0),
                  Text(doctor.about, style: kSubtitle2Style),
                  SizedBox(height: 20.0),
                  Text("Working hourse", style: kTitleStyle),
                  SizedBox(height: 5.0),
                  Row(
                    children: [
                  //    Text(doctor.firsthour, style: kSubtitle2Style),
                  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                    doctor.firsthour==doctor.lasthour?Row(children: <Widget>[Text('Sunday:     ',style: kSubtitle2Style),Text('Not work in this day',style: kSubtitle2Style,),],) :
                    ((double.parse(doctor.firsthour)==double.parse(doctor.lasthour)+0.5)||
                      ((double.parse(doctor.firsthour)==0)&&(double.parse(doctor.lasthour)==23.5)))   ?
                       Row(children: <Widget>[Text('Sunday:     ',style: kSubtitle2Style),Text('Work on all day',style: kSubtitle2Style,),],):
                      Row(children: <Widget>[Text('Sunday:     ',style: kSubtitle2Style),Text(convertToTimeFormat(doctor.firsthour)+' - '+convertToTimeFormat(doctor.lasthour), style: kSubtitle2Style),],),
                    
                    doctor.firsthour2==doctor.lasthour2?Row(children: <Widget>[Text('Monday:     ',style: kSubtitle2Style),Text('Not work in this day',style: kSubtitle2Style,),],) :
                    ((double.parse(doctor.firsthour2)==double.parse(doctor.lasthour2)+0.5)||
                      ((double.parse(doctor.firsthour2)==0)&&(double.parse(doctor.lasthour2)==23.5)))   ?
                       Row(children: <Widget>[Text('Monday:     ',style: kSubtitle2Style),Text('Work on all day',style: kSubtitle2Style,),],):                  
                      Row(children: <Widget>[Text('Monday:     ',style: kSubtitle2Style),Text(convertToTimeFormat(doctor.firsthour2)+' - '+convertToTimeFormat(doctor.lasthour2), style: kSubtitle2Style),],),
                            

                         doctor.firsthour3==doctor.lasthour3?Row(children: <Widget>[Text('Tuesday:     ',style: kSubtitle2Style),Text('Not work in this day',style: kSubtitle2Style,),],) :
                    ((double.parse(doctor.firsthour3)==double.parse(doctor.lasthour3)+0.5)||
                      ((double.parse(doctor.firsthour3)==0)&&(double.parse(doctor.lasthour3)==23.5)))   ?
                       Row(children: <Widget>[Text('Tuesday:     ',style: kSubtitle2Style),Text('Work on all day',style: kSubtitle2Style,),],):  
                      Row(children: <Widget>[Text('Tuesday:    ',style: kSubtitle2Style),Text(convertToTimeFormat(doctor.firsthour3)+' - '+convertToTimeFormat(doctor.lasthour3), style: kSubtitle2Style),],),
                    
                    
                    
                         doctor.firsthour4==doctor.lasthour4?Row(children: <Widget>[Text('Wednesday:     ',style: kSubtitle2Style),Text('Not work in this day',style: kSubtitle2Style,),],) :
                    ((double.parse(doctor.firsthour4)==double.parse(doctor.lasthour4)+0.5)||
                      ((double.parse(doctor.firsthour4)==0)&&(double.parse(doctor.lasthour4)==23.5)))   ?
                       Row(children: <Widget>[Text('Wednesday:     ',style: kSubtitle2Style),Text('Work on all day',style: kSubtitle2Style,),],):
                      Row(children: <Widget>[Text('Wednesday:  ',style: kSubtitle2Style),Text(convertToTimeFormat(doctor.firsthour4)+' - '+convertToTimeFormat(doctor.lasthour4), style: kSubtitle2Style),],),
               
               
               
                         doctor.firsthour5==doctor.lasthour5?Row(children: <Widget>[Text('Thursday:     ',style: kSubtitle2Style),Text('Not work in this day',style: kSubtitle2Style,),],) :
                    ((double.parse(doctor.firsthour5)==double.parse(doctor.lasthour5)+0.5)||
                      ((double.parse(doctor.firsthour5)==0)&&(double.parse(doctor.lasthour5)==23.5)))   ?
                       Row(children: <Widget>[Text('Thursday:     ',style: kSubtitle2Style),Text('Work on all day',style: kSubtitle2Style,),],):
                      Row(children: <Widget>[Text('Thursday:   ',style: kSubtitle2Style),Text(convertToTimeFormat(doctor.firsthour5)+' - '+convertToTimeFormat(doctor.lasthour5), style: kSubtitle2Style),],),
                   
                   
                          doctor.firsthour6==doctor.lasthour6?Row(children: <Widget>[Text('Friday:     ',style: kSubtitle2Style),Text('Not work in this day',style: kSubtitle2Style,),],) :
                    ((double.parse(doctor.firsthour6)==double.parse(doctor.lasthour6)+0.5)||
                      ((double.parse(doctor.firsthour6)==0)&&(double.parse(doctor.lasthour6)==23.5)))   ?
                       Row(children: <Widget>[Text('Friday:     ',style: kSubtitle2Style),Text('Work on all day',style: kSubtitle2Style,),],):
                      Row(children: <Widget>[Text('Friday:     ',style: kSubtitle2Style),Text(convertToTimeFormat(doctor.firsthour6)+' - '+convertToTimeFormat(doctor.lasthour6), style: kSubtitle2Style),],),
                   
                   
                   
                          doctor.firsthour7==doctor.lasthour7?Row(children: <Widget>[Text('Suturday:     ',style: kSubtitle2Style),Text('Not work in this day',style: kSubtitle2Style,),],) :
                    ((double.parse(doctor.firsthour7)==double.parse(doctor.lasthour7)+0.5)||
                      ((double.parse(doctor.firsthour7)==0)&&(double.parse(doctor.lasthour7)==23.5)))   ?
                       Row(children: <Widget>[Text('Suturday:     ',style: kSubtitle2Style),Text('Work on all day',style: kSubtitle2Style,),],):
                      Row(children: <Widget>[Text('Suturday:   ',style: kSubtitle2Style),Text(convertToTimeFormat(doctor.firsthour7)+' - '+convertToTimeFormat(doctor.lasthour7), style: kSubtitle2Style),],),
                   
                   
                      ],),
                      SizedBox(width: 20.0),
                      SizedBox(
                        width: 70.0,
                        height: 35.0,
                        // child: RaisedButton(
                        //   onPressed: () {},
                        //   color: kGreenColor,
                        //   elevation: 0,
                        //   shape: RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.circular(7.0),
                        //   ),
                        //   child: Text(
                        //     "Open",
                        //     style: kButtonStyle.copyWith(color: kGreen2Color),
                        //   ),
                        // ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Text("Stats", style: kTitleStyle),
                  SizedBox(height: 10.0),
                  Text("Experince and certification " +
                      doctor.experienceandcertifications),
                  SizedBox(height: 20.0),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        // Stats(name: "Patients", total: doctor.patients),
                        Spacer(),
                        Stats(
                            name: "Students",
                            total: doctor.patients.toString()),
                        // StatsExperience(
                        //     name: "Experience", total: doctor.experienceandcertifications),
                        Spacer(),
                        // Stats(
                        //     name: "Certifications",
                        //     total: doctor.certifications)
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: SizedBox(
                width: double.infinity,
                height: 55.0,
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReverseAppoinment( 
                          name: doctor.name,
                          email: doctor.email,
                          image: doctor.image,
                          firsthour: doctor.firsthour,
                          lasthour: doctor.lasthour,
                           firsthour2: doctor.firsthour2,
                          lasthour2: doctor.lasthour2,
                           firsthour3: doctor.firsthour3,
                          lasthour3: doctor.lasthour3,
                           firsthour4: doctor.firsthour4,
                          lasthour4: doctor.lasthour4,
                           firsthour5: doctor.firsthour5,
                          lasthour5: doctor.lasthour5,
                           firsthour6: doctor.firsthour6,
                          lasthour6: doctor.lasthour6,
                           firsthour7: doctor.firsthour7,
                          lasthour7: doctor.lasthour7,

                        ),
                      ),
                    );
                  },
                  elevation: 0.0,
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Center(
                    child: Text(
                      "Make an Private Session",
                      style: TextStyle(fontSize: 18,color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}

class StatsExperience extends StatelessWidget {
  final String total;
  final String name;
  StatsExperience({this.total, this.name});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(children: [
        TextSpan(
          text: "$total",
          style: kTitleStyle,
        ),
        TextSpan(
          text: " years\n",
          style: kSubtitleStyle.copyWith(fontSize: 12.0),
        ),
        TextSpan(
          text: "$name",
          style: kSubtitleStyle.copyWith(fontSize: 14.0),
        ),
      ]),
    );
  }
}

class Stats extends StatelessWidget {
  final String total;
  final String name;
  Stats({this.total, this.name});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(children: [
        TextSpan(
          text: "$total\n",
          style: kTitleStyle,
        ),
        TextSpan(
          text: "$name",
          style: kSubtitleStyle.copyWith(fontSize: 14.0),
        ),
      ]),
    );
  }
}

class ButtonAction extends StatelessWidget {
  final Color color;
  final IconData icon;
  ButtonAction({this.color, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.0,
      height: 50.0,
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.0),
        color: color,
      ),
      child: Icon(
        icon,
        size: 25.0,
        color: Colors.white,
      ),
    );
  }
}

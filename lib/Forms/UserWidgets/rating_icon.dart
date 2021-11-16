import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../Forms/ConstantIP.dart';
import '../UserClasses/constants.dart';

class RatingIcon extends StatefulWidget {
  final employeeEmail;

  RatingIcon({@required this.employeeEmail});
  @override
  _RatingIconState createState() => _RatingIconState();
}

class _RatingIconState extends State<RatingIcon> {

 var _currentEmail;
  bool isSignIn = false;

getPrefrences() async {
    SharedPreferences prefrences = await SharedPreferences.getInstance();
    setState(
      () {
        _currentEmail = prefrences.getString("email");
      },
    );
    if ( _currentEmail != null) {
      setState(
        () {
          isSignIn = true;
           _currentEmail = _currentEmail;
        },
      );
    }
  }


getRatingValue() async {
    getPrefrences();
    try {
      if (_currentEmail != null) {
        var data = {"dremail":widget.employeeEmail,"customeremail": _currentEmail,};
        var url = Uri.parse("http://"+ipAdressValue+"/HCare/getRatingValue.php");
        var response = await http.post(url, body: data);
        var responsebody = jsonDecode(response.body);
        if(responsebody['status']=="success")return responsebody['abouts'];
      }
    } catch (e) {
      print(e.toString());
    }
  }


setRatingValue(value) async {
    getPrefrences();
    try {
      if (_currentEmail != null) {
        var data = {"dremail":widget.employeeEmail,"customeremail": _currentEmail,"value":value};
        var url = Uri.parse("http://"+ipAdressValue+"/HCare/setRatingValue.php");
        var response = await http.post(url, body: data);
        var responsebody = jsonDecode(response.body);
        if(responsebody['status']=="success"){
          setState(() {
            
          });
          return responsebody['abouts'];}
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    getPrefrences();
    // print(widget.customerEmail);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return FutureBuilder(future: getRatingValue() ,
    builder: (context, snapshot) {
      // if(snapshot.connectionState==ConnectionState.waiting)return Text("Loadding ... ");
      if(!snapshot.hasData){
      return Row(
      children: [
        GestureDetector(
             onTap: (){setRatingValue("1");},
                  child: Icon(
            Icons.star,
            size: 15.0,
            color: kGrey2Color,
          ),
        ),
        GestureDetector(
                      onTap: (){setRatingValue("2");},

                  child: Icon(
            Icons.star,
            size: 15.0,
            color: kGrey2Color,
          ),
        ),
                GestureDetector(
                       onTap: (){setRatingValue("3");},
      child:  Icon(
          Icons.star,
          size: 15.0,
          color: kGrey2Color,
        ),
                ),
            GestureDetector(
                       onTap: (){setRatingValue("4");},
      child: Icon(
          Icons.star,
          size: 15.0,
          color: kGrey2Color,
        ),
            ),
                GestureDetector(
                      onTap: (){setRatingValue("5");},
      child: 
        Icon(
          Icons.star,
          size: 15.0,
          color: kGrey2Color,
        ),
                ),
      ],
    );
      }



 return Row(
      children: [
      
       
                GestureDetector(
                    onTap: (){setRatingValue("1");},
      child: 
        Icon(
          Icons.star,
          size: 15.0,
          color: snapshot.data['ratingValue']=="5" || snapshot.data['ratingValue']=="4" ||snapshot.data['ratingValue']=="3" ||snapshot.data['ratingValue']=="2" ||snapshot.data['ratingValue']=="1"?kYellowColor:kGrey2Color,
        ),
                ),
                   GestureDetector(
                    onTap: (){setRatingValue("2");},
      child: Icon(
          Icons.star,
          size: 15.0,
          color: snapshot.data['ratingValue']=="5" ||snapshot.data['ratingValue']=="4" ||snapshot.data['ratingValue']=="3" ||snapshot.data['ratingValue']=="2"?kYellowColor:kGrey2Color,
        ),
            ),
                GestureDetector(

                    onTap: (){setRatingValue("3");},
      child:  Icon(
          Icons.star,
          size: 15.0,
          color:  snapshot.data['ratingValue']=="5" ||snapshot.data['ratingValue']=="4" ||snapshot.data['ratingValue']=="3"?kYellowColor:kGrey2Color,
        ),
                ),
        GestureDetector(
                    onTap: (){setRatingValue("4");},

                  child: Icon(
            Icons.star,
            size: 15.0,
            color:  snapshot.data['ratingValue']=="4" ||snapshot.data['ratingValue']=="5"?kYellowColor:kGrey2Color,
          ),
        ),
             GestureDetector(
          onTap: (){setRatingValue("5");},
                  child: Icon(
            Icons.star,
            size: 15.0,
            color: snapshot.data['ratingValue']=="5"?kYellowColor:kGrey2Color,
          ),
        ), 
              
      ],
    );


    },
    );
   
  }
}
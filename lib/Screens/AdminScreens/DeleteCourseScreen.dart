// @dart=2.9
import 'package:flutter/material.dart';
import 'DeleteArabicCourse.dart';
import 'DeleteEnglishCourse.dart';
import 'DeleteMathCourse.dart';
import 'DeleteScienceCourse.dart';

class DeleteCourseScreen extends StatefulWidget {
  @override
  _DeleteCourseScreenState createState() => _DeleteCourseScreenState();
}

class _DeleteCourseScreenState extends State<DeleteCourseScreen> {
  @override
  Widget build(BuildContext context) {
    var getWidth = MediaQuery.of(context).size.width;
    var getHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),
        titleSpacing: 0,
        elevation: 0,
        backgroundColor: Theme.of(context).accentColor,
      ),
      body:SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Container(margin: EdgeInsets.only(top: getHeight*0.15),width: getWidth*0.8,child: FlatButton(onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DeleteEnglishCourse(),
                  ),
                );
              },child: Text("English",style: TextStyle(color: Colors.white),),),color: Colors.black26,),

              Container(margin: EdgeInsets.only(top: getHeight*0.05),width: getWidth*0.8,child: FlatButton(onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DeleteMathCourse(),
                  ),
                );
              },child: Text("Math",style: TextStyle(color: Colors.white),),),color:Theme.of(context).accentColor,),


              Container(margin: EdgeInsets.only(top: getHeight*0.05),width: getWidth*0.8,child: FlatButton(onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DeleteArabicCourse(),
                  ),
                );
              },child: Text("Arabic",style: TextStyle(color: Colors.white),),),color: Colors.black26,),



              Container(margin: EdgeInsets.only(top: getHeight*0.05),width: getWidth*0.8,child: FlatButton(onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DeleteScienceCourse(),
                  ),
                );
              },child: Text("Science",style: TextStyle(color: Colors.white),),),color: Theme.of(context).accentColor,),
            ],
          ),
        ),
      ),
    );
  }
}
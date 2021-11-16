// @dart=2.9
import 'package:flutter/material.dart';
import '../../Screens/AdminScreens/DeleteHomeNursing.dart';
import '../../Screens/AdminScreens/DeleteOccuptionalTherpay.dart';
import '../../Screens/AdminScreens/DeleteNaturalTherpay.dart';
import '../../Screens/AdminScreens/DeleteGeneralMedicine.dart';

class DeleteEmployeeScreen extends StatefulWidget {
  @override
  _DeleteEmployeeScreenState createState() => _DeleteEmployeeScreenState();
}

class _DeleteEmployeeScreenState extends State<DeleteEmployeeScreen> {
  @override
  Widget build(BuildContext context) {
     var getWidth = MediaQuery.of(context).size.width;
       var getHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Teacher"),
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
                        builder: (context) => DeleteHomeNursing(),
                      ),
                    );
                },child: Text("English",style: TextStyle(color: Colors.white),),),color: Colors.black26,),

                Container(margin: EdgeInsets.only(top: getHeight*0.05),width: getWidth*0.8,child: FlatButton(onPressed: (){
                      Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DeleteOccuptionalTherpay(),
                      ),
                    );
                },child: Text("Math",style: TextStyle(color: Colors.white),),),color:Theme.of(context).accentColor,),
                
   
                Container(margin: EdgeInsets.only(top: getHeight*0.05),width: getWidth*0.8,child: FlatButton(onPressed: (){
                   Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DeleteNaturalTherpay(),
                      ),
                    );
                },child: Text("Arabic",style: TextStyle(color: Colors.white),),),color: Colors.black26,),
                

                
                Container(margin: EdgeInsets.only(top: getHeight*0.05),width: getWidth*0.8,child: FlatButton(onPressed: (){
                   Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DeleteGeneralMedicine(),
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
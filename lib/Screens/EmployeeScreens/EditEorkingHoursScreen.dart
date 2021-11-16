// @dart=2.9
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../Forms/ConstantIP.dart';
// import '../../Screens/SignInScreen.dart';
// import '../../Forms/EmployeeForms/MainEmployeeDrawer.dart';

class EditEorkingHoursScreen extends StatefulWidget {
  @override
  _EditEorkingHoursScreenState createState() => _EditEorkingHoursScreenState();
}

class _EditEorkingHoursScreenState extends State<EditEorkingHoursScreen> {
   List<String>   list = ["00:00","00:30","01:00","01:30","02:00","02:30","03:00","03:30","04:00","04:30","05:00","05:30","06:00","06:30","07:00","07:30","08:00","08:30","09:00","09:30",
   "10:00","10:30","11:00","11:30","12:00","12:30","13:00","13:30","14:00","14:30","15:00","15:30","16:00","16:30","17:00","17:30","18:00","18:30","19:00","19:30",
   "20:00","20:30","21:00","21:30","22:00","22:30","23:00","23:30"];
   
   var f1,l1,f2,l2,f3,l3,f4,l4,f5,l5,f6,l6,f7,l7;
  var currentEmail;
 
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
 
   double convertTimeToDouble(String str) {
    double resultConvert;
    if (str == '') return -1.0;
    if(str=="00:00")return 0.0;
    else if(str=="00:30")return 0.5;
    else if(str=="01:00")return 1.0;
    else if(str=="01:30")return 1.5;
    else if(str=="02:00")return 2.0;
    else if(str=="02:30")return 2.5;
    else if(str=="03:00")return 3.0;
    else if(str=="03:30")return 3.5;
    else if(str=="04:00")return 4.0;
    else if(str=="04:30")return 4.5;
    else if(str=="05:00")return 5.0;
    else if(str=="05:30")return 5.5;
    else if(str=="06:00")return 6.0;
    else if(str=="06:30")return 6.5;
    else if(str=="07:00")return 7.0;
    else if(str=="07:30")return 7.5;
    else if(str=="08:00")return 8.0;
    else if(str=="08:30")return 8.5;
    else if(str=="09:00")return 9.0;
    else if(str=="09:30")return 9.5;
    else if(str=="10:00")return 10.0;
    else if(str=="10:30")return 10.5;
    else if(str=="11:00")return 11.0;
    else if(str=="11:30")return 11.5;
    else if(str=="12:00")return 12.0;
    else if(str=="12:30")return 12.5;
    else if(str=="13:00")return 13.0;
    else if(str=="13:30")return 13.5;
    else if(str=="14:00")return 14.0;
    else if(str=="14:30")return 14.5;
    else if(str=="15:00")return 15.0;
    else if(str=="15:30")return 15.5;
    else if(str=="16:00")return 16.0;
    else if(str=="16:30")return 16.5;
    else if(str=="17:00")return 17.0;
    else if(str=="17:30")return 17.5;
    else if(str=="18:00")return 18.0;
    else if(str=="18:30")return 18.5;
    else if(str=="19:00")return 19.0;
    else if(str=="19:30")return 19.5;
    else if(str=="20:00")return 20.0;
    else if(str=="20:30")return 20.5;
    else if(str=="21:00")return 21.0;
    else if(str=="21:30")return 21.5;
    else if(str=="22:00")return 22.0;
    else if(str=="22:30")return 22.5;
    else if(str=="23:00")return 23.0;
    else if(str=="23:30")return 23.5;
      
    return resultConvert;
  }
 
 
 
 
 
 
 getPrefrences() async {
    SharedPreferences prefrences = await SharedPreferences.getInstance();
    setState(
      () {
       
        currentEmail = prefrences.getString("email");
      },
    );
    if (currentEmail != null ) {
      setState(
        () {
          currentEmail=currentEmail;
          getWorkingHours();
          
        },
      );
    }
    // else{
    //         Navigator.push(
    //                   context,
    //                   MaterialPageRoute(
    //                     builder: (context) => SignInScreen(),
    //                   ),
    //                 );
    // }
  }

Future getWorkingHours() async {
    try {
      var data = {"email": currentEmail};
      var url = "http://"+ipAdressValue+"/HCare/getworkinghours.php";
      var response = await http.post(Uri.parse(url), body: data);
      var responsebody = jsonDecode(response.body);
      //print(responsebody['CategoryName'][0]);
      //  print(responsebody);
      if (responsebody['status'] == "success") {
        setState(() {
             //print(f1);print(f2);print(f3);print(f4);print(f5);print(f6);print(f7);
          f1=convertToTimeFormat(  responsebody['f1']);f2=convertToTimeFormat(responsebody['f2']);
          f3=convertToTimeFormat(  responsebody['f3']);f4=convertToTimeFormat(  responsebody['f4']);
          f5=convertToTimeFormat(  responsebody['f5']);f6=convertToTimeFormat(  responsebody['f6']);
          f7=convertToTimeFormat(  responsebody['f7']);
          l1=convertToTimeFormat(  responsebody['l1']);l2=convertToTimeFormat(  responsebody['l2']);
          l3=convertToTimeFormat(  responsebody['l3']);l4=convertToTimeFormat(  responsebody['l4']);
          l5=convertToTimeFormat(  responsebody['l5']);l6=convertToTimeFormat(  responsebody['l6']);
          l7=convertToTimeFormat(  responsebody['l7']);
        });
      }
      // print(responsebody);
    } catch (e) {
      print("Exception");
    }
  }


  completeDonecorrect(context, String title, String str) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(str),
            actions: <Widget>[
              FlatButton(
                  onPressed: () async{
                    //Navigator.of(context).pop();
                    Navigator.pop(context);
                    // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder:(c)=>EditUserProfile()), (route) => false);
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => MainEmployeeDrawer(),
                    //   ),
                    // );
                   //  Navigator.pop(context);
                  },
                  child: Text("OK"))
            ],
          );
        });
  }
Future pressSave()async{
    try{


      if(convertTimeToDouble(f1)>convertTimeToDouble(l1)){
        completeDonecorrect(context, "Sunday working error", "First Working hour should become less than last working hour");
      }
      else if(convertTimeToDouble(f2)>convertTimeToDouble(l2)){
        completeDonecorrect(context, "Monday working error", "First Working hour should become less than last working hour");
      }
      else if(convertTimeToDouble(f1)>convertTimeToDouble(l1)){
        completeDonecorrect(context, "Tuesday working error", "First Working hour should become less than last working hour");
      }
      else if(convertTimeToDouble(f1)>convertTimeToDouble(l1)){
        completeDonecorrect(context, "Wednesday working error", "First Working hour should become less than last working hour");
      }
      else if(convertTimeToDouble(f1)>convertTimeToDouble(l1)){
        completeDonecorrect(context, "Thuersday working error", "First Working hour should become less than last working hour");
      }
      else if(convertTimeToDouble(f1)>convertTimeToDouble(l1)){
        completeDonecorrect(context, "Friday working error", "First Working hour should become less than last working hour");
      }
      else if(convertTimeToDouble(f1)>convertTimeToDouble(l1)){
        completeDonecorrect(context, "Suterday working error", "First Working hour should become less than last working hour");
      }
      else{
        var data={'email':currentEmail,'f1':convertTimeToDouble(f1).toString(),'f2':convertTimeToDouble(f2).toString(),'f3':convertTimeToDouble(f3).toString(),
        'f4':convertTimeToDouble(f4).toString(),'f5':convertTimeToDouble(f5).toString(),'f6':convertTimeToDouble(f6).toString(),'f7':convertTimeToDouble(f7).toString(),
        'l1':convertTimeToDouble(l1).toString(),'l2':convertTimeToDouble(l2).toString(),'l3':convertTimeToDouble(l3).toString(),'l4':convertTimeToDouble(l4).toString(),
        'l5':convertTimeToDouble(l5).toString(),'l6':convertTimeToDouble(l6).toString(),'l7':convertTimeToDouble(l7).toString()};
 
        var url = "http://"+ipAdressValue+"/HCare/EditEmployeeWorkingHour.php";
        var response = await http.post(Uri.parse(url), body: data);
        var responsebody = jsonDecode(response.body);
        // print(responsebody);
        if(responsebody['status']=="success"){

            completeDonecorrect(context, "Working hours", "Edit working hours done successfully");
       }
        
      }

    } catch (e) {
      print("Exception");
    }
}

@override
void initState(){
  getPrefrences();
  
  super.initState();
}

  @override
  Widget build(BuildContext context) {
        var getWidth = MediaQuery.of(context).size.width;
    var getHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit working hours'),
        actions: <Widget>[IconButton(icon: Icon(Icons.save), onPressed: (){
          //print(f1);print(f2);print(f3);print(f4);print(f5);print(f6);print(f7);
         pressSave();
        })],
        titleSpacing: 0,
        elevation: 0,
        backgroundColor: Theme.of(context).accentColor,
      ),

      body: SingleChildScrollView(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                Container(margin: EdgeInsets.only(top: getHeight*0.08,left: getWidth*0.05),
                  child: Text('*Notice: \n\nIf you dont want to work in a day put start hour same as last hour.',style:TextStyle(fontSize: getWidth*0.03),),),
                              Container(
          margin: EdgeInsets.only(top: getHeight*0.04,left: getWidth*0.05),
          child:Column(children: <Widget>[
          
             Row(children: <Widget>[ Text("Sunday",style: TextStyle(fontWeight: FontWeight.bold),),
             SizedBox(width: getWidth*0.05,),Text("From    "),
             Container(  width:  getWidth*0.2,    color: Colors.white, 
             child: DropdownButton<String>(  isExpanded: true,                              
                                      dropdownColor: Colors.white,
                                      //value: "Press to select sutible time",
                                      value: f1, icon: const Icon(Icons.arrow_drop_down),
                                      iconSize: 24,
                                      elevation: 16,
                                      style:  const TextStyle(color: Colors.deepPurple),
                                      onChanged: (String newValue) {
                                        setState(() {
                                          // print(dropdownValue);
                                          f1 = newValue;
                                        });
                                      },
                                      items: list.map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text("" + value),
                                        );
                                      }).toList(),
                                    ),
             ),Text("    To    "),
             Container(  width:  getWidth*0.2,    color: Colors.white, child:DropdownButton<String>(  isExpanded: true,                              
                                      dropdownColor: Colors.white,
                                      //value: "Press to select sutible time",
                                      value: l1, icon: const Icon(Icons.arrow_drop_down),
                                      iconSize: 24,
                                      elevation: 16,
                                      style:  const TextStyle(color: Colors.deepPurple),
                                      onChanged: (String newValue) {
                                        setState(() {
                                          // print(dropdownValue);
                                          l1 = newValue;
                                        });
                                      },
                                      items: list.map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text("" + value),
                                        );
                                      }).toList(),
                                    ),
             ),
             ],),
                SizedBox(height: getHeight*0.05,), 



                  Row(children: <Widget>[ Text("Monday",style: TextStyle(fontWeight: FontWeight.bold),),
             SizedBox(width: getWidth*0.05,),Text("From    "),
             Container(  width:  getWidth*0.2,    color: Colors.white, child:DropdownButton<String>(  isExpanded: true,                              
                                      dropdownColor: Colors.white,
                                      //value: "Press to select sutible time",
                                      value: f2, icon: const Icon(Icons.arrow_drop_down),
                                      iconSize: 24,
                                      elevation: 16,
                                      style:  const TextStyle(color: Colors.deepPurple),
                                      onChanged: (String newValue) {
                                        setState(() {
                                          // print(dropdownValue);
                                          f2 = newValue;
                                        });
                                      },
                                      items: list.map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text("" + value),
                                        );
                                      }).toList(),
                                    ),
             ),Text("    To    "),
             Container(  width:  getWidth*0.2,    color: Colors.white, child:DropdownButton<String>(  isExpanded: true,                              
                                      dropdownColor: Colors.white,
                                      //value: "Press to select sutible time",
                                      value: l2, icon: const Icon(Icons.arrow_drop_down),
                                      iconSize: 24,
                                      elevation: 16,
                                      style:  const TextStyle(color: Colors.deepPurple),
                                      onChanged: (String newValue) {
                                        setState(() {
                                          // print(dropdownValue);
                                          l2 = newValue;
                                        });
                                      },
                                      items: list.map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text("" + value),
                                        );
                                      }).toList(),
                                    ),
             ),
             ],),
                SizedBox(height: getHeight*0.05,), 
            
             




                Row(children: <Widget>[ Text("Tuesday",style: TextStyle(fontWeight: FontWeight.bold),),
                 SizedBox(width: getWidth*0.05,),Text("From    "),
             Container(  width:  getWidth*0.2,    color: Colors.white, child:DropdownButton<String>(  isExpanded: true,                              
                                      dropdownColor: Colors.white,
                                      //value: "Press to select sutible time",
                                      value: f3, icon: const Icon(Icons.arrow_drop_down),
                                      iconSize: 24,
                                      elevation: 16,
                                      style:  const TextStyle(color: Colors.deepPurple),
                                      onChanged: (String newValue) {
                                        setState(() {
                                          // print(dropdownValue);
                                          f3 = newValue;
                                        });
                                      },
                                      items: list.map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text("" + value),
                                        );
                                      }).toList(),
                                    ),
             ),Text("   To    "),
             Container(  width:  getWidth*0.2,    color: Colors.white, child:DropdownButton<String>(  isExpanded: true,                              
                                      dropdownColor: Colors.white,
                                      //value: "Press to select sutible time",
                                      value: l3, icon: const Icon(Icons.arrow_drop_down),
                                      iconSize: 24,
                                      elevation: 16,
                                      style:  const TextStyle(color: Colors.deepPurple),
                                      onChanged: (String newValue) {
                                        setState(() {
                                          // print(dropdownValue);
                                          l3 = newValue;
                                        });
                                      },
                                      items: list.map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text("" + value),
                                        );
                                      }).toList(),
                                    ),
             ),
                ],),
 SizedBox(height: getHeight*0.05,), 
                
                
                
                
                
                Row(children: <Widget>[ Text("Wednesday",style: TextStyle(fontWeight: FontWeight.bold),),
                 SizedBox(width: getWidth*0.05,),Text("From    "),
             Container(  width:  getWidth*0.2,    color: Colors.white, child:DropdownButton<String>(  isExpanded: true,                              
                                      dropdownColor: Colors.white,
                                      //value: "Press to select sutible time",
                                      value: f4, icon: const Icon(Icons.arrow_drop_down),
                                      iconSize: 24,
                                      elevation: 16,
                                      style:  const TextStyle(color: Colors.deepPurple),
                                      onChanged: (String newValue) {
                                        setState(() {
                                          // print(dropdownValue);
                                          f4 = newValue;
                                        });
                                      },
                                      items: list.map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text("" + value),
                                        );
                                      }).toList(),
                                    ),
             ),Text("   To    "),
             Container(  width:  getWidth*0.2,    color: Colors.white, child:DropdownButton<String>(  isExpanded: true,                              
                                      dropdownColor: Colors.white,
                                      //value: "Press to select sutible time",
                                      value: l4, icon: const Icon(Icons.arrow_drop_down),
                                      iconSize: 24,
                                      elevation: 16,
                                      style:  const TextStyle(color: Colors.deepPurple),
                                      onChanged: (String newValue) {
                                        setState(() {
                                          // print(dropdownValue);
                                          l4 = newValue;
                                        });
                                      },
                                      items: list.map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text("" + value),
                                        );
                                      }).toList(),
                                    ),
             ),
                ],),
 SizedBox(height: getHeight*0.05,), 







                Row(children: <Widget>[ Text("Thursday",style: TextStyle(fontWeight: FontWeight.bold),),
                 SizedBox(width: getWidth*0.05,),Text("From    "),
             Container(  width:  getWidth*0.2,    color: Colors.white, child:DropdownButton<String>(  isExpanded: true,                              
                                      dropdownColor: Colors.white,
                                      //value: "Press to select sutible time",
                                      value: f5, icon: const Icon(Icons.arrow_drop_down),
                                      iconSize: 24,
                                      elevation: 16,
                                      style:  const TextStyle(color: Colors.deepPurple),
                                      onChanged: (String newValue) {
                                        setState(() {
                                          // print(dropdownValue);
                                          f5 = newValue;
                                        });
                                      },
                                      items: list.map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text("" + value),
                                        );
                                      }).toList(),
                                    ),
             ),Text("   To    "),
             Container(  width:  getWidth*0.2,    color: Colors.white, child:DropdownButton<String>(  isExpanded: true,                              
                                      dropdownColor: Colors.white,
                                      //value: "Press to select sutible time",
                                      value: l5, icon: const Icon(Icons.arrow_drop_down),
                                      iconSize: 24,
                                      elevation: 16,
                                      style:  const TextStyle(color: Colors.deepPurple),
                                      onChanged: (String newValue) {
                                        setState(() {
                                          // print(dropdownValue);
                                          l5 = newValue;
                                        });
                                      },
                                      items: list.map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text("" + value),
                                        );
                                      }).toList(),
                                    ),
             ),
                ],),

 SizedBox(height: getHeight*0.05,), 






                Row(children: <Widget>[ Text("Friday",style: TextStyle(fontWeight: FontWeight.bold),),
                 SizedBox(width: getWidth*0.05,),Text("From    "),
             Container(  width:  getWidth*0.2,    color: Colors.white, child:DropdownButton<String>(  isExpanded: true,                              
                                      dropdownColor: Colors.white,
                                      //value: "Press to select sutible time",
                                      value: f6, icon: const Icon(Icons.arrow_drop_down),
                                      iconSize: 24,
                                      elevation: 16,
                                      style:  const TextStyle(color: Colors.deepPurple),
                                      onChanged: (String newValue) {
                                        setState(() {
                                          // print(dropdownValue);
                                          f6 = newValue;
                                        });
                                      },
                                      items: list.map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text("" + value),
                                        );
                                      }).toList(),
                                    ),
             ),Text("    To    "),
             Container(  width:  getWidth*0.2,    color: Colors.white, child:DropdownButton<String>(  isExpanded: true,                              
                                      dropdownColor: Colors.white,
                                      //value: "Press to select sutible time",
                                      value: l6, icon: const Icon(Icons.arrow_drop_down),
                                      iconSize: 24,
                                      elevation: 16,
                                      style:  const TextStyle(color: Colors.deepPurple),
                                      onChanged: (String newValue) {
                                        setState(() {
                                          // print(dropdownValue);
                                          l6 = newValue;
                                        });
                                      },
                                      items: list.map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text("" + value),
                                        );
                                      }).toList(),
                                    ),
             ),
                
                ],),
 SizedBox(height: getHeight*0.05,),




                Row(children: <Widget>[ Text("Suterday",style: TextStyle(fontWeight: FontWeight.bold),),
                 SizedBox(width: getWidth*0.05,),Text("From    "),
             Container(  width:  getWidth*0.2,    color: Colors.white, child:DropdownButton<String>(  isExpanded: true,                              
                                      dropdownColor: Colors.white,
                                      //value: "Press to select sutible time",
                                      value: f7, icon: const Icon(Icons.arrow_drop_down),
                                      iconSize: 24,
                                      elevation: 16,
                                      style:  const TextStyle(color: Colors.deepPurple),
                                      onChanged: (String newValue) {
                                        setState(() {
                                          // print(dropdownValue);
                                          f7 = newValue;
                                        });
                                      },
                                      items: list.map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text("" + value),
                                        );
                                      }).toList(),
                                    ),
             ),Text("   To    "),
             Container(  width:  getWidth*0.2,    color: Colors.white, child:DropdownButton<String>(  isExpanded: true,                              
                                      dropdownColor: Colors.white,
                                      //value: "Press to select sutible time",
                                      value: l7, icon: const Icon(Icons.arrow_drop_down),
                                      iconSize: 24,
                                      elevation: 16,
                                      style:  const TextStyle(color: Colors.deepPurple),
                                      onChanged: (String newValue) {
                                        setState(() {
                                          // print(dropdownValue);
                                          l7 = newValue;
                                        });
                                      },
                                      items: list.map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text("" + value),
                                        );
                                      }).toList(),
                                    ),
             ),
                
                ],),          
 SizedBox(height: getHeight*0.05,),
          ],),
        ),
              ],),
      ),
    );
  }
}
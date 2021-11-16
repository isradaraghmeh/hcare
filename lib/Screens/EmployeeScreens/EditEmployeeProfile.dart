// @dart=2.9
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../UserScreens/EditFirstNameScreen.dart';
import '../UserScreens/EditLastNameScreen.dart';
import '../UserScreens/EditPasswordScreen.dart';
import '../../Screens/EmployeeScreens/EditEmployeePhoneNumber.dart';
import '../../Screens/EmployeeScreens/EditEmployeeSpecialist.dart';
import '../../Screens/EmployeeScreens/EditEmloyeeImageScreen.dart';
import '../../Screens/EmployeeScreens/EditEmployeeAbout.dart';
import '../../Screens/EmployeeScreens/EditEmployeeExperinceAndCertifications.dart';
import '../../Forms/ConstantIP.dart';
// import '../../Screens/SignInScreen.dart';

class EditEmployeeProfile extends StatefulWidget {
  @override
  _EditEmployeeProfileState createState() => _EditEmployeeProfileState();
}

class _EditEmployeeProfileState extends State<EditEmployeeProfile> {
   var _currentEmail, _currentFirstname, _currentLastname, _currentPassword;
  bool isSignIn = false;




  @override
  void initState() {
    getPrefrences();
    super.initState();
  }




  getPrefrences() async {
    SharedPreferences prefrences = await SharedPreferences.getInstance();
    setState(
      () {
        _currentEmail = prefrences.getString("email");
        _currentFirstname = prefrences.getString("firstname");
        _currentLastname = prefrences.getString("lastname");
        _currentPassword = prefrences.getString("password");
       
      },
    );
    if (_currentEmail != null &&
        _currentFirstname != null &&
        _currentLastname != null &&
        _currentPassword != null) {
      setState(
        () {
          isSignIn = true;
          _currentEmail = prefrences.getString("email");
          _currentFirstname = prefrences.getString("firstname");
          _currentLastname = prefrences.getString("lastname");
          _currentPassword = prefrences.getString("password");
          // getWorkingHours();
        },
      );
    }

  }
  
  
 _pressSignin() async {
    getPrefrences();
      try{

if(_currentEmail!=null){
        var data={"email":_currentEmail};
        var url="http://"+ipAdressValue+"/HCare/getAuthenticationPage.php";
        var response=await http.post(Uri.parse(url),body:data);
        var responsebody=jsonDecode(response.body);
        if(responsebody['status']=="success"){
        
          return responsebody;
        }
}
      }catch(e){
          print(e.toString());
      }
   
  }

  Future getWorkingHours() async {
    try {
      if(_currentEmail!=null){
      var data = {"email": _currentEmail};
      var url = "http://10.0.2.2/HCare/getEditEmployeeInfo.php";
      var response = await http.post(Uri.parse(url), body: data);
      var responsebody = jsonDecode(response.body);

      if (responsebody['status'] == "success") {
        return responsebody;
      }
      }
    } catch (e) {
      print("Exception");
    }
  }
  
  
  
  
  
  @override
  Widget build(BuildContext context) {
    var getHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit profile"),
        backgroundColor: Theme.of(context).accentColor,
        elevation: 0,
        titleSpacing: 0,
      ),
      body: SingleChildScrollView(
              child: FutureBuilder(
                future: _pressSignin(),
                builder: (context, snapshot) {
                    //  if (snapshot.connectionState ==
                    //               ConnectionState.waiting)
                    //             return Text("   Loadding ...    ");
                  if(!snapshot.hasData)return Text("");

                  return FutureBuilder(
                    future: getWorkingHours(),
                    builder: (context, snapshot2) {
                      if(!snapshot2.hasData)return Text("");
                      return Container(
          margin: EdgeInsets.only(top:getHeight*0.04),
          child: Column(
            children: <Widget>[
                      FlatButton(
                        onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder:(context)=>EditFirstNameScreen(currentFirstname: snapshot.data['firstname'],currentEmail: _currentEmail,),),);
                        },
                        child: ListTile(
                          title: Text("First name"),
                          subtitle:snapshot.data['firstname']==null?Text(""): Text(snapshot.data['firstname']),
                          trailing: Icon(Icons.edit),
                        ),
                      ),
                      Divider(color: Colors.black,),
                      FlatButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder:(context)=>EditLastNameScreen(currentLastname: snapshot.data['lastname'],currentEmail: _currentEmail,),),);
                        },
                        child: ListTile(
                          title: Text("Last name"),
                          subtitle:snapshot.data['lastname']==null?Text(""): Text(snapshot.data['lastname']),
                          trailing: Icon(Icons.edit),
                        ),
                      ),
                        Divider(color: Colors.black,),
                      FlatButton(
                        onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder:(context)=>EditPasswordScreen(currentpassword: snapshot.data['password'], currentEmail: _currentEmail),),);
                        },
                        child: ListTile(
                          title: Text("Password"),
                          subtitle:Text("Change your password"),
                          trailing: Icon(Icons.edit),
                        ),
                      ),
                        Divider(color: Colors.black,),  
                      FlatButton(
                        onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder:(context)=>EditEmployeePhoneNumber(currentPhone: snapshot2.data['phone'], currentEmail: _currentEmail),),);
                        },
                        child: ListTile(
                          title: Text("Phone"),
                          subtitle:snapshot2.data['phone']==null?Text(""):Text(snapshot2.data['phone']),
                          trailing: Icon(Icons.edit),
                        ),
                      ),
     Divider(color: Colors.black,),
                          FlatButton(
                        onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder:(context)=>EditEmployeeImageScreen(currentEmail: _currentEmail,),),);
                        },
                        child: ListTile(
                          title: Text("Change image profile"),
                          //subtitle:_specialist==null?Text(""):Text(_specialist),
                          trailing: Icon(Icons.edit),
                        ),
                      ),



                        Divider(color: Colors.black,),
                          FlatButton(
                        onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder:(context)=>EditEmployeeSpecialist(currenSpecialist: snapshot2.data['specialist'], currentEmail: _currentEmail),),);
                        },
                        child: ListTile(
                          title: Text("Specialist"),
                          subtitle:snapshot2.data['specialist']==null?Text(""):Text(snapshot2.data['specialist']),
                          trailing: Icon(Icons.edit),
                        ),
                      ),
                        Divider(color: Colors.black,),
                           FlatButton(
                        onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder:(context)=>EditEmployeeExperinceAndCertifications(currentExperinceAndCertifications: snapshot2.data['experienceandcertifications'] , currentEmail: _currentEmail),),);
                        },
                        child: ListTile(
                          title: Text("ُExperince and certifications"),
                          subtitle:snapshot2.data['experienceandcertifications']==null?Text(""):Text(snapshot2.data['experienceandcertifications']),
                          trailing: Icon(Icons.edit),
                        ),
                      ),
                        Divider(color: Colors.black,),
                        
                        
                           FlatButton(
                        onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder:(context)=>EditEmployeeAbout(currentAbout: snapshot2.data['about']  , currentEmail: _currentEmail),),);
                        },
                        child: ListTile(
                          title: Text("ُAbout"),
                          subtitle:snapshot2.data['about']==null?Text(""):Text(snapshot2.data['about']),
                          trailing: Icon(Icons.edit),
                        ),
                      ),
                        Divider(color: Colors.black,),
                        
            ],
          ),
        );
                    }
                  );
                }
              ),
      ),
    );
  }
}



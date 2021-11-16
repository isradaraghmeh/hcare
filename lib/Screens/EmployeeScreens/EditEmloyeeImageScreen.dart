// @dart=2.9
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../Forms/ConstantIP.dart';

class EditEmployeeImageScreen extends StatefulWidget {
  final currentEmail;
  EditEmployeeImageScreen({this.currentEmail});
  @override
  _EditEmployeeImageScreenState createState() =>
      _EditEmployeeImageScreenState();
}

class _EditEmployeeImageScreenState extends State<EditEmployeeImageScreen> {
  File file;

  Future pickerCamera() async {
    final myfile = await ImagePicker().getImage(source: ImageSource.camera);
    setState(() {
      if (myfile != null) {
        file = File(myfile.path);
        //  print(file);
      }
    });
  }

  Future pickerGelary() async {
    final myfile = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      if (myfile != null) {
        file = File(myfile.path);
        //  print(file);
      }
    });
  }

  showFailedDialog(context, String title, String str) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(str),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK"))
            ],
          );
        });
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
                  onPressed: () {
                   // Navigator.of(context).pop();
                       Navigator.pop(context);
                  },
                  child: Text("OK"))
            ],
          );
        });
  }

  showLoaddingDialog(context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Row(
              children: <Widget>[
                Text("Loadding..."),
                CircularProgressIndicator(),
              ],
            ),
          );
        });
  }

  Future pressSave() async {
    if (file == null) return;
    try {
      String base64 = base64Encode(file.readAsBytesSync());
      String imagename = file.path.split('/').last;
      var url = "http://"+ipAdressValue+"/HCare/EditEmployeeImage.php";
      var data = {
        "imagename": imagename,
        "image64": base64,
        "email": widget.currentEmail,
      };
      var response = await http.post(Uri.parse(url), body: data);
      var responsebody = jsonDecode(response.body);
     // print(responsebody);
      if (responsebody['status'] == "success") {
       // Navigator.of(context).pop();
        completeDonecorrect(context, "Edit image profile",
            "Edit image profile done successfully");
      } else {
        Navigator.of(context).pop();
        showFailedDialog(
            context, "Edit image profile", "Edit image profile failed");
      }
    } catch (e) {
      Navigator.of(context).pop();
      print(e.toString());
    }
    // print(base64);
  }

  

  @override
  Widget build(BuildContext context) {
    var getAppHeight = AppBar().preferredSize.height;
    var getWidth = MediaQuery.of(context).size.width;
    var getHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        elevation: 0,
        titleSpacing: 0,
        title: Text('image'),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.save,
              ),
              iconSize: getAppHeight * 0.5,
              onPressed: () {
                pressSave();
              }),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              //     margin: EdgeInsets.only(left: getWidth*0.1),
              width: getWidth,
              height: getHeight * 0.4,
              //  color: Colors.red,
              child: file == null
                  ? Center(child: Text("No image selected"))
                  : Image.file(file),
            ),
            SizedBox(
              height: getHeight * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Theme.of(context).accentColor,
                  maxRadius: getWidth * 0.08,
                  minRadius: getWidth * 0.05,
                  child: IconButton(
                      icon: Icon(
                        Icons.add_a_photo,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        pickerCamera();
                      }),
                ),
                SizedBox(
                  width: getWidth * 0.05,
                ),
                CircleAvatar(
                  backgroundColor:Theme.of(context).accentColor,
                  maxRadius: getWidth * 0.08,
                  minRadius: getWidth * 0.05,
                  child: IconButton(
                      icon: Icon(
                        Icons.add_photo_alternate,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        pickerGelary();
                      }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

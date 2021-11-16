import 'package:flutter/material.dart';

import '../ConstantIP.dart';



class UserInfo extends StatefulWidget {
  final image,name;
   UserInfo({
    Key key,
  this.name,this.image}) : super(key: key);

  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {

  
  // @override
  // void initState() {
  //   print(widget.image);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: <Widget>[
          Container(child: CircleAvatar(radius: 15,backgroundImage: NetworkImage("http://"+ipAdressValue+"/HCare/upload/"+widget.image),),width: 100,height: 100,),
          // Image.network("http://10.0.2.2/HCare/upload/"+widget.image,fit: BoxFit.cover ,width: 100,height: 100,),
          SizedBox(width: 24,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
             
              Text(widget.name,style: TextStyle(fontSize: 12),)
            ],
          )
        ],
      ),
    );
  }
}
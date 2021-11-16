import 'package:flutter/material.dart';

class MyAppbar extends StatelessWidget {
  const MyAppbar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton( icon:  Icon(Icons.arrow_back), onPressed: (){
              Navigator.pop(context);
            },),
         //   Icon(Icons.menu, color: Color(0xFFBCCBF3),size: 36,)
          ],
        ),
      ),
    );
  }
}
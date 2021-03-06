import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:HCare/Forms/ConstantIP.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewWalletScreen extends StatefulWidget {
  @override
  _ViewWalletScreenState createState() => _ViewWalletScreenState();
}



class _ViewWalletScreenState extends State<ViewWalletScreen> {
  List<Color> _backgroundColor;
  Color _iconColor;
  Color _textColor;
  List<Color> _actionContainerColor;
  Color _borderContainer;
  bool colorSwitched = false;
  var logoImage, _currentEmail, _currentFirstname, _currentLastname, wallet;

  getPrefrences() async {
    SharedPreferences prefrences = await SharedPreferences.getInstance();
    setState(
          () {
        _currentEmail = prefrences.getString("email");
        _currentFirstname = prefrences.getString("firstname");
        _currentLastname = prefrences.getString("lastname");
      },
    );
    if (_currentEmail != null &&
        _currentFirstname != null &&
        _currentLastname != null) {
      setState(
            () {
          _currentEmail = prefrences.getString("email");
          _currentFirstname = prefrences.getString("firstname");
          _currentLastname = prefrences.getString("lastname");
        },
      );
    }
  }

  Future getWallet() async {
    try {
      var data = {"studentemail" : _currentEmail};
      print(data);
      var url = "http://" + ipAdressValue + "/HCare/GetWallet.php";
      var response = await http.post(Uri.parse(url),body: data);
      var responsebody = jsonDecode(response.body);
      print(responsebody['status']);
      if (responsebody['status'] == "success") {
        wallet = responsebody['wallet'];
        print (wallet);
        return responsebody;
      }
      //  return responsebody;
    } catch (e) {
      print(e.toString());
    }
  }

  void changeTheme() async {
    if (colorSwitched) {
      setState(() {
        logoImage = 'assets/images/wallet_dark_logo.png';
        _backgroundColor = [
          Color.fromRGBO(252, 214, 0, 1),
          Color.fromRGBO(251, 207, 6, 1),
          Color.fromRGBO(250, 197, 16, 1),
          Color.fromRGBO(249, 161, 28, 1),
        ];
        _iconColor = Colors.white;
        _textColor = Color.fromRGBO(253, 211, 4, 1);
        _borderContainer = Color.fromRGBO(34, 58, 90, 0.2);
        _actionContainerColor = [
          Color.fromRGBO(47, 75, 110, 1),
          Color.fromRGBO(43, 71, 105, 1),
          Color.fromRGBO(39, 64, 97, 1),
          Color.fromRGBO(34, 58, 90, 1),
        ];
      });
    } else {
      setState(() {
        logoImage = 'assets/images/wallet_logo.png';
        _borderContainer = Color.fromRGBO(252, 233, 187, 1);
        _backgroundColor = [
          Color.fromRGBO(249, 249, 249, 1),
          Color.fromRGBO(241, 241, 241, 1),
          Color.fromRGBO(233, 233, 233, 1),
          Color.fromRGBO(222, 222, 222, 1),
        ];
        _iconColor = Colors.black;
        _textColor = Colors.black;
        _actionContainerColor = [
          Color.fromRGBO(255, 212, 61, 1),
          Color.fromRGBO(255, 212, 55, 1),
          Color.fromRGBO(255, 211, 48, 1),
          Color.fromRGBO(255, 211, 43, 1),
        ];
      });
    }
  }

  @override
  void initState() {
    changeTheme();
    getPrefrences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Wallet"),
        titleSpacing: 0,
        elevation: 0,
        backgroundColor: Color.fromRGBO(255, 211, 48, 1),
        //Theme.of(context).accentColor,
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder(
          future:  getWallet(),
          builder: (context, snapshot) {
            if(!snapshot.hasData)return Text("Menawe");
            return SafeArea(
              child: GestureDetector(
                onLongPress: () {
                  if (colorSwitched) {
                    colorSwitched = false;
                  } else {
                    colorSwitched = true;
                  }
                  changeTheme();
                  },
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          stops: [0.2, 0.3, 0.5, 0.8],
                          colors: _backgroundColor)),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                        height: 20.0,
                      ),
                      Image.asset(
                        logoImage,
                        fit: BoxFit.contain,
                        height: 100.0,
                        width: 100.0,
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            'Hello',
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                          Text(
                            _currentFirstname + " " + _currentLastname,
                            style: TextStyle(
                                fontSize: 24,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Container(
                        height: 300.0,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: _borderContainer,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15))),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15)),
                                gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    stops: [0.2, 0.4, 0.6, 0.8],
                                    colors: _actionContainerColor)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  height: 70,
                                  child: Center(
                                    child: ListView(
                                      children: <Widget>[
                                        Text(
                                          wallet,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: _textColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 30),
                                        ),
                                        Text(
                                          'Available Cash',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: _iconColor, fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Divider(
                                  height: 0.5,
                                  color: Colors.grey,
                                ),
                                Table(
                                  border: TableBorder.symmetric(
                                    inside: BorderSide(
                                        color: Colors.grey,
                                        style: BorderStyle.solid,
                                        width: 0.5),
                                  ),
                                  children: [
                                    TableRow(children: [
                                      _actionList(
                                          'assets/images/ic_send.png', 'Send Money'),
                                      _actionList(
                                          'assets/images/ic_money.png', 'Request'),
                                    ]),
                                    TableRow(children: [
                                      _actionList('assets/images/ic_transact.png',
                                          'Transactions'),
                                      _actionList('assets/images/ic_reward.png',
                                          'Reward Points'),
                                    ])
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }
          ),
    );
  }

// custom action widget
  Widget _actionList(String iconPath, String desc) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            iconPath,
            fit: BoxFit.contain,
            height: 45.0,
            width: 45.0,
            color: _iconColor,
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            desc,
            style: TextStyle(color: _iconColor),
          )
        ],
      ),
    );
  }
}

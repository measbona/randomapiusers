import 'package:randomapiusers/randomuserhelper.dart';
import 'package:flutter/material.dart';
import './users_list.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    
    getData().then((post) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => UsersList()
        )
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final _orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 300,
              height: 300,
              child: Container(
                height: 50,
                width: 50,
                child: Image.asset("assets/images/randomapiusers_logo.png"),
              )
            ),
            SizedBox(
              width: 30,
              height: 30,
              child: CircularProgressIndicator(
                valueColor:AlwaysStoppedAnimation<Color>(Color(0xff5098e4)),
              ),
            ),
            SizedBox(
              height: _orientation == Orientation.portrait ? 160 : 0,
            ),
          ],
        ),
      ),
    );
  }
}

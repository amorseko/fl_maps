import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;
import 'dart:io';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  startTime() async {
    var _duration = new Duration(seconds: 4);

    return new Timer(_duration, navigationPage);
  }

  void navigationPage() async {
//    Navigator.of(context).pushReplacementNamed('/prelogin_menu');
    Navigator.pushNamedAndRemoveUntil(context, "/maps_page", (_) => false);

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Image.asset("assets/images/logo.png", width: MediaQuery.of(context).size.width/2,),
        ),
      ),
    );
  }
}
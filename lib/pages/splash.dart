import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashPage();
  }
}

class _SplashPage extends State<SplashPage> {
  Timer _timer;
  // SharedPreferences _prefs;
  @override
  void initState() {
    // initTimer();
    super.initState();
  }

  void initTimer() async {
  final SharedPreferences  _prefs = await SharedPreferences.getInstance();
    _timer = new Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed(
          _prefs.containsKey('token') ? '/menu' : '/login');
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
        initTimer();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      decoration: BoxDecoration(color: Colors.white),
      child: Image.asset('assets/images/logo.png'),
    );
  }
}

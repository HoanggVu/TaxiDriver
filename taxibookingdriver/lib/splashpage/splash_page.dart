import 'dart:async';

import 'package:flutter/material.dart';
import 'package:taxibookingdriver/global/global.dart';
import 'package:taxibookingdriver/methods/assistant_methods.dart';
import 'package:taxibookingdriver/sesources/home_page.dart';
import 'package:taxibookingdriver/sesources/login_page.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  startTimer() {
    Timer(const Duration(seconds: 3), () async {
      if( firebaseAuth.currentUser != null){
        firebaseAuth.currentUser != null ? AssistantMethods.readCurrentOnlineUserInfo() : null;
        Navigator.push(context, MaterialPageRoute(builder: (c) => MainPage()));
      }
      else{
        Navigator.push(context, MaterialPageRoute(builder: (c) => LoginPage(

        )));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          '3 Chị Em',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

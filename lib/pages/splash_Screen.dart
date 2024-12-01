import 'dart:async';

import 'package:flutter/material.dart';
import 'package:to_do_list/pages/home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 1,milliseconds: 50), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text.rich(
          TextSpan(
            children: [
              TextSpan( style: const TextStyle(fontSize: 25, color: Colors.blueGrey),
                text: 'To'
              ),
              TextSpan(
                text: 'Do ',
                style: TextStyle(
                  fontSize: 30,color: Colors.lightBlueAccent
                )
              ),
              TextSpan( style: TextStyle(
                  fontSize: 25,
                  color: Colors.blueGrey
                ),
                text: 'List'
              ),
            ]
          ),
        ),
      ),
    );
  }
}

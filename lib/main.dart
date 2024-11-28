import 'package:flutter/material.dart';
import 'package:to_do_list/pages/splash_Screen.dart';
import 'package:to_do_list/themes/themes.dart';

void main() {
  runApp(myApp());
}

class myApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To Do List',
      theme: lightMode,
      darkTheme: darkMode,
      home: SplashScreen(),
    );
  }
}

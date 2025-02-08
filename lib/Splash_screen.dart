import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:route_flutter_todo/provider/my_provider.dart';
import 'dart:async';

import 'package:route_flutter_todo/screens/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName="SplashScreen";
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WelcomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<MyProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.themeMode==ThemeMode.light?
      Color(0xffF2FEFF):Color(0xff101127
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
         Image.asset("assets/images/Logo.png",),
          Spacer(),
             Image.asset("assets/images/brand.png",),
        ],
      ),
    );
  }
}


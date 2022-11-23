import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class CustomLoadingScreen extends StatefulWidget {
  const CustomLoadingScreen({super.key});

  @override
  CustomLoadingScreenState createState() => CustomLoadingScreenState();
}

class CustomLoadingScreenState extends State<CustomLoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Text("Loading"),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

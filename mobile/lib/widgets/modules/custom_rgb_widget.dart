import 'package:flutter/material.dart';

import '../../models/module.dart';

class CustomRgb extends StatefulWidget {
  const CustomRgb({Key? key, required this.module}) : super(key: key);

  final Module module;

  @override
  State<CustomRgb> createState() => _CustomRgbState();
}

class _CustomRgbState extends State<CustomRgb> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Rgb"),
        automaticallyImplyLeading: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            width: double.infinity,
            child: Column(
              children: <Widget>[
                Text("Rgb"),
                Icon(Icons.light_mode),
                Text("0-255, 0-255, 0-255"),
                Text("0-1024"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

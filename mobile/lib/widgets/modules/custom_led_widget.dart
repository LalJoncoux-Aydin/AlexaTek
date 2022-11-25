import 'package:flutter/material.dart';

import '../../models/module.dart';

class CustomLed extends StatefulWidget {
  const CustomLed({Key? key, required this.module}) : super(key: key);

  final Module module;

  @override
  State<CustomLed> createState() => _CustomLedState();
}

class _CustomLedState extends State<CustomLed> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text("Led"),);
  }
}

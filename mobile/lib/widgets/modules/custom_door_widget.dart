import 'package:flutter/material.dart';

import '../../models/module.dart';

class CustomDoor extends StatefulWidget {
  const CustomDoor({Key? key, required this.module}) : super(key: key);

  final Module module;

  @override
  State<CustomDoor> createState() => _CustomDoorState();
}

class _CustomDoorState extends State<CustomDoor> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text("Door"),);
  }
}

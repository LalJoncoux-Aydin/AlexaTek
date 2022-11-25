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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Door"),
        automaticallyImplyLeading: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            width: double.infinity,
            child: Column(
              children: <Widget>[
                Text("Door"),
                Icon(Icons.door_back_door_outlined),
                Text("Angle 180°"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

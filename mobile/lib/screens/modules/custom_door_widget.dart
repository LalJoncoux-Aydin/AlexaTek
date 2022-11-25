import 'package:flutter/material.dart';

import '../../models/module.dart';
import '../module_screen.dart';

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
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () async {
                await Navigator.of(context).pushReplacement(
                    MaterialPageRoute<dynamic>(
                      builder: (BuildContext context) => const ModuleScreen(),
                    )
                ); },
            );
          },
        ),
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

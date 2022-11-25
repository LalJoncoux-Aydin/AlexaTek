import 'package:alexatek/screens/module_screen.dart';
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Led"),
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
                Text("Led"),
                Icon(Icons.lightbulb),
                Text("Open/Close"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

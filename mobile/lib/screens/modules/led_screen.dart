import 'package:alexatek/screens/module_screen.dart';
import 'package:flutter/material.dart';

import '../../models/module.dart';

class LedScreen extends StatefulWidget {
  const LedScreen({Key? key, required this.module}) : super(key: key);

  final Module module;

  @override
  State<LedScreen> createState() => _LedScreenState();
}

class _LedScreenState extends State<LedScreen> {
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
                Icon(Icons.lightbulb, size: 45,),

                Text("Open/Close"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

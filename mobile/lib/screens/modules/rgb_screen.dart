import 'package:flutter/material.dart';

import '../../models/module.dart';
import '../module_screen.dart';

class RgbScreen extends StatefulWidget {
  const RgbScreen({Key? key, required this.module}) : super(key: key);

  final Module module;

  @override
  State<RgbScreen> createState() => _RgbScreenState();
}

class _RgbScreenState extends State<RgbScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Rgb"),
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
                Text("Rgb"),
                Icon(Icons.light_mode),
                Text("0-255, 0-255, 0-255"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

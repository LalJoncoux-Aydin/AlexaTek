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
    return Container(child: Text("Rgb"),);
  }
}

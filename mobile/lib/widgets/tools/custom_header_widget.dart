import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({Key? key, required this.toDisplay}) : super(key: key);

  final String toDisplay;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      width: double.infinity,
      child: Text(
        toDisplay,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: thirdColor,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class CustomNavLink extends StatelessWidget {
  const CustomNavLink({Key? key, required this.displayText1, required this.displayText2, required this.onTapFunction})
      : super(key: key);

  final String displayText1;
  final String displayText2;
  final void Function() onTapFunction;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Text(displayText1, style: const TextStyle(color: thirdColor)),
          ),
          GestureDetector(
            onTap: onTapFunction,
            child: Text(displayText2, style: const TextStyle(color: mainColor, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }
}

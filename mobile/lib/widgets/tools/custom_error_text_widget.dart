import 'package:flutter/material.dart';

class CustomErrorText extends StatelessWidget {
  const CustomErrorText({Key? key, required this.displayStr}) : super(key: key);

  final String displayStr;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Text(displayStr, style: Theme.of(context).textTheme.headline2),
    );
  }
}

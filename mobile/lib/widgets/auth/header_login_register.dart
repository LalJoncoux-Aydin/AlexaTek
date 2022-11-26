import 'package:flutter/material.dart';

class HeaderLoginRegister extends StatelessWidget {
  const HeaderLoginRegister({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 30),
      child: const Text("AlexaTek", style: TextStyle(
        fontSize: 35,
      ),),
    );
  }
}

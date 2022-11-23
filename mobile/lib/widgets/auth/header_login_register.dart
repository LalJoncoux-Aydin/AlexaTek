import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/global_variables.dart';

class HeaderLoginRegister extends StatelessWidget {
  const HeaderLoginRegister({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 30),
      child: const Text("AlexaTek"),
    );
  }
}

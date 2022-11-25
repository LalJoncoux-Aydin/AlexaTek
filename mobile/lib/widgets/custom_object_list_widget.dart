import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/module.dart';
import '../utils/colors.dart';
import 'modules/custom_door_widget.dart';
import 'modules/custom_led_widget.dart';
import 'modules/custom_rgb_widget.dart';

class CustomObjectListWidget extends StatelessWidget {
  const CustomObjectListWidget({Key? key, required this.listObj}) : super(key: key);

  final List<Module> listObj;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      width: double.infinity,
      color: secondaryColor,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext ctx, int index) => Container(
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child:  GestureDetector(
            onTap: () => selectItem(listObj[index], context),
            child: Container(
              child: Text(listObj[index].name),
            ),
          ),
        ),
        itemCount: listObj.length,
      ),
    );
  }
}

Future<void> selectItem(Module module, BuildContext context) async {
  if (module.name == "led") {
    await Navigator.of(context).pushReplacement(
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => CustomLed(module: module),
        )
    );
  } else if (module.name == "rgb") {
    await Navigator.of(context).pushReplacement(
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => CustomRgb(module: module),
        )
    );
  } else {
    await Navigator.of(context).pushReplacement(
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => CustomDoor(module: module),
        )
    );
  }
}

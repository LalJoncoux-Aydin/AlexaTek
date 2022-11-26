import 'package:flutter/material.dart';

import '../../models/module.dart';
import '../../utils/colors.dart';

class CustomObjectItem extends StatelessWidget {
  const CustomObjectItem({Key? key, required this.obj, required this.selectItem}) : super(key: key);

  final Module obj;
  final Function(Module, BuildContext) selectItem;

  @override
  Widget build(BuildContext context) {
    IconData iconName = Icons.not_interested;
    Color iconColor = thirdColor;
    if (obj.name == "led") {
      if (obj.value == "1") {
        iconName = Icons.lightbulb;
      } else {
        iconName = Icons.lightbulb_outline;
      }
    } else if (obj.name == "rgb") {
      iconName = Icons.light_mode;
      iconColor = Color.fromRGBO(int.parse(obj.value!.split(',')[0]), int.parse(obj.value!.split(',')[1]), int.parse(obj.value!.split(',')[2]), 1.0);
    } else {
      if (obj.value == "180") {
        iconName = Icons.door_back_door;
      } else {
        iconName = Icons.door_back_door_outlined;
      }
    }

    return Container(
      child:  GestureDetector(
        onTap: () => selectItem(obj, context),
        child: Row(
          children: [
            Icon(iconName, color: iconColor),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 15),
                child: Text(obj.name),
              )
            ),
            Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(obj.value!),
                )
            ),
          ],
        )
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../models/module.dart';

class CustomObjectItem extends StatelessWidget {
  const CustomObjectItem({Key? key, required this.obj, required this.selectItem}) : super(key: key);

  final Module obj;
  final Function(Module, BuildContext) selectItem;

  @override
  Widget build(BuildContext context) {
    IconData iconName = Icons.not_interested;
    if (obj.name == "led") {
      iconName = Icons.lightbulb;
    } else if (obj.name == "rgb") {
      iconName = Icons.light_mode;
    } else {
      iconName = Icons.door_back_door;
    }

    return Container(
      child:  GestureDetector(
        onTap: () => selectItem(obj, context),
        child: Row(
          children: [
            Icon(iconName),
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

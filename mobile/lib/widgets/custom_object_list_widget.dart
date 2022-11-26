import 'package:alexatek/widgets/modules/custom_object_item.dart';
import 'package:flutter/material.dart';

import '../models/module.dart';
import '../utils/colors.dart';
import '../screens/modules/door_screen.dart';
import '../screens/modules/led_screen.dart';
import '../screens/modules/rgb_screen.dart';

class CustomObjectListWidget extends StatelessWidget {
  const CustomObjectListWidget({Key? key, required this.listObj}) : super(key: key);

  final List<Module> listObj;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: thirdColor,
          width: 1,
        ),
      ),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext ctx, int index) => Container(
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child:  GestureDetector(
            onTap: () => selectItem(listObj[index], context),
            child: CustomObjectItem(obj: listObj[index], selectItem: selectItem),
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
          builder: (BuildContext context) => LedScreen(module: module),
        )
    );
  } else if (module.name == "rgb") {
    await Navigator.of(context).pushReplacement(
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => RgbScreen(module: module),
        )
    );
  } else {
    await Navigator.of(context).pushReplacement(
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => DoorScreen(module: module),
        )
    );
  }
}

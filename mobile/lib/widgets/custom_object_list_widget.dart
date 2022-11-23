import 'package:flutter/cupertino.dart';

import '../models/connected_objects.dart';
import '../utils/colors.dart';

class CustomObjectListWidget extends StatelessWidget {
  const CustomObjectListWidget({Key? key, required this.listObj}) : super(key: key);

  final List<ConnectedObjects> listObj;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      width: double.infinity,
      color: secondaryColor,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext ctx, int index) => Container(
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Text(listObj[index].name),
        ),
        itemCount: listObj.length,
      ),
    );
  }
}

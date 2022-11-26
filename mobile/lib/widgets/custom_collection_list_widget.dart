import 'package:alexatek/models/collection_objects.dart';
import 'package:flutter/cupertino.dart';

import '../utils/colors.dart';

class CustomCollectionListWidget extends StatelessWidget {
  const CustomCollectionListWidget({Key? key, required this.listCollection}) : super(key: key);

  final List<CollectionObjects> listCollection;

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
          child: Text(listCollection[index].name),
        ),
        itemCount: listCollection.length,
      ),
    );
  }
}

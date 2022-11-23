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
      color: secondaryColor,
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

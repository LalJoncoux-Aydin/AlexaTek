import 'package:alexatek/models/collection_objects.dart';
import 'package:alexatek/widgets/custom_collection_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:alexatek/models/user.dart' as model;
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class CollectionScreen extends StatefulWidget {
  const CollectionScreen({Key? key}) : super(key: key);

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  late UserProvider userProvider;
  late model.User myUser;
  late List<CollectionObjects> listColl = <CollectionObjects>[];

  @override
  void initState() {
    super.initState();
    setupUser();
  }

  void setupUser() async {
    userProvider = Provider.of(context, listen: false);
    await userProvider.refreshUser();
    if (userProvider.isUser == true) {
      setState(() {
        myUser = userProvider.getUser;
        listColl = myUser.listCollection;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text("Collection"),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            width: double.infinity,
            child: Column(
              children: <Widget>[
                Text("Your collections"),
                CustomCollectionListWidget(listCollection: listColl),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

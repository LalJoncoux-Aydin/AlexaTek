import 'package:alexatek/models/collection_objects.dart';
import 'package:alexatek/widgets/custom_collection_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../providers/user_provider.dart';
import '../widgets/tools/custom_header_widget.dart';
import '../widgets/tools/custom_loading_screen.dart';

class CollectionScreen extends StatefulWidget {
  const CollectionScreen({Key? key}) : super(key: key);

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  late UserProvider userProvider;
  late User myUser;
  late List<CollectionObjects> listColl = <CollectionObjects>[];
  late bool _isLoadingUser = true;

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
        listColl = myUser.listCollection!;
        _isLoadingUser = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoadingUser == true) {
      return const CustomLoadingScreen();
    } else {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Collection"),
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  const CustomHeader(toDisplay: "Select a collection :"),
                  CustomCollectionListWidget(listCollection: listColl),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}

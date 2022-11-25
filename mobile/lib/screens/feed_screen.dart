import 'package:alexatek/models/connected_objects.dart';
import 'package:alexatek/widgets/custom_collection_list_widget.dart';
import 'package:alexatek/widgets/custom_object_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/collection_objects.dart';
import '../models/user.dart';
import '../providers/user_provider.dart';
import '../widgets/tools/custom_loading_screen.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  late UserProvider userProvider;
  late User myUser;
  late List<ConnectedObjects> listObj = <ConnectedObjects>[];
  late List<CollectionObjects> listColl = <CollectionObjects>[];
  late bool _isLoadingUser = true;

  @override
  void initState() {
    super.initState();
    setupUser();
  }

  void setupUser() async {
    userProvider = Provider.of(context, listen: false);
    print(userProvider.getToken);
    await userProvider.refreshUser();
    if (userProvider.isUser == true) {
      setState(() {
        myUser = userProvider.getUser;
        listObj = myUser.listObject!;
        listColl = myUser.listCollection!;
        _isLoadingUser = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
/*    if (_isLoadingUser == false) {
      return const CustomLoadingScreen();
    } else {*/
      return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text("Home"),
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  const Text("Welcome John !"),
                  CustomObjectListWidget(listObj: listObj),
                  CustomCollectionListWidget(listCollection: listColl),
                ],
              ),
            ),
            //CustomObjectListWidget(listObj: listObj),
          ),
        )
      );
 //   }
  }
}

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../models/connected_objects.dart';
import '../models/user.dart';
import '../providers/user_provider.dart';
import '../widgets/custom_object_list_widget.dart';

class ObjectScreen extends StatefulWidget {
  const ObjectScreen({Key? key}) : super(key: key);

  @override
  State<ObjectScreen> createState() => _ObjectScreenState();
}

class _ObjectScreenState extends State<ObjectScreen> {
  late UserProvider userProvider;
  late User myUser;
  late List<ConnectedObjects> listObj = <ConnectedObjects>[];

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
        listObj = myUser.listObject!;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text("Objects"),
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  Text("Your objects"),
                  CustomObjectListWidget(listObj: listObj),
                ],
              ),
            ),
          ),
        )
    );
  }
}

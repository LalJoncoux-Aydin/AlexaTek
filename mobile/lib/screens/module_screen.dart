import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../models/module.dart';
import '../models/user.dart';
import '../providers/user_provider.dart';
import '../widgets/custom_object_list_widget.dart';

class ModuleScreen extends StatefulWidget {
  const ModuleScreen({Key? key}) : super(key: key);

  @override
  State<ModuleScreen> createState() => _ModuleScreenState();
}

class _ModuleScreenState extends State<ModuleScreen> {
  late UserProvider userProvider;
  late User myUser;
  late List<Module> listObj = <Module>[];

  @override
  void initState() {
    super.initState();
    setupUser();
  }

  void setupUser() async {
    userProvider = Provider.of(context, listen: false);
    await userProvider.refreshModule();
    if (userProvider.isUser == true) {
      setState(() {
        listObj = userProvider.listModule;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Modules"),
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  Text("Your modules"),
                  CustomObjectListWidget(listObj: listObj),
                ],
              ),
            ),
          ),
        )
    );
  }
}

import 'package:alexatek/layout/screen_layout.dart';
import 'package:alexatek/methods/auth_methods.dart';
import 'package:alexatek/models/module.dart';
import 'package:alexatek/screens/auth/login_screen.dart';
import 'package:alexatek/widgets/custom_collection_list_widget.dart';
import 'package:alexatek/widgets/custom_object_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/collection_objects.dart';
import '../models/user.dart';
import '../providers/user_provider.dart';
import '../widgets/tools/custom_header_widget.dart';
import '../widgets/tools/custom_loading_screen.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  late UserProvider userProvider;
  late User myUser;
  late String name = "";
  late String surname = "";
  late String token = "";
  late List<Module> listObj = <Module>[];
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
    await userProvider.refreshModule();
    if (userProvider.isUser == true) {
      setState(() {
        myUser = userProvider.getUser;
        name = myUser.name;
        surname = myUser.surname;
        listColl = myUser.listCollection!;
        listObj = userProvider.listModule;
        token = userProvider.getToken;
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
          title: const Text("Home"),
          automaticallyImplyLeading: false,
          actions: [
            Container(
              padding: const EdgeInsets.only(right: 15),
              child: GestureDetector(
                onTap: () => logout(context),
                child: const Icon(Icons.logout),
              )
            )
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  CustomHeader(toDisplay: "Welcome $name $surname !"),
                  CustomObjectListWidget(listObj: listObj),
                  CustomCollectionListWidget(listCollection: listColl),
                ],
              ),
            ),
            //CustomObjectListWidget(listObj: listObj),
          ),
        )
      );
    }
  }

  Future<void> logout(BuildContext context) async {
    var res = await AuthMethods().resetSavedValues(token: token);
    if (res == "Success") {
      await Navigator.of(context).pushReplacement(
          MaterialPageRoute<dynamic>(
            builder: (BuildContext context) =>
            const ScreenLayout(loginScreen: LoginScreen(),),
          )
      );
    }
  }
}

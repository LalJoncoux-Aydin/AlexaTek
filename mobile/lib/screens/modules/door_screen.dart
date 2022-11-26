import 'package:alexatek/layout/screen_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../methods/auth_methods.dart';
import '../../models/module.dart';
import '../../providers/user_provider.dart';
import '../../widgets/modules/custom_open_close_button_widget.dart';
import '../../widgets/tools/custom_loading_screen.dart';

class DoorScreen extends StatefulWidget {
  const DoorScreen({Key? key, required this.module}) : super(key: key);

  final Module module;

  @override
  State<DoorScreen> createState() => _DoorScreenState();
}

class _DoorScreenState extends State<DoorScreen> {
  bool isOn = true;
  bool _isLoading = false;
  bool _isLoadingUser = true;
  String errorMessage = "";
  String token = "";
  late UserProvider userProvider;

  @override
  void initState() {
    super.initState();
    setupUser();
  }

  void setupUser() async {
    isOn = widget.module.value == "180" ? false : true;
    userProvider = Provider.of(context, listen: false);
    await userProvider.refreshUser();
    if (userProvider.isUser == true) {
      setState(() {
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
          title: const Text("Door"),
          automaticallyImplyLeading: true,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () async {
                  await Navigator.of(context).pushReplacement(
                      MaterialPageRoute<dynamic>(
                        builder: (BuildContext context) => const ScreenLayout(),
                      )
                  ); },
              );
            },
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  if (isOn == false) const Icon(Icons.door_back_door, size: 45,) else
                    const Icon(Icons.door_back_door_outlined, size: 45,),
                  if (_isLoading == true) const CircularProgressIndicator() else
                    CustomOpenCloseButton(
                      id: widget.module.id,
                      setLedOn: setDoorOpening,
                      isSwitched: isOn,
                    ),
                  if (errorMessage != "") Text(errorMessage),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }

  void setDoorOpening(bool value) async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().setDoorValue(
      id: widget.module.id,
      value: value == true ? "180" : "0",
      token: token,
    );

    if (res == "Success") {
      setState(() {
        isOn = !value;
      });
    } else {
      setState(() {
        errorMessage = res;
      });
    }
    setState(() {
      _isLoading = false;
    });
  }
}

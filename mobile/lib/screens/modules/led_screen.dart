import 'package:alexatek/methods/auth_methods.dart';
import 'package:alexatek/screens/module_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/module.dart';
import '../../providers/user_provider.dart';
import '../../widgets/modules/custom_open_close_button_widget.dart';
import '../../widgets/tools/custom_loading_screen.dart';

class LedScreen extends StatefulWidget {
  const LedScreen({Key? key, required this.module}) : super(key: key);

  final Module module;

  @override
  State<LedScreen> createState() => _LedScreenState();
}

class _LedScreenState extends State<LedScreen> {
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
          title: const Text("Led"),
          automaticallyImplyLeading: true,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () async {
                  await Navigator.of(context).pushReplacement(
                      MaterialPageRoute<dynamic>(
                        builder: (BuildContext context) => const ModuleScreen(),
                      )
                  );
                },
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
                  if (isOn == false) const Icon(Icons.lightbulb, size: 45,) else
                    const Icon(Icons.lightbulb_outline, size: 45,),
                  if (_isLoading == true) const CircularProgressIndicator() else
                    CustomOpenCloseButton(id: widget.module.id,
                      setLedOn: setLedOn,
                      isSwitched: isOn,),
                  if (errorMessage != "") Text(errorMessage),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }

  void setLedOn(bool value) async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().setLedValue(
      id: widget.module.id,
      value: value == true ? "0": "1",
      token: token,
    );
    setState(() {
      _isLoading = false;
    });

    if (res == "Success") {
      setState(() {
        isOn = !value;
      });
    } else {
      setState(() {
        errorMessage = res;
      });
    }
  }
}
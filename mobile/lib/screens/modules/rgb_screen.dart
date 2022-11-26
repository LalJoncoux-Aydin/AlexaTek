import 'package:alexatek/widgets/tools/custom_validation_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../layout/screen_layout.dart';
import '../../methods/auth_methods.dart';
import '../../models/module.dart';
import '../../providers/user_provider.dart';
import '../../utils/colors.dart';
import '../../widgets/tools/custom_loading_screen.dart';
import '../../widgets/tools/custom_text_form_field_widget.dart';

class RgbScreen extends StatefulWidget {
  const RgbScreen({Key? key, required this.module}) : super(key: key);

  final Module module;

  @override
  State<RgbScreen> createState() => _RgbScreenState();
}

class _RgbScreenState extends State<RgbScreen> {
  Color isColor = const Color.fromRGBO(175, 174, 174, 1.0);
  bool _isLoading = false;
  bool _isLoadingUser = true;
  String errorMessage = "";
  String token = "";
  late UserProvider userProvider;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late String value1 = "0";
  late String value2 = "0";
  late String value3 = "0";
  final TextEditingController _value1Controller = TextEditingController();
  final TextEditingController _value2Controller = TextEditingController();
  final TextEditingController _value3Controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _value1Controller.dispose();
    _value2Controller.dispose();
    _value3Controller.dispose();
  }

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
          title: const Text("Rgb"),
          automaticallyImplyLeading: true,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () async {
                  await Navigator.of(context).pushReplacement(
                      MaterialPageRoute<dynamic>(
                        builder: (BuildContext context) => const ScreenLayout(
                          loginScreen: null,
                        ),
                      )
                  );
                },
              );
            },
          ),
        ),
        body: SafeArea(
          child: Form(
            key: formKey,
            child: Center(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  width: double.infinity,
                  child: Column(
                    children: <Widget>[
                      Icon(Icons.light_mode, color: isColor, size: 45),
                      CustomTextFormField(hintText: '0-255', textEditingController: _value1Controller, isPass: false, isValid: valueIsValid(value1), updateInput: updateValue1,),
                      CustomTextFormField(hintText: '0-255', textEditingController: _value2Controller, isPass: false, isValid: valueIsValid(value2), updateInput: updateValue2,),
                      CustomTextFormField(hintText: '0-255', textEditingController: _value3Controller, isPass: false, isValid: valueIsValid(value3), updateInput: updateValue3,),
                      if (errorMessage != "") Text(errorMessage),
                      CustomValidationButton(displayText: "Confirm", formKey: formKey, loadingState: _isLoading, onTapFunction: setRgbColor, buttonColor: mainColor),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      );
    }
  }

  // Setters - Getters
  // Name update - IsValid
  void updateValue1(dynamic value) {
    setState(() {
      value1 = value;
    });
  }
  void updateValue2(dynamic value) {
    setState(() {
      value2 = value;
    });
  }
  void updateValue3(dynamic value) {
    setState(() {
      value3 = value;
    });
  }
  String? valueIsValid(dynamic value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }


  void setRgbColor(dynamic formKey, BuildContext? context) async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      String res = await AuthMethods().setRgbValue(
        id: widget.module.id,
        value1: value1,
        value2: value2,
        value3: value3,
        token: token,
      );

      if (res == "Success") {
        setState(() {
          isColor = Color.fromARGB(255, int.parse(value1), int.parse(value2), int.parse(value3));
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
}

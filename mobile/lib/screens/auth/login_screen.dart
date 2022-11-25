import 'package:flutter/material.dart';
import 'package:alexatek/methods/auth_methods.dart';
import 'package:alexatek/screens/auth/register_screen.dart';
import 'package:alexatek/widgets/tools/custom_error_text_widget.dart';
import 'package:provider/provider.dart';

import '../../layout/screen_layout.dart';
import '../../providers/user_provider.dart';
import '../../widgets/auth/custom_nav_link_widget.dart';
import '../../widgets/auth/header_login_register.dart';
import '../../widgets/tools/custom_text_form_field_widget.dart';
import '../../widgets/tools/custom_validation_button.dart';
import '../../utils/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  late String email = "";
  late String password = "";
  late String errorText = "";
  late UserProvider userProvider;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  void initState() {
    super.initState();
    setupUser();
  }

  void setupUser() async {
    userProvider = Provider.of(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    const HeaderLoginRegister(),
                    CustomTextFormField(hintText: 'Enter your email', textEditingController: _emailController, isPass: false, isValid: emailIsValid(email), updateInput: updateEmail),
                    CustomTextFormField(hintText: 'Enter your password', textEditingController: _passwordController, isPass: true, isValid: passwordIsValid(password), updateInput: updatePassword),
                    if (errorText != "") CustomErrorText(displayStr: errorText),
                    CustomValidationButton(displayText: 'Login', formKey: formKey, loadingState: _isLoading, onTapFunction: loginUser, buttonColor: mainColor),
                    CustomNavLink(displayText1: "Don't have an account ?", displayText2: "Register", onTapFunction: navigateToRegister),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void updateEmail(dynamic newMail) {
    setState(() {
      email = newMail;
    });
  }
  String? emailIsValid(dynamic value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
      return 'Please enter an email in the correct format';
    }
    return null;
  }

  void updatePassword(dynamic newPassword) {
    setState(() {
      password = newPassword;
    });
  }
  String? passwordIsValid(dynamic value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  void loginUser(dynamic formKey, BuildContext? context) async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      final String res = await AuthMethods().loginUser(
        email: _emailController.text,
        password: _passwordController.text,
      );
      setState(() {
        _isLoading = false;
      });

      // if res is Success, go to next page
      if (res == "server-error") {
        setState(() {
          errorText = "A server error happened : $res";
        });
      } else if (res == "credentials-error") {
        setState(() {
          errorText = "Credentials are incorrect.";
        });
      } else {
        userProvider.setupToken(res);
        await Navigator.of(context!).push(
          MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => const ScreenLayout(),
          ),
        );
      }
    }
  }

  void navigateToRegister() {
    Navigator.of(context).push(MaterialPageRoute<dynamic>(builder: (BuildContext context) => const RegisterScreen()));
  }
}

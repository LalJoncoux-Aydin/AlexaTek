import 'package:alexatek/layout/screen_layout.dart';
import 'package:flutter/material.dart';
import 'package:alexatek/screens/auth/login_screen.dart';
import 'package:provider/provider.dart';

import '../../methods/auth_methods.dart';
import '../../providers/user_provider.dart';
import '../../utils/colors.dart';
import '../../widgets/auth/custom_nav_link_widget.dart';
import '../../widgets/auth/header_login_register.dart';
import '../../widgets/tools/custom_error_text_widget.dart';
import '../../widgets/tools/custom_text_form_field_widget.dart';
import '../../widgets/tools/custom_validation_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  late String name = "";
  late String surname = "";
  late String email = "";
  late String password = "";
  late String errorText = "";
  late UserProvider userProvider;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _surnameController.dispose();
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
                    CustomTextFormField(hintText: 'Enter your name', textEditingController: _nameController, isPass: false, isValid: nameIsValid(name), updateInput: updateName,),
                    CustomTextFormField(hintText: 'Enter your surname', textEditingController: _surnameController, isPass: false, isValid: nameIsValid(surname), updateInput: updateSurname,),
                    CustomTextFormField(hintText: 'Enter your email', textEditingController: _emailController, isPass: false, isValid: emailIsValid(email), updateInput: updateEmail,),
                    CustomTextFormField(hintText: 'Enter your password', textEditingController: _passwordController, isPass: true, isValid: passwordIsValid(password), updateInput: updatePassword,),
                    if (errorText != "") CustomErrorText(displayStr: errorText),
                    CustomValidationButton(displayText: 'Register', formKey: formKey, loadingState: _isLoading, onTapFunction: registerUser, buttonColor: mainColor,),
                    CustomNavLink(displayText1: "Already have an account ?", displayText2: "Login", onTapFunction: navigateToLogin,),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


  // Setters - Getters
    // Name update - IsValid
  void updateName(dynamic newName) {
    setState(() {
      name = newName;
    });
  }
  void updateSurname(dynamic newName) {
    setState(() {
      surname = newName;
    });
  }
  String? nameIsValid(dynamic value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

    // Email update - IsValid
  void updateEmail(dynamic newMail) {
    setState(() {
      email = newMail;
    });
  }
  String? emailIsValid(dynamic value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    } else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
      return 'Please enter an email in the correct format';
    }
    return null;
  }

    // Password update - IsValid
  void updatePassword(dynamic newPassword) {
    setState(() {
      password = newPassword;
    });
  }
  String? passwordIsValid(dynamic value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    /*else if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(value)) {
      return 'Please enter a password with 8 characters length - 1 letters in Upper Case - 1 Special Character (!@#\$&*) - 1 numerals (0-9)';
    }*/
    return null;
  }


  // Methods
    // Register user into the server
  void registerUser(dynamic formKey, BuildContext? context) async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Back function
      var res = await AuthMethods().registerUser(
        name: _nameController.text,
        surname: _surnameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        group: "0",
      );
      setState(() {
        _isLoading = false;
      });

      if (res == "Success") {
        var loginRes = await AuthMethods().loginUser(
          email: _emailController.text,
          password: _passwordController.text,
        );
        userProvider.setupToken(loginRes);
        await Navigator.of(context!).pushReplacement(
            MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => const ScreenLayout(),
            )
        );
      } else {
        setState(() {
          errorText = "A server error happened : $res";
        });
      }
    }
  }

    // Navigate to login
  void navigateToLogin() {
    Navigator.of(context).maybePop(
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => const LoginScreen(),
      ),
    );
  }
}

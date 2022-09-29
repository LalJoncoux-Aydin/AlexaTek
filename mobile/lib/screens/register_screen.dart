import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instatek/resources/auth_methods.dart';
import 'package:instatek/screens/login_screen.dart';
import 'package:instatek/utils/colors.dart';

import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout_screen.dart';
import '../responsive/web_screen_layout.dart';
import '../utils/utils.dart';
import '../widgets/text_field_input.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  void registerUser() async {
    // set loading to true
    setState(() {
      _isLoading = true;
    });

    // signup user using our auth method
/*    String res = await AuthMethods().registerUser(
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text,
        bio: _bioController.text,
        profilePicture : _image,
    );*/
    String res = "Success";

    setState(() {
      _isLoading = false;
    });
    // if string returned is success, user has been created
    if (res == "Success") {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
          ),
        ),
      );
    } else {
      // show the error
      showSnackBar(context, res);
    }
  }

  void navigateToLogin() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
                child: _buildBodyContainer())
        ));
  }

  Widget _buildBodyContainer() {
    // For the spacing
    var size = MediaQuery
        .of(context)
        .size;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      width: double.infinity,
      child: Column(
        children: [
          _buildInput('Enter your username', _usernameController, false),
          _buildInput('Enter your email', _emailController, false),
          _buildInput('Enter your password', _passwordController, true),
          _buildInput('Enter your bio', _bioController, false),
          _buildButton('Register'),
          _buildNavLink("I already have an account", "Login"),
        ],
      ),
    );
  }

  Widget _buildInput(displayTxt, controller, pw) {
    return Column(
      children: [
        const SizedBox(height: 10),
        TextFieldInput(
          hintText: displayTxt,
          textInputType: TextInputType.text,
          textEditingController: controller,
          isPass: pw,
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildButton(displayTxt) {
    return Column(
      children: [
        const SizedBox(height: 14),
        InkWell(
          onTap: () => registerUser(),
          child: Container(
            width: double.infinity,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: const ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4),),
              ),
              color: blueColor,
            ),
            child: !_isLoading ? Text(displayTxt) : const CircularProgressIndicator(color: primaryColor),
          ),
        ),
        const SizedBox(height: 14),
      ],
    );
  }

  Widget _buildNavLink(displayText1, displayText2) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(displayText1),
            ),
            GestureDetector(
                onTap: navigateToLogin,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(displayText2,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ))
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }


}

import 'package:alexatek/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:alexatek/providers/user_provider.dart';
import 'package:alexatek/screens/auth/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'layout/screen_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildWidget>[
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(),
        ),
      ],
      builder: (BuildContext context, _) {
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          color: backgroundColor,
          title: 'Alexatek',
          home: ScreenLayout(
            loginScreen: LoginScreen(),
          ),
        );
      },
    );
  }
}

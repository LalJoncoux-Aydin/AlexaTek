import 'package:alexatek/utils/colors.dart';
import 'package:alexatek/widgets/tools/custom_loading_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:alexatek/providers/theme_provider.dart';
import 'package:alexatek/providers/user_provider.dart';
import 'package:alexatek/screens/auth/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'layout/screen_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyDdn1q0EK9RU1JMBtqPhfNNjMGUQV5TieE',
        appId: '1:254429523809:web:160dbab7037581ac0d5f20',
        messagingSenderId: '254429523809',
        projectId: 'alexatek-6fa75',
        storageBucket: 'alexatek-6fa75.appspot.com',
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
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
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
      ],
      builder: (BuildContext context, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          color: backgroundColor,
          title: 'Alexatek',
          home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  return const ScreenLayout();
                } else if (snapshot.hasError) {
                  return Center(child: Text('${snapshot.error}'));
                }
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CustomLoadingScreen();
              }
              return const LoginScreen();
            },
          ),
        );
      },
    );
  }
}

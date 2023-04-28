import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:taxibookingdriver/sesources/car_info_page.dart';
import 'package:taxibookingdriver/sesources/login_page.dart';
import 'package:taxibookingdriver/splashpage/splash_page.dart';
import 'package:taxibookingdriver/theme/theme_provider.dart';

Future<void> main() async {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.system,
      theme: Themes.lightTheme,
      darkTheme: Themes.darkTheme,
      debugShowCheckedModeBanner: false,
      home: const SplashPage(),
    );
  }
}
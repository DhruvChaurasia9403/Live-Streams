import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:streamstreak/Config/Theme.dart';
import 'package:streamstreak/Pages/PagePath/PagePath.dart';
import 'package:streamstreak/Pages/Welcome/WelcomePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      title: 'Live Streams',
      getPages: pagePath,
      darkTheme: darkTheme,
      home: const Welcomepage(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:streamstreak/Config/Theme.dart';
import 'package:streamstreak/Pages/HomePage/HomePage.dart';
import 'package:streamstreak/Pages/PagePath/PagePath.dart';
import 'package:streamstreak/Pages/Welcome/WelcomePage.dart';

void main() async {
  const String cloudName = "dgsxsujn9";
  const String apiKey = "298341531231328";
  const String apiSecret = "P8cYl99PCaAgDTvcJ7XKV6xwnLE";
  print("Cloudinary initialized for $cloudName");
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
      home: Welcomepage(),
    );
  }
}


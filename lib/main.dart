
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'views/home_page.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const OnchainHeritageApp());
}

class OnchainHeritageApp extends StatelessWidget {
  const OnchainHeritageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Onchain Heritage',
      theme: AppTheme.darkTheme,
      home: HomePage(),
    );
  }
}

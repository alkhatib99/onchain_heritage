import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onchain_heritage/core/routes/app_pages.dart';
import 'package:onchain_heritage/core/utils/app_const.dart';
import 'app/views/home_page.dart';
import 'core/theme/app_theme.dart';

void main() {
  runApp(const OnchainHeritageApp());
}

class OnchainHeritageApp extends StatelessWidget {
  const OnchainHeritageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

      title: AppConstnats.appName,
      theme: AppTheme.darkTheme,
      // home: HomePage(),
      // r
      getPages: AppPages.routes,
      initialRoute: AppPages.INITIAL,
      // defaultTransition: Transition.fadeIn,
    );
  }
}

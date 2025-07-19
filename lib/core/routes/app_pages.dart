import 'package:get/get.dart';
import 'package:onchain_heritage/app/bindings/home_binding.dart';
import 'package:onchain_heritage/app/bindings/splash_binding.dart';
import 'package:onchain_heritage/app/views/home_page.dart';
import 'package:onchain_heritage/app/views/splash_view.dart';
import 'package:onchain_heritage/core/routes/app_routes.dart';

class AppPages {
  static const INITIAL = AppRoutes.splash;

  static final routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    // inteaction page,
    // GetPage(

    //     name: AppRoutes.interaction,
    //     page: () => HomePage(),
    //     binding: HomeBinding(),
    // )
  ];
}

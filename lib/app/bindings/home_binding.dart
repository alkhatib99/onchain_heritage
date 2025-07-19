import 'package:get/get.dart';
import 'package:onchain_heritage/app/controllers/interaction_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<InteractionController>(() => InteractionController());
    // Get.lazyPut<SplashController>(() => SplashController());
  }
}
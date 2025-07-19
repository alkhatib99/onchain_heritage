import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onchain_heritage/core/routes/app_routes.dart';
 
class SplashController extends GetxController {
  final RxDouble logoOpacity = 0.0.obs;
  final RxDouble logoScale = 0.5.obs;
  final Rx<Offset> titleOffset = const Offset(0, 0.5).obs;
  final RxDouble titleOpacity = 0.0.obs;
  final Rx<Offset> subtitleOffset = const Offset(0, 0.5).obs;
  final RxDouble subtitleOpacity = 1.0.obs; // Changed to 1.0 for initial visibility
 
  @override
  void onReady() {
    super.onReady();
    print('SplashController onReady called'); // Debug print
    _startAnimation();
  }

  Future<void> _startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 500));
    logoOpacity.value = 1.0;
    logoScale.value = 1.0;

    await Future.delayed(const Duration(milliseconds: 800));
    titleOffset.value = Offset.zero;
    titleOpacity.value = 1.0;

    await Future.delayed(const Duration(milliseconds: 500));
    subtitleOffset.value = Offset.zero;
    subtitleOpacity.value = 1.0;

    await Future.delayed(const Duration(seconds: 2));
    
    // Check if there's an active session
    // if (_sessionService.isSessionActive.value && _sessionService.connectedAddress.value.isNotEmpty) {
    //   // If there's an active session, go to multi-send
    //   Get.offNamed(Routes.multiSend);
    // } else {
    //   // Otherwise, go to wallet connect
    //   Get.offNamed(Routes.walletConnect);
    // }
  
    Get.offNamed(AppRoutes.home);  

  }
}



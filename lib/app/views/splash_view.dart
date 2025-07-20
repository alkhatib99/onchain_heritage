import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onchain_heritage/app/controllers/splash_controller.dart';
import 'package:onchain_heritage/core/theme/app_theme.dart';
import 'package:onchain_heritage/core/utils/app_const.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final SplashController controller = Get.find();

    return Scaffold(
      backgroundColor: AppTheme.primaryBackground,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo with fade-in and scale animation
            Obx(
              () => AnimatedOpacity(
                opacity: controller.logoOpacity.value,
                duration: const Duration(seconds: 1),
                child: AnimatedScale(
                  scale: controller.logoScale.value,
                  duration: const Duration(seconds: 1),
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 150,
                        height: 150,
                        color: Colors.white,
                        child: const Icon(
                          Icons.image_not_supported,
                          size: 60,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            // Title with slide-up animation
            Obx(
              () => AnimatedSlide(
                offset: controller.titleOffset.value,
                duration: const Duration(seconds: 1),
                child: AnimatedOpacity(
                  opacity: controller.titleOpacity.value,
                  duration: const Duration(seconds: 1),
                  child: Text(
                    AppConstnats.appName,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: AppTheme.whiteText,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat', // Ensure Montserrat is used
                        ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Subtitle with slide-up animation
            Obx(
              () => AnimatedSlide(
                offset: controller.subtitleOffset.value,
                duration: const Duration(seconds: 1),
                child: AnimatedOpacity(
                  opacity: controller.subtitleOpacity.value,
                  duration: const Duration(seconds: 1),
                  child: Text(
                    'Loading...', // You can change this to a more dynamic loading text
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppTheme.lightGrayText,
                          fontFamily: 'Montserrat', // Ensure Montserrat is used
                        ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

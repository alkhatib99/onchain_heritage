import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onchain_heritage/theme/app_theme.dart';
import '../controllers/interaction_controller.dart';
import '../widgets/meta_mask_interaction_widget.dart';
import '../widgets/image_reveal_widget.dart';

class HomePage extends StatelessWidget {
  final InteractionController controller = Get.put(InteractionController());

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkTheme.scaffoldBackgroundColor,
      //  Colors.black,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Obx(() {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Onchain Heritage",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.darkTheme.textTheme.displayLarge?.color ??
                          Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  MetaMaskInteractionWidget(),
                  const SizedBox(height: 20),
                  Text(
                    "Total Interactions: \n ${controller.totalInteractions}",
                    style: TextStyle(
                      fontSize: 20,
                      color: AppTheme.darkTheme.textTheme.bodyLarge?.color ??
                          Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 30),
                  ImageRevealWidget(),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}

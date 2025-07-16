
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/interaction_controller.dart';

class ImageRevealWidget extends StatelessWidget {
  final InteractionController controller = Get.find();

  ImageRevealWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      int total = controller.totalInteractions.value;
      double percentageRevealed = (total / 100000).clamp(0.0, 1.0);

      return Container(
        width: 300,
        height: 300,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(border: Border.all(color: Colors.white24)),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'lib/assets/images/full_image.png',
                fit: BoxFit.cover,
                alignment: Alignment.topLeft,
              ),
            ),
            Positioned.fill(
              child: FractionallySizedBox(
                widthFactor: 1 - percentageRevealed,
                alignment: Alignment.topRight,
                child: Container(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

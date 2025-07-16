import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/interaction_controller.dart';

class ImageRevealWidget extends StatelessWidget {
  final controller = Get.find<InteractionController>();

  ImageRevealWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.blueGrey,
              ),
              child: Center(
                child: Text(
                  "${controller.totalInteractions.value}",
                  style: TextStyle(fontSize: 36, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: controller.walletAddress.isEmpty
                  ? null
                  : controller.participate,
              child: Text("Participate"),
            ),
          ],
        ));
  }
}

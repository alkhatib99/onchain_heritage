import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onchain_heritage/app/controllers/interaction_controller.dart';
import 'package:onchain_heritage/app/widgets/participate_button.dart';

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
            ParticipateButton(),
            // ElevatedButton(
            //   onPressed: controller.walletAddress.isEmpty
            //       ? null
            //       : controller.participate(context),
            //   child: Text("Participate"),
            // ),
          ],
        ));
  }
}

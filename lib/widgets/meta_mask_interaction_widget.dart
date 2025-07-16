import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/interaction_controller.dart';

class MetaMaskInteractionWidget extends StatelessWidget {
  final controller = Get.find<InteractionController>();

  MetaMaskInteractionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          children: [
            ElevatedButton.icon(
              icon: Icon(Icons.account_balance_wallet),
              label: Text(
                controller.walletAddress.isEmpty
                    ? "Connect Wallet"
                    : "Wallet: ${controller.walletAddress.value.substring(0, 6)}...",
              ),
              onPressed: controller.connectToMetaMask,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
              ),
            ),
            SizedBox(height: 10),
            if (controller.statusMessage.isNotEmpty)
              Text(controller.statusMessage.value,
                  style: TextStyle(color: Colors.white)),
          ],
        ));
  }
}

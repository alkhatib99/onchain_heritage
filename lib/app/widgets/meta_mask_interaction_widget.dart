import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_theme.dart';
import '../controllers/interaction_controller.dart';

class MetaMaskInteractionWidget extends StatelessWidget {
  final InteractionController controller = Get.find();

  MetaMaskInteractionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : controller.isMetaMaskInstalled
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MouseRegion(
                      onEnter: (_) => controller.isHovering.value = true,
                      onExit: (_) => controller.isHovering.value = false,
                      child: GestureDetector(
                        onTap: () => controller.walletAddress.isEmpty
                            ? controller.connectToMetaMask()
                            : controller.participate(context),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24.0, vertical: 12.0),
                          decoration: BoxDecoration(
                            color: controller.isHovering.value
                                ? AppTheme.buttonHoverColor
                                : AppTheme.buttonBackgroundColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.account_balance_wallet,
                                  color: Colors.white),
                              const SizedBox(width: 10),
                              Flexible(
                                child: Text(
                                  controller.walletAddress.isEmpty
                                      ? "Connect Wallet"
                                      : "${controller.walletAddress}"
                                          .replaceRange(8, 38, '...'),
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    if (controller.statusMessage.isNotEmpty)
                      Text(
                        controller.statusMessage.value,
                        style: const TextStyle(color: Colors.white),
                      ),
                  ],
                )
              : Column(
                  children: [
                    const Icon(Icons.warning, color: Colors.orange, size: 40),
                    const SizedBox(height: 10),
                    const Text(
                      "MetaMask not detected. Please install it to continue.",
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: controller.connectToMetaMask,
                      child: const Text("Install MetaMask"),
                    )
                  ],
                ),
    );
  }
}

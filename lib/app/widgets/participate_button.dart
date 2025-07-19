import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onchain_heritage/app/controllers/interaction_controller.dart';

class ParticipateButton extends StatelessWidget {
  final InteractionController controller = Get.find();

  ParticipateButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isHovering = controller.isHovering.value;
      final isPressed = controller.isPressed.value;
      final isLoading = controller.isParticipating.value;

      return MouseRegion(
        onEnter: (_) => controller.isHovering.value = true,
        onExit: (_) => controller.isHovering.value = false,
        child: GestureDetector(
          onTapDown: (_) => controller.isPressed.value = true,
          onTapUp: (_) => controller.isPressed.value = false,
          onTapCancel: () => controller.isPressed.value = false,
          onTap: () => controller.participate(context),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 150),
            padding: EdgeInsets.symmetric(
              vertical: 16,
              horizontal: isHovering ? 28 : 24,
            ),
            decoration: BoxDecoration(
              color: isLoading
                  ? Colors.grey.shade700
                  : isPressed
                      ? Colors.deepPurple.shade700
                      : isHovering
                          ? Colors.deepPurple.shade600
                          : Colors.deepPurple,
              borderRadius: BorderRadius.circular(14),
              boxShadow: isHovering
                  ? [
                      BoxShadow(
                        color: Colors.deepPurple.withOpacity(0.3),
                        blurRadius: 12,
                        offset: Offset(0, 6),
                      )
                    ]
                  : [],
            ),
            child: isLoading
                ? SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                        strokeWidth: 2, color: Colors.white),
                  )
                : Text(
                    'Participate',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
          ),
        ),
      );
    });
  }
}

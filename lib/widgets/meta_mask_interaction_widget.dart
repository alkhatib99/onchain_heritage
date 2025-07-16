
import 'dart:convert';
import 'dart:html';
import 'dart:js' as js;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';
import '../controllers/interaction_controller.dart';

class MetaMaskInteractionWidget extends StatelessWidget {
  final InteractionController controller = Get.find();

  MetaMaskInteractionWidget({super.key});

  void connectToMetaMask() {
    final ethereum = js.context['ethereum'];
    if (ethereum != null) {
      js.context.callMethod('eval', [
        '''
        ethereum.request({ method: 'eth_requestAccounts' }).then(accounts => {
          window.dispatchEvent(new CustomEvent('walletConnected', { detail: accounts[0] }));
        });
        '''
      ]);
    } else {
      window.alert("MetaMask is not available. Please install it.");
    }
  }

  void setupListener() {
    window.on['walletConnected']?.listen((event) {
      final address = event is CustomEvent ? event.detail.toString() : '';
      controller.setWalletAddress(address);
    });
  }

  @override
  Widget build(BuildContext context) {
    setupListener();
    return Obx(() {
      return Column(
        children: [
          ElevatedButton(
            onPressed: connectToMetaMask,
            child: Text(controller.walletAddress.value.isEmpty
                ? "Connect MetaMask"
                : "Connected: ${controller.walletAddress.value.substring(0, 6)}..."),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: controller.participate,
            child: const Text("Leave My Mark"),
          ),
        ],
      );
    });
  }
}

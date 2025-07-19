import 'dart:async';
import 'dart:convert';
import 'dart:js_interop';
import 'dart:js_interop_unsafe';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';
import '../../core/utils/app_const.dart';
import '../../core/services/js_eth_provider.dart';

@JS('window.ethereum.request')
external JSObject ethRequest(JSObject options);

class InteractionController extends GetxController {
  final isWeb = kIsWeb.obs;
  final isLoading = false.obs;
  final isParticipating = false.obs;
  final isConnected = false.obs;

  var isHovering = false.obs;
  var isPressed = false.obs;
  final isWalletConnected = false.obs;
  final isMetaMaskInstalled = kIsWeb && ethereum != null.obs;
  final isMetaMaskConnected = false.obs;
  final isMetaMaskConnecting = false.obs;
  final isMetaMaskDisconnected = false.obs;
  final isMetaMaskError = false.obs;
  final isMetaMaskErrorMessage = ''.obs;
  final isMetaMaskAccountChanged = false.obs;
  final isMetaMaskNetworkChanged = false.obs;
  final isMetaMaskChainChanged = false.obs;
  final isMetaMaskPermissionDenied = false.obs;
  final isMetaMaskPermissionGranted = false.obs;
  final isMetaMaskPermissionRequesting = false.obs;
  final isMetaMaskPermissionGrantedMessage = ''.obs;
  final isMetaMaskPermissionDeniedMessage = ''.obs;
  final isMetaMaskPermissionRequestingMessage = ''.obs;
  final isMetaMaskPermissionGrantedAddress = ''.obs;
  final isMetaMaskPermissionDeniedAddress = ''.obs;
  final isMetaMaskPermissionRequestingAddress = ''.obs;
  final isMetaMaskPermissionGrantedChainId = ''.obs;
  final walletAddress = ''.obs;
  final totalInteractions = 0.obs;
  final statusMessage = ''.obs;

  late Web3Client web3client;
  late DeployedContract contract;
  late ContractFunction participateFunction;
  late ContractFunction totalInteractionsFunction;
  late EthereumAddress contractAddr;
  DateTime? _lastFetch;
  // final rpcUrl = AppConstnats.RPC_URL;
  final rpcUrl = AppConstnats.RPC_URL_ALCHEMY; // Use Alchemy RPC URL
  // 'https://eth-sepolia.g.alchemy.com/v2/7K64JRQfwyx6SFyH62HPn7Je0-4c0jZu';

  final contractAddressHex = AppConstnats.CONTRACT_ADDRESS;

  @override
  void onInit() async {
    super.onInit();
    await initContract();
    // setupWalletListener();
  }

  Future<void> initContract() async {
    try {
      contractAddr = EthereumAddress.fromHex(contractAddressHex);
      web3client = Web3Client(rpcUrl, Client());
      final abiString =
          await rootBundle.loadString(AppConstnats.contractAbiPath);
      final abiJson = jsonDecode(abiString);

      contract = DeployedContract(
        ContractAbi.fromJson(jsonEncode(abiJson), 'OnchainHeritage'),
        contractAddr,
      );

      participateFunction = contract.function('participate');
      totalInteractionsFunction = contract.function('totalInteractions');
      fetchTotalInteractions();
    } catch (e) {
      statusMessage.value = 'Contract init failed: $e';
    }
  }

  void setupWalletListener({String? address}) {
    if (address != null && address.isNotEmpty) {
      walletAddress.value = address;
      statusMessage.value = 'Connected: ${address.substring(0, 6)}...';
      fetchTotalInteractions();
    } else {
      statusMessage.value = 'No wallet address provided.';
    }
  }

  Future<void> connectToMetaMask() async {
    if (!kIsWeb) {
      statusMessage.value = 'MetaMask is only supported on Web.';
      return;
    }
    // if()
    // isLoading.value = true;

    try {
      if (ethereum == null) {
        statusMessage.value = 'MetaMask not found. Please install it.';
        return;
      }
      if (walletAddress.isNotEmpty) {
        statusMessage.value =
            'Already connected: ${walletAddress.value.substring(0, 6)}...';
        return;
      }
      // Request accounts from MetaMask
      isLoading.value = true;
      // final accounts = await ethereum.request(List<String>['eth_accounts']);

      statusMessage.value = 'Connecting to MetaMask...';
      var address = await requestAccounts();
      setupWalletListener(address: address);
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      statusMessage.value = 'Connection failed: $e';
    }
    isConnected.value = walletAddress.isNotEmpty;
    if (isConnected.value) {
      statusMessage.value =
          'Connected: ${walletAddress.value.substring(0, 6)}...';
    } else {
      statusMessage.value = 'Connection failed. Please try again.' +
          (kIsWeb ? ' Ensure MetaMask is installed.' : '');
    }
  }

  Future<void> waitForConfirmation(String txHash) async {
    final eth = ethereum;
    if (eth == null) throw 'Ethereum provider not found';

    final req = createRequestParams();
    req.setProperty('method'.toJS, 'eth_getTransactionReceipt'.toJS);

    final checkInterval = Duration(seconds: 3);
    while (true) {
      final args = JSArray();
      args[0] = txHash.toJS;
      req.setProperty('params'.toJS, args);

      final result =
          await EthereumExtension(eth as Ethereum).request(req).toDart;
      final receipt = result.dartify();

      if (receipt != null && receipt is Map && receipt['status'] == '0x1') {
        print("✅ Tx confirmed!");
        return;
      }

      print("⏳ Waiting for confirmation...");
      await Future.delayed(checkInterval);
    }
  }

  void participate(BuildContext context) async {
    if (walletAddress.value.isEmpty) {
      statusMessage.value = 'Connect wallet first.';
      _showSnack(context, '⚠️ Connect wallet first.');
      HapticFeedback.vibrate();
      return;
    }

    isParticipating.value = true;
    isLoading.value = true;
    _showLoading();

    try {
      final dataHex = _getEncodedData();
      final txHash = await sendTransaction(
          walletAddress.value, contractAddressHex, dataHex);
      statusMessage.value = 'Tx sent: $txHash';

      await waitForConfirmation(txHash);
      await fetchTotalInteractions();

      statusMessage.value = '🎉 Participation successful!';
      _showSnack(context, '🎉 Participation confirmed!');
      HapticFeedback.lightImpact();
    } catch (e) {
      statusMessage.value = '❌ Transaction failed: $e';
      _showSnack(context, '❌ Transaction failed: $e');
      HapticFeedback.vibrate();
    } finally {
      _hideLoading();
      isLoading.value = false;
      isParticipating.value = false;
    }
  }

  String _getEncodedData() {
    final data = participateFunction.encodeCall([]);
    return bytesToHex(data, include0x: true);
  }

  Future<void> fetchTotalInteractions() async {
    try {
      final now = DateTime.now();
      if (_lastFetch != null && now.difference(_lastFetch!).inSeconds < 10) {
        return; // Avoid fetching too frequently
      }
      _lastFetch = now;

      final result = await web3client.call(
        contract: contract,
        function: totalInteractionsFunction,
        params: [],
      );
      totalInteractions.value = (result.first as BigInt).toInt();
    } catch (e) {
      statusMessage.value = 'Failed to load total: $e';
    }
  }

  void _showLoading() {
    Get.dialog(
      Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );
  }

  void _hideLoading() {
    if (Get.isDialogOpen ?? false) Get.back();
  }

  void _showSnack(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.black87,
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  void onClose() {
    web3client.dispose();
    super.onClose();
  }
}

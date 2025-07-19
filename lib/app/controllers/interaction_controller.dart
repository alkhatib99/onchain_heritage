import 'dart:async';
import 'dart:convert';
import 'dart:js_interop';
import 'package:flutter/foundation.dart';
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
  final walletAddress = ''.obs;
  final totalInteractions = 0.obs;
  final statusMessage = ''.obs;

  late Web3Client web3client;
  late DeployedContract contract;
  late ContractFunction participateFunction;
  late ContractFunction totalInteractionsFunction;
  late EthereumAddress contractAddr;

  final rpcUrl = AppConstnats.RPC_URL;
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

    try {
      final address = await requestAccounts();
      setupWalletListener(address: address);
    } catch (e) {
      statusMessage.value = 'Connection failed: $e';
    }
  }

  void participate() {
    if (walletAddress.value.isEmpty) {
      statusMessage.value = 'Connect wallet first.';
      return;
    }

    final dataHex = _getEncodedData();
    final txParams = JS('''
      {
        "method": "eth_sendTransaction",
        "params": [{
          "from": "${walletAddress.value}",
          "to": "$contractAddressHex",
          "data": "$dataHex"
        }]
      }
    ''') as JSObject;

    final promise = ethRequest(txParams);
    final completer = Completer<dynamic>();

    void onSuccess(JSAny result) => completer.complete(result.dartify());
    void onError(JSAny error) => completer.completeError(error.toString());

    (promise as dynamic).then((onSuccess).toJS, (onError).toJS);

    completer.future.then((txHash) {
      statusMessage.value = 'Tx sent: $txHash';
      fetchTotalInteractions();
    }).catchError((e) {
      statusMessage.value = 'Tx failed: $e';
    });
  }

  String _getEncodedData() {
    final data = participateFunction.encodeCall([]);
    return bytesToHex(data, include0x: true);
  }

  Future<void> fetchTotalInteractions() async {
    try {
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
}

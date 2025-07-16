import 'dart:convert';
import 'dart:html';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:onchain_heritage/utils/app_const.dart';
import 'package:web3dart/web3dart.dart';

class InteractionController extends GetxController {
  final walletAddress = ''.obs;
  final totalInteractions = 0.obs;

  late Web3Client web3client;
  late DeployedContract contract;
  late ContractFunction participateFunction;
  late ContractFunction totalInteractionsFunction;
  late EthereumAddress contractAddress;

  final rpcUrl = AppConstnats.RPC_URL; // 'https://sepolia.infura.io'; // Base Sepolia RPC
  // 'https://sepolia.base.org'; // Base Sepolia RPC
  final contractAddressHex = AppConstnats.CONTRACT_ADDRESS;
  

  // '0xce303e6041a8c86f273802559a1dfa0f846a6817'; // Replace with actual contract

  @override
  void onInit() {
    super.onInit();
    initContract();
  }

  void setWalletAddress(String address) {
    walletAddress.value = address;
    fetchTotalInteractions();
  }

  Future<void> initContract() async {
    web3client = Web3Client(rpcUrl, Client());
    contractAddress = EthereumAddress.fromHex(contractAddressHex);

    final abiString = await window.fetch('lib/assets/OnchainHeritage.abi.json')
      .then((res) => res.text());
    final abi = ContractAbi.fromJson(abiString, 'OnchainHeritage');

    contract = DeployedContract(abi, contractAddress);
    participateFunction = contract.function('participate');
    totalInteractionsFunction = contract.function('totalInteractions');

    fetchTotalInteractions();
  }

  Future<void> fetchTotalInteractions() async {
    if (web3client == null || contract == null) return;

    final result = await web3client.call(
      contract: contract,
      function: totalInteractionsFunction,
      params: [],
    );

    if (result.isNotEmpty) {
      totalInteractions.value = result[0].toInt();
    }
  }

  Future<void> participate() async {
    if (walletAddress.isEmpty) return;

    final encodedCall = participateFunction.encodeCall([]);
    final tx = {
      'from': walletAddress.value,
      'to': contractAddress.hex,
      'data': encodedCall,
    };

    final ethereum = (window as dynamic).ethereum;
    if (ethereum != null) {
      final txParams = jsify(tx);
      ethereum.callMethod('request', [jsify({
        'method': 'eth_sendTransaction',
        'params': [txParams]
      })]).then((_) {
        fetchTotalInteractions();
      }).catchError((err) {
        print("Error sending tx: \$err");
      });
    }
  }

  dynamic jsify(Map map) => map;
}

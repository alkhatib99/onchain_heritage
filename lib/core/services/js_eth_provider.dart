@JS()
library js_eth_provider;

import 'dart:async';
import 'dart:js_interop';
import 'dart:js_interop_unsafe';
import 'package:web/web.dart';

/// External JS functions to create JS objects
@JS('createRequestParams')
external JSObject createRequestParams();

@JS('createTxParams')
external JSObject createTxParams();

/// Global Ethereum provider from window.ethereum
@JS('window.ethereum')
external JSObject? get ethereum;

/// Global JS globalThis object
@JS('globalThis')
external JSObject get globalThisJS;

/// Interop class for Ethereum (window.ethereum)
@JS()
@staticInterop
class Ethereum {}

extension EthereumExtension on Ethereum {
  external JSPromise request(JSObject options);
}

/// Request MetaMask accounts via eth_requestAccounts
Future<String> requestAccounts() async {
  final eth = ethereum;
  if (eth == null) throw 'Ethereum provider not found';

  final req = createRequestParams();
  req.setProperty('method'.toJS, 'eth_requestAccounts'.toJS);
  req.setProperty('params'.toJS, JSArray());

  final promise = EthereumExtension(eth as Ethereum).request(req);
  final result = await promise.toDart;
  final accounts = result.dartify() as List?;
  if (accounts != null && accounts.isNotEmpty) return accounts.first.toString();
  throw 'No accounts returned';
}

/// Send transaction via MetaMask
Future<String> sendTransaction(String from, String to, String data) async {
  final eth = ethereum;
  if (eth == null) throw 'Ethereum provider not found';

  final tx = createTxParams();
  tx.setProperty('from'.toJS, from.toJS);
  tx.setProperty('to'.toJS, to.toJS);
  tx.setProperty('data'.toJS, data.toJS);

  final req = createRequestParams();
  req.setProperty('method'.toJS, 'eth_sendTransaction'.toJS);
  final params = JSArray();
  params[0] = tx;
  req.setProperty('params'.toJS, params);

  final promise = EthereumExtension(eth as Ethereum).request(req);
  final result = await promise.toDart;
  return result.toString();
}

/// Poll transaction receipt until confirmed
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

    final result = await EthereumExtension(eth as Ethereum).request(req).toDart;
    final receipt = result.dartify();

    if (receipt != null && receipt is Map && receipt['status'] == '0x1') {
      print("✅ Tx confirmed!");
      return;
    }

    print("⏳ Waiting for confirmation...");
    await Future.delayed(checkInterval);
  }
}

/// Set up 'walletConnected' listener using globalThis
void setupWalletListener(void Function(String) onConnect) {
  final JSFunction jsCallback = ((JSAny event) {
    final detail = (event as JSObject).getProperty('detail'.toJS);
    if (detail != null && detail is JSString) {
      onConnect(detail.toDart);
    }
  }).toJS;

  final args = JSArray();
  args[0] = 'walletConnected'.toJS;
  args[1] = jsCallback;

  globalThisJS.callMethod('addEventListener'.toJS, args);
}

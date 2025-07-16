@JS()
library js_eth_provider;

import 'dart:async';
import 'dart:js_interop';

/// Global Ethereum provider
@JS('window.ethereum')
external JSObject? get ethereum;

/// Global JS globalThis object
@JS('globalThis')
external JSObject get globalThisJS;

/// Request MetaMask accounts via eth_requestAccounts
Future<String> requestAccounts() async {
  final eth = ethereum;
  if (eth == null) throw 'Ethereum provider not found';

  final params = JS('{"method": "eth_requestAccounts"}') as JSObject;
  final promise = (eth as dynamic).request(params) as JSObject;

  final completer = Completer<dynamic>();
  void onFulfilled(JSAny result) => completer.complete(result.dartify());
  void onRejected(JSAny error) => completer.completeError(error.toString());
  (promise as dynamic).then( (onFulfilled) => onFulfilled(onFulfilled), (onRejected) => onRejected(onRejected) );

  final result = await completer.future;
  if (result is List && result.isNotEmpty) return result[0] as String;
  throw 'No accounts returned';
}

/// Set up 'walletConnected' listener using globalThis
void setupWalletListener(void Function(String) onConnect) {
  final JSFunction jsCallback = ((JSAny event) {
    final dynamic detail = (event as dynamic).detail;
    if (detail != null) onConnect(detail.toString());
  }) .toJS;

  (globalThisJS as dynamic).addEventListener('walletConnected', jsCallback);
}

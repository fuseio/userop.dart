import 'package:web3dart/json_rpc.dart';

class BundlerJsonRpcProvider extends JsonRPC {
  BundlerJsonRpcProvider(super.url, super.client);

  late JsonRPC? _bundlerRpc;
  final Set<String> _bundlerMethods = {
    'eth_sendUserOperation',
    'eth_estimateUserOperationGas',
    'eth_getUserOperationByHash',
    'eth_getUserOperationReceipt',
    'eth_supportedEntryPoints',
  };

  setBundlerRpc(String? bundlerRpc) {
    if (bundlerRpc != null) {
      _bundlerRpc = JsonRPC(bundlerRpc, client);
    }
    return this;
  }

  Future<dynamic> send(String method, List<dynamic> params) async {
    if (_bundlerRpc != null && _bundlerMethods.contains(method)) {
      return await _bundlerRpc?.call(method, params);
    }

    return await super.call(method, params);
  }
}

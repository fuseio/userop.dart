import 'package:web3dart/json_rpc.dart';

/// A wrapper over JsonRPC, specifically for the Bundler RPC.
///
/// It has the added ability to re-route bundler methods.
/// By default, userop.dart assumes both bundler and node methods share the same RPC url.
/// This class allows for these methods to be re-routed to a different endpoint if needed.
class BundlerJsonRpcProvider extends JsonRPC {
  /// The constructor takes [url] and [client] as input, which are passed to the parent JsonRPC class.
  BundlerJsonRpcProvider(super.url, super.client);

  late JsonRPC? _bundlerRpc;

  /// A set of method names that are specific to the bundler.
  /// These are the methods that this class can re-route if the `_bundlerRpc` is set.
  final Set<String> _bundlerMethods = {
    'eth_sendUserOperation',
    'eth_estimateUserOperationGas',
    'eth_getUserOperationByHash',
    'eth_getUserOperationReceipt',
    'eth_supportedEntryPoints',
  };

  /// Method to set the [_bundlerRpc].
  /// This can be used to specify a different endpoint for the bundler RPC.
  ///
  /// [bundlerRpc] should be the new RPC url for the bundler. If this is not null,
  /// all bundler-specific RPC methods will be sent to this new endpoint instead.
  setBundlerRpc(String? bundlerRpc) {
    if (bundlerRpc != null) {
      _bundlerRpc = JsonRPC(bundlerRpc, client);
    }
    return this;
  }

  /// Override of the parent class's `call` method. It takes the RPC [method] name and the [params] to pass to it.
  ///
  /// If the method name is in `_bundlerMethods` and `_bundlerRpc` has been set, it will call the method on the bundler RPC.
  /// If not, it will call the method on the default RPC.
  Future<dynamic> send(String method, List<dynamic> params) async {
    if (_bundlerRpc != null && _bundlerMethods.contains(method)) {
      return await _bundlerRpc?.call(method, params);
    }

    return await super.call(method, params);
  }
}

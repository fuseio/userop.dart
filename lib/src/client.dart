import 'package:http/http.dart' as http;
import 'package:userop/src/constants/erc_4337.dart';
import 'package:userop/src/context.dart';
import 'package:userop/src/extensions/filter_options.dart';
import 'package:userop/src/typechain/EntryPoint.g.dart';
import 'package:userop/src/types.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/json_rpc.dart';
import 'package:web3dart/web3dart.dart';

import 'provider.dart';

/// A Client class for interacting with an ERC-4337 bundler.
///
/// The `Client` class provides methods for building and sending user operations to the ERC-4337 bundler.
/// The class includes methods for both real and simulated (dry-run) operation sending.
class Client implements IClient {
  final Web3Client web3client;
  final RpcService jsonRpc;

  late BigInt chainId;
  late final EntryPoint entryPoint;
  late int waitTimeoutMs;
  late int waitIntervalMs;

  /// Constructor for `Client`.
  ///
  /// Initializes the `Web3Client`, `RpcService`, and other necessary properties.
  /// Requires an RPC bundler url for connection.
  Client(
    String rpcUrl, {
    IClientOpts? opts,
  })  : web3client = Web3Client.custom(
          JsonRPC(rpcUrl, http.Client()),
        ),
        waitTimeoutMs = 30000,
        waitIntervalMs = 5000,
        jsonRpc = BundlerJsonRpcProvider(
          rpcUrl,
          http.Client(),
        ).setBundlerRpc(
          opts?.overrideBundlerRpc,
        ) {
    entryPoint = EntryPoint(
      client: web3client,
      address: EthereumAddress.fromHex(ERC4337.ENTRY_POINT),
    );
  }

  /// Static initializer for `Client`.
  ///
  /// Fetches the `chainId` and returns a `Client` instance.
  static Future<IClient> init(String rpcUrl, {IClientOpts? opts}) async {
    final instance = Client(rpcUrl, opts: opts);
    instance.chainId = await instance.web3client.getChainId();

    return instance;
  }

  /// Builds a user operation.
  ///
  /// Accepts an `IUserOperationBuilder` and returns a built user operation.
  @override
  Future<IUserOperation> buildUserOperation(
    IUserOperationBuilder builder,
  ) async {
    return builder.buildOp(entryPoint.self.address, chainId);
  }

  /// Sends a user operation.
  ///
  /// Accepts an `IUserOperationBuilder` and optional send operation options.
  /// Returns a response containing the hash of the user operation and a wait function.
  @override
  Future<ISendUserOperationResponse> sendUserOperation(
    IUserOperationBuilder builder, {
    ISendUserOperationOpts? opts,
  }) async {
    final dryRun = opts?.dryRun ?? false;
    final op = await buildUserOperation(builder);
    opts?.onBuild?.call(op);

    final String userOpHash = dryRun
        ? bytesToHex(
            UserOperationMiddlewareCtx(op, entryPoint.self.address, chainId)
                .getUserOpHash(),
            include0x: true,
          )
        : (await jsonRpc("eth_sendUserOperation", [
            op.opToJson(),
            entryPoint.self.address.toString(),
          ]))
            .result as String;
    builder.resetOp();

    return ISendUserOperationResponse(
      userOpHash,
      () async {
        if (dryRun) {
          return null;
        }

        final end = DateTime.now().millisecondsSinceEpoch + waitTimeoutMs;
        final block = await web3client.getBlockNumber();
        while (DateTime.now().millisecondsSinceEpoch < end) {
          final userOperationEvent =
              entryPoint.self.event('UserOperationEvent');
          final filterEvent = await web3client
              .events(
                FilterUserOperationEventEventFilter.events(
                  contract: entryPoint.self,
                  event: userOperationEvent,
                  userOpHash: userOpHash,
                  fromBlock: BlockNum.exact(block - 100),
                ),
              )
              .take(1)
              .first;
          if (filterEvent.transactionHash != null) {
            return filterEvent;
          }

          await Future.delayed(Duration(milliseconds: waitIntervalMs));
        }

        return null;
      },
    );
  }
}

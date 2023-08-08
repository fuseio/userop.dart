import 'dart:typed_data';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/json_rpc.dart';
import 'package:http/http.dart' as http;

import '../../../userop.dart';
import '../../typechain/SimpleAccount.g.dart' as simple_account_impl;
import '../../types.dart';

extension E on String {
  String lastChars(int n) => substring(length - n);
}

/// A simple account class that extends the `UserOperationBuilder`.
/// This class provides methods for interacting with an 4337 simple account.
class SimpleAccount extends UserOperationBuilder {
  final EthPrivateKey credentials;

  /// The Bundler RPC service instance to interact with the network.
  late final RpcService provider;

  /// The EntryPoint object to interact with the ERC4337 EntryPoint contract.
  late final EntryPoint entryPoint;

  /// The factory instance to create simple account contracts.
  late final SimpleAccountFactory simpleAccountFactory;

  /// The initialization code for the contract.
  late String initCode;

  /// The proxy instance to interact with the SimpleAccount contract.
  late simple_account_impl.SimpleAccount proxy;

  SimpleAccount(
    this.credentials,
    String rpcUrl, {
    IPresetBuilderOpts? opts,
  }) : super() {
    final web3client = Web3Client.custom(BundlerJsonRpcProvider(
      rpcUrl,
      http.Client(),
    ).setBundlerRpc(
      opts?.overrideBundlerRpc,
    ));
    provider = BundlerJsonRpcProvider(rpcUrl, http.Client()).setBundlerRpc(
      opts?.overrideBundlerRpc,
    );
    entryPoint = EntryPoint(
      address: opts?.entryPoint ?? EthereumAddress.fromHex(ERC4337.ENTRY_POINT),
      client: web3client,
    );
    simpleAccountFactory = SimpleAccountFactory(
      address: opts?.simpleAccountFactoryAddress ??
          EthereumAddress.fromHex(ERC4337.SIMPLE_ACCOUNT_FACTORY),
      client: web3client,
    );
    initCode = '0x';
    proxy = simple_account_impl.SimpleAccount(
      address: EthereumAddress.fromHex(Addresses.AddressZero),
      client: web3client,
    );
  }

  /// Resolves the nonce and init code for the SimpleAccount contract creation.
  Future<void> resolveAccount(ctx) async {
    ctx.op.nonce = await entryPoint.getNonce(
      EthereumAddress.fromHex(ctx.op.sender),
      BigInt.zero,
    );
    ctx.op.initCode = ctx.op.nonce == BigInt.zero ? initCode : "0x";
  }

  /// Initializes a SimpleAccount object and returns it.
  static Future<SimpleAccount> init(
    EthPrivateKey credentials,
    String rpcUrl, {
    IPresetBuilderOpts? opts,
  }) async {
    final instance = SimpleAccount(credentials, rpcUrl, opts: opts);

    try {
      final List<String> inputArr = [
        instance.simpleAccountFactory.self.address.toString(),
        bytesToHex(
          instance.simpleAccountFactory.self
              .function('createAccount')
              .encodeCall(
            [
              credentials.address,
              opts?.salt ?? BigInt.zero,
            ],
          ),
          include0x: true,
        ),
      ];
      instance.initCode =
          '0x${inputArr.map((hexStr) => hexStr.toString().substring(2)).join('')}';
      final ethCallData = bytesToHex(
        instance.entryPoint.self.function('getSenderAddress').encodeCall([
          hexToBytes(instance.initCode),
        ]),
        include0x: true,
      );
      final rpcReponse = await instance.provider.call('eth_call', [
        {
          'to': instance.entryPoint.self.address.toString(),
          'data': ethCallData,
        }
      ]);
      throw rpcReponse;
    } on RPCError catch (e) {
      final smartContractAddress = '0x${(e.data as String).lastChars(40)}';
      instance.proxy = simple_account_impl.SimpleAccount(
        address: EthereumAddress.fromHex(smartContractAddress),
        client: instance.simpleAccountFactory.client,
      );
    }

    final baseInstance = instance
        .useDefaults({
          'sender': instance.proxy.self.address.toString(),
          'signature': bytesToHex(
            credentials.signPersonalMessageToUint8List(
              Uint8List.fromList('0xdead'.codeUnits),
            ),
            include0x: true,
          ),
        })
        .useMiddleware(instance.resolveAccount)
        .useMiddleware(getGasPrice(
          instance.simpleAccountFactory.client,
          instance.provider,
        ));

    final withPM = opts?.paymasterMiddleware != null
        ? baseInstance.useMiddleware(
            opts?.paymasterMiddleware as UserOperationMiddlewareFn)
        : baseInstance.useMiddleware(
            estimateUserOperationGas(
              instance.simpleAccountFactory.client,
              instance.provider,
            ),
          );

    return withPM.useMiddleware(eOASignature(instance.credentials))
        as SimpleAccount;
  }

  /// Executes a transaction on the network.
  Future<IUserOperationBuilder> execute(
    EthereumAddress to,
    BigInt value,
    Uint8List data,
  ) async {
    return setCallData(
      bytesToHex(
        proxy.self.function('execute').encodeCall(
          [to, value, data],
        ),
        include0x: true,
      ),
    );
  }

  /// Executes a batch transaction on the network.
  Future<IUserOperationBuilder> executeBatch(
    List<EthereumAddress> to,
    List<Uint8List> data,
  ) async {
    return setCallData(
      bytesToHex(
        proxy.self.function('executeBatch').encodeCall(
          [to, data],
        ),
        include0x: true,
      ),
    );
  }
}

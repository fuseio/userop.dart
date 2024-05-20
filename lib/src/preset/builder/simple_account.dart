import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:web3dart/crypto.dart';

import '../../../userop.dart';
import '../../typechain/SimpleAccount.g.dart' as simple_account_impl;
import '../../typechain/index.dart';

extension E on String {
  String lastChars(int n) => substring(length - n);
}

/// A simple account class that extends the `UserOperationBuilder`.
/// This class provides methods for interacting with an 4337 simple account.
class SimpleAccount extends UserOperationBuilder {
  final EthPrivateKey credentials;

  /// The EntryPoint object to interact with the ERC4337 EntryPoint contract.
  late final EntryPoint entryPoint;

  /// The factory instance to create simple account contracts.
  late final SimpleAccountFactory simpleAccountFactory;

  /// The initialization code for the contract.
  late String initCode;

  /// The nonce key to use the Semi-Abstract-Nonce mechanism.
  late final BigInt nonceKey;

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
    entryPoint = EntryPoint(
      address: opts?.entryPoint ?? EthereumAddress.fromHex(ERC4337.ENTRY_POINT),
      client: web3client,
    );
    simpleAccountFactory = SimpleAccountFactory(
      address: opts?.factoryAddress ??
          EthereumAddress.fromHex(ERC4337.SIMPLE_ACCOUNT_FACTORY),
      client: web3client,
    );
    initCode = '0x';
    nonceKey = opts?.nonceKey ?? BigInt.zero;
    proxy = simple_account_impl.SimpleAccount(
      address: EthereumAddress.fromHex(Addresses.AddressZero),
      client: web3client,
    );
  }

  /// Resolves the nonce and init code for the SimpleAccount contract creation.
  Future<void> resolveAccount(ctx) async {
    final results = await Future.wait([
      entryPoint.getNonce(
        (
          key: nonceKey,
          sender: EthereumAddress.fromHex(ctx.op.sender),
        ),
      ),
      entryPoint.client.makeRPCCall<String>('eth_getCode', [
        ctx.op.sender,
        'latest',
      ])
    ]);
    ctx.op.nonce = results[0];
    final code = results[1];
    ctx.op.initCode = code == "0x" ? initCode : "0x";
  }

  /// Initializes a SimpleAccount object and returns it.
  static Future<SimpleAccount> init(
    EthPrivateKey credentials,
    String rpcUrl, {
    IPresetBuilderOpts? opts,
  }) async {
    final instance = SimpleAccount(credentials, rpcUrl, opts: opts);

    final List<String> inputArr = [
      instance.simpleAccountFactory.self.address.toString(),
      bytesToHex(
        instance.simpleAccountFactory.self.function('createAccount').encodeCall(
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
    final smartContractAddress = await instance.simpleAccountFactory.getAddress(
      (
        owner: credentials.address,
        salt: opts?.salt ?? BigInt.zero,
      ),
    );
    instance.proxy = simple_account_impl.SimpleAccount(
      address: smartContractAddress,
      client: instance.simpleAccountFactory.client,
    );

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
        ));

    final withPM = opts?.paymasterMiddleware != null
        ? baseInstance.useMiddleware(
            opts?.paymasterMiddleware as UserOperationMiddlewareFn)
        : baseInstance.useMiddleware(
            estimateUserOperationGas(
              instance.simpleAccountFactory.client,
            ),
          );

    return withPM.useMiddleware(signUserOpHash(instance.credentials))
        as SimpleAccount;
  }

  /// Executes a transaction on the network.
  Future<IUserOperationBuilder> execute(
    Call call,
  ) async {
    return setCallData(
      bytesToHex(
        proxy.self.function('execute').encodeCall(
          [
            call.to,
            call.value,
            call.data,
          ],
        ),
        include0x: true,
      ),
    );
  }

  /// Executes a batch transaction on the network.
  Future<IUserOperationBuilder> executeBatch(
    List<Call> calls,
  ) async {
    return setCallData(
      bytesToHex(
        proxy.self.function('executeBatch').encodeCall(
          [
            calls.map((e) => e.to).toList(),
            calls.map((e) => e.data).toList(),
          ],
        ),
        include0x: true,
      ),
    );
  }
}

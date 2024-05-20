import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:web3dart/crypto.dart';

import '../../../userop.dart';
import '../../typechain/EtherspotWallet.g.dart' as etherspot_wallet_impl;
import '../../typechain/index.dart';

/// A EtherspotWallet class that extends the `UserOperationBuilder`.
/// This class provides methods for interacting with an 4337 EtherspotWallet.
class EtherspotWallet extends UserOperationBuilder {
  final EthPrivateKey credentials;

  /// The EntryPoint object to interact with the ERC4337 EntryPoint contract.
  late final EntryPoint entryPoint;

  /// The factory instance to create Etherspot Wallet contracts.
  late final EtherspotWalletFactory etherspotWalletFactory;

  /// The initialization code for the contract.
  late String initCode;

  /// The nonce key to use the Semi-Abstract-Nonce mechanism.
  late BigInt nonceKey;

  /// The proxy instance to interact with the EtherspotWallet contract.
  late etherspot_wallet_impl.EtherspotWallet proxy;

  EtherspotWallet(
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
    etherspotWalletFactory = EtherspotWalletFactory(
      address: opts?.factoryAddress ??
          EthereumAddress.fromHex(ERC4337.ETHERSPOT_WALLET_FACTORY),
      client: web3client,
    );
    initCode = '0x';
    nonceKey = opts?.nonceKey ?? BigInt.zero;
    proxy = etherspot_wallet_impl.EtherspotWallet(
      address: EthereumAddress.fromHex(Addresses.AddressZero),
      client: web3client,
    );
  }

  /// Resolves the nonce and init code for the EtherspotWallet contract creation.
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
      ]),
    ]);
    ctx.op.nonce = results[0];
    final code = results[1];
    ctx.op.initCode = code == "0x" ? initCode : "0x";
  }

  /// Initializes a EtherspotWallet object and returns it.
  static Future<EtherspotWallet> init(
    EthPrivateKey credentials,
    String rpcUrl, {
    IPresetBuilderOpts? opts,
  }) async {
    final instance = EtherspotWallet(credentials, rpcUrl, opts: opts);
    final List<String> inputArr = [
      instance.etherspotWalletFactory.self.address.toString(),
      bytesToHex(
        instance.etherspotWalletFactory.self
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

    final smartContractAddress =
        await instance.etherspotWalletFactory.getAddress(
      (
        index: opts?.salt ?? BigInt.zero,
        owner: credentials.address,
      ),
    );
    instance.proxy = etherspot_wallet_impl.EtherspotWallet(
      address: smartContractAddress,
      client: instance.etherspotWalletFactory.client,
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
          instance.etherspotWalletFactory.client,
        ));

    final withPM = opts?.paymasterMiddleware != null
        ? baseInstance.useMiddleware(
            opts?.paymasterMiddleware as UserOperationMiddlewareFn)
        : baseInstance.useMiddleware(
            estimateUserOperationGas(
              instance.etherspotWalletFactory.client,
            ),
          );

    return withPM.useMiddleware(signUserOpHash(instance.credentials))
        as EtherspotWallet;
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
            calls.map((e) => e.value).toList(),
            calls.map((e) => e.data).toList(),
          ],
        ),
        include0x: true,
      ),
    );
  }
}

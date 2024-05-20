import 'dart:typed_data';
import 'package:eth_sig_util/util/abi.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/json_rpc.dart';
import 'package:http/http.dart' as http;

import '../../../userop.dart';
import '../../typechain/Kernel.g.dart' as kernel_impl;
import '../../typechain/index.dart';

enum Operation {
  Call,
  DelegateCall,
}

/// A kernel class that extends the `UserOperationBuilder`.
/// This class provides methods for interacting with an 4337 ZeroDev Kernel.
class Kernel extends UserOperationBuilder {
  final EthPrivateKey credentials;

  /// The EntryPoint object to interact with the ERC4337 EntryPoint contract.
  late final EntryPoint entryPoint;

  /// The factory instance to create kernel contracts.
  late final ECDSAKernelFactory eCDSAKernelFactory;

  /// The factory instance to interact with the Multicall3 contract.
  late Multisend multisend;

  /// The initialization code for the contract.
  late String initCode;

  /// The nonce key to use the Semi-Abstract-Nonce mechanism.
  late final BigInt nonceKey;

  /// The proxy instance to interact with the Kernel contract.
  late kernel_impl.Kernel proxy;

  Kernel(
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
    eCDSAKernelFactory = ECDSAKernelFactory(
      address: opts!.factoryAddress!,
      client: web3client,
    );
    initCode = '0x';
    nonceKey = opts.nonceKey ?? BigInt.zero;
    multisend = Multisend(
      address: EthereumAddress.fromHex(Addresses.AddressZero),
      client: web3client,
    );
    proxy = kernel_impl.Kernel(
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
      ]),
    ]);
    ctx.op.nonce = results[0];
    final code = results[1];
    ctx.op.initCode = code == "0x" ? initCode : "0x";
  }

  Future<void> sudoMode(ctx) async {
    final inputArr = [
      KernelModes.SUDO,
      ctx.op.signature,
    ];
    final si =
        inputArr.map((hexStr) => hexStr.toString().substring(2)).join('');
    ctx.op.signature = bytesToHex(
      hexToBytes(si),
      include0x: true,
    );
  }

  /// Initializes a Kernel object and returns it.
  static Future<Kernel> init(
    EthPrivateKey credentials,
    String rpcUrl, {
    IPresetBuilderOpts? opts,
  }) async {
    final instance = Kernel(credentials, rpcUrl, opts: opts);

    try {
      final List<String> inputArr = [
        instance.eCDSAKernelFactory.self.address.toString(),
        bytesToHex(
          instance.eCDSAKernelFactory.self.function('createAccount').encodeCall(
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
      await instance.entryPoint.client.makeRPCCall('eth_call', [
        {
          'to': instance.entryPoint.self.address.toString(),
          'data': ethCallData,
        }
      ]);
    } on RPCError catch (e) {
      if (e.data == 'revert') {
        rethrow;
      }
      final smartContractAddress = '0x${(e.data as String).lastChars(40)}';
      final chain = await instance.eCDSAKernelFactory.client.getChainId();
      final ms = Safe().multiSend[chain.toString()];
      if (ms == null) {
        throw Exception(
          'Multisend contract not deployed on network: ${chain.toString()}',
        );
      }
      instance.multisend = Multisend(
        address: EthereumAddress.fromHex(ms),
        client: instance.multisend.client,
      );
      instance.proxy = kernel_impl.Kernel(
        address: EthereumAddress.fromHex(smartContractAddress),
        client: instance.proxy.client,
      );
    }

    final inputArr = [
      KernelModes.SUDO,
      bytesToHex(
        credentials.signPersonalMessageToUint8List(
          Uint8List.fromList('0xdead'.codeUnits),
        ),
        include0x: true,
      ),
    ];
    final signature =
        '0x${inputArr.map((hexStr) => hexStr.toString().substring(2)).join('')}';
    final baseInstance = instance
        .useDefaults({
          'sender': instance.proxy.self.address.toString(),
          'signature': bytesToHex(hexToBytes(signature), include0x: true),
        })
        .useMiddleware(instance.resolveAccount)
        .useMiddleware(getGasPrice(
          instance.eCDSAKernelFactory.client,
        ));

    final withPM = opts?.paymasterMiddleware != null
        ? baseInstance.useMiddleware(
            opts?.paymasterMiddleware as UserOperationMiddlewareFn)
        : baseInstance.useMiddleware(
            estimateUserOperationGas(
              instance.eCDSAKernelFactory.client,
            ),
          );

    return withPM
        .useMiddleware(signUserOpHash(instance.credentials))
        .useMiddleware(instance.sudoMode) as Kernel;
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
            BigInt.zero,
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
    final data = multisend.self.function('multiSend').encodeCall([
      Uint8List.fromList(calls
          .expand(
            (e) => AbiUtil.solidityPack(
              [
                "uint8",
                "address",
                "uint256",
                "uint256",
                "bytes",
              ],
              [
                0,
                e.to.addressBytes,
                e.value,
                e.data.length,
                e.data,
              ],
            ),
          )
          .toList()),
    ]);

    return setCallData(
      bytesToHex(
        proxy.self.function('execute').encodeCall(
          [
            multisend.self.address,
            BigInt.zero,
            data,
            BigInt.one,
          ],
        ),
        include0x: true,
      ),
    );
  }
}

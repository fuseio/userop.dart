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

const AddressZero = "0x0000000000000000000000000000000000000000";

class SimpleAccount extends UserOperationBuilder {
  final EthPrivateKey credentials;
  late final RpcService provider;
  late final EntryPoint entryPoint;
  late final SimpleAccountFactory simpleAccountFactory;
  late String initCode;
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
      address: EthereumAddress.fromHex(ERC4337.ENTRY_POINT),
      client: web3client,
    );
    simpleAccountFactory = SimpleAccountFactory(
      address: EthereumAddress.fromHex(ERC4337.SIMPLE_ACCOUNT_FACTORY),
      client: web3client,
    );
    initCode = '0x';
    proxy = simple_account_impl.SimpleAccount(
      address: EthereumAddress.fromHex(AddressZero),
      client: web3client,
    );
  }

  Future<void> resolveAccount(ctx) async {
    ctx.op.nonce = await entryPoint.getNonce(
      EthereumAddress.fromHex(ctx.op.sender),
      BigInt.zero,
    );
    ctx.op.initCode = ctx.op.nonce == BigInt.zero ? initCode : "0x";
  }

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

  Future<IUserOperationBuilder> executeBatch(
    List<EthereumAddress> to,
    List<Uint8List> data,
  ) async {
    return setCallData(
      bytesToHex(
        proxy.self.function('executeBatch').encodeCall([to, data]),
        include0x: true,
      ),
    );
  }
}

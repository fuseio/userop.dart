import 'dart:typed_data';

import 'package:userop/src/types.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/json_rpc.dart';
import 'package:web3dart/web3dart.dart';

class GasEstimate {
  BigInt? verificationGasLimit;
  BigInt preVerificationGas;
  BigInt callGasLimit;

  /// TODO: remove this with EntryPoint v0.7
  BigInt verificationGas;

  GasEstimate({
    this.verificationGasLimit,
    required this.preVerificationGas,
    required this.verificationGas,
    required this.callGasLimit,
  });
}

Future<BigInt> estimateCreationGas(
  Web3Client client,
  String initCode,
) async {
  print('initCode.codeUnits ${initCode.codeUnits}');
  final initCodeHex = bytesToHex(initCode.codeUnits);
  print('initCodeHex $initCodeHex');
  final factory = initCodeHex.substring(0, 42);
  final callData = "0x${initCodeHex.substring(42)}";
  return await client.estimateGas(
    to: factory as EthereumAddress,
    data: callData as Uint8List,
  );
}

UserOperationMiddlewareFn estimateUserOperationGas(
  Web3Client client,
  RpcService provider,
) {
  return (ctx) async {
    if (ctx.op.nonce == BigInt.zero) {
      ctx.op.verificationGasLimit = ctx.op.verificationGasLimit +
          await estimateCreationGas(
            client,
            ctx.op.initCode,
          );
    }

    final est = (await provider.call(
      'eth_estimateUserOperationGas',
      [ctx.op.toJson(), ctx.entryPoint],
    )) as GasEstimate;

    ctx.op.preVerificationGas = est.preVerificationGas;
    ctx.op.verificationGasLimit =
        est.verificationGasLimit ?? est.verificationGas;
    ctx.op.callGasLimit = est.callGasLimit;
  };
}

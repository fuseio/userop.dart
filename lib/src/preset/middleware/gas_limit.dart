import 'package:userop/src/constants/defaults.dart';
import 'package:userop/src/types.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/json_rpc.dart';
import 'package:web3dart/web3dart.dart';

import '../../models/index.dart';

Future<BigInt> estimateCreationGas(
  Web3Client client,
  String initCode,
) async {
  final initCodeHex = initCode;
  final factoryAddress = initCodeHex.substring(0, 42);
  final callData = "0x${initCodeHex.substring(42)}";
  return await client.estimateGas(
    to: EthereumAddress.fromHex(factoryAddress),
    data: hexToBytes(callData),
  );
}

UserOperationMiddlewareFn estimateUserOperationGas(
  Web3Client client,
  RpcService provider,
) {
  return (ctx) async {
    if (ctx.op.nonce.compareTo(BigInt.zero) == 0) {
      final currentVerificationGasLimit =
          ctx.op.verificationGasLimit ?? Defaults.defaultVerificationGasLimit;
      ctx.op.verificationGasLimit = currentVerificationGasLimit +
          await estimateCreationGas(client, ctx.op.initCode);
    }

    final rpcResponse = await provider.call(
      'eth_estimateUserOperationGas',
      [ctx.op.opToJson(), ctx.entryPoint.toString()],
    );
    final est = GasEstimate.fromJson(
      rpcResponse.result as Map<String, dynamic>,
    );
    ctx.op.preVerificationGas = BigInt.parse(est.preVerificationGas);
    ctx.op.verificationGasLimit = est.verificationGasLimit != null
        ? BigInt.parse(est.verificationGasLimit!)
        : BigInt.parse(est.verificationGas);
    ctx.op.callGasLimit = BigInt.parse(est.callGasLimit);
  };
}

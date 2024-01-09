import 'package:userop/src/types.dart';
import 'package:web3dart/json_rpc.dart';
import 'package:web3dart/web3dart.dart';

import '../../models/index.dart';

UserOperationMiddlewareFn estimateUserOperationGas(
  Web3Client client,
  RpcService provider,
) {
  return (ctx) async {
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

import 'package:web3dart/json_rpc.dart';

import '../../models/verifying_paymaster_result.dart';
import '../../types.dart';

UserOperationMiddlewareFn verifyingPaymaster(
  JsonRPC provider,
  Map<String, dynamic> context,
) {
  return (ctx) async {
    ctx.op.verificationGasLimit = ctx.op.verificationGasLimit * BigInt.from(3);

    final rpcResponse = await provider.call(
      'pm_sponsorUserOperation',
      [ctx.op.opToJson(), ctx.entryPoint.toString(), context],
    );

    final pm = VerifyingPaymasterResult.fromJson(
      rpcResponse.result as Map<String, dynamic>,
    );

    ctx.op.paymasterAndData = pm.paymasterAndData;
    ctx.op.preVerificationGas = BigInt.parse(pm.preVerificationGas);
    ctx.op.verificationGasLimit = BigInt.parse(pm.verificationGasLimit);
    ctx.op.callGasLimit = BigInt.parse(pm.callGasLimit);
  };
}

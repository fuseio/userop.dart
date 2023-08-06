import 'package:web3dart/json_rpc.dart';

import '../../models/verifying_paymaster_result.dart';
import '../../types.dart';

UserOperationMiddlewareFn verifyingPaymaster(
  JsonRPC provider,
  Map<String, dynamic> context,
) {
  return (ctx) async {
    ctx.op.verificationGasLimit = ctx.op.verificationGasLimit * BigInt.from(3);

    final result = await provider.call(
      'pm_sponsorUserOperation',
      [ctx.op.toJson(), ctx.entryPoint, context],
    );
    final pm = VerifyingPaymasterResult.fromJson(
      result as Map<String, dynamic>,
    );

    ctx.op.paymasterAndData = pm.paymasterAndData;
    ctx.op.preVerificationGas = pm.preVerificationGas;
    ctx.op.verificationGasLimit = pm.verificationGasLimit;
    ctx.op.callGasLimit = pm.callGasLimit;
  };
}

import 'package:http/http.dart';
import 'package:userop/userop.dart' hide Client;

import '../../models/verifying_paymaster_result.dart';

UserOperationMiddlewareFn verifyingPaymaster(
  String paymasterRpc,
  Map<String, dynamic> context,
) {
  return (ctx) async {
    ctx.op.verificationGasLimit = ctx.op.verificationGasLimit * BigInt.from(3);

    final provider = BundlerJsonRpcProvider(paymasterRpc, Client());
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

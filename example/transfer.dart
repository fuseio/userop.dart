import 'dart:io';

import 'package:userop/userop.dart';
// import 'package:http/http.dart' as http;
import 'package:web3dart/crypto.dart';

Future<void> main(List<String> arguments) async {
  final targetAddress = EthereumAddress.fromHex(arguments[0]);
  final amount = BigInt.parse(arguments[1]);
  final signingKey = EthPrivateKey.fromHex('YOUR_PRIVATE_KEY');
  final String bundlerRPC = 'YOUR_BUNDLER_RPC_URL';

  // final paymasterMiddleware = verifyingPaymaster(
  //   BundlerJsonRpcProvider('YOUR_PAYMASTER_SERVICE_URL', http.Client()),
  //   {},
  // );

  final IPresetBuilderOpts opts = IPresetBuilderOpts();
  // ..paymasterMiddleware = paymasterMiddleware;
  final simpleAccount = await SimpleAccount.init(
    signingKey,
    bundlerRPC,
    opts: opts,
  );

  final iClientOpts = IClientOpts()..overrideBundlerRpc = bundlerRPC;

  final client = await Client.init(
    bundlerRPC,
    opts: iClientOpts,
  );
  final sendOpts = ISendUserOperationOpts()
    ..dryRun = false
    ..onBuild = (IUserOperation ctx) async {
      print("Signed UserOperation: ${ctx.sender}");
    };

  final res = await client.sendUserOperation(
    await simpleAccount.execute(
      targetAddress,
      amount,
      hexToBytes('0x'),
    ),
    opts: sendOpts,
  );
  print('UserOpHash: ${res.userOpHash}');

  print('Waiting for transaction...');
  final ev = await res.wait();
  print('Transaction hash: ${ev?.transactionHash}');
  exit(1);
}

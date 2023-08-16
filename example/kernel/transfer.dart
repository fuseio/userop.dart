import 'dart:io';
import 'dart:typed_data';

import 'package:userop/userop.dart';

/// Run this example with: dart example/transfer.dart TARGET_ADDRESS VALUE_IN_WEI

Future<void> main(List<String> arguments) async {
  final targetAddress = EthereumAddress.fromHex(arguments[0]);
  final amount = BigInt.parse(arguments[1]);
  final signingKey = EthPrivateKey.fromHex('YOUR_PRIVATE_KEY');
  final bundlerRPC = 'YOUR_BUNDLER_RPC_URL';

  // final paymasterMiddleware = verifyingPaymaster(
  //   'YOUR_PAYMASTER_SERVICE_URL,
  //   {},
  // );

  // final opts = IPresetBuilderOpts()..paymasterMiddleware = paymasterMiddleware;
  final kernel = await Kernel.init(
    signingKey,
    bundlerRPC,
    // opts: opts,
  );

  final client = await Client.init(bundlerRPC);
  final sendOpts = ISendUserOperationOpts()
    ..dryRun = false
    ..onBuild = (IUserOperation ctx) {
      print("Signed UserOperation: ${ctx.sender}");
    };

  final call = Call(
    to: targetAddress,
    value: amount,
    data: Uint8List(0),
  );
  final res = await client.sendUserOperation(
    await kernel.execute(call),
    opts: sendOpts,
  );
  print('UserOpHash: ${res.userOpHash}');

  print('Waiting for transaction...');
  final ev = await res.wait();
  print('Transaction hash: ${ev?.transactionHash}');
  exit(1);
}

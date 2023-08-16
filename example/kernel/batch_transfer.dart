import 'dart:io';

import 'package:userop/userop.dart';

Future<void> main(List<String> arguments) async {
  final tokenAddress = arguments[0];
  final targetAddresses = List<String>.from(arguments[1].split(','));
  final amount = BigInt.parse(arguments[2]);
  final signingKey = EthPrivateKey.fromHex('YOUR_PRIVATE_KEY');
  final bundlerRPC = 'YOUR_BUNDLER_RPC_URL';

  // final paymasterMiddleware = verifyingPaymaster(
  //   'YOUR_PAYMASTER_SERVICE_URL',
  //   {},
  // );

  // final IPresetBuilderOpts opts = IPresetBuilderOpts()
  //   ..paymasterMiddleware = paymasterMiddleware;
  final kernel = await Kernel.init(
    signingKey,
    bundlerRPC,
    // opts: opts,
  );

  final client = await Client.init(
    bundlerRPC,
  );
  final ISendUserOperationOpts sendOpts = ISendUserOperationOpts()
    ..dryRun = false
    ..onBuild = (IUserOperation ctx) async {
      print("Signed UserOperation");
    };

  final List<Call> calls = [];
  targetAddresses.map((e) => e.trim()).forEach((ethereumAddress) {
    calls.add(
      Call(
        to: EthereumAddress.fromHex(tokenAddress),
        value: BigInt.zero,
        data: ContractsHelper.encodedDataForContractCall(
          'ERC20',
          tokenAddress,
          'transfer',
          [
            EthereumAddress.fromHex(ethereumAddress),
            amount,
          ],
          include0x: true,
        ),
      ),
    );
  });

  final userOp = await kernel.executeBatch(calls);

  final res = await client.sendUserOperation(
    userOp,
    opts: sendOpts,
  );

  print('UserOpHash: ${res.userOpHash}');

  print('Waiting for transaction...');
  final ev = await res.wait();
  print('Transaction hash: ${ev?.transactionHash}');
  exit(1);
}

import 'dart:io';

import 'package:userop/userop.dart';
// import 'package:web3dart/crypto.dart';

Future<void> main(List<String> arguments) async {
  final tokenAddress = EthereumAddress.fromHex(arguments[0]);
  final targetAddress = EthereumAddress.fromHex(arguments[1]);
  final amount = BigInt.parse(arguments[2]);
  final signingKey = EthPrivateKey.fromHex('YOUR_PRIVATE_KEY');
  final bundlerRPC = 'YOUR_BUNDLER_RPC_URL';

  // final paymasterMiddleware = verifyingPaymaster(
  //   'YOUR_PAYMASTER_SERVICE_URL',
  //   {},
  // );

  final IPresetBuilderOpts opts = IPresetBuilderOpts();
  // ..paymasterMiddleware = paymasterMiddleware;
  final etherspotWallet = await EtherspotWallet.init(
    signingKey,
    bundlerRPC,
    opts: opts,
  );

  final IClientOpts iClientOpts = IClientOpts()
    ..overrideBundlerRpc = bundlerRPC;

  final client = await Client.init(bundlerRPC, opts: iClientOpts);

  final sendOpts = ISendUserOperationOpts()
    ..dryRun = false
    ..onBuild = (IUserOperation ctx) {
      print("Signed UserOperation");
    };

  final call = Call(
    to: tokenAddress,
    value: BigInt.zero,
    data: ContractsHelper.encodedDataForContractCall(
      'ERC20',
      tokenAddress.toString(),
      'transfer',
      [
        targetAddress,
        amount,
      ],
      include0x: true,
    ),
  );

  final userOp = await etherspotWallet.execute(call);
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

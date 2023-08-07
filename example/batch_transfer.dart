import 'dart:io';
import 'dart:typed_data';

import 'package:userop/src/types.dart';
import 'package:userop/src/utils/contracts.dart';
import 'package:userop/userop.dart';
// import 'package:http/http.dart' as http;
// import 'package:web3dart/crypto.dart';

Future<void> main(List<String> arguments) async {
  final tokenAddress = arguments[0];
  final targetAddresses = List<String>.from(arguments[1].split(','));
  final amount = BigInt.parse(arguments[2]);
  final signingKey = EthPrivateKey.fromHex(
    'YOUR_PRIVATE_KEY',
  );
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

  final IClientOpts iClientOpts = IClientOpts()
    ..overrideBundlerRpc = bundlerRPC;
  final client = await Client.init(
    bundlerRPC,
    opts: iClientOpts,
  );
  final ISendUserOperationOpts sendOpts = ISendUserOperationOpts()
    ..dryRun = false
    ..onBuild = (IUserOperation ctx) async {
      print("Signed UserOperation");
    };

  final List<EthereumAddress> dest = [];
  final List<Uint8List> data = [];
  targetAddresses.map((e) => e.trim()).forEach((ethereumAddress) {
    dest.add(EthereumAddress.fromHex(tokenAddress));
    data.add(ContractsHelper.encodedDataForContractCall(
      'ERC20',
      tokenAddress,
      'transfer',
      [
        EthereumAddress.fromHex(ethereumAddress),
        amount,
      ],
      include0x: true,
    ));
  });
  final userOp = await simpleAccount.executeBatch(
    dest,
    data,
  );
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

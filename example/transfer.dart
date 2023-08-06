import 'package:userop/src/types.dart';
import 'package:userop/userop.dart';
import 'package:http/http.dart' as http;

Future<void> main(List<String> arguments) async {
  final signingKey = EthPrivateKey.fromHex(
    'YOUR_PRIVATE_KEY',
  );

  final String bundlerRPC = 'YOUR_BUNDLER_RPC_URL';

  final paymasterMiddleware = verifyingPaymaster(
    BundlerJsonRpcProvider('YOUR_PAYMASTER_SERVICE_URL', http.Client()),
    {},
  );

  final IPresetBuilderOpts opts = IPresetBuilderOpts()
    ..paymasterMiddleware = paymasterMiddleware;
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
  final ISendUserOperationOpts sendUserOperationOpts = ISendUserOperationOpts()
    ..dryRun = true
    ..onBuild = print;
  // final res = await client.sendUserOperation(
  //   // simpleAccount.execute(
  //   //   '0x7Ceabc27B1dc6A065fAD85A86AFBaF97F7692088',
  //   //   BigInt.from(0.00001),
  //   //   hexToBytes('0x'),
  //   // ),
  //   // opts: sendUserOperationOpts,
  // );
  // print('UserOpHash: ${res.userOpHash}');
  // final ev = await res.wait();
  // print('Event: $ev');
}

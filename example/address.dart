import 'package:userop/src/types.dart';
import 'package:userop/userop.dart';

Future<void> main(List<String> arguments) async {
  final signingKey = EthPrivateKey.fromHex(
    'YOUR_PRIVATE_KEY',
  );

  final String bundlerRPC = 'YOUR_BUNDLER_RPC_URL';

  // final paymasterMiddleware = verifyingPaymaster(
  //   'YOUR_PAYMASTER_SERVICE_URL',
  //   {},
  //   BundlerJsonRpcProvider('YOUR_PAYMASTER_SERVICE_URL', http.Client()),
  // );

  final IPresetBuilderOpts opts = IPresetBuilderOpts()
    ..overrideBundlerRpc = bundlerRPC;
  //   ..paymasterMiddleware = paymasterMiddleware;
  final simpleAccount = await SimpleAccount.init(
    signingKey,
    bundlerRPC,
    opts: opts,
  );

  print('SimpleAccount address: ${simpleAccount.getSender()}');
}

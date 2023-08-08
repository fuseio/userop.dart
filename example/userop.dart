import 'package:userop/userop.dart';

Future<void> main(List<String> arguments) async {
  final signingKey = EthPrivateKey.fromHex('YOUR_PRIVATE_KEY');
  final bundlerRPC = 'YOUR_BUNDLER_RPC_URL';

  final opts = IPresetBuilderOpts()..overrideBundlerRpc = bundlerRPC;
  final simpleAccount = await SimpleAccount.init(
    signingKey,
    bundlerRPC,
    opts: opts,
  );

  print('SimpleAccount address: ${simpleAccount.getSender()}');
}

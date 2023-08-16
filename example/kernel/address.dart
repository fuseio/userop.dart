import 'package:userop/userop.dart';

/// Run this example with: dart example/address.dart

Future<void> main(List<String> arguments) async {
  final signingKey = EthPrivateKey.fromHex('YOUR_PRIVATE_KEY');
  final bundlerRPC = 'YOUR_BUNDLER_RPC_URL';
  final opts = IPresetBuilderOpts()
    ..factoryAddress = EthereumAddress.fromHex(
      'YOUR_FACTORY_ADDRESS',
    );

  final kernel = await Kernel.init(
    signingKey,
    bundlerRPC,
    opts: opts,
  );

  print('Kernel address: ${kernel.getSender()}');
}

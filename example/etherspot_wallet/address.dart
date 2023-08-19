import 'dart:io';

import 'package:userop/userop.dart';

/// Run this example with: dart example/address.dart

Future<void> main(List<String> arguments) async {
  final signingKey = EthPrivateKey.fromHex('YOUR_PRIVATE_KEY');
  final bundlerRPC = 'YOUR_BUNDLER_RPC_URL';

  final etherspotWallet = await EtherspotWallet.init(
    signingKey,
    bundlerRPC,
  );

  print('Etherspot Wallet address: ${etherspotWallet.getSender()}');
  exit(1);
}

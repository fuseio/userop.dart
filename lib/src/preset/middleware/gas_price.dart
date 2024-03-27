import 'package:web3dart/web3dart.dart';

import 'package:userop/src/types.dart';

Future<Map<String, dynamic>> eip1559GasPrice(
  Web3Client client,
) async {
  final List<dynamic> results = await Future.wait([
    client.makeRPCCall<String>("eth_maxPriorityFeePerGas", []),
    client.getBlockInformation(),
  ]);

  final fee = results[0];
  final block = results[1] as BlockInformation;

  final tip = BigInt.parse(fee);
  final buffer = tip ~/ BigInt.from(100) * BigInt.from(13);
  final maxPriorityFeePerGas = tip + buffer;
  final maxFeePerGas = block.baseFeePerGas != null
      ? (block.baseFeePerGas!.getInWei * BigInt.from(2)) + maxPriorityFeePerGas
      : maxPriorityFeePerGas;

  return {
    'maxFeePerGas': maxFeePerGas,
    'maxPriorityFeePerGas': maxPriorityFeePerGas
  };
}

Future<Map<String, dynamic>> legacyGasPrice(Web3Client client) async {
  final gas = await client.getGasPrice();

  return {
    'maxFeePerGas': gas.getInWei,
    'maxPriorityFeePerGas': gas.getInWei,
  };
}

UserOperationMiddlewareFn getGasPrice(
  Web3Client client,
) {
  return (ctx) async {
    Object? eip1559Error;

    try {
      final gasPrices = await eip1559GasPrice(client);
      ctx.op.maxFeePerGas = gasPrices['maxFeePerGas'];
      ctx.op.maxPriorityFeePerGas = gasPrices['maxPriorityFeePerGas'];
      return;
    } catch (error) {
      eip1559Error = error;
    }

    try {
      final gasPrices = await legacyGasPrice(client);
      ctx.op.maxFeePerGas = gasPrices['maxFeePerGas'];
      ctx.op.maxPriorityFeePerGas = gasPrices['maxPriorityFeePerGas'];
      return;
    } catch (error) {
      throw Exception('$eip1559Error, $error');
    }
  };
}

import 'package:web3dart/json_rpc.dart';
import 'package:web3dart/web3dart.dart';

import '../../types.dart';

Future<Map<String, dynamic>> eip1559GasPrice(
  Web3Client client,
  RpcService provider,
) async {
  final List<dynamic> results = await Future.wait([
    provider.call("eth_maxPriorityFeePerGas", []),
    client.getBlockNumber(),
  ]);

  final fee = results[0] as String;

  final tip = BigInt.parse(fee);
  final mul = 100 * 13;
  final buffer = BigInt.parse((tip / BigInt.parse(mul.toString())) as String);
  final maxPriorityFeePerGas = tip + buffer;
  final maxFeePerGas = maxPriorityFeePerGas;

  return {
    'maxFeePerGas': maxFeePerGas.toString(),
    'maxPriorityFeePerGas': maxPriorityFeePerGas.toString()
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
  RpcService provider,
) {
  return (ctx) async {
    Object? eip1559Error;
    if (ctx.op.maxFeePerGas > BigInt.zero &&
        ctx.op.maxPriorityFeePerGas > BigInt.zero) {
      return;
    }

    try {
      final gasPrices = await eip1559GasPrice(client, provider);
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

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:userop/src/preset/middleware/gas_limit.dart';
import 'package:userop/src/types.dart';
import 'package:web3dart/web3dart.dart';

class MockWeb3Client extends Mock implements Web3Client {}
class MockIUserOperationMiddlewareCtx extends Mock implements IUserOperationMiddlewareCtx {}

void main() {
  group('estimateUserOperationGas middleware', () {
    late MockWeb3Client mockWeb3Client;
    late MockIUserOperationMiddlewareCtx mockCtx;
    late UserOperationMiddlewareFn middleware;

    setUp(() {
      mockWeb3Client = MockWeb3Client();
      mockCtx = MockIUserOperationMiddlewareCtx();
      middleware = estimateUserOperationGas(mockWeb3Client);
    });

    test('Correctly estimates gas and updates context', () async {
      when(mockWeb3Client.makeRPCCall<Map<String, dynamic>>(
        'eth_estimateUserOperationGas',
        any,
      )).thenAnswer((_) async => {
        'preVerificationGas': '0x5208',
        'verificationGasLimit': '0x186a0',
        'callGasLimit': '0x30d40',
      });

      await middleware(mockCtx);

      verify(mockCtx.op.preVerificationGas = BigInt.parse('0x5208'));
      verify(mockCtx.op.verificationGasLimit = BigInt.parse('0x186a0'));
      verify(mockCtx.op.callGasLimit = BigInt.parse('0x30d40'));
    });

    test('Handles RPC call failure gracefully', () {
      when(mockWeb3Client.makeRPCCall<Map<String, dynamic>>(
        'eth_estimateUserOperationGas',
        any,
      )).thenThrow(Exception('RPC call failed'));

      expect(() async => await middleware(mockCtx), throwsA(isA<Exception>()));
    });
  });
}

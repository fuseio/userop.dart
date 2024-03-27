import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:userop/src/preset/middleware/gas_limit.dart';
import 'package:userop/src/types.dart';
import 'package:web3dart/web3dart.dart';

class MockWeb3Client extends Mock implements Web3Client {}

void main() {
  group('estimateUserOperationGas', () {
    final mockWeb3Client = MockWeb3Client();
    final estimateUserOperationGasMiddleware = estimateUserOperationGas(mockWeb3Client);

    test('correctly updates UserOperationContext with gas estimates', () async {
      final ctx = UserOperationContext(op: UserOperation(), entryPoint: '0x123');
      when(mockWeb3Client.makeRPCCall<Map<String, dynamic>>(
        'eth_estimateUserOperationGas',
        any,
      )).thenAnswer((_) async => {
        'preVerificationGas': '1000',
        'verificationGasLimit': '2000',
        'callGasLimit': '3000',
        'verificationGas': '1500',
      });

      await estimateUserOperationGasMiddleware(ctx);

      expect(ctx.op.preVerificationGas, equals(BigInt.parse('1000')));
      expect(ctx.op.verificationGasLimit, equals(BigInt.parse('2000')));
      expect(ctx.op.callGasLimit, equals(BigInt.parse('3000')));
    });

    test('handles errors gracefully when RPC call fails', () async {
      final ctx = UserOperationContext(op: UserOperation(), entryPoint: '0x123');
      when(mockWeb3Client.makeRPCCall<Map<String, dynamic>>(
        'eth_estimateUserOperationGas',
        any,
      )).thenThrow(Exception('RPC error'));

      expect(() async => await estimateUserOperationGasMiddleware(ctx), throwsException);
    });
  });
}

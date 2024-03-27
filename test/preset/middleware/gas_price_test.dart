import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:userop/src/preset/middleware/gas_price.dart';
import 'package:web3dart/web3dart.dart';

class MockWeb3Client extends Mock implements Web3Client {}

void main() {
  group('Gas Price Middleware', () {
    MockWeb3Client mockWeb3Client;

    setUp(() {
      mockWeb3Client = MockWeb3Client();
    });

    group('eip1559GasPrice', () {
      test('returns correct gas prices on successful RPC calls', () async {
        when(mockWeb3Client.makeRPCCall<String>("eth_maxPriorityFeePerGas", []))
            .thenAnswer((_) async => '1000000000');
        when(mockWeb3Client.getBlockInformation())
            .thenAnswer((_) async => BlockInformation(baseFeePerGas: EtherAmount.inWei(BigInt.from(1000000000))));

        final result = await eip1559GasPrice(mockWeb3Client);

        expect(result['maxFeePerGas'], BigInt.from(2200000000));
        expect(result['maxPriorityFeePerGas'], BigInt.from(1130000000));
      });

      test('throws exception on RPC call failure', () {
        when(mockWeb3Client.makeRPCCall<String>("eth_maxPriorityFeePerGas", []))
            .thenThrow(Exception('RPC error'));

        expect(() async => await eip1559GasPrice(mockWeb3Client), throwsException);
      });
    });

    group('legacyGasPrice', () {
      test('returns correct gas prices on successful RPC call', () async {
        when(mockWeb3Client.getGasPrice())
            .thenAnswer((_) async => EtherAmount.inWei(BigInt.from(1000000000)));

        final result = await legacyGasPrice(mockWeb3Client);

        expect(result['maxFeePerGas'], BigInt.from(1000000000));
        expect(result['maxPriorityFeePerGas'], BigInt.from(1000000000));
      });

      test('throws exception on RPC call failure', () {
        when(mockWeb3Client.getGasPrice()).thenThrow(Exception('RPC error'));

        expect(() async => await legacyGasPrice(mockWeb3Client), throwsException);
      });
    });
  });
}

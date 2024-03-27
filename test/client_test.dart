import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:userop/src/client.dart';
import 'package:userop/src/provider.dart';
import 'package:userop/src/typechain/EntryPoint.g.dart';
import 'package:web3dart/web3dart.dart';

class MockWeb3Client extends Mock implements Web3Client {}

class MockEntryPoint extends Mock implements EntryPoint {}

void main() {
  group('Client', () {
    late MockWeb3Client mockWeb3Client;
    late MockEntryPoint mockEntryPoint;
    late Client client;
    const rpcUrl = 'http://localhost:8545';

    setUp(() {
      mockWeb3Client = MockWeb3Client();
      mockEntryPoint = MockEntryPoint();
      client = Client(rpcUrl);
    });

    test('initializes with correct RPC URL and options', () {
      expect(client.web3client, isA<Web3Client>());
      // Verifying the internal setup of BundlerJsonRpcProvider could be challenging without exposing internals,
      // so this test focuses on what can be observed or intercepted externally.
    });

    group('buildUserOperation', () {
      test('successfully builds user operation', () async {
        final builder = IUserOperationBuilder();
        when(mockEntryPoint.self).thenReturn(EthereumAddress.fromHex('0x123'));
        when(mockWeb3Client.getChainId()).thenAnswer((_) async => BigInt.one);

        final operation = await client.buildUserOperation(builder);

        expect(operation, isNotNull);
        // Further assertions can be made based on the expected structure of the operation
      });
    });

    group('sendUserOperation', () {
      test('successfully sends user operation', () async {
        final builder = IUserOperationBuilder();
        when(mockWeb3Client.makeRPCCall<String>('eth_sendUserOperation', any)).thenAnswer((_) async => '0x123');

        final response = await client.sendUserOperation(builder);

        expect(response.userOpHash, equals('0x123'));
        // Additional assertions can be made based on the expected behavior
      });

      test('handles dry-run correctly', () async {
        final builder = IUserOperationBuilder();
        final opts = ISendUserOperationOpts(dryRun: true);

        final response = await client.sendUserOperation(builder, opts: opts);

        expect(response.userOpHash, isNotNull);
        // Verify that no actual sending occurs during a dry-run
      });

      test('fails gracefully on error', () async {
        final builder = IUserOperationBuilder();
        when(mockWeb3Client.makeRPCCall<String>('eth_sendUserOperation', any)).thenThrow(Exception('RPC error'));

        expect(() async => await client.sendUserOperation(builder), throwsException);
      });
    });
  });
}

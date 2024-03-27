import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:userop/src/client.dart';
import 'package:userop/src/provider.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;

class MockWeb3Client extends Mock implements Web3Client {}
class MockBundlerJsonRpcProvider extends Mock implements BundlerJsonRpcProvider {}
class MockIClientOpts extends Mock implements IClientOpts {}

void main() {
  group('Client', () {
    late MockWeb3Client mockWeb3Client;
    late MockBundlerJsonRpcProvider mockBundlerJsonRpcProvider;
    late MockIClientOpts mockIClientOpts;
    const rpcUrl = 'http://localhost:8545';

    setUp(() {
      mockWeb3Client = MockWeb3Client();
      mockBundlerJsonRpcProvider = MockBundlerJsonRpcProvider();
      mockIClientOpts = MockIClientOpts();
    });

    test('initializes correctly with given RPC URL and options', () {
      when(mockBundlerJsonRpcProvider.setBundlerRpc(any)).thenReturn(mockBundlerJsonRpcProvider);
      final client = Client(rpcUrl, opts: mockIClientOpts);

      expect(client.web3client, isNotNull);
      expect(client.waitTimeoutMs, equals(30000));
      expect(client.waitIntervalMs, equals(5000));
    });

    group('buildUserOperation', () {
      test('builds user operation correctly', () async {
        final client = Client(rpcUrl, opts: mockIClientOpts);
        final builder = IUserOperationBuilder();
        final operation = await client.buildUserOperation(builder);

        expect(operation, isNotNull);
        // Further assertions can be made based on the expected behavior of buildUserOperation
      });
    });

    group('sendUserOperation', () {
      test('handles dry-run correctly', () async {
        final client = Client(rpcUrl, opts: mockIClientOpts);
        final builder = IUserOperationBuilder();
        final response = await client.sendUserOperation(builder, opts: ISendUserOperationOpts(dryRun: true));

        expect(response.userOpHash, isNotNull);
        // Further assertions can be made based on the expected behavior of sendUserOperation in dry-run mode
      });

      test('sends operation correctly', () async {
        when(mockWeb3Client.makeRPCCall<String>(any, any)).thenAnswer((_) async => '0x123');
        final client = Client(rpcUrl, opts: mockIClientOpts);
        final builder = IUserOperationBuilder();
        final response = await client.sendUserOperation(builder);

        expect(response.userOpHash, equals('0x123'));
        // Further assertions can be made based on the expected behavior of sendUserOperation in normal mode
      });
    });
  });
}

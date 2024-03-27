import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:stream_channel/stream_channel.dart';
import 'package:userop/src/client.dart';
import 'package:userop/src/types.dart';
import 'package:userop/src/provider.dart';
import 'package:web3dart/web3dart.dart';

class MockWeb3Client extends Mock implements Web3Client {}
class MockBundlerJsonRpcProvider extends Mock implements BundlerJsonRpcProvider {}

@GenerateMocks([MockWeb3Client, MockBundlerJsonRpcProvider])
void main() {
  group('Client initialization', () {
    test('Initializes correctly with default options', () async {
      final client = await Client.init('http://example.com');
      expect(client, isA<Client>());
    });

    test('Handles IClientOpts correctly', () async {
      final mockChannel = StreamChannelController<String>();
      final client = await Client.init('http://example.com', opts: IClientOpts(
        overrideBundlerRpc: 'http://bundler.com',
        socketConnector: () => mockChannel.local,
      ));
      expect(client.web3client, isA<Web3Client>());
    });
  });

  group('Client.buildUserOperation', () {
    test('Builds user operation correctly', () async {
      final client = await Client.init('http://example.com');
      final op = await client.buildUserOperation(IUserOperation.defaultUserOp());
      expect(op, isA<IUserOperation>());
    });
  });

  group('Client.sendUserOperation', () {
    test('Sends user operation correctly', () async {
      final client = await Client.init('http://example.com');
      final response = await client.sendUserOperation(IUserOperation.defaultUserOp());
      expect(response, isA<ISendUserOperationResponse>());
    });

    test('Handles dry-run correctly', () async {
      final client = await Client.init('http://example.com');
      final response = await client.sendUserOperation(IUserOperation.defaultUserOp(), opts: ISendUserOperationOpts(dryRun: true));
      expect(response.userOpHash, isNotNull);
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:userop/src/preset/builder/simple_account.dart';
import 'package:userop/src/types.dart';
import 'package:web3dart/web3dart.dart';

class MockWeb3Client extends Mock implements Web3Client {}
class MockSimpleAccountFactory extends Mock implements SimpleAccountFactory {}

void main() {
  group('SimpleAccount contract creation', () {
    late MockWeb3Client mockWeb3Client;
    late MockSimpleAccountFactory mockSimpleAccountFactory;
    late SimpleAccount simpleAccount;

    setUp(() {
      mockWeb3Client = MockWeb3Client();
      mockSimpleAccountFactory = MockSimpleAccountFactory();
      simpleAccount = SimpleAccount(
        EthPrivateKey.fromHex('0x123'),
        'http://example.com',
        opts: IPresetBuilderOpts(
          factoryAddress: EthereumAddress.fromHex('0x456'),
          nonceKey: BigInt.from(1),
        ),
      );
    });

    test('Initializes with correct initCode and nonceKey', () {
      expect(simpleAccount.initCode, isNotEmpty);
      expect(simpleAccount.nonceKey, equals(BigInt.from(1)));
    });
  });

  group('SimpleAccount transaction execution', () {
    late SimpleAccount simpleAccount;

    setUp(() {
      simpleAccount = SimpleAccount(
        EthPrivateKey.fromHex('0x789'),
        'http://example.com',
      );
    });

    test('Executes single transaction correctly', () async {
      final call = Call(
        to: EthereumAddress.fromHex('0xabc'),
        value: BigInt.zero,
        data: Uint8List.fromList([0x01]),
      );
      final userOpBuilder = await simpleAccount.execute(call);
      expect(userOpBuilder.getCallData(), isNotEmpty);
    });

    test('Executes batch transactions correctly', () async {
      final calls = [
        Call(
          to: EthereumAddress.fromHex('0xdef'),
          value: BigInt.zero,
          data: Uint8List.fromList([0x02]),
        ),
        Call(
          to: EthereumAddress.fromHex('0xghi'),
          value: BigInt.from(100),
          data: Uint8List.fromList([0x03]),
        ),
      ];
      final userOpBuilder = await simpleAccount.executeBatch(calls);
      expect(userOpBuilder.getCallData(), isNotEmpty);
    });
  });
}

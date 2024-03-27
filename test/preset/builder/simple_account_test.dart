import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:userop/src/preset/builder/simple_account.dart';
import 'package:userop/src/typechain/SimpleAccount.g.dart' as simple_account_contract;
import 'package:web3dart/web3dart.dart';
import 'dart:typed_data';

class MockWeb3Client extends Mock implements Web3Client {}
class MockSimpleAccountFactory extends Mock implements simple_account_contract.SimpleAccount {}

void main() {
  group('SimpleAccount', () {
    late MockWeb3Client mockWeb3Client;
    late MockSimpleAccountFactory mockSimpleAccountFactory;
    late SimpleAccount simpleAccount;

    setUp(() {
      mockWeb3Client = MockWeb3Client();
      mockSimpleAccountFactory = MockSimpleAccountFactory();
      simpleAccount = SimpleAccount(EthPrivateKey.fromHex('0x'), 'http://localhost:8545');
    });

    test('init method initializes contract with correct parameters', () async {
      when(mockWeb3Client.getNonce(any, any)).thenAnswer((_) async => BigInt.one);
      when(mockWeb3Client.makeRPCCall<String>('eth_getCode', any)).thenAnswer((_) async => '0x123');

      await simpleAccount.init(EthPrivateKey.fromHex('0x'), 'http://localhost:8545');

      expect(simpleAccount.initCode, equals('0x123'));
      expect(simpleAccount.nonceKey, equals(BigInt.one));
    });

    test('execute method encodes transaction data correctly', () async {
      when(mockSimpleAccountFactory.execute(any, any, any)).thenReturn(Future.value('0x123'));

      final result = await simpleAccount.execute(Call(address: EthereumAddress.fromHex('0x'), data: Uint8List(0), value: BigInt.zero));

      expect(result, equals('0x123'));
    });

    test('executeBatch method encodes batch transaction data correctly', () async {
      when(mockSimpleAccountFactory.executeBatch(any, any, any)).thenReturn(Future.value('0x123'));

      final result = await simpleAccount.executeBatch([Call(address: EthereumAddress.fromHex('0x'), data: Uint8List(0), value: BigInt.zero)]);

      expect(result, equals('0x123'));
    });
  });
}

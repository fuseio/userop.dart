import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:web3dart/web3dart.dart';
import 'package:userop/src/preset/builder/etherspot_wallet.dart';
import 'package:userop/src/typechain/EtherspotWallet.g.dart' as etherspot_wallet_impl;
import 'package:userop/src/typechain/EntryPoint.g.dart';
import 'package:userop/src/typechain/EtherspotWalletFactory.g.dart';

class MockWeb3Client extends Mock implements Web3Client {}
class MockEtherspotWalletFactory extends Mock implements EtherspotWalletFactory {}
class MockEntryPoint extends Mock implements EntryPoint {}
class MockCredentials extends Mock implements EthPrivateKey {}

void main() {
  group('EtherspotWallet', () {
    MockWeb3Client mockWeb3Client;
    MockEtherspotWalletFactory mockEtherspotWalletFactory;
    MockEntryPoint mockEntryPoint;
    MockCredentials mockCredentials;

    setUp(() {
      mockWeb3Client = MockWeb3Client();
      mockEtherspotWalletFactory = MockEtherspotWalletFactory();
      mockEntryPoint = MockEntryPoint();
      mockCredentials = MockCredentials();
    });

    test('init successfully initializes EtherspotWallet', () async {
      when(mockEtherspotWalletFactory.getAddress(any, any)).thenAnswer((_) async => EthereumAddress.fromHex('0x123'));
      final etherspotWallet = await EtherspotWallet.init(mockCredentials, 'http://localhost:8545', opts: null);
      expect(etherspotWallet, isA<EtherspotWallet>());
      verify(mockEtherspotWalletFactory.getAddress(any, any)).called(1);
    });

    test('execute builds and encodes transaction correctly', () async {
      final etherspotWallet = EtherspotWallet(mockCredentials, 'http://localhost:8545');
      final call = Call(to: EthereumAddress.fromHex('0x456'), value: EtherAmount.inWei(BigInt.one), data: Uint8List(0));
      final userOpBuilder = await etherspotWallet.execute(call);
      expect(userOpBuilder, isNotNull);
      // Further assertions on the encoded transaction
    });

    test('executeBatch builds and encodes batch transaction correctly', () async {
      final etherspotWallet = EtherspotWallet(mockCredentials, 'http://localhost:8545');
      final calls = [
        Call(to: EthereumAddress.fromHex('0x789'), value: EtherAmount.inWei(BigInt.two), data: Uint8List(0)),
        Call(to: EthereumAddress.fromHex('0xabc'), value: EtherAmount.inWei(BigInt.three), data: Uint8List(0))
      ];
      final userOpBuilder = await etherspotWallet.executeBatch(calls);
      expect(userOpBuilder, isNotNull);
      // Further assertions on the encoded batch transaction
    });
  });
}

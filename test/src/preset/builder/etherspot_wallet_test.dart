import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:userop/src/preset/builder/etherspot_wallet.dart';
import 'package:userop/src/types.dart';
import 'package:web3dart/web3dart.dart';

class MockWeb3Client extends Mock implements Web3Client {}
class MockEtherspotWalletFactory extends Mock implements EtherspotWalletFactory {}

void main() {
  group('EtherspotWallet', () {
    late MockWeb3Client mockWeb3Client;
    late MockEtherspotWalletFactory mockEtherspotWalletFactory;
    late EtherspotWallet etherspotWallet;

    setUp(() {
      mockWeb3Client = MockWeb3Client();
      mockEtherspotWalletFactory = MockEtherspotWalletFactory();
      etherspotWallet = EtherspotWallet(
        EthPrivateKey.fromHex('0x123'),
        'http://example.com',
        opts: IPresetBuilderOpts(
          factoryAddress: EthereumAddress.fromHex('0x456'),
          nonceKey: BigInt.from(1),
        ),
      );
    });

    test('Initializes with correct initCode and nonceKey', () async {
      expect(etherspotWallet.initCode, isNotEmpty);
      expect(etherspotWallet.nonceKey, equals(BigInt.from(1)));
    });

    test('Executes single transaction correctly', () async {
      final call = Call(
        to: EthereumAddress.fromHex('0x789'),
        value: BigInt.zero,
        data: Uint8List.fromList([0x00]),
      );
      final userOpBuilder = await etherspotWallet.execute(call);
      expect(userOpBuilder.getCallData(), isNotEmpty);
    });

    test('Executes batch transactions correctly', () async {
      final calls = [
        Call(
          to: EthereumAddress.fromHex('0xabc'),
          value: BigInt.zero,
          data: Uint8List.fromList([0x01]),
        ),
        Call(
          to: EthereumAddress.fromHex('0xdef'),
          value: BigInt.from(100),
          data: Uint8List.fromList([0x02]),
        ),
      ];
      final userOpBuilder = await etherspotWallet.executeBatch(calls);
      expect(userOpBuilder.getCallData(), isNotEmpty);
    });
  });
}

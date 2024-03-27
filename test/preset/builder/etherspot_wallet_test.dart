import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:userop/src/preset/builder/etherspot_wallet.dart';
import 'package:userop/src/typechain/EtherspotWallet.g.dart' as etherspot_wallet_contract;
import 'package:web3dart/web3dart.dart';

class MockWeb3Client extends Mock implements Web3Client {}
class MockEtherspotWalletFactory extends Mock implements etherspot_wallet_contract.EtherspotWallet {}

void main() {
  group('EtherspotWallet', () {
    late MockWeb3Client mockWeb3Client;
    late MockEtherspotWalletFactory mockEtherspotWalletFactory;
    late EtherspotWallet etherspotWallet;

    setUp(() {
      mockWeb3Client = MockWeb3Client();
      mockEtherspotWalletFactory = MockEtherspotWalletFactory();
      etherspotWallet = EtherspotWallet(EthPrivateKey.fromHex('0x'), 'http://localhost:8545');
    });

    test('init method initializes contract with correct parameters', () async {
      // Setup mocks and expectations
      // Assuming the initCode and nonceKey are expected to be '0x123' and BigInt.one respectively after initialization
      when(mockWeb3Client.getNonce(any, any)).thenAnswer((_) async => BigInt.one);
      when(mockWeb3Client.makeRPCCall<String>('eth_getCode', any)).thenAnswer((_) async => '0x123');

      // Call the method under test
      await etherspotWallet.init(EthPrivateKey.fromHex('0x'), 'http://localhost:8545');

      // Verify the results
      expect(etherspotWallet.initCode, equals('0x123'));
      expect(etherspotWallet.nonceKey, equals(BigInt.one));
    });

    test('execute method encodes transaction data correctly', () async {
      // Setup mocks and expectations
      final expectedData = '0xencoded';
      when(mockEtherspotWalletFactory.execute(any, any, any)).thenReturn(Future.value(expectedData));

      // Call the method under test
      final result = await etherspotWallet.execute(Call(address: EthereumAddress.fromHex('0x'), data: Uint8List(0), value: BigInt.zero));

      // Verify the results
      expect(result, equals(expectedData));
    });

    test('executeBatch method encodes batch transaction data correctly', () async {
      // Setup mocks and expectations
      final expectedData = '0xencodedBatch';
      when(mockEtherspotWalletFactory.executeBatch(any, any, any)).thenReturn(Future.value(expectedData));

      // Call the method under test
      final result = await etherspotWallet.executeBatch([Call(address: EthereumAddress.fromHex('0x'), data: Uint8List(0), value: BigInt.zero)]);

      // Verify the results
      expect(result, equals(expectedData));
    });
  });
}

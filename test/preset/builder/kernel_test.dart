import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:userop/src/preset/builder/kernel.dart';
import 'package:web3dart/web3dart.dart';
import 'package:userop/src/typechain/Multisend.g.dart';
import 'package:userop/src/typechain/ECDSAKernelFactory.g.dart';

class MockWeb3Client extends Mock implements Web3Client {}
class MockECDSAKernelFactory extends Mock implements ECDSAKernelFactory {}
class MockMultisend extends Mock implements Multisend {}

void main() {
  group('Kernel', () {
    late MockWeb3Client mockWeb3Client;
    late MockECDSAKernelFactory mockECDSAKernelFactory;
    late MockMultisend mockMultisend;
    late Kernel kernel;

    setUp(() {
      mockWeb3Client = MockWeb3Client();
      mockECDSAKernelFactory = MockECDSAKernelFactory();
      mockMultisend = MockMultisend();
      kernel = Kernel(EthPrivateKey.fromHex('0x'), 'http://localhost:8545', opts: IPresetBuilderOpts());
    });

    test('Kernel.init correctly initializes', () async {
      when(mockWeb3Client.getChainId()).thenAnswer((_) async => BigInt.one);
      await kernel.init(EthPrivateKey.fromHex('0x'), 'http://localhost:8545');
      expect(kernel.proxy, isNotNull);
      expect(kernel.multisend, isNotNull);
      expect(kernel.initCode, isNotEmpty);
    });

    test('execute method encodes and sends transaction correctly', () async {
      when(mockWeb3Client.sendTransaction(any, any)).thenAnswer((_) async => '0x123');
      var result = await kernel.execute(Call(address: EthereumAddress.fromHex('0x'), data: Uint8List(0), value: BigInt.zero));
      expect(result, isNotNull);
    });

    test('executeBatch method encodes and sends batch transactions correctly', () async {
      when(mockWeb3Client.sendTransaction(any, any)).thenAnswer((_) async => '0x123');
      var result = await kernel.executeBatch([Call(address: EthereumAddress.fromHex('0x'), data: Uint8List(0), value: BigInt.zero)]);
      expect(result, isNotNull);
    });

    test('sudoMode modifies transaction signature correctly', () async {
      var ctx = UserOperationContext(op: UserOperation(), signature: '0xdead');
      await kernel.sudoMode(ctx);
      expect(ctx.op.signature, isNot(equals('0xdead')));
    });
  });
}

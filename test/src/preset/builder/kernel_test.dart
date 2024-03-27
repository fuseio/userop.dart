import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:userop/src/preset/builder/kernel.dart';
import 'package:userop/src/types.dart';
import 'package:web3dart/web3dart.dart';
import 'package:userop/src/constants/addresses.dart';
import 'package:userop/src/constants/erc_4337.dart';

class MockWeb3Client extends Mock implements Web3Client {}
class MockECDSAKernelFactory extends Mock implements ECDSAKernelFactory {}
class MockMultisend extends Mock implements Multisend {}

void main() {
  group('Kernel contract creation', () {
    late MockWeb3Client mockWeb3Client;
    late MockECDSAKernelFactory mockECDSAKernelFactory;
    late MockMultisend mockMultisend;
    late Kernel kernel;

    setUp(() {
      mockWeb3Client = MockWeb3Client();
      mockECDSAKernelFactory = MockECDSAKernelFactory();
      mockMultisend = MockMultisend();
      kernel = Kernel(
        EthPrivateKey.fromHex('0x123'),
        'http://example.com',
        opts: IPresetBuilderOpts(
          factoryAddress: EthereumAddress.fromHex('0x456'),
          nonceKey: BigInt.from(1),
        ),
      );
    });

    test('Initializes with correct initCode and nonceKey', () {
      expect(kernel.initCode, isNotEmpty);
      expect(kernel.nonceKey, equals(BigInt.from(1)));
    });

    test('Applies sudoMode correctly', () async {
      await kernel.sudoMode(IUserOperation.defaultUserOp());
      // Verify the signature is modified correctly
    });
  });

  group('Kernel transaction execution', () {
    late Kernel kernel;

    setUp(() {
      kernel = Kernel(
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
      final userOpBuilder = await kernel.execute(call);
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
      final userOpBuilder = await kernel.executeBatch(calls);
      expect(userOpBuilder.getCallData(), isNotEmpty);
    });
  });
}

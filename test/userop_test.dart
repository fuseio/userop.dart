import 'package:test/test.dart';
import 'package:userop/src/types.dart';
import 'package:userop/userop.dart';

const MOCK_BYTES_1 = '0xdead';
const MOCK_BYTES_2 = '0xbeef';

void main() {
  final mockValue =
      EthereumAddress.fromHex('0x0000000000000000000000000000000000000000');

  group('UserOperationBuilder', () {
    test('Should initialize correctly', () {
      final builder = UserOperationBuilder();

      expect(builder.getOp().toJson(), equals(defaultUserOp.toJson()));
    });
  });

  group('Fields', () {
    group('Sender', () {
      final builder = UserOperationBuilder();

      test('Updates via setter with good values', () {
        expect(
            builder.getSender(),
            equals(EthereumAddress.fromHex(
                    '0x0000000000000000000000000000000000000000')
                .toString()));
        expect(builder.setSender(mockValue).getSender(),
            equals(mockValue.toString()));
      });

      test('Updates via partial with good values', () {
        expect(builder.setPartial({'sender': mockValue.toString()}).getSender(),
            equals(mockValue.toString()));
      });

      test('Throws error via setter on bad values', () {
        final mockValue = '0xdead';

        expect(() => builder.setSender(EthereumAddress.fromHex(mockValue)),
            throwsArgumentError);
      });

      test('Throws error via partial on bad values', () {
        final mockValue = '0xdead';
        expect(
            () => builder
                .setPartial({'sender': EthereumAddress.fromHex(mockValue)}),
            throwsArgumentError);
      });
    });
  });

  group('Defaults', () {
    test('Should not wipe after a reset', () {
      final builder =
          UserOperationBuilder().useDefaults({'sender': mockValue.toString()});

      expect(builder.resetOp().getSender(), equals(mockValue.toString()));
    });

    test('Should forget defaults on resetDefault', () {
      final secondMockAddress =
          EthereumAddress.fromHex('0x2b0741C5da32817Bbc80d2d431E8957a68BD34c1');
      final builder = UserOperationBuilder()
          .useDefaults({'sender': secondMockAddress.toString()});

      expect(builder.resetDefaults().resetOp().getSender(),
          equals(mockValue.toString()));
    });
  });
}

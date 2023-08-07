import 'package:test/test.dart';
import 'package:userop/src/types.dart';
import 'package:userop/userop.dart';

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

  group('BuildOp', () {
    final mockMaxFeePerGas = BigInt.zero;
    final mockMaxPriorityFeePerGas = BigInt.zero;
    const MOCK_BYTES_1 = '0xdead';

    mockMW1(IUserOperationMiddlewareCtx ctx) async {
      return ctx.op.paymasterAndData = MOCK_BYTES_1;
    }

    mockMW2(IUserOperationMiddlewareCtx ctx) async {
      ctx.op.maxFeePerGas = mockMaxFeePerGas;
      ctx.op.maxPriorityFeePerGas = mockMaxPriorityFeePerGas;
    }

    test('Should apply all changes from middleware functions', () async {
      final builder = UserOperationBuilder()
        ..useMiddleware(mockMW1)
        ..useMiddleware(mockMW2);

      final entryPoint = ERC4337.ENTRY_POINT;

      expect(
          await builder.buildOp(
              EthereumAddress.fromHex(entryPoint), BigInt.parse('0x1')),
          equals(IUserOperation.fromJson({
            ...defaultUserOp.toJson(),
            'paymasterAndData': MOCK_BYTES_1,
            'maxFeePerGas': mockMaxFeePerGas,
            'maxPriorityFeePerGas': mockMaxPriorityFeePerGas,
          }).opToJson()));
    });

    test('Should forget middleware on resetMiddleware', () async {
      final builder = UserOperationBuilder()
        ..useMiddleware(mockMW1)
        ..useMiddleware(mockMW2)
        ..resetMiddleware();

      expect(
          await builder.buildOp(mockValue, BigInt.parse('0x1')),
          equals(IUserOperation.fromJson({
            ...defaultUserOp.toJson(),
          }).toJson()));
    });
  });
}

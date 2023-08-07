import 'package:freezed_annotation/freezed_annotation.dart';

part 'verifying_paymaster_result.freezed.dart';
part 'verifying_paymaster_result.g.dart';

@freezed
class VerifyingPaymasterResult with _$VerifyingPaymasterResult {
  factory VerifyingPaymasterResult({
    required String paymasterAndData,
    required String preVerificationGas,
    required String verificationGasLimit,
    required String callGasLimit,
  }) = _VerifyingPaymasterResult;

  factory VerifyingPaymasterResult.fromJson(Map<String, dynamic> json) =>
      _$VerifyingPaymasterResultFromJson(json);
}

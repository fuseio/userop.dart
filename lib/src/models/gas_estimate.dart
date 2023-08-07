import 'package:freezed_annotation/freezed_annotation.dart';

part 'gas_estimate.freezed.dart';
part 'gas_estimate.g.dart';

@freezed
class GasEstimate with _$GasEstimate {
  factory GasEstimate({
    required String? verificationGasLimit,
    required String preVerificationGas,
    required String callGasLimit,

    /// TODO: remove this with EntryPoint v0.7
    required String verificationGas,
  }) = _GasEstimate;

  factory GasEstimate.fromJson(Map<String, dynamic> json) =>
      _$GasEstimateFromJson(json);
}

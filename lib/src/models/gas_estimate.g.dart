// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gas_estimate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GasEstimateImpl _$$GasEstimateImplFromJson(Map<String, dynamic> json) =>
    _$GasEstimateImpl(
      verificationGasLimit: json['verificationGasLimit'] as String?,
      preVerificationGas: json['preVerificationGas'] as String,
      callGasLimit: json['callGasLimit'] as String,
      verificationGas: json['verificationGas'] as String,
    );

Map<String, dynamic> _$$GasEstimateImplToJson(_$GasEstimateImpl instance) =>
    <String, dynamic>{
      'verificationGasLimit': instance.verificationGasLimit,
      'preVerificationGas': instance.preVerificationGas,
      'callGasLimit': instance.callGasLimit,
      'verificationGas': instance.verificationGas,
    };

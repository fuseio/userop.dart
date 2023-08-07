// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gas_estimate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GasEstimate _$$_GasEstimateFromJson(Map<String, dynamic> json) =>
    _$_GasEstimate(
      verificationGasLimit: json['verificationGasLimit'] as String?,
      preVerificationGas: json['preVerificationGas'] as String,
      callGasLimit: json['callGasLimit'] as String,
      verificationGas: json['verificationGas'] as String,
    );

Map<String, dynamic> _$$_GasEstimateToJson(_$_GasEstimate instance) =>
    <String, dynamic>{
      'verificationGasLimit': instance.verificationGasLimit,
      'preVerificationGas': instance.preVerificationGas,
      'callGasLimit': instance.callGasLimit,
      'verificationGas': instance.verificationGas,
    };

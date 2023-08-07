// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verifying_paymaster_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_VerifyingPaymasterResult _$$_VerifyingPaymasterResultFromJson(
        Map<String, dynamic> json) =>
    _$_VerifyingPaymasterResult(
      paymasterAndData: json['paymasterAndData'] as String,
      preVerificationGas: json['preVerificationGas'] as String,
      verificationGasLimit: json['verificationGasLimit'] as String,
      callGasLimit: json['callGasLimit'] as String,
    );

Map<String, dynamic> _$$_VerifyingPaymasterResultToJson(
        _$_VerifyingPaymasterResult instance) =>
    <String, dynamic>{
      'paymasterAndData': instance.paymasterAndData,
      'preVerificationGas': instance.preVerificationGas,
      'verificationGasLimit': instance.verificationGasLimit,
      'callGasLimit': instance.callGasLimit,
    };

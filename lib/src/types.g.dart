// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'types.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserOperation _$$_UserOperationFromJson(Map<String, dynamic> json) =>
    _$_UserOperation(
      sender: json['sender'] as String? ??
          '0x0000000000000000000000000000000000000000',
      nonce: BigInt.parse(json['nonce'] as String),
      initCode: json['initCode'] as String? ?? '0x',
      callData: json['callData'] as String? ?? '0x',
      callGasLimit: BigInt.parse(json['callGasLimit'] as String),
      verificationGasLimit:
          BigInt.parse(json['verificationGasLimit'] as String),
      preVerificationGas: BigInt.parse(json['preVerificationGas'] as String),
      maxFeePerGas: BigInt.parse(json['maxFeePerGas'] as String),
      maxPriorityFeePerGas:
          BigInt.parse(json['maxPriorityFeePerGas'] as String),
      paymasterAndData: json['paymasterAndData'] as String? ?? '0x',
      signature: json['signature'] as String? ?? '0x',
    );

Map<String, dynamic> _$$_UserOperationToJson(_$_UserOperation instance) =>
    <String, dynamic>{
      'sender': instance.sender,
      'nonce': instance.nonce.toString(),
      'initCode': instance.initCode,
      'callData': instance.callData,
      'callGasLimit': instance.callGasLimit.toString(),
      'verificationGasLimit': instance.verificationGasLimit.toString(),
      'preVerificationGas': instance.preVerificationGas.toString(),
      'maxFeePerGas': instance.maxFeePerGas.toString(),
      'maxPriorityFeePerGas': instance.maxPriorityFeePerGas.toString(),
      'paymasterAndData': instance.paymasterAndData,
      'signature': instance.signature,
    };

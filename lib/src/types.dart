import 'dart:typed_data';

import 'package:userop/userop.dart';

import 'utils/crypto.dart';

IUserOperation defaultUserOp = IUserOperation(
  sender: AddressZero,
  nonce: BigInt.zero,
  initCode: '0x',
  callData: '0x',
  callGasLimit: BigInt.from(35000),
  verificationGasLimit: BigInt.from(70000),
  preVerificationGas: BigInt.from(21000),
  maxFeePerGas: BigInt.zero,
  maxPriorityFeePerGas: BigInt.zero,
  paymasterAndData: '0x',
  signature: '0x',
);

class UserOperationEventEvent {
  // Define the structure according to your need
}

class IUserOperation {
  late String sender;
  late BigInt nonce;
  late String initCode;
  late String callData;
  late BigInt callGasLimit;
  late BigInt verificationGasLimit;
  late BigInt preVerificationGas;
  late BigInt maxFeePerGas;
  late BigInt maxPriorityFeePerGas;
  late String paymasterAndData;
  late String signature;

  Map<String, dynamic> opToJson() {
    Map<String, dynamic> result = {};

    toJson().forEach((key, value) {
      var val = value;
      if (val is BigInt) {
        val = hexlify(val);
      } else if (val is EthereumAddress) {
        val = val.toString();
      }
      result[key] = val;
    });
    return result;
  }

  IUserOperation({
    required this.sender,
    required this.nonce,
    required this.initCode,
    required this.callData,
    required this.callGasLimit,
    required this.verificationGasLimit,
    required this.preVerificationGas,
    required this.maxFeePerGas,
    required this.maxPriorityFeePerGas,
    required this.paymasterAndData,
    required this.signature,
  });

  factory IUserOperation.fromJson(Map<String, dynamic> json) => IUserOperation(
        sender: json["sender"],
        nonce: json["nonce"],
        initCode: json["initCode"],
        callData: json["callData"],
        callGasLimit: json["callGasLimit"],
        verificationGasLimit: json["verificationGasLimit"],
        preVerificationGas: json["preVerificationGas"],
        maxFeePerGas: json["maxFeePerGas"],
        maxPriorityFeePerGas: json["maxPriorityFeePerGas"],
        paymasterAndData: json["paymasterAndData"],
        signature: json["signature"],
      );

  Map<String, dynamic> toJson() => {
        "sender": sender,
        "nonce": nonce,
        "initCode": initCode,
        "callData": callData,
        "callGasLimit": callGasLimit,
        "verificationGasLimit": verificationGasLimit,
        "preVerificationGas": preVerificationGas,
        "maxFeePerGas": maxFeePerGas,
        "maxPriorityFeePerGas": maxPriorityFeePerGas,
        "paymasterAndData": paymasterAndData,
        "signature": signature,
      };
}

abstract class IUserOperationBuilder {
  String getSender();
  BigInt getNonce();
  String getInitCode();
  String getCallData();
  BigInt getCallGasLimit();
  BigInt getVerificationGasLimit();
  BigInt getPreVerificationGas();
  BigInt getMaxFeePerGas();
  BigInt getMaxPriorityFeePerGas();
  String getPaymasterAndData();
  String getSignature();
  IUserOperation getOp();

  IUserOperationBuilder setSender(String address);
  IUserOperationBuilder setNonce(BigInt nonce);
  IUserOperationBuilder setInitCode(String code);
  IUserOperationBuilder setCallData(String data);
  IUserOperationBuilder setCallGasLimit(BigInt gas);
  IUserOperationBuilder setVerificationGasLimit(BigInt gas);
  IUserOperationBuilder setPreVerificationGas(BigInt gas);
  IUserOperationBuilder setMaxFeePerGas(BigInt fee);
  IUserOperationBuilder setMaxPriorityFeePerGas(BigInt fee);
  IUserOperationBuilder setPaymasterAndData(String data);
  IUserOperationBuilder setSignature(String bytes);
  IUserOperationBuilder setPartial(Map<String, dynamic> partialOp);

  IUserOperationBuilder useDefaults(Map<String, dynamic> partialOp);
  IUserOperationBuilder resetDefaults();

  IUserOperationBuilder useMiddleware(UserOperationMiddlewareFn fn);
  IUserOperationBuilder resetMiddleware();

  Future<IUserOperation> buildOp(
    EthereumAddress entryPoint,
    BigInt chainId,
  );

  IUserOperationBuilder resetOp();
}

typedef UserOperationMiddlewareFn = Future<void> Function(
    IUserOperationMiddlewareCtx context);

abstract class IUserOperationMiddlewareCtx {
  late IUserOperation op;
  late EthereumAddress entryPoint;
  late BigInt chainId;

  Uint8List getUserOpHash();
}

abstract class IClient {
  Future<ISendUserOperationResponse> sendUserOperation(
      IUserOperationBuilder builder,
      {ISendUserOperationOpts? opts});

  Future<IUserOperation> buildUserOperation(IUserOperationBuilder builder);
}

class IClientOpts {
  EthereumAddress? entryPoint;
  String? overrideBundlerRpc;
}

class ISendUserOperationOpts {
  bool? dryRun;
  Function(IUserOperation op)? onBuild;
}

class ISendUserOperationResponse {
  final String userOpHash;
  final Future<FilterEvent?> Function() wait;

  ISendUserOperationResponse(this.userOpHash, this.wait);
}

class IPresetBuilderOpts {
  EthereumAddress? entryPoint;
  BigInt? salt;
  EthereumAddress? simpleAccountFactoryAddress;
  UserOperationMiddlewareFn? paymasterMiddleware;
  String? overrideBundlerRpc;
}

class ICall {
  late EthereumAddress to;
  late BigInt value;
  late String data;
}

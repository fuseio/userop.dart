import 'dart:typed_data';

import 'package:userop/userop.dart';

/// `IUserOperation` is a class representing an ERC-4337 User Operation.
/// Building a UserOperation involves constructing multiple parts and merging them together.
class IUserOperation {
  /// The sender of the operation.
  late String sender;

  /// The nonce of the operation.
  late BigInt nonce;

  /// The init code of the operation.
  late String initCode;

  /// The call data of the operation.
  late String callData;

  /// The gas limit for the operation call.
  late BigInt callGasLimit;

  /// The gas limit for operation verification.
  late BigInt verificationGasLimit;

  /// The gas for pre-verification of the operation.
  late BigInt preVerificationGas;

  /// The maximum fee per gas for the operation.
  late BigInt maxFeePerGas;

  /// The maximum priority fee per gas for the operation.
  late BigInt maxPriorityFeePerGas;

  /// The paymaster and associated data for the operation.
  late String paymasterAndData;

  /// The signature of the operation.
  late String signature;

  /// Default constructor for the `IUserOperation`.
  /// It initializes all fields with default values.
  factory IUserOperation.defaultUserOp() => IUserOperation(
        sender: Addresses.AddressZero,
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

  /// Converts the operation to JSON format.
  ///
  /// Returns a Map where keys are field names and values are their corresponding values.
  /// If the value is a BigInt or EthereumAddress, it is converted to a hex string.
  Map<String, dynamic> opToJson() {
    Map<String, dynamic> result = {};

    toJson().forEach((key, value) {
      var val = value;
      if (val is BigInt) {
        val = '0x${val.toRadixString(16)}';
      } else if (val is EthereumAddress) {
        val = val.toString();
      }
      result[key] = val;
    });
    return result;
  }

  /// Main constructor for the `IUserOperation`.
  ///
  /// Requires all fields to be provided.
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

  /// Factory constructor that creates an instance of `IUserOperation` from a Map (typically from JSON).
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

  /// Converts the `IUserOperation` to a Map.
  ///
  /// Returns a Map where keys are field names and values are their corresponding values.
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

/// An abstract class representing a builder for a `IUserOperation`.
///
/// `IUserOperationBuilder` provides a flexible way to construct a `IUserOperation` that can be passed to the client.
abstract class IUserOperationBuilder {
  /// Gets the sender of the operation.
  String getSender();

  /// Gets the nonce of the operation.
  BigInt getNonce();

  /// Gets the init code of the operation.
  String getInitCode();

  /// Gets the call data of the operation.
  String getCallData();

  /// Gets the call gas limit of the operation.
  BigInt getCallGasLimit();

  /// Gets the verification gas limit of the operation.
  BigInt getVerificationGasLimit();

  /// Gets the pre-verification gas of the operation.
  BigInt getPreVerificationGas();

  /// Gets the max fee per gas of the operation.
  BigInt getMaxFeePerGas();

  /// Gets the max priority fee per gas of the operation.
  BigInt getMaxPriorityFeePerGas();

  /// Gets the paymaster and associated data of the operation.
  String getPaymasterAndData();

  /// Gets the signature of the operation.
  String getSignature();

  /// Gets the constructed operation.
  IUserOperation getOp();

  /// Sets the sender of the operation.
  IUserOperationBuilder setSender(String address);

  /// Sets the nonce of the operation.
  IUserOperationBuilder setNonce(BigInt nonce);

  /// Sets the init code of the operation.
  IUserOperationBuilder setInitCode(String code);

  /// Sets the call data of the operation.
  IUserOperationBuilder setCallData(String data);

  /// Sets the call gas limit of the operation.
  IUserOperationBuilder setCallGasLimit(BigInt gas);

  /// Sets the verification gas limit of the operation.
  IUserOperationBuilder setVerificationGasLimit(BigInt gas);

  /// Sets the pre-verification gas of the operation.
  IUserOperationBuilder setPreVerificationGas(BigInt gas);

  /// Sets the max fee per gas of the operation.
  IUserOperationBuilder setMaxFeePerGas(BigInt fee);

  /// Sets the max priority fee per gas of the operation.
  IUserOperationBuilder setMaxPriorityFeePerGas(BigInt fee);

  /// Sets the paymaster and associated data of the operation.
  IUserOperationBuilder setPaymasterAndData(String data);

  /// Sets the signature of the operation.
  IUserOperationBuilder setSignature(String bytes);

  /// Sets the operation partially with a map of key-value pairs.
  IUserOperationBuilder setPartial(Map<String, dynamic> partialOp);

  /// Uses default values for fields not set in `partialOp`.
  IUserOperationBuilder useDefaults(Map<String, dynamic> partialOp);

  /// Resets all field values to their defaults.
  IUserOperationBuilder resetDefaults();

  /// Applies middleware function to the operation construction process.
  IUserOperationBuilder useMiddleware(UserOperationMiddlewareFn fn);

  /// Resets middleware.
  IUserOperationBuilder resetMiddleware();

  /// Builds the operation asynchronously and returns a future of it.
  Future<IUserOperation> buildOp(
    EthereumAddress entryPoint,
    BigInt chainId,
  );

  /// Resets the operation to initial state.
  IUserOperationBuilder resetOp();
}

/// Interface for a user operation middleware.
typedef UserOperationMiddlewareFn = Future<void> Function(
    IUserOperationMiddlewareCtx context);

/// Context for the middleware of user operations.
abstract class IUserOperationMiddlewareCtx {
  /// The user operation.
  late IUserOperation op;

  /// The entry point.
  late EthereumAddress entryPoint;

  /// The chain ID.
  late BigInt chainId;

  /// Gets the hash of the user operation.
  Uint8List getUserOpHash();
}

/// An interface for the client class.
///
/// This interface contains two methods - `sendUserOperation` and `buildUserOperation` - which must be implemented in any concrete class.
abstract class IClient {
  Future<ISendUserOperationResponse> sendUserOperation(
      IUserOperationBuilder builder,
      {ISendUserOperationOpts? opts});

  Future<IUserOperation> buildUserOperation(IUserOperationBuilder builder);
}

/// Class for options related to the client.
class IClientOpts {
  EthereumAddress? entryPoint;
  String? overrideBundlerRpc;
}

/// Options for sending user operations.
///
/// `dryRun`: A boolean indicating whether the user operation should be sent without actually executing it.
/// `onBuild`: A callback function to be called after the user operation has been built.
class ISendUserOperationOpts {
  bool? dryRun;
  Function(IUserOperation op)? onBuild;
}

/// Response for the sendUserOperation method.
///
/// Contains the `userOpHash` and a method to wait for the transaction information.
class ISendUserOperationResponse {
  final String userOpHash;
  final Future<FilterEvent?> Function() wait;

  ISendUserOperationResponse(this.userOpHash, this.wait);
}

/// Options for the preset builder.
class IPresetBuilderOpts {
  EthereumAddress? entryPoint;
  BigInt? salt;
  EthereumAddress? factoryAddress;
  UserOperationMiddlewareFn? paymasterMiddleware;
  BigInt? nonceKey;
  String? overrideBundlerRpc;
  GasLimitOptions? gasLimitOptions;

  IPresetBuilderOpts({
    this.entryPoint,
    this.salt,
    this.factoryAddress,
    this.paymasterMiddleware,
    this.nonceKey,
    this.overrideBundlerRpc,
    this.gasLimitOptions,
  });

  IPresetBuilderOpts copyWith({
    EthereumAddress? entryPoint,
    BigInt? salt,
    EthereumAddress? factoryAddress,
    UserOperationMiddlewareFn? paymasterMiddleware,
    BigInt? nonceKey,
    String? overrideBundlerRpc,
    GasLimitOptions? gasLimitOptions,
  }) {
    return IPresetBuilderOpts(
      entryPoint: entryPoint ?? this.entryPoint,
      salt: salt ?? this.salt,
      factoryAddress: factoryAddress ?? this.factoryAddress,
      paymasterMiddleware: paymasterMiddleware ?? this.paymasterMiddleware,
      nonceKey: nonceKey ?? this.nonceKey,
      overrideBundlerRpc: overrideBundlerRpc ?? this.overrideBundlerRpc,
      gasLimitOptions: gasLimitOptions ?? this.gasLimitOptions,
    );
  }
}

class GasLimitOptions {
  final BigInt? callGasLimit;
  final BigInt? verificationGasLimit;
  final BigInt? preVerificationGas;

  const GasLimitOptions({
    this.callGasLimit,
    this.verificationGasLimit,
    this.preVerificationGas,
  });
}

class Call {
  EthereumAddress to;
  BigInt value;
  Uint8List data;

  Call({
    required this.to,
    required this.value,
    required this.data,
  });
}

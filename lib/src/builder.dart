import 'package:web3dart/web3dart.dart';

import './types.dart';

import 'context.dart';

/// A concrete implementation of `IUserOperationBuilder` that provides a flexible way to construct a `IUserOperation`.
class UserOperationBuilder implements IUserOperationBuilder {
  /// The default `IUserOperation` object that is used as a base to build upon.
  late IUserOperation _defaultOp;

  /// The current `IUserOperation` object that is being built.
  late IUserOperation _currentOp;

  /// The stack of middleware functions that are applied to the current operation when `buildOp` is called.
  late List<UserOperationMiddlewareFn> _middlewareStack;

  UserOperationBuilder() {
    _defaultOp = IUserOperation.defaultUserOp();
    _currentOp = _defaultOp;
    _middlewareStack = [];
  }

  Map<String, dynamic> resolveFields(Map<String, dynamic> op) {
    final obj = {
      'sender': op['sender'],
      'nonce': op['nonce'],
      'initCode': op['initCode'],
      'callData': op['callData'],
      'callGasLimit': op['callGasLimit'],
      'verificationGasLimit': op['verificationGasLimit'],
      'preVerificationGas': op['preVerificationGas'],
      'maxFeePerGas': op['maxFeePerGas'],
      'maxPriorityFeePerGas': op['maxPriorityFeePerGas'],
      'paymasterAndData': op['paymasterAndData'],
      'signature': op['signature'],
    };
    return obj.keys.fold<Map<String, dynamic>>(
      {},
      (prev, current) =>
          obj[current] != null ? {...prev, current: obj[current]} : prev,
    );
  }

  @override
  String getSender() {
    return _currentOp.sender.toString();
  }

  @override
  BigInt getNonce() {
    return _currentOp.nonce;
  }

  @override
  String getInitCode() {
    return _currentOp.initCode;
  }

  @override
  String getCallData() {
    return _currentOp.callData;
  }

  @override
  BigInt getCallGasLimit() {
    return _currentOp.callGasLimit;
  }

  @override
  BigInt getVerificationGasLimit() {
    return _currentOp.verificationGasLimit;
  }

  @override
  BigInt getPreVerificationGas() {
    return _currentOp.preVerificationGas;
  }

  @override
  BigInt getMaxFeePerGas() {
    return _currentOp.maxFeePerGas;
  }

  @override
  BigInt getMaxPriorityFeePerGas() {
    return _currentOp.maxPriorityFeePerGas;
  }

  @override
  String getPaymasterAndData() {
    return _currentOp.paymasterAndData;
  }

  @override
  String getSignature() {
    return _currentOp.signature;
  }

  @override
  IUserOperation getOp() {
    return _currentOp;
  }

  @override
  IUserOperationBuilder setSender(String address) {
    _currentOp.sender = address;
    return this;
  }

  @override
  IUserOperationBuilder setCallData(String data) {
    _currentOp.callData = data;
    return this;
  }

  @override
  IUserOperationBuilder setCallGasLimit(BigInt gas) {
    _currentOp.callGasLimit = gas;
    return this;
  }

  @override
  IUserOperationBuilder setInitCode(String code) {
    _currentOp.initCode = code;
    return this;
  }

  @override
  IUserOperationBuilder setMaxFeePerGas(BigInt val) {
    _currentOp.maxFeePerGas = val;
    return this;
  }

  @override
  IUserOperationBuilder setMaxPriorityFeePerGas(BigInt fee) {
    _currentOp.maxPriorityFeePerGas = fee;
    return this;
  }

  @override
  IUserOperationBuilder setNonce(BigInt val) {
    _currentOp.nonce = val;
    return this;
  }

  @override
  IUserOperationBuilder setPaymasterAndData(String val) {
    _currentOp.paymasterAndData = val;
    return this;
  }

  @override
  IUserOperationBuilder setPreVerificationGas(BigInt gas) {
    _currentOp.preVerificationGas = gas;
    return this;
  }

  @override
  IUserOperationBuilder setVerificationGasLimit(BigInt gas) {
    _currentOp.verificationGasLimit = gas;
    return this;
  }

  @override
  IUserOperationBuilder resetDefaults() {
    _defaultOp = IUserOperation.defaultUserOp();
    return this;
  }

  @override
  IUserOperationBuilder setPartial(Map<String, dynamic> partialOp) {
    _currentOp = IUserOperation.fromJson({
      ..._currentOp.toJson(),
      ...resolveFields(partialOp),
    });
    return this;
  }

  @override
  IUserOperationBuilder setSignature(String val) {
    _currentOp.signature = val;
    return this;
  }

  @override
  IUserOperationBuilder useDefaults(Map<String, dynamic> partialOp) {
    final resolvedOp = resolveFields(partialOp);
    _defaultOp =
        IUserOperation.fromJson({..._defaultOp.toJson(), ...resolvedOp});
    _currentOp =
        IUserOperation.fromJson({..._currentOp.toJson(), ...resolvedOp});
    return this;
  }

  @override
  Future<IUserOperation> buildOp(
    EthereumAddress entryPoint,
    BigInt chainId,
  ) async {
    final ctx = UserOperationMiddlewareCtx(
      _currentOp,
      entryPoint,
      chainId,
    );
    for (final fn in _middlewareStack) {
      await fn(ctx);
    }

    setPartial(ctx.op.toJson());
    return _currentOp;
  }

  @override
  IUserOperationBuilder resetMiddleware() {
    _middlewareStack = [];
    return this;
  }

  @override
  IUserOperationBuilder resetOp() {
    _currentOp = _defaultOp;
    return this;
  }

  @override
  IUserOperationBuilder useMiddleware(UserOperationMiddlewareFn fn) {
    _middlewareStack = [..._middlewareStack, fn];
    return this;
  }
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'verifying_paymaster_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

VerifyingPaymasterResult _$VerifyingPaymasterResultFromJson(
    Map<String, dynamic> json) {
  return _VerifyingPaymasterResult.fromJson(json);
}

/// @nodoc
mixin _$VerifyingPaymasterResult {
  String get paymasterAndData => throw _privateConstructorUsedError;
  String get preVerificationGas => throw _privateConstructorUsedError;
  String get verificationGasLimit => throw _privateConstructorUsedError;
  String get callGasLimit => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VerifyingPaymasterResultCopyWith<VerifyingPaymasterResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VerifyingPaymasterResultCopyWith<$Res> {
  factory $VerifyingPaymasterResultCopyWith(VerifyingPaymasterResult value,
          $Res Function(VerifyingPaymasterResult) then) =
      _$VerifyingPaymasterResultCopyWithImpl<$Res, VerifyingPaymasterResult>;
  @useResult
  $Res call(
      {String paymasterAndData,
      String preVerificationGas,
      String verificationGasLimit,
      String callGasLimit});
}

/// @nodoc
class _$VerifyingPaymasterResultCopyWithImpl<$Res,
        $Val extends VerifyingPaymasterResult>
    implements $VerifyingPaymasterResultCopyWith<$Res> {
  _$VerifyingPaymasterResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? paymasterAndData = null,
    Object? preVerificationGas = null,
    Object? verificationGasLimit = null,
    Object? callGasLimit = null,
  }) {
    return _then(_value.copyWith(
      paymasterAndData: null == paymasterAndData
          ? _value.paymasterAndData
          : paymasterAndData // ignore: cast_nullable_to_non_nullable
              as String,
      preVerificationGas: null == preVerificationGas
          ? _value.preVerificationGas
          : preVerificationGas // ignore: cast_nullable_to_non_nullable
              as String,
      verificationGasLimit: null == verificationGasLimit
          ? _value.verificationGasLimit
          : verificationGasLimit // ignore: cast_nullable_to_non_nullable
              as String,
      callGasLimit: null == callGasLimit
          ? _value.callGasLimit
          : callGasLimit // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VerifyingPaymasterResultImplCopyWith<$Res>
    implements $VerifyingPaymasterResultCopyWith<$Res> {
  factory _$$VerifyingPaymasterResultImplCopyWith(
          _$VerifyingPaymasterResultImpl value,
          $Res Function(_$VerifyingPaymasterResultImpl) then) =
      __$$VerifyingPaymasterResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String paymasterAndData,
      String preVerificationGas,
      String verificationGasLimit,
      String callGasLimit});
}

/// @nodoc
class __$$VerifyingPaymasterResultImplCopyWithImpl<$Res>
    extends _$VerifyingPaymasterResultCopyWithImpl<$Res,
        _$VerifyingPaymasterResultImpl>
    implements _$$VerifyingPaymasterResultImplCopyWith<$Res> {
  __$$VerifyingPaymasterResultImplCopyWithImpl(
      _$VerifyingPaymasterResultImpl _value,
      $Res Function(_$VerifyingPaymasterResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? paymasterAndData = null,
    Object? preVerificationGas = null,
    Object? verificationGasLimit = null,
    Object? callGasLimit = null,
  }) {
    return _then(_$VerifyingPaymasterResultImpl(
      paymasterAndData: null == paymasterAndData
          ? _value.paymasterAndData
          : paymasterAndData // ignore: cast_nullable_to_non_nullable
              as String,
      preVerificationGas: null == preVerificationGas
          ? _value.preVerificationGas
          : preVerificationGas // ignore: cast_nullable_to_non_nullable
              as String,
      verificationGasLimit: null == verificationGasLimit
          ? _value.verificationGasLimit
          : verificationGasLimit // ignore: cast_nullable_to_non_nullable
              as String,
      callGasLimit: null == callGasLimit
          ? _value.callGasLimit
          : callGasLimit // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VerifyingPaymasterResultImpl implements _VerifyingPaymasterResult {
  _$VerifyingPaymasterResultImpl(
      {required this.paymasterAndData,
      required this.preVerificationGas,
      required this.verificationGasLimit,
      required this.callGasLimit});

  factory _$VerifyingPaymasterResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$VerifyingPaymasterResultImplFromJson(json);

  @override
  final String paymasterAndData;
  @override
  final String preVerificationGas;
  @override
  final String verificationGasLimit;
  @override
  final String callGasLimit;

  @override
  String toString() {
    return 'VerifyingPaymasterResult(paymasterAndData: $paymasterAndData, preVerificationGas: $preVerificationGas, verificationGasLimit: $verificationGasLimit, callGasLimit: $callGasLimit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VerifyingPaymasterResultImpl &&
            (identical(other.paymasterAndData, paymasterAndData) ||
                other.paymasterAndData == paymasterAndData) &&
            (identical(other.preVerificationGas, preVerificationGas) ||
                other.preVerificationGas == preVerificationGas) &&
            (identical(other.verificationGasLimit, verificationGasLimit) ||
                other.verificationGasLimit == verificationGasLimit) &&
            (identical(other.callGasLimit, callGasLimit) ||
                other.callGasLimit == callGasLimit));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, paymasterAndData,
      preVerificationGas, verificationGasLimit, callGasLimit);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VerifyingPaymasterResultImplCopyWith<_$VerifyingPaymasterResultImpl>
      get copyWith => __$$VerifyingPaymasterResultImplCopyWithImpl<
          _$VerifyingPaymasterResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VerifyingPaymasterResultImplToJson(
      this,
    );
  }
}

abstract class _VerifyingPaymasterResult implements VerifyingPaymasterResult {
  factory _VerifyingPaymasterResult(
      {required final String paymasterAndData,
      required final String preVerificationGas,
      required final String verificationGasLimit,
      required final String callGasLimit}) = _$VerifyingPaymasterResultImpl;

  factory _VerifyingPaymasterResult.fromJson(Map<String, dynamic> json) =
      _$VerifyingPaymasterResultImpl.fromJson;

  @override
  String get paymasterAndData;
  @override
  String get preVerificationGas;
  @override
  String get verificationGasLimit;
  @override
  String get callGasLimit;
  @override
  @JsonKey(ignore: true)
  _$$VerifyingPaymasterResultImplCopyWith<_$VerifyingPaymasterResultImpl>
      get copyWith => throw _privateConstructorUsedError;
}

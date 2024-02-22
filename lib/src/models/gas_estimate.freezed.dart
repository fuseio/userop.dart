// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gas_estimate.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GasEstimate _$GasEstimateFromJson(Map<String, dynamic> json) {
  return _GasEstimate.fromJson(json);
}

/// @nodoc
mixin _$GasEstimate {
  String? get verificationGasLimit => throw _privateConstructorUsedError;
  String get preVerificationGas => throw _privateConstructorUsedError;
  String get callGasLimit => throw _privateConstructorUsedError;

  /// TODO: remove this with EntryPoint v0.7
  String get verificationGas => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GasEstimateCopyWith<GasEstimate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GasEstimateCopyWith<$Res> {
  factory $GasEstimateCopyWith(
          GasEstimate value, $Res Function(GasEstimate) then) =
      _$GasEstimateCopyWithImpl<$Res, GasEstimate>;
  @useResult
  $Res call(
      {String? verificationGasLimit,
      String preVerificationGas,
      String callGasLimit,
      String verificationGas});
}

/// @nodoc
class _$GasEstimateCopyWithImpl<$Res, $Val extends GasEstimate>
    implements $GasEstimateCopyWith<$Res> {
  _$GasEstimateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? verificationGasLimit = freezed,
    Object? preVerificationGas = null,
    Object? callGasLimit = null,
    Object? verificationGas = null,
  }) {
    return _then(_value.copyWith(
      verificationGasLimit: freezed == verificationGasLimit
          ? _value.verificationGasLimit
          : verificationGasLimit // ignore: cast_nullable_to_non_nullable
              as String?,
      preVerificationGas: null == preVerificationGas
          ? _value.preVerificationGas
          : preVerificationGas // ignore: cast_nullable_to_non_nullable
              as String,
      callGasLimit: null == callGasLimit
          ? _value.callGasLimit
          : callGasLimit // ignore: cast_nullable_to_non_nullable
              as String,
      verificationGas: null == verificationGas
          ? _value.verificationGas
          : verificationGas // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GasEstimateImplCopyWith<$Res>
    implements $GasEstimateCopyWith<$Res> {
  factory _$$GasEstimateImplCopyWith(
          _$GasEstimateImpl value, $Res Function(_$GasEstimateImpl) then) =
      __$$GasEstimateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? verificationGasLimit,
      String preVerificationGas,
      String callGasLimit,
      String verificationGas});
}

/// @nodoc
class __$$GasEstimateImplCopyWithImpl<$Res>
    extends _$GasEstimateCopyWithImpl<$Res, _$GasEstimateImpl>
    implements _$$GasEstimateImplCopyWith<$Res> {
  __$$GasEstimateImplCopyWithImpl(
      _$GasEstimateImpl _value, $Res Function(_$GasEstimateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? verificationGasLimit = freezed,
    Object? preVerificationGas = null,
    Object? callGasLimit = null,
    Object? verificationGas = null,
  }) {
    return _then(_$GasEstimateImpl(
      verificationGasLimit: freezed == verificationGasLimit
          ? _value.verificationGasLimit
          : verificationGasLimit // ignore: cast_nullable_to_non_nullable
              as String?,
      preVerificationGas: null == preVerificationGas
          ? _value.preVerificationGas
          : preVerificationGas // ignore: cast_nullable_to_non_nullable
              as String,
      callGasLimit: null == callGasLimit
          ? _value.callGasLimit
          : callGasLimit // ignore: cast_nullable_to_non_nullable
              as String,
      verificationGas: null == verificationGas
          ? _value.verificationGas
          : verificationGas // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GasEstimateImpl implements _GasEstimate {
  _$GasEstimateImpl(
      {required this.verificationGasLimit,
      required this.preVerificationGas,
      required this.callGasLimit,
      required this.verificationGas});

  factory _$GasEstimateImpl.fromJson(Map<String, dynamic> json) =>
      _$$GasEstimateImplFromJson(json);

  @override
  final String? verificationGasLimit;
  @override
  final String preVerificationGas;
  @override
  final String callGasLimit;

  /// TODO: remove this with EntryPoint v0.7
  @override
  final String verificationGas;

  @override
  String toString() {
    return 'GasEstimate(verificationGasLimit: $verificationGasLimit, preVerificationGas: $preVerificationGas, callGasLimit: $callGasLimit, verificationGas: $verificationGas)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GasEstimateImpl &&
            (identical(other.verificationGasLimit, verificationGasLimit) ||
                other.verificationGasLimit == verificationGasLimit) &&
            (identical(other.preVerificationGas, preVerificationGas) ||
                other.preVerificationGas == preVerificationGas) &&
            (identical(other.callGasLimit, callGasLimit) ||
                other.callGasLimit == callGasLimit) &&
            (identical(other.verificationGas, verificationGas) ||
                other.verificationGas == verificationGas));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, verificationGasLimit,
      preVerificationGas, callGasLimit, verificationGas);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GasEstimateImplCopyWith<_$GasEstimateImpl> get copyWith =>
      __$$GasEstimateImplCopyWithImpl<_$GasEstimateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GasEstimateImplToJson(
      this,
    );
  }
}

abstract class _GasEstimate implements GasEstimate {
  factory _GasEstimate(
      {required final String? verificationGasLimit,
      required final String preVerificationGas,
      required final String callGasLimit,
      required final String verificationGas}) = _$GasEstimateImpl;

  factory _GasEstimate.fromJson(Map<String, dynamic> json) =
      _$GasEstimateImpl.fromJson;

  @override
  String? get verificationGasLimit;
  @override
  String get preVerificationGas;
  @override
  String get callGasLimit;
  @override

  /// TODO: remove this with EntryPoint v0.7
  String get verificationGas;
  @override
  @JsonKey(ignore: true)
  _$$GasEstimateImplCopyWith<_$GasEstimateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

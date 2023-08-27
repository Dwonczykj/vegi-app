// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'ESCExplanation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ESCExplanation _$ESCExplanationFromJson(Map<String, dynamic> json) {
  return _ESCExplanation.fromJson(json);
}

/// @nodoc
mixin _$ESCExplanation {
  String get evidence => throw _privateConstructorUsedError;
  int get id => throw _privateConstructorUsedError;
  num get measure =>
      throw _privateConstructorUsedError; // required ESCRating escrating,
  num get rating => throw _privateConstructorUsedError;
  int get source => throw _privateConstructorUsedError;
  String get title =>
      throw _privateConstructorUsedError; // required String description,
  List<String> get reasons => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ESCExplanationCopyWith<ESCExplanation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ESCExplanationCopyWith<$Res> {
  factory $ESCExplanationCopyWith(
          ESCExplanation value, $Res Function(ESCExplanation) then) =
      _$ESCExplanationCopyWithImpl<$Res, ESCExplanation>;
  @useResult
  $Res call(
      {String evidence,
      int id,
      num measure,
      num rating,
      int source,
      String title,
      List<String> reasons,
      String imageUrl});
}

/// @nodoc
class _$ESCExplanationCopyWithImpl<$Res, $Val extends ESCExplanation>
    implements $ESCExplanationCopyWith<$Res> {
  _$ESCExplanationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? evidence = null,
    Object? id = null,
    Object? measure = null,
    Object? rating = null,
    Object? source = null,
    Object? title = null,
    Object? reasons = null,
    Object? imageUrl = null,
  }) {
    return _then(_value.copyWith(
      evidence: null == evidence
          ? _value.evidence
          : evidence // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      measure: null == measure
          ? _value.measure
          : measure // ignore: cast_nullable_to_non_nullable
              as num,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as num,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      reasons: null == reasons
          ? _value.reasons
          : reasons // ignore: cast_nullable_to_non_nullable
              as List<String>,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ESCExplanationCopyWith<$Res>
    implements $ESCExplanationCopyWith<$Res> {
  factory _$$_ESCExplanationCopyWith(
          _$_ESCExplanation value, $Res Function(_$_ESCExplanation) then) =
      __$$_ESCExplanationCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String evidence,
      int id,
      num measure,
      num rating,
      int source,
      String title,
      List<String> reasons,
      String imageUrl});
}

/// @nodoc
class __$$_ESCExplanationCopyWithImpl<$Res>
    extends _$ESCExplanationCopyWithImpl<$Res, _$_ESCExplanation>
    implements _$$_ESCExplanationCopyWith<$Res> {
  __$$_ESCExplanationCopyWithImpl(
      _$_ESCExplanation _value, $Res Function(_$_ESCExplanation) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? evidence = null,
    Object? id = null,
    Object? measure = null,
    Object? rating = null,
    Object? source = null,
    Object? title = null,
    Object? reasons = null,
    Object? imageUrl = null,
  }) {
    return _then(_$_ESCExplanation(
      evidence: null == evidence
          ? _value.evidence
          : evidence // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      measure: null == measure
          ? _value.measure
          : measure // ignore: cast_nullable_to_non_nullable
              as num,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as num,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      reasons: null == reasons
          ? _value.reasons
          : reasons // ignore: cast_nullable_to_non_nullable
              as List<String>,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$_ESCExplanation extends _ESCExplanation {
  _$_ESCExplanation(
      {required this.evidence,
      required this.id,
      required this.measure,
      required this.rating,
      required this.source,
      required this.title,
      required this.reasons,
      this.imageUrl = ''})
      : super._();

  factory _$_ESCExplanation.fromJson(Map<String, dynamic> json) =>
      _$$_ESCExplanationFromJson(json);

  @override
  final String evidence;
  @override
  final int id;
  @override
  final num measure;
// required ESCRating escrating,
  @override
  final num rating;
  @override
  final int source;
  @override
  final String title;
// required String description,
  @override
  final List<String> reasons;
  @override
  @JsonKey()
  final String imageUrl;

  @override
  String toString() {
    return 'ESCExplanation(evidence: $evidence, id: $id, measure: $measure, rating: $rating, source: $source, title: $title, reasons: $reasons, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ESCExplanation &&
            (identical(other.evidence, evidence) ||
                other.evidence == evidence) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.measure, measure) || other.measure == measure) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other.reasons, reasons) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, evidence, id, measure, rating,
      source, title, const DeepCollectionEquality().hash(reasons), imageUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ESCExplanationCopyWith<_$_ESCExplanation> get copyWith =>
      __$$_ESCExplanationCopyWithImpl<_$_ESCExplanation>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ESCExplanationToJson(
      this,
    );
  }
}

abstract class _ESCExplanation extends ESCExplanation {
  factory _ESCExplanation(
      {required final String evidence,
      required final int id,
      required final num measure,
      required final num rating,
      required final int source,
      required final String title,
      required final List<String> reasons,
      final String imageUrl}) = _$_ESCExplanation;
  _ESCExplanation._() : super._();

  factory _ESCExplanation.fromJson(Map<String, dynamic> json) =
      _$_ESCExplanation.fromJson;

  @override
  String get evidence;
  @override
  int get id;
  @override
  num get measure;
  @override // required ESCRating escrating,
  num get rating;
  @override
  int get source;
  @override
  String get title;
  @override // required String description,
  List<String> get reasons;
  @override
  String get imageUrl;
  @override
  @JsonKey(ignore: true)
  _$$_ESCExplanationCopyWith<_$_ESCExplanation> get copyWith =>
      throw _privateConstructorUsedError;
}

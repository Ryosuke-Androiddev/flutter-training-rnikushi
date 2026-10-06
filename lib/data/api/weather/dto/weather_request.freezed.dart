// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weather_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WeatherRequest {

 String get area; DateTime get date;
/// Create a copy of WeatherRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeatherRequestCopyWith<WeatherRequest> get copyWith => _$WeatherRequestCopyWithImpl<WeatherRequest>(this as WeatherRequest, _$identity);

  /// Serializes this WeatherRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as WeatherRequest;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WeatherRequest&&(identical(other.area, _this.area) || other.area == _this.area)&&(identical(other.date, _this.date) || other.date == _this.date));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as WeatherRequest;
  return Object.hash(runtimeType,_this.area,_this.date);
}

@override
String toString() {
  final _this = this as WeatherRequest;
  return 'WeatherRequest(area: ${_this.area}, date: ${_this.date})';
}


}

/// @nodoc
abstract mixin class $WeatherRequestCopyWith<$Res>  {
  factory $WeatherRequestCopyWith(WeatherRequest value, $Res Function(WeatherRequest) _then) = _$WeatherRequestCopyWithImpl;
@useResult
$Res call({
 String area, DateTime date
});




}
/// @nodoc
class _$WeatherRequestCopyWithImpl<$Res>
    implements $WeatherRequestCopyWith<$Res> {
  _$WeatherRequestCopyWithImpl(this._self, this._then);

  final WeatherRequest _self;
  final $Res Function(WeatherRequest) _then;

/// Create a copy of WeatherRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? area = null,Object? date = null,}) {
  return _then(WeatherRequest(
area: null == area ? _self.area : area // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [WeatherRequest].
extension WeatherRequestPatterns on WeatherRequest {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WeatherRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WeatherRequest() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WeatherRequest value)  $default,){
final _that = this;
switch (_that) {
case _WeatherRequest():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WeatherRequest value)?  $default,){
final _that = this;
switch (_that) {
case _WeatherRequest() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String area,  DateTime date)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WeatherRequest() when $default != null:
return $default(_that.area,_that.date);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String area,  DateTime date)  $default,) {final _that = this;
switch (_that) {
case _WeatherRequest():
return $default(_that.area,_that.date);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String area,  DateTime date)?  $default,) {final _that = this;
switch (_that) {
case _WeatherRequest() when $default != null:
return $default(_that.area,_that.date);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(createFactory: false)

class _WeatherRequest implements WeatherRequest {
  const _WeatherRequest({required this.area, required this.date});
  

@override final  String area;
@override final  DateTime date;

/// Create a copy of WeatherRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeatherRequestCopyWith<_WeatherRequest> get copyWith => __$WeatherRequestCopyWithImpl<_WeatherRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WeatherRequestToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _WeatherRequest&&(identical(other.area, area) || other.area == area)&&(identical(other.date, date) || other.date == date));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,area,date);
}

@override
String toString() {
    return 'WeatherRequest(area: $area, date: $date)';
}


}

/// @nodoc
abstract mixin class _$WeatherRequestCopyWith<$Res> implements $WeatherRequestCopyWith<$Res> {
  factory _$WeatherRequestCopyWith(_WeatherRequest value, $Res Function(_WeatherRequest) _then) = __$WeatherRequestCopyWithImpl;
@override @useResult
$Res call({
 String area, DateTime date
});




}
/// @nodoc
class __$WeatherRequestCopyWithImpl<$Res>
    implements _$WeatherRequestCopyWith<$Res> {
  __$WeatherRequestCopyWithImpl(this._self, this._then);

  final _WeatherRequest _self;
  final $Res Function(_WeatherRequest) _then;

/// Create a copy of WeatherRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? area = null,Object? date = null,}) {
  return _then(_WeatherRequest(
area: null == area ? _self.area : area // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on

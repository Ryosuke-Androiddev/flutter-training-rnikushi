// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weather_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WeatherResponse {

 WeatherCondition get weatherCondition; int get maxTemperature; int get minTemperature; DateTime get date;
/// Create a copy of WeatherResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeatherResponseCopyWith<WeatherResponse> get copyWith => _$WeatherResponseCopyWithImpl<WeatherResponse>(this as WeatherResponse, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as WeatherResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WeatherResponse&&(identical(other.weatherCondition, _this.weatherCondition) || other.weatherCondition == _this.weatherCondition)&&(identical(other.maxTemperature, _this.maxTemperature) || other.maxTemperature == _this.maxTemperature)&&(identical(other.minTemperature, _this.minTemperature) || other.minTemperature == _this.minTemperature)&&(identical(other.date, _this.date) || other.date == _this.date));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as WeatherResponse;
  return Object.hash(runtimeType,_this.weatherCondition,_this.maxTemperature,_this.minTemperature,_this.date);
}

@override
String toString() {
  final _this = this as WeatherResponse;
  return 'WeatherResponse(weatherCondition: ${_this.weatherCondition}, maxTemperature: ${_this.maxTemperature}, minTemperature: ${_this.minTemperature}, date: ${_this.date})';
}


}

/// @nodoc
abstract mixin class $WeatherResponseCopyWith<$Res>  {
  factory $WeatherResponseCopyWith(WeatherResponse value, $Res Function(WeatherResponse) _then) = _$WeatherResponseCopyWithImpl;
@useResult
$Res call({
 WeatherCondition weatherCondition, int maxTemperature, int minTemperature, DateTime date
});




}
/// @nodoc
class _$WeatherResponseCopyWithImpl<$Res>
    implements $WeatherResponseCopyWith<$Res> {
  _$WeatherResponseCopyWithImpl(this._self, this._then);

  final WeatherResponse _self;
  final $Res Function(WeatherResponse) _then;

/// Create a copy of WeatherResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? weatherCondition = null,Object? maxTemperature = null,Object? minTemperature = null,Object? date = null,}) {
  return _then(WeatherResponse(
weatherCondition: null == weatherCondition ? _self.weatherCondition : weatherCondition // ignore: cast_nullable_to_non_nullable
as WeatherCondition,maxTemperature: null == maxTemperature ? _self.maxTemperature : maxTemperature // ignore: cast_nullable_to_non_nullable
as int,minTemperature: null == minTemperature ? _self.minTemperature : minTemperature // ignore: cast_nullable_to_non_nullable
as int,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [WeatherResponse].
extension WeatherResponsePatterns on WeatherResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WeatherResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WeatherResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WeatherResponse value)  $default,){
final _that = this;
switch (_that) {
case _WeatherResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WeatherResponse value)?  $default,){
final _that = this;
switch (_that) {
case _WeatherResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( WeatherCondition weatherCondition,  int maxTemperature,  int minTemperature,  DateTime date)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WeatherResponse() when $default != null:
return $default(_that.weatherCondition,_that.maxTemperature,_that.minTemperature,_that.date);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( WeatherCondition weatherCondition,  int maxTemperature,  int minTemperature,  DateTime date)  $default,) {final _that = this;
switch (_that) {
case _WeatherResponse():
return $default(_that.weatherCondition,_that.maxTemperature,_that.minTemperature,_that.date);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( WeatherCondition weatherCondition,  int maxTemperature,  int minTemperature,  DateTime date)?  $default,) {final _that = this;
switch (_that) {
case _WeatherResponse() when $default != null:
return $default(_that.weatherCondition,_that.maxTemperature,_that.minTemperature,_that.date);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(createToJson: false)

class _WeatherResponse extends WeatherResponse {
  const _WeatherResponse({required this.weatherCondition, required this.maxTemperature, required this.minTemperature, required this.date}): super._();
  factory _WeatherResponse.fromJson(Map<String, dynamic> json) => _$WeatherResponseFromJson(json);

@override final  WeatherCondition weatherCondition;
@override final  int maxTemperature;
@override final  int minTemperature;
@override final  DateTime date;

/// Create a copy of WeatherResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeatherResponseCopyWith<_WeatherResponse> get copyWith => __$WeatherResponseCopyWithImpl<_WeatherResponse>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _WeatherResponse&&(identical(other.weatherCondition, weatherCondition) || other.weatherCondition == weatherCondition)&&(identical(other.maxTemperature, maxTemperature) || other.maxTemperature == maxTemperature)&&(identical(other.minTemperature, minTemperature) || other.minTemperature == minTemperature)&&(identical(other.date, date) || other.date == date));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,weatherCondition,maxTemperature,minTemperature,date);
}

@override
String toString() {
    return 'WeatherResponse(weatherCondition: $weatherCondition, maxTemperature: $maxTemperature, minTemperature: $minTemperature, date: $date)';
}


}

/// @nodoc
abstract mixin class _$WeatherResponseCopyWith<$Res> implements $WeatherResponseCopyWith<$Res> {
  factory _$WeatherResponseCopyWith(_WeatherResponse value, $Res Function(_WeatherResponse) _then) = __$WeatherResponseCopyWithImpl;
@override @useResult
$Res call({
 WeatherCondition weatherCondition, int maxTemperature, int minTemperature, DateTime date
});




}
/// @nodoc
class __$WeatherResponseCopyWithImpl<$Res>
    implements _$WeatherResponseCopyWith<$Res> {
  __$WeatherResponseCopyWithImpl(this._self, this._then);

  final _WeatherResponse _self;
  final $Res Function(_WeatherResponse) _then;

/// Create a copy of WeatherResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? weatherCondition = null,Object? maxTemperature = null,Object? minTemperature = null,Object? date = null,}) {
  return _then(_WeatherResponse(
weatherCondition: null == weatherCondition ? _self.weatherCondition : weatherCondition // ignore: cast_nullable_to_non_nullable
as WeatherCondition,maxTemperature: null == maxTemperature ? _self.maxTemperature : maxTemperature // ignore: cast_nullable_to_non_nullable
as int,minTemperature: null == minTemperature ? _self.minTemperature : minTemperature // ignore: cast_nullable_to_non_nullable
as int,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on

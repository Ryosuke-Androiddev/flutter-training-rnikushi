import 'package:flutter_training/domain/weather/model/weather_condition.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_forecast.freezed.dart';

@freezed
abstract class WeatherForecast with _$WeatherForecast {
  const factory WeatherForecast({
    required WeatherCondition condition,
    required int maxTemperature,
    required int minTemperature,
    required DateTime date,
  }) = _WeatherForecast;
}

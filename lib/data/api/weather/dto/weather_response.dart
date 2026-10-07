import 'package:flutter_training/domain/weather/model/weather_condition.dart';
import 'package:flutter_training/domain/weather/model/weather_forecast.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_response.freezed.dart';
part 'weather_response.g.dart';

@Freezed(toJson: false)
abstract class WeatherResponse with _$WeatherResponse {
  const factory WeatherResponse({
    required WeatherCondition weatherCondition,
    required int maxTemperature,
    required int minTemperature,
    required DateTime date,
  }) = _WeatherResponse;

  const WeatherResponse._();

  factory WeatherResponse.fromJson(Map<String, dynamic> json) =>
      _$WeatherResponseFromJson(json);

  WeatherForecast toWeatherForecast() => WeatherForecast(
    condition: weatherCondition,
    maxTemperature: maxTemperature,
    minTemperature: minTemperature,
    date: date,
  );
}

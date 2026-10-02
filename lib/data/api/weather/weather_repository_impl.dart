import 'package:flutter_training/domain/weather/exception/unknown_weather_condition_exception.dart';
import 'package:flutter_training/domain/weather/model/weather_condition.dart';
import 'package:flutter_training/domain/weather/repository/weather_repository.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  WeatherRepositoryImpl({YumemiWeather? api}) : _api = api ?? YumemiWeather();

  final YumemiWeather _api;

  @override
  WeatherCondition fetchSimpleWeather() {
    final name = _api.fetchSimpleWeather();
    return switch (name) {
      'sunny' => WeatherCondition.sunny,
      'cloudy' => WeatherCondition.cloudy,
      'rainy' => WeatherCondition.rainy,
      _ => throw UnknownWeatherConditionException(name),
    };
  }
}

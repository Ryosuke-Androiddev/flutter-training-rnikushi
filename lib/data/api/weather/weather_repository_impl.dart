import 'package:flutter_training/domain/weather/exception/unknown_weather_condition_exception.dart';
import 'package:flutter_training/domain/weather/exception/weather_invalid_parameter_exception.dart';
import 'package:flutter_training/domain/weather/exception/weather_unknown_exception.dart';
import 'package:flutter_training/domain/weather/model/weather_condition.dart';
import 'package:flutter_training/domain/weather/repository/weather_repository.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  const WeatherRepositoryImpl(this._api);

  final YumemiWeather _api;

  @override
  WeatherCondition fetchWeatherCondition({required String area}) {
    final String name;
    try {
      name = _api.fetchThrowsWeather(area);
    } on YumemiWeatherError catch (error) {
      throw switch (error) {
        YumemiWeatherError.invalidParameter =>
          const WeatherInvalidParameterException(),
        YumemiWeatherError.unknown => const WeatherUnknownException(),
      };
    }
    return switch (name) {
      'sunny' => WeatherCondition.sunny,
      'cloudy' => WeatherCondition.cloudy,
      'rainy' => WeatherCondition.rainy,
      _ => throw UnknownWeatherConditionException(name),
    };
  }
}

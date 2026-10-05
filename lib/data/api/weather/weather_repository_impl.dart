import 'package:flutter_training/domain/model/app_error.dart';
import 'package:flutter_training/domain/model/result.dart';
import 'package:flutter_training/domain/weather/model/weather_condition.dart';
import 'package:flutter_training/domain/weather/repository/weather_repository.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  const WeatherRepositoryImpl(this._api);

  final YumemiWeather _api;

  @override
  Result<WeatherCondition> fetchWeatherCondition({required String area}) {
    final String name;
    try {
      name = _api.fetchThrowsWeather(area);
    } on YumemiWeatherError catch (error) {
      return Failure(switch (error) {
        YumemiWeatherError.invalidParameter => const InvalidParameterError(),
        YumemiWeatherError.unknown => const UnknownError(),
      });
    }
    return switch (name) {
      'sunny' => const Success(WeatherCondition.sunny),
      'cloudy' => const Success(WeatherCondition.cloudy),
      'rainy' => const Success(WeatherCondition.rainy),
      _ => const Failure(UnknownError()),
    };
  }
}

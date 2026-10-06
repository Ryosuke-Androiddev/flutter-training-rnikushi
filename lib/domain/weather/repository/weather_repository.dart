import 'package:flutter_training/domain/model/result.dart';
import 'package:flutter_training/domain/weather/model/weather_condition.dart';

abstract interface class WeatherRepository {
  Result<WeatherCondition> fetchWeatherCondition({required String area});
}

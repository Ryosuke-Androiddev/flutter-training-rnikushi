import 'package:flutter_training/domain/weather/model/weather_condition.dart';

abstract interface class WeatherRepository {
  WeatherCondition fetchSimpleWeather();
}

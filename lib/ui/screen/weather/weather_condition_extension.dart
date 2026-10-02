import 'package:flutter_training/domain/weather/model/weather_condition.dart';

extension WeatherConditionX on WeatherCondition {
  String get assetPath => switch (this) {
    WeatherCondition.sunny => 'assets/images/sunny.svg',
    WeatherCondition.cloudy => 'assets/images/cloudy.svg',
    WeatherCondition.rainy => 'assets/images/rainy.svg',
  };
}

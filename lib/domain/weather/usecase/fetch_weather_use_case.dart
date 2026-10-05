import 'package:flutter_training/domain/model/result.dart';
import 'package:flutter_training/domain/weather/model/weather_condition.dart';

abstract interface class FetchWeatherUseCase {
  Result<WeatherCondition> call({required String area});
}

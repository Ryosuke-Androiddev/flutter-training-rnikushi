import 'package:flutter_training/domain/model/app_error.dart';
import 'package:flutter_training/domain/weather/model/weather_condition.dart';

final class WeatherUiState {
  const WeatherUiState({this.weatherCondition, this.error});

  final WeatherCondition? weatherCondition;
  final AppError? error;
}

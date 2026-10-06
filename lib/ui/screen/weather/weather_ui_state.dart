import 'package:flutter_training/domain/model/app_error.dart';
import 'package:flutter_training/domain/weather/model/weather_forecast.dart';

final class WeatherUiState {
  const WeatherUiState({this.weatherForecast, this.error});

  final WeatherForecast? weatherForecast;
  final AppError? error;
}

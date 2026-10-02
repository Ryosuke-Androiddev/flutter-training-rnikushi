import 'package:flutter/foundation.dart';
import 'package:flutter_training/domain/model/app_error.dart';
import 'package:flutter_training/domain/model/result.dart';
import 'package:flutter_training/domain/weather/model/weather_condition.dart';
import 'package:flutter_training/domain/weather/usecase/fetch_weather_use_case.dart';

class WeatherViewModel extends ChangeNotifier {
  WeatherViewModel(this._fetchWeatherUseCase);

  final FetchWeatherUseCase _fetchWeatherUseCase;

  WeatherCondition _weatherCondition = WeatherCondition.unknown;

  WeatherCondition get weatherCondition => _weatherCondition;

  void reload() {
    _weatherCondition = switch (_fetchWeatherUseCase()) {
      Success(:final value) => value,
      Failure(error: UnknownError()) => WeatherCondition.unknown,
    };
    notifyListeners();
  }
}

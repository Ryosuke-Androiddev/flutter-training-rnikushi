import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/di/weather_providers.dart';
import 'package:flutter_training/domain/model/app_error.dart';
import 'package:flutter_training/domain/model/result.dart';
import 'package:flutter_training/domain/weather/model/weather_condition.dart';

final weatherViewModelProvider =
    NotifierProvider<WeatherViewModel, WeatherCondition?>(WeatherViewModel.new);

class WeatherViewModel extends Notifier<WeatherCondition?> {
  @override
  WeatherCondition? build() => null;

  void fetchWeather() {
    state = switch (ref.read(fetchWeatherUseCaseProvider)()) {
      Success(:final value) => value,
      Failure(error: UnknownError()) => null,
    };
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/di/weather_providers.dart';
import 'package:flutter_training/domain/model/result.dart';
import 'package:flutter_training/ui/screen/weather/weather_ui_state.dart';

final NotifierProvider<WeatherViewModel, WeatherUiState>
weatherViewModelProvider = NotifierProvider.autoDispose(WeatherViewModel.new);

class WeatherViewModel extends Notifier<WeatherUiState> {
  static const _area = 'tokyo';

  @override
  WeatherUiState build() => const WeatherUiState();

  void fetchWeather() {
    state = switch (ref.read(fetchWeatherUseCaseProvider)(area: _area)) {
      Success(:final value) => WeatherUiState(weatherCondition: value),
      Failure(:final error) => WeatherUiState(
        weatherCondition: state.weatherCondition,
        error: error,
      ),
    };
  }

  void clearError() {
    state = WeatherUiState(weatherCondition: state.weatherCondition);
  }
}

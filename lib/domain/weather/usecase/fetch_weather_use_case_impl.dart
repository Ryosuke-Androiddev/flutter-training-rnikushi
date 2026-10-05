import 'package:flutter_training/domain/model/result.dart';
import 'package:flutter_training/domain/weather/model/weather_condition.dart';
import 'package:flutter_training/domain/weather/repository/weather_repository.dart';
import 'package:flutter_training/domain/weather/usecase/fetch_weather_use_case.dart';

class FetchWeatherUseCaseImpl implements FetchWeatherUseCase {
  const FetchWeatherUseCaseImpl(this._repository);

  final WeatherRepository _repository;

  @override
  Result<WeatherCondition> call({required String area}) =>
      _repository.fetchWeatherCondition(area: area);
}

import 'package:flutter_training/domain/model/app_error.dart';
import 'package:flutter_training/domain/model/result.dart';
import 'package:flutter_training/domain/weather/exception/weather_invalid_parameter_exception.dart';
import 'package:flutter_training/domain/weather/model/weather_condition.dart';
import 'package:flutter_training/domain/weather/repository/weather_repository.dart';
import 'package:flutter_training/domain/weather/usecase/fetch_weather_use_case.dart';

class FetchWeatherUseCaseImpl implements FetchWeatherUseCase {
  const FetchWeatherUseCaseImpl(this._repository);

  final WeatherRepository _repository;

  @override
  Result<WeatherCondition> call({required String area}) {
    try {
      return Success(_repository.fetchWeatherCondition(area: area));
    } on WeatherInvalidParameterException {
      return const Failure(InvalidParameterError());
    } on Exception {
      return const Failure(UnknownError());
    }
  }
}

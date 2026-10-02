import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/data/api/weather/weather_repository_impl.dart';
import 'package:flutter_training/domain/model/app_error.dart';
import 'package:flutter_training/domain/model/result.dart';
import 'package:flutter_training/domain/weather/model/weather_condition.dart';
import 'package:flutter_training/domain/weather/usecase/fetch_weather_use_case_impl.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

class FakeYumemiWeather extends Fake implements YumemiWeather {
  FakeYumemiWeather({this.weather, this.exception});

  final String? weather;
  final Exception? exception;

  @override
  String fetchSimpleWeather() {
    if (exception case final exception?) {
      throw exception;
    }
    return weather!;
  }
}

FetchWeatherUseCaseImpl createUseCase(FakeYumemiWeather api) {
  return FetchWeatherUseCaseImpl(WeatherRepositoryImpl(api: api));
}

void main() {
  group('FetchWeatherUseCaseImpl', () {
    final successCases = {
      'sunny': WeatherCondition.sunny,
      'cloudy': WeatherCondition.cloudy,
      'rainy': WeatherCondition.rainy,
    };

    for (final MapEntry(key: weather, value: expected)
        in successCases.entries) {
      test('API が "$weather" を返すと Success($expected) を返す', () {
        final useCase = createUseCase(FakeYumemiWeather(weather: weather));

        final result = useCase();

        expect(
          result,
          isA<Success<WeatherCondition>>().having(
            (s) => s.value,
            'value',
            expected,
          ),
        );
      });
    }

    for (final weather in ['snowy', 'unknown', '']) {
      test('API が想定外の "$weather" を返すと UnknownError の Failure を返す', () {
        final useCase = createUseCase(FakeYumemiWeather(weather: weather));

        final result = useCase();

        expect(
          result,
          isA<Failure<WeatherCondition>>().having(
            (f) => f.error,
            'error',
            isA<UnknownError>(),
          ),
        );
      });
    }

    test('API が例外を投げると UnknownError の Failure を返す', () {
      final useCase = createUseCase(
        FakeYumemiWeather(exception: Exception('error')),
      );

      final result = useCase();

      expect(
        result,
        isA<Failure<WeatherCondition>>().having(
          (f) => f.error,
          'error',
          isA<UnknownError>(),
        ),
      );
    });
  });
}

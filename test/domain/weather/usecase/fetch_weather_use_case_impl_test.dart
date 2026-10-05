import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/di/weather_providers.dart';
import 'package:flutter_training/domain/model/app_error.dart';
import 'package:flutter_training/domain/weather/model/weather_condition.dart';
import 'package:flutter_training/domain/weather/usecase/fetch_weather_use_case.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

import '../../../fake/fake_yumemi_weather.dart';
import '../../../helper/result_matchers.dart';

FetchWeatherUseCase createUseCase(YumemiWeather api) {
  final container = ProviderContainer.test(
    overrides: [yumemiWeatherProvider.overrideWithValue(api)],
  );
  return container.read(fetchWeatherUseCaseProvider);
}

void main() {
  group('FetchWeatherUseCaseImpl', () {
    const area = 'tokyo';

    const successCases = {
      'sunny': WeatherCondition.sunny,
      'cloudy': WeatherCondition.cloudy,
      'rainy': WeatherCondition.rainy,
    };

    for (final MapEntry(key: weather, value: expected)
        in successCases.entries) {
      test('API が "$weather" を返すと Success($expected) を返す', () {
        final useCase = createUseCase(FakeYumemiWeather.returns(weather));

        expect(useCase(area: area), isSuccess(expected));
      });
    }

    for (final weather in ['snowy', 'unknown', '']) {
      test('API が想定外の "$weather" を返すと UnknownError の Failure を返す', () {
        final useCase = createUseCase(FakeYumemiWeather.returns(weather));

        expect(useCase(area: area), isFailure<UnknownError>());
      });
    }

    test(
      'API が invalidParameter を投げると InvalidParameterError の Failure を返す',
      () {
        final useCase = createUseCase(
          FakeYumemiWeather.throws(YumemiWeatherError.invalidParameter),
        );

        expect(useCase(area: area), isFailure<InvalidParameterError>());
      },
    );

    test('API が unknown を投げると UnknownError の Failure を返す', () {
      final useCase = createUseCase(
        FakeYumemiWeather.throws(YumemiWeatherError.unknown),
      );

      expect(useCase(area: area), isFailure<UnknownError>());
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

class FakeYumemiWeather extends Fake implements YumemiWeather {
  FakeYumemiWeather.returns(String weather) : _fetch = (() => weather);

  FakeYumemiWeather.throws(YumemiWeatherError error)
    : _fetch = (() => Error.throwWithStackTrace(error, StackTrace.current));

  final String Function() _fetch;

  @override
  String fetchThrowsWeather(String area) => _fetch();
}

import 'package:flutter_test/flutter_test.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

class FakeYumemiWeather extends Fake implements YumemiWeather {
  FakeYumemiWeather.returns(String weather) : _fetch = (() => weather);

  FakeYumemiWeather.throws(Exception exception)
    : _fetch = (() => throw exception);

  final String Function() _fetch;

  @override
  String fetchSimpleWeather() => _fetch();
}

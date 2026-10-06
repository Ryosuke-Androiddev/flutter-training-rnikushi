import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

class FakeYumemiWeather extends Fake implements YumemiWeather {
  FakeYumemiWeather.returns(String weather) : _responses = [() => weather];

  FakeYumemiWeather.throws(YumemiWeatherError error)
    : _responses = [() => _throw(error)];

  FakeYumemiWeather.returnsThenThrows(String weather, YumemiWeatherError error)
    : _responses = [() => weather, () => _throw(error)];

  final List<String Function()> _responses;

  final List<String> _requestedAreas = [];

  List<String> get requestedAreas => List.unmodifiable(_requestedAreas);

  @override
  String fetchThrowsWeather(String area) {
    final index = min(_requestedAreas.length, _responses.length - 1);
    _requestedAreas.add(area);
    return _responses[index]();
  }

  static String _throw(YumemiWeatherError error) =>
      Error.throwWithStackTrace(error, StackTrace.current);
}

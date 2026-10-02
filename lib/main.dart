import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_training/data/api/weather/weather_repository_impl.dart';
import 'package:flutter_training/domain/weather/usecase/fetch_weather_use_case_impl.dart';
import 'package:flutter_training/ui/screen/weather/weather_screen.dart';
import 'package:flutter_training/ui/screen/weather/weather_view_model.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

void main() {
  final viewModel = WeatherViewModel(
    FetchWeatherUseCaseImpl(WeatherRepositoryImpl(YumemiWeather())),
  );
  runApp(MainApp(viewModel: viewModel));
}

class MainApp extends StatelessWidget {
  const MainApp({required this.viewModel, super.key});

  final WeatherViewModel viewModel;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      DiagnosticsProperty<WeatherViewModel>('viewModel', viewModel),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: WeatherScreen(viewModel: viewModel));
  }
}

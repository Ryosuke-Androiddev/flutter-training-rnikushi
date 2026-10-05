import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_training/ui/screen/launch/after_layout_mixin.dart';
import 'package:flutter_training/ui/screen/weather/weather_screen.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({super.key});

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen>
    with AfterLayoutMixin<LaunchScreen> {
  @override
  void afterFirstLayout() {
    unawaited(_showWeatherScreen());
  }

  Future<void> _showWeatherScreen() async {
    while (mounted) {
      await Future<void>.delayed(const Duration(milliseconds: 500));
      if (!mounted) {
        return;
      }
      final route = MaterialPageRoute<void>(
        builder: (_) => const WeatherScreen(),
      );
      Navigator.of(context).push(route);
      await route.completed;
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(backgroundColor: Colors.green);
  }
}

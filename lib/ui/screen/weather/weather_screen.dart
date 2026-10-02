import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_training/domain/weather/model/weather_condition.dart';
import 'package:flutter_training/ui/screen/weather/weather_view_model.dart';

class WeatherScreen extends ConsumerWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherCondition = ref.watch(weatherViewModelProvider);
    final labelLarge = Theme.of(context).textTheme.labelLarge;

    return Scaffold(
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.5,
          child: Column(
            children: [
              const Spacer(),
              AspectRatio(
                aspectRatio: 1,
                child: switch (weatherCondition) {
                  WeatherCondition.sunny => SvgPicture.asset(
                    'assets/images/sunny.svg',
                  ),
                  WeatherCondition.cloudy => SvgPicture.asset(
                    'assets/images/cloudy.svg',
                  ),
                  WeatherCondition.rainy => SvgPicture.asset(
                    'assets/images/rainy.svg',
                  ),
                  WeatherCondition.unknown => const Placeholder(),
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        '** ℃',
                        textAlign: TextAlign.center,
                        style: labelLarge?.copyWith(color: Colors.blue),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '** ℃',
                        textAlign: TextAlign.center,
                        style: labelLarge?.copyWith(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    const SizedBox(height: 80),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () {},
                            child: const Text('Close'),
                          ),
                        ),
                        Expanded(
                          child: TextButton(
                            onPressed: () => ref
                                .read(weatherViewModelProvider.notifier)
                                .reload(),
                            child: const Text('Reload'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

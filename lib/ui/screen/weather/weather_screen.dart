import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_training/domain/model/app_error.dart';
import 'package:flutter_training/ui/screen/weather/app_error_extension.dart';
import 'package:flutter_training/ui/screen/weather/weather_condition_extension.dart';
import 'package:flutter_training/ui/screen/weather/weather_view_model.dart';

class WeatherScreen extends ConsumerWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(weatherViewModelProvider.select((state) => state.error), (
      _,
      error,
    ) async {
      if (error == null) {
        return;
      }
      await _showErrorDialog(context, error);
      if (context.mounted) {
        ref.read(weatherViewModelProvider.notifier).clearError();
      }
    });

    final weatherCondition = ref.watch(
      weatherViewModelProvider.select((state) => state.weatherCondition),
    );
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
                child: weatherCondition == null
                    ? const Placeholder()
                    : SvgPicture.asset(weatherCondition.assetPath),
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
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('Close'),
                          ),
                        ),
                        Expanded(
                          child: TextButton(
                            onPressed: () => ref
                                .read(weatherViewModelProvider.notifier)
                                .fetchWeather(),
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

  Future<void> _showErrorDialog(BuildContext context, AppError error) =>
      showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('エラー'),
          content: Text(error.message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
}

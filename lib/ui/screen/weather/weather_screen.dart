import 'package:flutter/material.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.5,
          child: _CenterWithBottom(
            center: _WeatherPanel(),
            bottom: _ActionButtons(),
          ),
        ),
      ),
    );
  }
}

class _CenterWithBottom extends StatelessWidget {
  const _CenterWithBottom({required this.center, required this.bottom});

  final Widget center;
  final Widget bottom;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Expanded(child: SizedBox.shrink()),
        center,
        Expanded(
          child: Align(alignment: Alignment.topCenter, child: bottom),
        ),
      ],
    );
  }
}

class _WeatherPanel extends StatelessWidget {
  const _WeatherPanel();

  @override
  Widget build(BuildContext context) {
    final labelLarge = Theme.of(context).textTheme.labelLarge;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const AspectRatio(aspectRatio: 1, child: Placeholder()),
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
      ],
    );
  }
}

class _ActionButtons extends StatelessWidget {
  const _ActionButtons();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 80),
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              onPressed: () {},
              child: const Text('Close'),
            ),
          ),
          Expanded(
            child: TextButton(
              onPressed: () {},
              child: const Text('Reload'),
            ),
          ),
        ],
      ),
    );
  }
}

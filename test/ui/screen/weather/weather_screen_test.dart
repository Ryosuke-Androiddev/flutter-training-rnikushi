import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/di/weather_providers.dart';
import 'package:flutter_training/ui/screen/weather/weather_screen.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

import '../../../fake/fake_yumemi_weather.dart';

Future<void> pumpWeatherScreen(WidgetTester tester, YumemiWeather api) {
  tester.view
    ..physicalSize = const Size(1080, 2400)
    ..devicePixelRatio = 3;
  addTearDown(tester.view.reset);
  return tester.pumpWidget(
    ProviderScope(
      overrides: [yumemiWeatherProvider.overrideWithValue(api)],
      child: const MaterialApp(home: WeatherScreen()),
    ),
  );
}

Future<void> tapReload(WidgetTester tester) async {
  await tester.tap(find.text('Reload'));
  await tester.pumpAndSettle();
}

void main() {
  group('WeatherScreen', () {
    const unknownMessage = '天気を取得できませんでした。時間をおいて再度お試しください。';

    testWidgets('API が unknown を投げるとエラーダイアログを表示する', (tester) async {
      await pumpWeatherScreen(
        tester,
        FakeYumemiWeather.throws(YumemiWeatherError.unknown),
      );

      await tapReload(tester);

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text(unknownMessage), findsOneWidget);
    });

    testWidgets(
      'API が invalidParameter を投げると取得条件のエラーメッセージを表示する',
      (tester) async {
        await pumpWeatherScreen(
          tester,
          FakeYumemiWeather.throws(YumemiWeatherError.invalidParameter),
        );

        await tapReload(tester);

        expect(find.text('天気の取得条件が正しくありません。'), findsOneWidget);
      },
    );

    testWidgets('OK で閉じた後も、再度エラーになるとダイアログを表示する', (tester) async {
      await pumpWeatherScreen(
        tester,
        FakeYumemiWeather.throws(YumemiWeatherError.unknown),
      );

      await tapReload(tester);
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();

      expect(find.byType(AlertDialog), findsNothing);

      await tapReload(tester);

      expect(find.byType(AlertDialog), findsOneWidget);
    });

    testWidgets('ダイアログの外側をタップして閉じた後も、再度エラーになるとダイアログを表示する', (
      tester,
    ) async {
      await pumpWeatherScreen(
        tester,
        FakeYumemiWeather.throws(YumemiWeatherError.unknown),
      );

      await tapReload(tester);
      await tester.tapAt(const Offset(10, 10));
      await tester.pumpAndSettle();

      expect(find.byType(AlertDialog), findsNothing);

      await tapReload(tester);

      expect(find.byType(AlertDialog), findsOneWidget);
    });

    testWidgets('取得に失敗しても、表示中の天気を残す', (tester) async {
      await pumpWeatherScreen(
        tester,
        FakeYumemiWeather.returnsThenThrows(
          'sunny',
          YumemiWeatherError.unknown,
        ),
      );

      await tapReload(tester);

      expect(find.byType(SvgPicture), findsOneWidget);

      await tapReload(tester);
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();

      expect(find.byType(SvgPicture), findsOneWidget);
      expect(find.byType(Placeholder), findsNothing);
    });

    testWidgets('取得に成功するとダイアログを表示しない', (tester) async {
      await pumpWeatherScreen(tester, FakeYumemiWeather.returns('sunny'));

      await tapReload(tester);

      expect(find.byType(AlertDialog), findsNothing);
    });
  });
}

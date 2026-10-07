import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_request.freezed.dart';
part 'weather_request.g.dart';

@Freezed(fromJson: false, toJson: true)
abstract class WeatherRequest with _$WeatherRequest {
  const factory WeatherRequest({
    required String area,
    required DateTime date,
  }) = _WeatherRequest;
}

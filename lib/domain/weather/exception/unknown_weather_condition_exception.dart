class UnknownWeatherConditionException implements Exception {
  const UnknownWeatherConditionException(this.value);

  final String value;

  @override
  String toString() => 'UnknownWeatherConditionException: $value';
}

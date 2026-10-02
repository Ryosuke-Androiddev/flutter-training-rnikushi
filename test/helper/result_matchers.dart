import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/domain/model/app_error.dart';
import 'package:flutter_training/domain/model/result.dart';

Matcher isSuccess<T>(T value) =>
    isA<Success<T>>().having((s) => s.value, 'value', value);

Matcher isFailure<E extends AppError>() =>
    isA<Failure<Object?>>().having((f) => f.error, 'error', isA<E>());

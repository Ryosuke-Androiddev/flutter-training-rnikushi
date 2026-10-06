import 'package:flutter_training/domain/model/app_error.dart';

extension AppErrorX on AppError {
  String get message => switch (this) {
    InvalidParameterError() => '天気の取得条件が正しくありません。',
    UnknownError() => '天気を取得できませんでした。時間をおいて再度お試しください。',
  };
}

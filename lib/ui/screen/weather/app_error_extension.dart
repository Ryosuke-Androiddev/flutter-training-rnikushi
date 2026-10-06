import 'package:flutter_training/domain/model/app_error.dart';

extension AppErrorX on AppError {
  String get message => switch (this) {
    InvalidParameterError() => '天気の取得条件が正しくありません。',
    MalformedJsonError() => '天気の情報を読み取れませんでした。',
    UnexpectedResponseError() => '天気の情報が想定外の内容でした。',
    UnknownError() => '天気を取得できませんでした。時間をおいて再度お試しください。',
  };
}

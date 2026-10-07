sealed class AppError {
  const AppError();
}

final class InvalidParameterError extends AppError {
  const InvalidParameterError();
}

final class MalformedJsonError extends AppError {
  const MalformedJsonError();
}

final class UnexpectedResponseError extends AppError {
  const UnexpectedResponseError();
}

final class UnknownError extends AppError {
  const UnknownError();
}

sealed class AppError {
  const AppError();
}

final class InvalidParameterError extends AppError {
  const InvalidParameterError();
}

final class UnknownError extends AppError {
  const UnknownError();
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_error.freezed.dart';

@freezed
class AppError with _$AppError {
  const AppError._();

  // Ошибки, связанные с сетью и API
  const factory AppError.networkConnectionError() = _NetworkConnectionError;
  const factory AppError.serverError() = _ServerError;

  // Ошибки, связанные с аутентификацией
  const factory AppError.invalidEmailError() = _InvalidCredentialsError;
  const factory AppError.userAlreadyExistsError() = _UserAlreadyExistsError;
  const factory AppError.permissionDenied() = _PermissionDenied;

  // Ошибки, связанные с базой данных
  const factory AppError.notFound() = _NotFound;
  const factory AppError.databaseError() = _DatabaseError;
  const factory AppError.userNotFound() = _DataNotFound;

  // Ошибки валидации данных (например, некорректный ввод)
  const factory AppError.validationError({required String message}) =
      _ValidationError;

  // Общая, непредвиденная ошибка
  const factory AppError.unknownError() = _UnknownError;

  String get message {
    return when(
      networkConnectionError: () => 'Проверьте подключение к интернету.',
      userAlreadyExistsError: () =>
          'Этот пользователь уже существует. Пожалуйста, выберите другой.',
      userNotFound: () =>
          'Пользователь не найден. Пожалуйста, проверьте введённые данные.',
      invalidEmailError: () => 'Неверный адрес электронной почты или пароль.',
      unknownError: () =>
          'Произошла непредвиденная ошибка. Пожалуйста, попробуйте позже.',
      serverError: () =>
          'Сервер временно недоступен. Попробуйте снова через некоторое время.',
      databaseError: () =>
          'Произошла ошибка базы данных. Пожалуйста, обратитесь в поддержку.',
      permissionDenied: () => 'У вас нет прав для выполнения этого действия.',
      notFound: () => 'Запрошенный ресурс не найден.',
      validationError: (String message) => message,
    );
  }
}

part of 'forgot_password_bloc.dart';

@freezed
abstract class ForgotPasswordState with _$ForgotPasswordState {
  const factory ForgotPasswordState.initial() = _Initial;

  const factory ForgotPasswordState.loading() = _Loading;

  const factory ForgotPasswordState.error(String message) = _ErrorState;

  const factory ForgotPasswordState.success() = _Success;
}

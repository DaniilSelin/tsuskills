part of 'login_bloc.dart';

@freezed
abstract class LoginState with _$LoginState {
  const factory LoginState.initial() = _Initial;

  const factory LoginState.loading() = _Loading;

  const factory LoginState.error(String message) = _ErrorState;

  const factory LoginState.success(UserEntity user) = _Success;
}

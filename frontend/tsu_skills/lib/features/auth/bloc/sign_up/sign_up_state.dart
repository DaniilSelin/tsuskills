part of 'sign_up_bloc.dart';

@freezed
abstract class SignUpState with _$SignUpState {
  const factory SignUpState.initial() = _Initial;

  const factory SignUpState.loading() = _Loading;

  const factory SignUpState.error(String message) = _ErrorState;

  const factory SignUpState.success(UserEntity user) = _Success;
}

part of 'sign_up_bloc.dart';

@freezed
abstract class SignUpEvent with _$SignUpEvent {
  const factory SignUpEvent.sendData({
    required String email,
    required String username,
    required String password,
    required String repeatPassword,
  }) = _SendData;
}

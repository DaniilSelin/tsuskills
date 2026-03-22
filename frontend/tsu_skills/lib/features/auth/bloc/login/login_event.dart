part of 'login_bloc.dart';

@freezed
abstract class LoginEvent with _$LoginEvent {
  const factory LoginEvent.sendData({
    required String username,
    required String password,
  }) = _SendData;
}

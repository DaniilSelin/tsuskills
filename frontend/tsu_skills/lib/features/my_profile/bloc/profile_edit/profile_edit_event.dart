part of 'profile_edit_bloc.dart';

@freezed
abstract class ProfileEditEvent with _$ProfileEditEvent {
  const factory ProfileEditEvent.started() = _Started;
  const factory ProfileEditEvent.sendData({
    required String email,
    required String username,
    required String vkRef,
    required String telegramRef,
    required String phone,
    XFile? userPhoto,
  }) = _SendData;
}

part of 'profile_edit_bloc.dart';

@freezed
abstract class ProfileEditState with _$ProfileEditState {
  const factory ProfileEditState.loading() = _Loading;
  const factory ProfileEditState.loaded(UserEntity user) = _Loaded;
  const factory ProfileEditState.error(String message) = _ErrorState;
  const factory ProfileEditState.success() = _Success;
}

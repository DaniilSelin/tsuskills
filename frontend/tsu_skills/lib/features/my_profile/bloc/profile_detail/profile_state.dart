part of 'profile_bloc.dart';

@freezed
abstract class ProfileState with _$ProfileState {
  const factory ProfileState.loading() = _Loading;
  const factory ProfileState.loaded(UserEntity user) = _Loaded;
  const factory ProfileState.error(String message) = _ErrorState;
  const factory ProfileState.logout() = _HasLogoutState;
}

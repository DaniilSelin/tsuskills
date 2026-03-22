part of 'user_role_bloc.dart';

@freezed
abstract class UserRoleState with _$UserRoleState {
  const factory UserRoleState.loading() = _Loading;
  const factory UserRoleState.loadedRole(RoleEnum role) = _LoadedRole;
  const factory UserRoleState.error(String message) = _Error;
}

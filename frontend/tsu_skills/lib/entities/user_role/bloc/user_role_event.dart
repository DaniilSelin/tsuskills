part of 'user_role_bloc.dart';

@freezed
abstract class UserRoleEvent with _$UserRoleEvent {
  const factory UserRoleEvent.init() = _Init;
  const factory UserRoleEvent.updateRole() = _UpdateRole;
}

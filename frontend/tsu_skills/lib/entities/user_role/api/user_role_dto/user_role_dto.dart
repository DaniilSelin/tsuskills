import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_role_dto.freezed.dart';
part 'user_role_dto.g.dart';

@freezed
abstract class UserRoleDto with _$UserRoleDto {
  const factory UserRoleDto({
    required String id,
    required String name,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _UserRoleDto;

  factory UserRoleDto.fromJson(Map<String, dynamic> json) =>
      _$UserRoleDtoFromJson(json);
}

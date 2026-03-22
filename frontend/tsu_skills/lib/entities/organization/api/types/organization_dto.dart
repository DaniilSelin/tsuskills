import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tsu_skills/shared/lib/api/dto/pointer/pointer_dto.dart';

part 'organization_dto.freezed.dart';
part 'organization_dto.g.dart';

@freezed
abstract class OrganizationDto with _$OrganizationDto {
  const factory OrganizationDto({
    required String objectId,
    required DateTime createdAt,
    required DateTime updatedAt,
    @JsonKey(name: 'ACL') Map<String, dynamic>? acl,
    required String aboutUs,
    required String name,
    PointerDto? director,
  }) = _OrganizationDto;

  factory OrganizationDto.fromJson(Map<String, dynamic> json) =>
      _$OrganizationDtoFromJson(json);
}

@freezed
abstract class OrganizationCompanion with _$OrganizationCompanion {
  const factory OrganizationCompanion({
    String? objectId,
    @JsonKey(name: 'ACL') Map<String, dynamic>? acl,
    String? aboutUs,
    String? name,
    String? directorId,
  }) = _OrganizationCompanion;

  factory OrganizationCompanion.fromJson(Map<String, dynamic> json) =>
      _$OrganizationCompanionFromJson(json);
}

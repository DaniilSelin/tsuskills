import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tsu_skills/entities/organization/api/types/organization_dto.dart';
import 'package:tsu_skills/entities/skill/@x/vacancy.dart';

part 'vacancy_dto.freezed.dart';
part 'vacancy_dto.g.dart';

@freezed
abstract class VacancyDto with _$VacancyDto {
  const factory VacancyDto({
    required String objectId,
    required DateTime createdAt,
    required DateTime updatedAt,
    required String title,
    required String description,
    required OrganizationDto organization,
    required SkillArrayDto skillPointers,
  }) = _VacancyDto;

  factory VacancyDto.fromJson(Map<String, dynamic> json) =>
      _$VacancyDtoFromJson(json);
}

@freezed
abstract class VacancyCompanion with _$VacancyCompanion {
  const factory VacancyCompanion({
    String? objectId,
    String? title,
    String? description,
    List<String>? skillIds,
    String? organizationId,
  }) = _VacancyCompanion;

  factory VacancyCompanion.fromJson(Map<String, dynamic> json) =>
      _$VacancyCompanionFromJson(json);
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tsu_skills/entities/organization/@x/vacancy.dart';
import 'package:tsu_skills/entities/skill/@x/vacancy.dart';

part 'vacancy_entity.freezed.dart';

@freezed
abstract class VacancyEntity with _$VacancyEntity {
  const factory VacancyEntity({
    required String objectId,
    required DateTime createdAt,
    required DateTime updatedAt,
    required String title,
    required String description,
    required List<SkillEntity> skills,
    required OrganizationEntity organization,
  }) = _VacancyEntity;
}

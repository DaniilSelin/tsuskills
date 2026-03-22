import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tsu_skills/entities/resume/@x/application.dart';
import 'package:tsu_skills/entities/vacancy/@x/application.dart';

part 'application_entity.freezed.dart';

@freezed
abstract class ApplicationEntity with _$ApplicationEntity {
  const factory ApplicationEntity({
    required String id,
    required DateTime createdAt,
    required DateTime updatedAt,
    required ResumeEntity resume,
    required VacancyEntity vacancy,
  }) = _ApplicationEntity;
}

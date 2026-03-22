import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tsu_skills/entities/resume/@x/application.dart';
import 'package:tsu_skills/entities/vacancy/@x/application.dart';

part 'application_dto.freezed.dart';
part 'application_dto.g.dart';

@freezed
abstract class ApplicationDto with _$ApplicationDto {
  const factory ApplicationDto({
    @JsonKey(name: 'className', defaultValue: 'Application')
    required String className,
    @JsonKey(name: 'objectId') required String id,
    @JsonKey(name: 'createdAt') required DateTime createdAt,
    @JsonKey(name: 'updatedAt') required DateTime updatedAt,
    required ResumeDto resume,
    required VacancyDto vacancy,
  }) = _ApplicationDto;

  factory ApplicationDto.fromJson(Map<String, dynamic> json) =>
      _$ApplicationDtoFromJson(json);
}

@freezed
abstract class ApplicationCompanion with _$ApplicationCompanion {
  const factory ApplicationCompanion({
    required String resumeId,
    required String vacancyId,
  }) = _ApplicationCompanion;

  factory ApplicationCompanion.fromJson(Map<String, dynamic> json) =>
      _$ApplicationCompanionFromJson(json);
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tsu_skills/entities/skill/api/skill_dto/skill_dto.dart';
import 'package:tsu_skills/entities/user/@x/resume.dart';
import 'package:tsu_skills/shared/lib/api/dto/pointer/pointer_dto.dart';

part 'resume_dto.freezed.dart';
part 'resume_dto.g.dart';

@freezed
abstract class ResumeCompanion with _$ResumeCompanion {
  const factory ResumeCompanion({
    String? id,
    String? name,
    String? description,
    String? aboutMe,
    List<String>? skillIds,
  }) = _ResumeCompanion;

  factory ResumeCompanion.fromJson(Map<String, dynamic> json) =>
      _$ResumeCompanionFromJson(json);
}

@freezed
abstract class ResumeDto with _$ResumeDto {
  const factory ResumeDto({
    @JsonKey(name: 'objectId') required String id,
    required DateTime updatedAt,
    required DateTime createdAt,
    @JsonKey(name: 'ACL', defaultValue: {}) required Map<String, dynamic> acl,
    required String name,
    required String description,
    @JsonKey(name: 'user') UserDto? user,
    required String aboutMe,
    @JsonKey(name: 'skills') required SkillRelationDto skillsRelation,
    @JsonKey(name: 'skillPointers') required SkillArrayDto skills,
  }) = _ResumeDto;

  factory ResumeDto.fromJson(Map<String, dynamic> json) =>
      _$ResumeDtoFromJson(json);
}

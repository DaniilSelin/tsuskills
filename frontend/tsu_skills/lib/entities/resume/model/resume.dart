import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tsu_skills/entities/skill/@x/resume.dart';
import 'package:tsu_skills/entities/user/@x/resume.dart';

part 'resume.freezed.dart';

@freezed
abstract class ResumeEntity with _$ResumeEntity {
  const factory ResumeEntity({
    required String id,
    required DateTime updatedAt,
    required DateTime createdAt,
    required String name,
    required String description,
    required UserEntity? user,
    required String aboutMe,
    required List<SkillEntity> skills,
  }) = _ResumeEntity;
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'skill.freezed.dart';

@freezed
abstract class SkillEntity with _$SkillEntity {
  const factory SkillEntity({
    required String id,
    required String name,
    required DateTime createdAt,
    required DateTime updatedAt,
    required Map<String, dynamic> acl,
  }) = _SkillEntity;
}

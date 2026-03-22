import 'package:freezed_annotation/freezed_annotation.dart';

part 'skill_dto.freezed.dart';
part 'skill_dto.g.dart';


@freezed
abstract class SkillDto with _$SkillDto {
  const factory SkillDto({
    @JsonKey(name: 'className', defaultValue: 'Skills')
    required String className,

    @JsonKey(name: 'objectId') required String id,
    required String name,

    @JsonKey(name: 'createdAt') required DateTime createdAt,
    @JsonKey(name: 'updatedAt') required DateTime updatedAt,

    @JsonKey(name: 'ACL', defaultValue: {}) required Map<String, dynamic> acl,
  }) = _SkillDto;

  factory SkillDto.fromJson(Map<String, dynamic> json) =>
      _$SkillDtoFromJson(json);
}

@freezed
abstract class SkillArrayDto with _$SkillArrayDto {
  const factory SkillArrayDto({
    @JsonKey(name: 'className', defaultValue: 'ParseArray')
    required String className,

    @JsonKey(name: 'estimatedArray', defaultValue: <SkillDto>[])
    required List<SkillDto> estimatedArray,
  }) = _SkillArrayDto;

  factory SkillArrayDto.fromJson(Map<String, dynamic> json) =>
      _$SkillArrayDtoFromJson(json);
}

@freezed
abstract class SkillRelationDto with _$SkillRelationDto {
  const factory SkillRelationDto({
    @JsonKey(name: 'className', defaultValue: 'ParseRelation')
    required String className,

    @JsonKey(name: 'targetClass', defaultValue: 'Skills')
    required String targetClass,
  }) = _SkillRelationDto;

  factory SkillRelationDto.fromJson(Map<String, dynamic> json) =>
      _$SkillRelationDtoFromJson(json);
}
import 'package:tsu_skills/entities/skill/model/types/skill.dart';
import 'package:tsu_skills/entities/skill/api/skill_dto/skill_dto.dart';

class SkillMapper {
  static SkillEntity toEntity(SkillDto dto) {
    final createdAt = dto.createdAt;
    final updatedAt = dto.updatedAt;

    return SkillEntity(
      id: dto.id,
      name: dto.name,
      createdAt: createdAt,
      updatedAt: updatedAt,
      acl: dto.acl,
    );
  }

  static List<SkillEntity> toEntityList(List<SkillDto> dto) {
    return dto.map(toEntity).toList();
  }
}

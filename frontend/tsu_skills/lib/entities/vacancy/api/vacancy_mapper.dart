import 'package:tsu_skills/entities/organization/@x/vacancy.dart';
import 'package:tsu_skills/entities/skill/@x/vacancy.dart';
import 'package:tsu_skills/entities/vacancy/api/vacancy_dto/vacancy_dto.dart';
import 'package:tsu_skills/entities/vacancy/model/vacancy_entity.dart';

class VacancyMapper {
  static VacancyEntity toEntity(VacancyDto dto) {
    return VacancyEntity(
      objectId: dto.objectId,
      createdAt: dto.createdAt,
      updatedAt: dto.updatedAt,
      title: dto.title,
      description: dto.description,
      organization: OrganizationMapper.toEntity(dto.organization),
      skills: dto.skillPointers.estimatedArray.map(SkillMapper.toEntity).toList(),
    );
  }
}

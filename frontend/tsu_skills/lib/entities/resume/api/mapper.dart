import 'package:tsu_skills/entities/resume/api/dto/resume_dto.dart';
import 'package:tsu_skills/entities/resume/model/resume.dart';
import 'package:tsu_skills/entities/skill/@x/resume.dart';
import 'package:tsu_skills/entities/user/@x/organization.dart';

abstract class ResumeMapper {
  static ResumeEntity toEntity(ResumeDto dto) {
    return ResumeEntity(
      id: dto.id,
      updatedAt: dto.updatedAt,
      createdAt: dto.createdAt,
      name: dto.name,
      description: dto.description,
      user: (dto.user !=null)? UserMapper.toEntity(dto.user!) : null ,
      aboutMe: dto.aboutMe,
      skills: dto.skills.estimatedArray
          .map((dto) => SkillMapper.toEntity(dto))
          .toList(),
    );
  }

  static List<ResumeEntity> toEntityList(List<ResumeDto> dto) {
    return dto.map((el) => toEntity(el)).toList();
  }
}

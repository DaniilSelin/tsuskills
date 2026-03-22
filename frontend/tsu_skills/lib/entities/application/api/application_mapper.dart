import 'package:tsu_skills/entities/application/api/application_dto/application_dto.dart';
import 'package:tsu_skills/entities/application/model/application_entity.dart';
import 'package:tsu_skills/entities/resume/@x/application.dart';
import 'package:tsu_skills/entities/vacancy/@x/application.dart';

abstract class ApplicationMapper {
  static ApplicationEntity toEntity(ApplicationDto dto) => ApplicationEntity(
    id: dto.id,
    createdAt: dto.createdAt,
    updatedAt: dto.updatedAt,
    resume: ResumeMapper.toEntity(dto.resume),
    vacancy: VacancyMapper.toEntity(dto.vacancy),
  );

  static List<ApplicationEntity> toEntityList(List<ApplicationDto> dtos) =>
      dtos.map(toEntity).toList();
}

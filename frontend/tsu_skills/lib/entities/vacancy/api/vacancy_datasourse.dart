import 'package:fpdart/fpdart.dart';
import 'package:tsu_skills/entities/vacancy/api/vacancy_dto/vacancy_dto.dart';
import 'package:tsu_skills/shared/lib/core/errors/app_error.dart';

abstract class VacancyDatasource {
  Future<Either<AppError, Unit>> createVacancy(VacancyCompanion vacancy);
  Future<Either<AppError, Unit>> updateVacancy(VacancyCompanion vacancy);
  Future<Either<AppError, Unit>> deleteVacancy(String objectId);

  Future<Either<AppError, VacancyDto?>> getVacancy(String objectId);
  Future<Either<AppError, List<VacancyDto>>> getOrganizationVacancies(
    String organizationId,
  );
  Future<Either<AppError, List<VacancyDto>>> getVacanciesBySkills(
    List<String> skillIds,
  );
  Future<Either<AppError, List<VacancyDto>>> searchVacancies({
    String? name,
    List<String>? skillIds,
  });

  Future<Either<AppError, List<VacancyDto>>> searchMyVacancies(
    VacancyCompanion companion,
  );
  Future<Either<AppError, List<VacancyDto>>> getMyVacancies();
}

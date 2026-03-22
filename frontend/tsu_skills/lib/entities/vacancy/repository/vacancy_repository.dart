import 'package:tsu_skills/entities/vacancy/model/vacancy_entity.dart';
import 'package:tsu_skills/shared/lib/core/errors/app_error.dart';
import 'package:fpdart/fpdart.dart';

abstract class VacancyRepository {
  Future<Either<AppError, Unit>> createVacancy({
    required String name,
    required String description,
    required List<String> skillIds,
  });
  Future<Either<AppError, Unit>> updateVacancy({
    String? name,
    String? description,
    String? organizationId,
    List<String>? skillIds,
  });
  Future<Either<AppError, Unit>> deleteVacancy(String objectId);

  Future<Either<AppError, VacancyEntity?>> getVacancy(String objectId);
  Future<Either<AppError, List<VacancyEntity>>> getOrganizationVacancies(
    String organizationId,
  );
  Future<Either<AppError, List<VacancyEntity>>> getVacanciesBySkills(
    List<String> skillIds,
  );
  Future<Either<AppError, List<VacancyEntity>>> searchVacancies({
    String? name,
    List<String>? skillIds,
  });
  Future<Either<AppError, List<VacancyEntity>>> searchMyVacancies({
    String? title,
    String? description,
    List<String>? skillIds,
  });
  Future<Either<AppError, List<VacancyEntity>>> getMyVacancies();
}

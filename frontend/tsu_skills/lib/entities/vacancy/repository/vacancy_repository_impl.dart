import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:tsu_skills/entities/vacancy/api/vacancy_datasourse.dart';
import 'package:tsu_skills/entities/vacancy/api/vacancy_dto/vacancy_dto.dart';
import 'package:tsu_skills/entities/vacancy/api/vacancy_mapper.dart';
import 'package:tsu_skills/entities/vacancy/repository/vacancy_repository.dart';
import 'package:tsu_skills/entities/vacancy/model/vacancy_entity.dart';
import 'package:tsu_skills/shared/lib/core/errors/app_error.dart';

@Injectable(as: VacancyRepository)
class VacancyRepositoryImpl implements VacancyRepository {
  final VacancyDatasource _datasource;
  const VacancyRepositoryImpl(this._datasource);

  @override
  Future<Either<AppError, List<VacancyEntity>>> searchVacancies({
    String? name,
    List<String>? skillIds,
  }) async {
    final result = await _datasource.searchVacancies(
      name: name,
      skillIds: skillIds,
    );

    return result.map((list) => list.map(VacancyMapper.toEntity).toList());
  }

  @override
  Future<Either<AppError, Unit>> createVacancy({
    required String name,
    required String description,
    required List<String>? skillIds,
  }) {
    return _datasource.createVacancy(
      VacancyCompanion(
        title: name,
        description: description,
        skillIds: skillIds,
      ),
    );
  }

  @override
  Future<Either<AppError, Unit>> updateVacancy({
    String? name,
    String? description,
    String? organizationId,
    List<String>? skillIds,
  }) {
    return _datasource.updateVacancy(
      VacancyCompanion(
        title: name,
        description: description,
        organizationId: organizationId,
        skillIds: skillIds,
      ),
    );
  }

  @override
  Future<Either<AppError, Unit>> deleteVacancy(String objectId) {
    return _datasource.deleteVacancy(objectId);
  }

  @override
  Future<Either<AppError, VacancyEntity?>> getVacancy(String objectId) async {
    final result = await _datasource.getVacancy(objectId);
    return result.map(
      (dto) => dto != null ? VacancyMapper.toEntity(dto) : null,
    );
  }

  @override
  Future<Either<AppError, List<VacancyEntity>>> getOrganizationVacancies(
    String organizationId,
  ) async {
    final result = await _datasource.getOrganizationVacancies(organizationId);
    return result.map((list) => list.map(VacancyMapper.toEntity).toList());
  }

  @override
  Future<Either<AppError, List<VacancyEntity>>> getMyVacancies() async {
    final result = await _datasource.getMyVacancies();
    return result.map((list) => list.map(VacancyMapper.toEntity).toList());
  }

  @override
  Future<Either<AppError, List<VacancyEntity>>> getVacanciesBySkills(
    List<String> skillIds,
  ) async {
    final result = await _datasource.getVacanciesBySkills(skillIds);
    return result.map((list) => list.map(VacancyMapper.toEntity).toList());
  }

  @override
  Future<Either<AppError, List<VacancyEntity>>> searchMyVacancies({
    String? title,
    String? description,
    List<String>? skillIds,
  }) async {
    final result = await _datasource.searchMyVacancies(
      VacancyCompanion(
        title: title,
        description: description,
        skillIds: skillIds,
      ),
    );

    return result.map((el) => el.map(VacancyMapper.toEntity).toList());
  }
}

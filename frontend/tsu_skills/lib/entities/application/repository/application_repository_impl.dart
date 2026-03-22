import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:tsu_skills/entities/application/api/application_datasourse.dart';
import 'package:tsu_skills/entities/application/api/application_dto/application_dto.dart';
import 'package:tsu_skills/entities/application/api/application_mapper.dart';
import 'package:tsu_skills/entities/application/model/application_entity.dart';
import 'package:tsu_skills/entities/application/repository/application_repository.dart';
import 'package:tsu_skills/shared/lib/core/errors/app_error.dart';

@Injectable(as: ApplicationRepository)
class ApplicationRepositoryImpl implements ApplicationRepository {
  ApplicationRepositoryImpl(this._datasourse);
  final ApplicationDatasourse _datasourse;

  @override
  Future<Either<AppError, String>> createApplication({
    required String resumeId,
    required String vacancyId,
  }) async {
    return _datasourse.createApplication(
      ApplicationCompanion(resumeId: resumeId, vacancyId: vacancyId),
    );
  }

  @override
  Future<Either<AppError, List<ApplicationEntity>>> fetchByVacancyId(
    String vacancyId,
  ) async {
    final response = await _datasourse.fetchByVacancyId(vacancyId);

    return response.map(ApplicationMapper.toEntityList);
  }

  @override
  Future<Either<AppError, List<ApplicationEntity>>> fetchMyApplication() async {
    final response = await _datasourse.fetchMyApplication();

    return response.map(ApplicationMapper.toEntityList);
  }

  @override
  Future<Either<AppError, ApplicationEntity>> getMyApplicationById(
    String applicationId,
  ) async {
    final response = await _datasourse.getMyApplicationById(applicationId);

    return response.map(ApplicationMapper.toEntity);
  }

  @override
  Future<Either<AppError, List<ApplicationEntity>>> getApplicationsByVacancy(
    String vacancyId,
  ) async {
    final response = await _datasourse.getApplicationsByVacancy(vacancyId);
    return response.map(ApplicationMapper.toEntityList);
  }
}

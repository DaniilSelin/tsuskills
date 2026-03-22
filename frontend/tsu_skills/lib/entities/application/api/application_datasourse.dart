import 'package:fpdart/fpdart.dart';
import 'package:tsu_skills/entities/application/api/application_dto/application_dto.dart';
import 'package:tsu_skills/shared/lib/core/errors/app_error.dart';

abstract interface class ApplicationDatasourse {
  Future<Either<AppError, String>> createApplication(
    ApplicationCompanion companion,
  );

  Future<Either<AppError, List<ApplicationDto>>> fetchByVacancyId(
    String vacancyId,
  );

  Future<Either<AppError, List<ApplicationDto>>> fetchMyApplication();

  Future<Either<AppError, ApplicationDto>> getMyApplicationById(
    String applicationId,
  );

  Future<Either<AppError, List<ApplicationDto>>> getApplicationsByVacancy(
    String vacancyId,
  );
}

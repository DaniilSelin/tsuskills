import 'package:fpdart/fpdart.dart';
import 'package:tsu_skills/entities/application/model/application_entity.dart';
import 'package:tsu_skills/shared/lib/core/errors/app_error.dart';

abstract interface class ApplicationRepository {
  Future<Either<AppError, String>> createApplication({
    required String resumeId,
    required String vacancyId,
  });

  Future<Either<AppError, List<ApplicationEntity>>> fetchByVacancyId(
    String vacancyId,
  );

  Future<Either<AppError, List<ApplicationEntity>>> fetchMyApplication();

  Future<Either<AppError, ApplicationEntity>> getMyApplicationById(
    String applicationId,
  );

  Future<Either<AppError, List<ApplicationEntity>>> getApplicationsByVacancy(
    String vacancyId,
  );
}

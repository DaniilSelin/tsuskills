import 'package:tsu_skills/entities/resume/api/dto/resume_dto.dart';
import 'package:tsu_skills/shared/lib/core/errors/app_error.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ResumeRemoteDataSource {
  Future<Either<AppError, List<ResumeDto>>> getAvailableResumesForVacancy({
    required String vacancyId,
  });

  Future<Either<AppError, ResumeDto>> fetchResumeDto({
    required String resumeId,
  });

  Future<Either<AppError, List<ResumeDto>>> fetchResumes();

  Future<Either<AppError, Unit>> createResume({required ResumeCompanion data});

  Future<Either<AppError, Unit>> deleteResume({required String resumeId});

  Future<Either<AppError, Unit>> updateResume(ResumeCompanion data);
}

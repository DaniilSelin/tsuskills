import 'package:fpdart/fpdart.dart';
import 'package:tsu_skills/entities/resume/model/resume.dart';
import 'package:tsu_skills/shared/lib/core/errors/app_error.dart';

abstract interface class ResumeRepository {
  Future<Either<AppError, ResumeEntity>> getResume({required String resumeId});

  Future<Either<AppError, Unit>> updateResume({
    required String id,
    String? name,
    String? description,
    String? aboutMe,
    List<String>? skillIds,
  });
  Future<Either<AppError, Unit>> deleteResume({required String resumeId});

  Future<Either<AppError, List<ResumeEntity>>> getMyResumesList();

  Future<Either<AppError, Unit>> createResume({
    required String name,
    required String description,
    required String aboutMe,
    required List<String> skillIds,
  });

  Future<Either<AppError, List<ResumeEntity>>> getAvailableResumesForVacancy(
    String vacancyId,
  );
}

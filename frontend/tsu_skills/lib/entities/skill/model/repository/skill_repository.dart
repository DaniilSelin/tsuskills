import 'package:fpdart/fpdart.dart';
import 'package:tsu_skills/entities/skill/model/types/skill.dart';
import 'package:tsu_skills/shared/lib/core/errors/app_error.dart';

abstract class SkillRepository {
  Future<Either<AppError, List<SkillEntity>>> searchSkills(String query);
  Future<Either<AppError, SkillEntity>> addSkill(String name);
  Future<Either<AppError, Unit>> updateSkill(
    String skillId,
    Map<String, dynamic> changes,
  );
  Future<Either<AppError, Unit>> deleteSkill(String skillId);
}

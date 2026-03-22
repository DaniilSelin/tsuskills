import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:tsu_skills/entities/skill/api/skill_dto/skill_dto.dart';
import 'package:tsu_skills/shared/lib/api/client/api_client.dart';
import 'package:tsu_skills/shared/lib/core/errors/app_error.dart';

@injectable
class SkillRemoteDataSource {
  final ApiClient _api;

  SkillRemoteDataSource(this._api);

  Future<Either<AppError, List<SkillDto>>> searchSkills(String query) async {
    final result = await _api.getList('/api/v1/skills', queryParams: {'q': query});
    return result.fold(
      (err) => Left(err),
      (list) {
        final skills = list.map((e) => SkillDto.fromJson(Map<String, dynamic>.from(e))).toList();
        return Right(skills);
      },
    );
  }

  Future<Either<AppError, SkillDto>> createSkill(String name) async {
    final result = await _api.post('/api/v1/skills', body: {'name': name});
    return result.fold((err) => Left(err), (data) => Right(SkillDto.fromJson(data)));
  }

  Future<Either<AppError, Unit>> updateSkill(String skillId, Map<String, dynamic> changes) async {
    // Go backend doesn't have skill update yet — noop
    return const Right(unit);
  }

  Future<Either<AppError, Unit>> deleteSkill(String skillId) async {
    final result = await _api.delete('/api/v1/skills/$skillId');
    return result.fold((err) => Left(err), (_) => Right(unit));
  }
}

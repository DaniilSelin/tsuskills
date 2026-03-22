import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:tsu_skills/entities/skill/api/datasourse.dart';
import 'package:tsu_skills/entities/skill/api/mapper.dart';
import 'package:tsu_skills/entities/skill/model/types/skill.dart';
import 'package:tsu_skills/entities/skill/model/repository/skill_repository.dart';
import 'package:tsu_skills/shared/lib/core/errors/app_error.dart';

@Injectable(as: SkillRepository)
class SkillRepositoryImpl implements SkillRepository {
  final SkillRemoteDataSource _dataSource;
  SkillRepositoryImpl(this._dataSource);

  @override
  Future<Either<AppError, List<SkillEntity>>> searchSkills(String query) async {
    final result = await _dataSource.searchSkills(query);
    return result.map((dto) => SkillMapper.toEntityList(dto));
  }

  @override
  Future<Either<AppError, SkillEntity>> addSkill(String name) async {
    final result = await _dataSource.createSkill(name);
    return result.map((dto) => SkillMapper.toEntity(dto));
  }

  @override
  Future<Either<AppError, Unit>> deleteSkill(String skillId) async {
    return _dataSource.deleteSkill(skillId);
  }

  @override
  Future<Either<AppError, Unit>> updateSkill(String skillId, Map<String, dynamic> changes) async {
    return _dataSource.updateSkill(skillId, changes);
  }
}

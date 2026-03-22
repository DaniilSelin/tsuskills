import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:tsu_skills/entities/resume/api/mapper.dart';
import 'package:tsu_skills/entities/resume/api/resume_datasourse.dart';
import 'package:tsu_skills/entities/resume/api/dto/resume_dto.dart';
import 'package:tsu_skills/entities/resume/repository/resume_repository.dart';
import 'package:tsu_skills/entities/resume/model/resume.dart';
import 'package:tsu_skills/shared/lib/core/errors/app_error.dart';

@Injectable(as: ResumeRepository)
class ResumeRepositoryImpl implements ResumeRepository {
  final ResumeRemoteDataSource _dataSource;

  ResumeRepositoryImpl(this._dataSource);

  @override
  Future<Either<AppError, ResumeEntity>> getResume({
    required String resumeId,
  }) async {
    final resultDto = await _dataSource.fetchResumeDto(resumeId: resumeId);
    return resultDto.map((dto) => ResumeMapper.toEntity(dto));
  }

  @override
  Future<Either<AppError, List<ResumeEntity>>> getMyResumesList() async {
    final resultDtoList = await _dataSource.fetchResumes();

    return resultDtoList.map((dto) => ResumeMapper.toEntityList(dto));
  }

  @override
  Future<Either<AppError, Unit>> createResume({
    required String name,
    required String description,
    required String aboutMe,
    required List<String> skillIds,
  }) async {
    final result = await _dataSource.createResume(
      data: ResumeCompanion(
        name: name,
        description: description,
        aboutMe: aboutMe,
        skillIds: skillIds,
      ),
    );
    return result;
  }

  @override
  Future<Either<AppError, Unit>> updateResume({
    required String id,
    String? name,
    String? description,
    String? aboutMe,
    List<String>? skillIds,
  }) async {
    final resultDto = await _dataSource.updateResume(
      ResumeCompanion(
        id: id,
        description: description,
        name: name,
        aboutMe: aboutMe,
        skillIds: skillIds,
      ),
    );

    return resultDto.map((_) => unit);
  }

  @override
  Future<Either<AppError, Unit>> deleteResume({
    required String resumeId,
  }) async {
    return _dataSource.deleteResume(resumeId: resumeId);
  }

  @override
  Future<Either<AppError, List<ResumeEntity>>> getAvailableResumesForVacancy(
    String vacancyId,
  ) async {
    final response = await _dataSource.getAvailableResumesForVacancy(
      vacancyId: vacancyId,
    );

    return response.map((list) => list.map(ResumeMapper.toEntity).toList());
  }
}

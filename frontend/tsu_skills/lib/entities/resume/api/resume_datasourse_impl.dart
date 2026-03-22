import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:tsu_skills/entities/resume/api/dto/resume_dto.dart';
import 'package:tsu_skills/entities/resume/api/resume_datasourse.dart';
import 'package:tsu_skills/shared/lib/api/client/api_client.dart';
import 'package:tsu_skills/shared/lib/api/token/token_storage.dart';
import 'package:tsu_skills/shared/lib/core/errors/app_error.dart';

@Injectable(as: ResumeRemoteDataSource)
class ResumeRemoteDataSourceImpl implements ResumeRemoteDataSource {
  final ApiClient _api;
  final TokenStorage _tokenStorage;

  ResumeRemoteDataSourceImpl(this._api, this._tokenStorage);

  @override
  Future<Either<AppError, List<ResumeDto>>> getAvailableResumesForVacancy({required String vacancyId}) async {
    return fetchResumes(); // все мои резюме — фильтрация на UI
  }

  @override
  Future<Either<AppError, ResumeDto>> fetchResumeDto({required String resumeId}) async {
    final result = await _api.get('/api/v1/resumes/$resumeId');
    return result.fold((err) => Left(err), (data) => Right(ResumeDto.fromJson(data)));
  }

  @override
  Future<Either<AppError, List<ResumeDto>>> fetchResumes() async {
    final userId = _tokenStorage.userId;
    if (userId == null) return const Left(AppError.permissionDenied());

    final result = await _api.getList('/api/v1/resumes', queryParams: {'user_id': userId});
    return result.fold(
      (err) => Left(err),
      (list) {
        final resumes = list.map((e) => ResumeDto.fromJson(Map<String, dynamic>.from(e))).toList();
        return Right(resumes);
      },
    );
  }

  @override
  Future<Either<AppError, Unit>> createResume({required ResumeCompanion data}) async {
    final userId = _tokenStorage.userId;
    if (userId == null) return const Left(AppError.permissionDenied());

    final result = await _api.post('/api/v1/resumes', body: {
      'user_id': userId,
      'name': data.name ?? '',
      'description': data.description ?? '',
      'about_me': data.aboutMe ?? '',
      'skill_names': data.skillIds ?? [],
    });
    return result.fold((err) => Left(err), (_) => Right(unit));
  }

  @override
  Future<Either<AppError, Unit>> deleteResume({required String resumeId}) async {
    final result = await _api.delete('/api/v1/resumes/$resumeId');
    return result.fold((err) => Left(err), (_) => Right(unit));
  }

  @override
  Future<Either<AppError, Unit>> updateResume(ResumeCompanion data) async {
    if (data.id == null) return Left(AppError.validationError(message: 'No resume ID'));
    final body = <String, dynamic>{};
    if (data.name != null) body['name'] = data.name;
    if (data.description != null) body['description'] = data.description;
    if (data.aboutMe != null) body['about_me'] = data.aboutMe;
    if (data.skillIds != null) body['skill_names'] = data.skillIds;
    final result = await _api.put('/api/v1/resumes/${data.id}', body: body);
    return result.fold((err) => Left(err), (_) => Right(unit));
  }
}

import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:tsu_skills/entities/application/api/application_datasourse.dart';
import 'package:tsu_skills/entities/application/api/application_dto/application_dto.dart';
import 'package:tsu_skills/shared/lib/api/client/api_client.dart';
import 'package:tsu_skills/shared/lib/api/token/token_storage.dart';
import 'package:tsu_skills/shared/lib/core/errors/app_error.dart';

@Injectable(as: ApplicationDatasourse)
class ApplicationDatasourseImpl implements ApplicationDatasourse {
  final ApiClient _api;
  final TokenStorage _tokenStorage;

  ApplicationDatasourseImpl(this._api, this._tokenStorage);

  @override
  Future<Either<AppError, String>> createApplication(ApplicationCompanion companion) async {
    final result = await _api.post('/api/v1/applications', body: {
      'resume_id': companion.resumeId,
      'vacancy_id': companion.vacancyId,
    });
    return result.fold(
      (err) => Left(err),
      (data) => Right(data['id'] as String? ?? ''),
    );
  }

  @override
  Future<Either<AppError, List<ApplicationDto>>> fetchByVacancyId(String vacancyId) async {
    return getApplicationsByVacancy(vacancyId);
  }

  @override
  Future<Either<AppError, List<ApplicationDto>>> fetchMyApplication() async {
    final userId = _tokenStorage.userId;
    if (userId == null) return const Left(AppError.permissionDenied());

    final result = await _api.getList('/api/v1/applications', queryParams: {'user_id': userId});
    return result.fold(
      (err) => Left(err),
      (list) {
        final apps = list.map((e) => ApplicationDto.fromJson(Map<String, dynamic>.from(e))).toList();
        return Right(apps);
      },
    );
  }

  @override
  Future<Either<AppError, ApplicationDto>> getMyApplicationById(String applicationId) async {
    final result = await _api.get('/api/v1/applications/$applicationId');
    return result.fold((err) => Left(err), (data) => Right(ApplicationDto.fromJson(data)));
  }

  @override
  Future<Either<AppError, List<ApplicationDto>>> getApplicationsByVacancy(String vacancyId) async {
    final result = await _api.getList('/api/v1/applications', queryParams: {'vacancy_id': vacancyId});
    return result.fold(
      (err) => Left(err),
      (list) {
        final apps = list.map((e) => ApplicationDto.fromJson(Map<String, dynamic>.from(e))).toList();
        return Right(apps);
      },
    );
  }
}

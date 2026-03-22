import 'package:fpdart/fpdart.dart' as fp;
import 'package:injectable/injectable.dart';
import 'package:tsu_skills/entities/vacancy/api/vacancy_datasourse.dart';
import 'package:tsu_skills/entities/vacancy/api/vacancy_dto/vacancy_dto.dart';
import 'package:tsu_skills/shared/lib/api/client/api_client.dart';
import 'package:tsu_skills/shared/lib/api/token/token_storage.dart';
import 'package:tsu_skills/shared/lib/core/errors/app_error.dart';

@Injectable(as: VacancyDatasource)
class VacancyDatasourceImpl implements VacancyDatasource {
  final ApiClient _api;
  final TokenStorage _tokenStorage;

  VacancyDatasourceImpl(this._api, this._tokenStorage);

  @override
  Future<fp.Either<AppError, List<VacancyDto>>> getMyVacancies() async {
    final employerId = _tokenStorage.userId;
    if (employerId == null) return const fp.Left(AppError.permissionDenied());

    final result = await _api.get(
      '/api/v1/vacancies',
      queryParams: {'employer_id': employerId},
    );
    return result.fold(
      (err) => fp.Left(err),
      (data) {
        final list = (data['vacancies'] as List<dynamic>? ?? [])
            .map((e) => VacancyDto.fromJson(Map<String, dynamic>.from(e)))
            .toList();
        return fp.Right(list);
      },
    );
  }

  @override
  Future<fp.Either<AppError, List<VacancyDto>>> searchMyVacancies(VacancyCompanion companion) async {
    return getMyVacancies(); // simplified — filter client-side
  }

  @override
  Future<fp.Either<AppError, List<VacancyDto>>> searchVacancies({String? name, List<String>? skillIds}) async {
    final body = <String, dynamic>{};
    if (name != null && name.isNotEmpty) body['q'] = name;
    // skillIds search через OpenSearch
    final result = await _api.post('/api/v1/vacancies/search', body: body);
    return result.fold(
      (err) => fp.Left(err),
      (data) {
        final list = (data['vacancies'] as List<dynamic>? ?? [])
            .map((e) => VacancyDto.fromJson(Map<String, dynamic>.from(e)))
            .toList();
        return fp.Right(list);
      },
    );
  }

  @override
  Future<fp.Either<AppError, fp.Unit>> createVacancy(VacancyCompanion vacancy) async {
    final body = <String, dynamic>{
      'employer_id': _tokenStorage.userId ?? '',
      'title': vacancy.title ?? '',
      'description': vacancy.description ?? '',
      'activity_type': {'id': 1, 'name': 'Программирование'},
      'employment_type': 'Полная занятость',
      'work_schedule': 'Офисный',
      'skills': (vacancy.skillIds ?? []).map((id) => {'id': 0, 'name': id}).toList(),
    };
    final result = await _api.post('/api/v1/vacancies', body: body);
    return result.fold((err) => fp.Left(err), (_) => fp.Right(fp.unit));
  }

  @override
  Future<fp.Either<AppError, fp.Unit>> updateVacancy(VacancyCompanion vacancy) async {
    if (vacancy.objectId == null) {
      return fp.Left(AppError.validationError(message: 'No vacancy ID'));
    }
    final body = <String, dynamic>{};
    if (vacancy.title != null) body['title'] = vacancy.title;
    if (vacancy.description != null) body['description'] = vacancy.description;

    final result = await _api.put('/api/v1/vacancies/${vacancy.objectId}', body: body);
    return result.fold((err) => fp.Left(err), (_) => fp.Right(fp.unit));
  }

  @override
  Future<fp.Either<AppError, fp.Unit>> deleteVacancy(String objectId) async {
    final result = await _api.delete('/api/v1/vacancies/$objectId');
    return result.fold((err) => fp.Left(err), (_) => fp.Right(fp.unit));
  }

  @override
  Future<fp.Either<AppError, VacancyDto?>> getVacancy(String objectId) async {
    final result = await _api.get('/api/v1/vacancies/$objectId');
    return result.fold(
      (err) => fp.Left(err),
      (data) => fp.Right(VacancyDto.fromJson(data)),
    );
  }

  @override
  Future<fp.Either<AppError, List<VacancyDto>>> getOrganizationVacancies(String organizationId) async {
    // организации привязаны через employer_id
    return searchVacancies();
  }

  @override
  Future<fp.Either<AppError, List<VacancyDto>>> getVacanciesBySkills(List<String> skillIds) async {
    return searchVacancies();
  }
}

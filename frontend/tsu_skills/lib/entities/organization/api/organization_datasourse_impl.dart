import 'package:fpdart/fpdart.dart' as fp;
import 'package:injectable/injectable.dart';
import 'package:tsu_skills/entities/organization/api/organization_datasourse.dart';
import 'package:tsu_skills/entities/organization/api/types/organization_dto.dart';
import 'package:tsu_skills/shared/lib/api/client/api_client.dart';
import 'package:tsu_skills/shared/lib/api/token/token_storage.dart';
import 'package:tsu_skills/shared/lib/core/errors/app_error.dart';

@Injectable(as: OrganizationDatasource)
class OrganizationDatasourceImpl implements OrganizationDatasource {
  final ApiClient _api;
  final TokenStorage _tokenStorage;

  const OrganizationDatasourceImpl(this._api, this._tokenStorage);

  @override
  Future<fp.Either<AppError, OrganizationDto?>> getMyOrganization() async {
    final directorId = _tokenStorage.userId;
    if (directorId == null) return const fp.Left(AppError.permissionDenied());

    final result = await _api.get(
      '/api/v1/organizations/my',
      queryParams: {'director_id': directorId},
    );
    return result.fold(
      (err) => err == const AppError.notFound() ? const fp.Right(null) : fp.Left(err),
      (data) => fp.Right(OrganizationDto.fromJson(data)),
    );
  }

  @override
  Future<fp.Either<AppError, OrganizationDto?>> getOrganizationByUser(String userId) async {
    final result = await _api.get('/api/v1/organizations/my', queryParams: {'director_id': userId});
    return result.fold(
      (err) => err == const AppError.notFound() ? const fp.Right(null) : fp.Left(err),
      (data) => fp.Right(OrganizationDto.fromJson(data)),
    );
  }

  @override
  Future<fp.Either<AppError, OrganizationDto?>> getOrganization(String objectId) async {
    final result = await _api.get('/api/v1/organizations/$objectId');
    return result.fold((err) => fp.Left(err), (data) => fp.Right(OrganizationDto.fromJson(data)));
  }

  @override
  Future<fp.Either<AppError, fp.Unit>> createOrganization(OrganizationCompanion org) async {
    final result = await _api.post('/api/v1/organizations', body: {
      'name': org.name ?? '',
      'about_us': org.aboutUs ?? '',
      'director_id': org.directorId ?? _tokenStorage.userId ?? '',
    });
    return result.fold((err) => fp.Left(err), (_) => fp.Right(fp.unit));
  }

  @override
  Future<fp.Either<AppError, fp.Unit>> updateMyOrganization(OrganizationCompanion org) async {
    if (org.objectId == null) return fp.Left(AppError.validationError(message: 'No org ID'));
    final body = <String, dynamic>{};
    if (org.name != null) body['name'] = org.name;
    if (org.aboutUs != null) body['about_us'] = org.aboutUs;
    final result = await _api.put('/api/v1/organizations/${org.objectId}', body: body);
    return result.fold((err) => fp.Left(err), (_) => fp.Right(fp.unit));
  }

  @override
  Future<fp.Either<AppError, fp.Unit>> deleteOrganization(String objectId) async {
    final result = await _api.delete('/api/v1/organizations/$objectId');
    return result.fold((err) => fp.Left(err), (_) => fp.Right(fp.unit));
  }

  @override
  Future<fp.Either<AppError, List<OrganizationDto>>> getOrganizations({int limit = 100, int skip = 0}) async {
    // skills-service не имеет list all orgs, возвращаем пустой
    return const fp.Right([]);
  }
}

import 'package:injectable/injectable.dart';
import 'package:tsu_skills/entities/organization/api/organization_datasourse.dart';
import 'package:tsu_skills/entities/organization/api/organization_mapper.dart';
import 'package:tsu_skills/entities/organization/api/types/organization_dto.dart';
import 'package:tsu_skills/entities/organization/model/repository/organization_repository.dart';
import 'package:fpdart/fpdart.dart' as fp;
import 'package:tsu_skills/entities/organization/model/types/organization.dart';
import 'package:tsu_skills/shared/lib/core/errors/app_error.dart';

@Injectable(as: OrganizationRepository)
class OrganizationRepositoryImpl implements OrganizationRepository {
  final OrganizationDatasource _datasource;

  OrganizationRepositoryImpl(this._datasource);

  @override
  Future<fp.Either<AppError, fp.Unit>> createOrganization({
    required String name,
    required String directorId,
    String? aboutUs,
  }) async {
    return _datasource.createOrganization(
      OrganizationCompanion(
        name: name,
        aboutUs: aboutUs,
        directorId: directorId,
      ),
    );
  }

  @override
  Future<fp.Either<AppError, fp.Unit>> updateOrganization({
    String? id,
    String? name,
    String? directorId,
    String? aboutUs,
  }) async {
    return _datasource.updateMyOrganization(
      OrganizationCompanion(
        objectId: id,
        name: name,
        aboutUs: aboutUs,
        directorId: directorId,
      ),
    );
  }

  @override
  Future<fp.Either<AppError, fp.Unit>> deleteOrganization(String objectId) =>
      _datasource.deleteOrganization(objectId);

  @override
  Future<fp.Either<AppError, OrganizationEntity?>> getOrganization(
    String objectId,
  ) async {
    final result = await _datasource.getOrganization(objectId);
    return result.map(
      (dto) => dto != null ? OrganizationMapper.toEntity(dto) : null,
    );
  }

  @override
  Future<fp.Either<AppError, List<OrganizationEntity>>> getOrganizations({
    int limit = 100,
    int skip = 0,
  }) async {
    final result = await _datasource.getOrganizations(limit: limit, skip: skip);
    return result.map((list) => list.map(OrganizationMapper.toEntity).toList());
  }

  @override
  Future<fp.Either<AppError, OrganizationEntity?>> getMyOrganization() async {
    final result = await _datasource.getMyOrganization();
    return result.map(
      (dto) => dto != null ? OrganizationMapper.toEntity(dto) : null,
    );
  }

  @override
  Future<fp.Either<AppError, OrganizationEntity?>> getOrganizationByUser(
    String userId,
  ) async {
    final result = await _datasource.getOrganizationByUser(userId);
    return result.map(
      (dto) => dto != null ? OrganizationMapper.toEntity(dto) : null,
    );
  }
}

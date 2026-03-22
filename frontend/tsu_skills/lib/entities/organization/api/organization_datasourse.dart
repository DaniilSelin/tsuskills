import 'package:fpdart/fpdart.dart';
import 'package:tsu_skills/entities/organization/api/types/organization_dto.dart';
import 'package:tsu_skills/shared/lib/core/errors/app_error.dart';

abstract interface class OrganizationDatasource {
  Future<Either<AppError, Unit>> createOrganization(
    OrganizationCompanion organization,
  );
  Future<Either<AppError, Unit>> updateMyOrganization(
    OrganizationCompanion organization,
  );
  Future<Either<AppError, OrganizationDto?>> getOrganizationByUser(
    String userId,
  );
  Future<Either<AppError, OrganizationDto?>> getMyOrganization();
  Future<Either<AppError, Unit>> deleteOrganization(String objectId);
  Future<Either<AppError, OrganizationDto?>> getOrganization(String objectId);
  Future<Either<AppError, List<OrganizationDto>>> getOrganizations({
    int limit = 100,
    int skip = 0,
  });
}

import 'package:tsu_skills/entities/organization/model/types/organization.dart';
import 'package:tsu_skills/shared/lib/core/errors/app_error.dart';
import 'package:fpdart/fpdart.dart' as fp;

abstract interface class OrganizationRepository {
  Future<fp.Either<AppError, fp.Unit>> createOrganization({
    required String name,
    required String directorId,
    String? aboutUs,
  });

  Future<fp.Either<AppError, fp.Unit>> updateOrganization({
    String? id,
    String? name,
    String? directorId,
    String? aboutUs,
  });

  Future<fp.Either<AppError, fp.Unit>> deleteOrganization(String objectId);

  Future<fp.Either<AppError, OrganizationEntity?>> getOrganization(
    String objectId,
  );

  Future<fp.Either<AppError, List<OrganizationEntity>>> getOrganizations({
    int limit = 100,
    int skip = 0,
  });

  Future<fp.Either<AppError, OrganizationEntity?>> getMyOrganization();

  Future<fp.Either<AppError, OrganizationEntity?>> getOrganizationByUser(
    String userId,
  );
}

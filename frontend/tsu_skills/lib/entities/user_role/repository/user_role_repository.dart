import 'package:tsu_skills/entities/user_role/model/role_enum.dart';
import 'package:tsu_skills/shared/lib/core/errors/app_error.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class UserRoleRepository {
  Future<Either<AppError, RoleEnum>> fetchCurrentUserRole();
}
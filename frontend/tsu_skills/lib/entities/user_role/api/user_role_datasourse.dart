import 'package:tsu_skills/entities/user_role/api/user_role_dto/user_role_dto.dart';
import 'package:tsu_skills/shared/lib/core/errors/app_error.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class UserRoleDataSource{
  Future<Either<AppError, UserRoleDto?>> fetchCurrentUserRole();
}

import 'package:injectable/injectable.dart';
import 'package:tsu_skills/entities/user_role/api/user_role_datasourse.dart';
import 'package:tsu_skills/entities/user_role/model/role_enum.dart';
import 'package:tsu_skills/entities/user_role/repository/user_role_repository.dart';
import 'package:tsu_skills/shared/lib/core/errors/app_error.dart';
import 'package:fpdart/fpdart.dart';

@Injectable(as: UserRoleRepository)
class UserRoleRepositoryImpl implements UserRoleRepository {
  UserRoleRepositoryImpl(this._dataSource);
  final UserRoleDataSource _dataSource;

  @override
  Future<Either<AppError, RoleEnum>> fetchCurrentUserRole() async {
    final response = await _dataSource.fetchCurrentUserRole();
    return response.fold((e) => Left(e), (dto) {
      if (dto == null) {
        return Right(RoleEnum.guest);
      }

      RoleEnum? role;
      if (dto.name == 'user') {
        role = RoleEnum.user;
      }
      if (dto.name == 'organizator') {
        role = RoleEnum.organizator;
      }

      if (role == null) {
        return Left(
          AppError.validationError(message: 'неизвестная роль ${dto.name}'),
        );
      }

      return Right(role);
    });
  }
}

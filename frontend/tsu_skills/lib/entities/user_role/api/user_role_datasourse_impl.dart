import 'package:injectable/injectable.dart';
import 'package:tsu_skills/entities/user_role/api/user_role_datasourse.dart';
import 'package:tsu_skills/entities/user_role/api/user_role_dto/user_role_dto.dart';
import 'package:tsu_skills/shared/lib/api/client/api_client.dart';
import 'package:tsu_skills/shared/lib/api/token/token_storage.dart';
import 'package:tsu_skills/shared/lib/core/errors/app_error.dart';
import 'package:fpdart/fpdart.dart';

@Injectable(as: UserRoleDataSource)
class UserRoleDataSourceImpl implements UserRoleDataSource {
  final ApiClient _api;
  final TokenStorage _tokenStorage;

  UserRoleDataSourceImpl(this._api, this._tokenStorage);

  @override
  Future<Either<AppError, UserRoleDto?>> fetchCurrentUserRole() async {
    if (!_tokenStorage.isAuthenticated) {
      return const Right(null); // guest
    }

    // Проверяем, валиден ли токен через /auth
    final result = await _api.get('/api/v1/users/auth');
    return result.fold(
      (err) {
        // Если 401 — токен невалиден, значит guest
        return const Right(null);
      },
      (data) {
        final userId = data['user_id'] as String?;
        if (userId == null) return const Right(null);

        _tokenStorage.saveUserId(userId);

        // Пока роль определяем как 'user' — в будущем можно добавить
        // эндпоинт /api/v1/users/me/role на бэкенде
        return Right(UserRoleDto(id: userId, name: 'user'));
      },
    );
  }
}

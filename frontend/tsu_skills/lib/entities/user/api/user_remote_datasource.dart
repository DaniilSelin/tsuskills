import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:tsu_skills/shared/lib/api/client/api_client.dart';
import 'package:tsu_skills/shared/lib/api/token/token_storage.dart';
import 'package:tsu_skills/shared/lib/core/errors/app_error.dart';
import 'package:tsu_skills/entities/user/api/user_dto/user_dto.dart';

@injectable
class UserRemoteDatasource {
  final ApiClient _api;
  final TokenStorage _tokenStorage;

  UserRemoteDatasource(this._api, this._tokenStorage);

  Future<Either<AppError, Unit>> logout() async {
    _tokenStorage.clear();
    return const Right(unit);
  }

  Future<Either<AppError, UserDto>> getCurrentUser() async {
    final result = await _api.get('/api/v1/users/me');
    return result.fold(
      (err) => Left(err),
      (data) => Right(UserDto.fromJson(data)),
    );
  }

  Future<Either<AppError, UserDto>> updateUser({
    String? username,
    String? email,
    String? vkRef,
    String? telegramRef,
    String? phone,
  }) async {
    final userId = _tokenStorage.userId;
    if (userId == null) return const Left(AppError.permissionDenied());

    final body = <String, dynamic>{};
    if (username != null && username.isNotEmpty) body['name'] = username;
    if (email != null && email.isNotEmpty) body['email'] = email;

    final result = await _api.put('/api/v1/users/$userId', body: body);
    return result.fold(
      (err) => Left(err),
      (_) async {
        // после обновления получаем свежие данные
        final fresh = await getCurrentUser();
        return fresh;
      },
    );
  }
}

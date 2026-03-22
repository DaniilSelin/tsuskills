import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:tsu_skills/shared/lib/api/client/api_client.dart';
import 'package:tsu_skills/shared/lib/api/token/token_storage.dart';
import 'package:tsu_skills/shared/lib/core/errors/app_error.dart';

class AuthResult {
  final String userId;
  final String accessToken;
  final String refreshToken;
  AuthResult({required this.userId, required this.accessToken, required this.refreshToken});
}

@injectable
class AuthDatasource {
  final ApiClient _api;
  final TokenStorage _tokenStorage;

  AuthDatasource(this._api, this._tokenStorage);

  Future<Either<AppError, AuthResult>> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final result = await _api.post(
      '/api/v1/users/register',
      body: {'name': name, 'email': email, 'password': password},
      auth: false,
    );
    return result.fold((err) => Left(err), (data) {
      final auth = AuthResult(
        userId: data['user_id'] as String? ?? '',
        accessToken: data['access_token'] as String,
        refreshToken: data['refresh_token'] as String,
      );
      _tokenStorage.saveTokens(
        accessToken: auth.accessToken,
        refreshToken: auth.refreshToken,
        userId: auth.userId,
      );
      return Right(auth);
    });
  }

  Future<Either<AppError, AuthResult>> login({
    required String email,
    required String password,
  }) async {
    final result = await _api.post(
      '/api/v1/users/login',
      body: {'email': email, 'password': password},
      auth: false,
    );
    return result.fold((err) => Left(err), (data) {
      final auth = AuthResult(
        userId: '',
        accessToken: data['access_token'] as String,
        refreshToken: data['refresh_token'] as String,
      );
      _tokenStorage.saveTokens(
        accessToken: auth.accessToken,
        refreshToken: auth.refreshToken,
      );
      return Right(auth);
    });
  }

  Future<Either<AppError, void>> requestPasswordReset(String email) async {
    return const Right(null);
  }

  void logout() {
    _tokenStorage.clear();
  }
}

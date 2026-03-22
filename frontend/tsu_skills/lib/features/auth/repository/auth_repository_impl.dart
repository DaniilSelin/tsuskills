import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:tsu_skills/entities/user/index.dart';
import 'package:tsu_skills/features/auth/api/auth_datasourse.dart';
import 'package:tsu_skills/features/auth/repository/auth_repository.dart';
import 'package:tsu_skills/shared/lib/core/errors/app_error.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._datasource);
  final AuthDatasource _datasource;

  @override
  Future<Either<AppError, UserEntity>> login(String username, String password) async {
    final response = await _datasource.login(email: username, password: password);
    return response.map((auth) => UserEntity(
      id: auth.userId,
      username: username,
      email: username,
    ));
  }

  @override
  Future<Either<AppError, void>> requestPasswordReset(String email) async {
    return _datasource.requestPasswordReset(email);
  }

  @override
  Future<Either<AppError, UserEntity>> signUp(String email, String username, String password) async {
    final response = await _datasource.signUp(
      name: username,
      email: email,
      password: password,
    );
    return response.map((auth) => UserEntity(
      id: auth.userId,
      username: username,
      email: email,
    ));
  }
}

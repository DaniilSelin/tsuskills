import 'package:fpdart/fpdart.dart';
import 'package:tsu_skills/entities/user/model/user_entity.dart';
import 'package:tsu_skills/shared/lib/core/errors/app_error.dart';

abstract interface class AuthRepository {
  Future<Either<AppError, UserEntity>> signUp(
    String email,
    String username,
    String password,
  );
  Future<Either<AppError, UserEntity>> login(String username, String password);
  Future<Either<AppError, void>> requestPasswordReset(String email);
}

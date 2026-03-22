import 'package:fpdart/fpdart.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tsu_skills/entities/user/model/user_entity.dart';
import 'package:tsu_skills/shared/lib/core/errors/app_error.dart';

abstract interface class UserRemoteRepository {
  Future<Either<AppError, UserEntity>> getCurrentUser();
  Future<Either<AppError, UserEntity>> updateUser({
    String? email,
    String? username,
    String? vkRef,
    String? phone,
    String? telegramRef,
    XFile? userPhotoFile,
  });

  Future<Either<AppError, Unit>> logout();
}

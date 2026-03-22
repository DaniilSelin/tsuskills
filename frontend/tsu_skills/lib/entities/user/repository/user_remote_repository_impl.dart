import 'package:fpdart/fpdart.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:tsu_skills/entities/user/api/user_remote_datasource.dart';
import 'package:tsu_skills/entities/user/api/user_mapper.dart';
import 'package:tsu_skills/entities/user/model/user_entity.dart';
import 'package:tsu_skills/entities/user/repository/user_remote_repository.dart';
import 'package:tsu_skills/shared/lib/core/errors/app_error.dart';

@Injectable(as: UserRemoteRepository)
class UserRemoteRepositoryImpl implements UserRemoteRepository {
  UserRemoteRepositoryImpl(this._datasource);
  final UserRemoteDatasource _datasource;

  @override
  Future<Either<AppError, UserEntity>> getCurrentUser() async {
    final response = await _datasource.getCurrentUser();
    return response.map((dto) => UserMapper.toEntity(dto));
  }

  @override
  Future<Either<AppError, UserEntity>> updateUser({
    String? email,
    String? username,
    String? vkRef,
    String? phone,
    String? telegramRef,
    XFile? userPhotoFile,
  }) async {
    final response = await _datasource.updateUser(
      email: email,
      username: username,
      vkRef: vkRef,
      telegramRef: telegramRef,
      phone: phone,
    );
    return response.map((dto) => UserMapper.toEntity(dto));
  }

  @override
  Future<Either<AppError, Unit>> logout() => _datasource.logout();
}

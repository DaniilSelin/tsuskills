import 'package:tsu_skills/entities/user/api/user_dto/user_dto.dart';
import 'package:tsu_skills/entities/user/model/user_entity.dart';

class UserMapper {
  static UserEntity toEntity(UserDto dto) => UserEntity(
    id: dto.id,
    username: dto.name,
    email: dto.email?.address ?? '',
  );
}

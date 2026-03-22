import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entity.freezed.dart';

@freezed
abstract class UserEntity with _$UserEntity {
  const factory UserEntity({
    required String id,
    required String username,
    required String email,
    String? vkRef,
    String? telegramRef,
    String? phone,
    String? userPhotoUrl,
  }) = _UserEntity;
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_dto.freezed.dart';
part 'user_dto.g.dart';

@freezed
abstract class UserDto with _$UserDto {
  const factory UserDto({
    @JsonKey(name: 'id') required String id,
    required String name,
    @JsonKey(name: 'status') String? status,
    @JsonKey(name: 'is_verified') bool? isVerified,
    @JsonKey(name: 'email') EmailDto? email,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _UserDto;

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);
}

@freezed
abstract class EmailDto with _$EmailDto {
  const factory EmailDto({
    @JsonKey(name: 'address') required String address,
    @JsonKey(name: 'is_primary') bool? isPrimary,
    @JsonKey(name: 'is_verified') bool? isVerified,
  }) = _EmailDto;

  factory EmailDto.fromJson(Map<String, dynamic> json) =>
      _$EmailDtoFromJson(json);
}

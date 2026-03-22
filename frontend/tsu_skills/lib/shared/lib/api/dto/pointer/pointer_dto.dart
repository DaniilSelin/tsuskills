import 'package:freezed_annotation/freezed_annotation.dart';

part 'pointer_dto.freezed.dart';
part 'pointer_dto.g.dart';

@freezed
abstract class PointerDto with _$PointerDto {
  const factory PointerDto({required String objectId}) = _PointerDto;

  factory PointerDto.fromJson(Map<String, dynamic> json) =>
      _$PointerDtoFromJson(json);
}

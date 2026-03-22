import 'package:freezed_annotation/freezed_annotation.dart';

part 'organization.freezed.dart';

@freezed
abstract class OrganizationEntity with _$OrganizationEntity {
  const factory OrganizationEntity({
    required String objectId,
    required DateTime createdAt,
    required DateTime updatedAt,
    String? aboutUs,
    required String name,
  }) = _OrganizationEntity;
}
part of 'update_organization_bloc.dart';

@freezed
class UpdateOrganizationEvent with _$UpdateOrganizationEvent {
  const factory UpdateOrganizationEvent.fetchOrganization() =
      _FetchOrganization;
  const factory UpdateOrganizationEvent.saveOrganization({
    String? name,
    String? aboutUs,
  }) = _SaveOrganization;
}

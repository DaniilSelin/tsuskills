part of 'my_organization_bloc.dart';

@freezed
abstract class MyOrganizationEvent with _$MyOrganizationEvent {
  const factory MyOrganizationEvent.fetchOrganization() = _FetchOrganization;
}
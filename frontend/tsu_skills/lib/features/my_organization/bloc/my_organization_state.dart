part of 'my_organization_bloc.dart';

@freezed
abstract class MyOrganizationState with _$MyOrganizationState {
  const factory MyOrganizationState.loading() = _Loading;
  const factory MyOrganizationState.loaded(OrganizationEntity organization) =
      _Loaded;
  const factory MyOrganizationState.error(String message) = _ErrorState;
}

part of 'update_organization_bloc.dart';

@freezed
class UpdateOrganizationState with _$UpdateOrganizationState {
  const factory UpdateOrganizationState.loading() = _Loading;
  const factory UpdateOrganizationState.loaded(OrganizationEntity entity) =
      _Loaded;
  const factory UpdateOrganizationState.saved() = _Saved;
  const factory UpdateOrganizationState.error(String message) = _ErrorState;
}

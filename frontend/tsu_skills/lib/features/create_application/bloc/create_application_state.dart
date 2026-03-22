part of 'create_application_bloc.dart';

@freezed
abstract class CreateApplicationState with _$CreateApplicationState {
  const factory CreateApplicationState.loaded(List<ResumeEntity> resumes) =
      _Loaded;
  const factory CreateApplicationState.loading() = _Loading;
  const factory CreateApplicationState.createdApplication(
    String applicationId,
  ) = _CreatedApplication;
  const factory CreateApplicationState.error(String message) = _Error;
}

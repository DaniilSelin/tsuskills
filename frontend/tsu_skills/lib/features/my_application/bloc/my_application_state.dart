part of 'my_application_bloc.dart';

@freezed
class MyApplicationState with _$MyApplicationState {
  const factory MyApplicationState.loading() = _Loading;
  const factory MyApplicationState.loaded(
    List<ApplicationEntity> applications,
  ) = _Loaded;

  const factory MyApplicationState.error(String message) = _Error;
}

part of 'application_on_vacancy_bloc.dart';

@freezed
abstract class ApplicationOnVacancyState with _$ApplicationOnVacancyState {
  const factory ApplicationOnVacancyState.loading() = _Loading;
  const factory ApplicationOnVacancyState.load(
    List<ApplicationEntity> entities,
  ) = _Load;
  const factory ApplicationOnVacancyState.error(String message) = _ErrorState;
}

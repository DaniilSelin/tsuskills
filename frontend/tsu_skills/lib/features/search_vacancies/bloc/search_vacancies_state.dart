part of 'search_vacancies_bloc.dart';

@freezed
abstract class SearchVacanciesState with _$SearchVacanciesState {
  const factory SearchVacanciesState.initial() = _Initial;
  const factory SearchVacanciesState.loading() = _Loading;
  const factory SearchVacanciesState.loaded(
    List<VacancyEntity> vacancies,
    bool isEmptyFilter,
  ) = _Loaded;
  const factory SearchVacanciesState.error(String message) = _Error;
}

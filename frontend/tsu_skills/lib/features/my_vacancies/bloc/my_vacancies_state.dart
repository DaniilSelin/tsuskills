part of 'my_vacancies_bloc.dart';

@freezed
abstract class MyVacanciesState with _$MyVacanciesState {
  const factory MyVacanciesState.loading() = _Loading;
  const factory MyVacanciesState.loaded(List<VacancyEntity> vacancies) =
      _Loaded;
  const factory MyVacanciesState.error(String message) = _ErrorState;
}

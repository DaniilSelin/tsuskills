part of 'my_vacancies_bloc.dart';

@freezed
abstract class MyVacanciesEvent with _$MyVacanciesEvent {
  const factory MyVacanciesEvent.fetchVacancies({int? page}) = _FetchVacancies;
}

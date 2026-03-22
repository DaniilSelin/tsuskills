part of 'vacancy_detail_bloc.dart';

@freezed
abstract class VacancyDetailEvent with _$VacancyDetailEvent {
  const factory VacancyDetailEvent.fetchVacancy() = _FetchVacancy;
}

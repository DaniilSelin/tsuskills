part of 'application_on_vacancy_bloc.dart';

@freezed
class ApplicationOnVacancyEvent with _$ApplicationOnVacancyEvent {
  const factory ApplicationOnVacancyEvent.fetchApplications() =
      _FetchApplications;
}

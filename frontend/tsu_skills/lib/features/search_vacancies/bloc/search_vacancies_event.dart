part of 'search_vacancies_bloc.dart';

@freezed
abstract class SearchVacanciesEvent with _$SearchVacanciesEvent {
  const factory SearchVacanciesEvent.search({
    String? name,
    List<String>? skillIds,
  }) = _Search;

  const factory SearchVacanciesEvent.clear() = _Clear;
}

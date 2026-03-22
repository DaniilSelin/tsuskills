part of 'vacancy_detail_bloc.dart';

@freezed
abstract class VacancyDetailState with _$VacancyDetailState {
  const factory VacancyDetailState.loading() = _Loading;
  const factory VacancyDetailState.loaded(VacancyEntity vacancy) = _Loaded;
  const factory VacancyDetailState.error(String message) = _Error;
}

part of 'create_vacancy_bloc.dart';

@freezed
abstract class CreateVacancyState with _$CreateVacancyState {
  const factory CreateVacancyState.initial() = _Initial;
  const factory CreateVacancyState.saved() = _Saved;
  const factory CreateVacancyState.loading() = _Loading;
  const factory CreateVacancyState.error(String message) = _Error;
}

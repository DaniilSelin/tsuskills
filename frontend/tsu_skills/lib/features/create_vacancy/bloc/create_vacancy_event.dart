part of 'create_vacancy_bloc.dart';

@freezed
abstract class CreateVacancyEvent with _$CreateVacancyEvent {
  const factory CreateVacancyEvent.createVacancy({
    required String title,
    required String description,
    required List<SkillEntity> skills,
  }) = _CreateVacancy;
}

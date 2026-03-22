part of 'create_resume_bloc.dart';

@freezed
abstract class CreateResumeEvent with _$CreateResumeEvent {
  const factory CreateResumeEvent.createResume({
    required String name,
    required String description,
    required String aboutMe,
    required List<SkillEntity> skills,
  }) = _CreateResume;
}

part of 'resume_edit_bloc.dart';

@freezed
abstract class ResumeEditEvent with _$ResumeEditEvent {
  const factory ResumeEditEvent.init() = _Init;
  const factory ResumeEditEvent.save({
    required String name,
    required String description,
    required String aboutMe,
    required List<SkillEntity> skills,
  }) = _Save;
}

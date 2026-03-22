part of 'resume_edit_bloc.dart';

@freezed
abstract class ResumeEditState with _$ResumeEditState {
  const factory ResumeEditState.loading() = _Loading;
  const factory ResumeEditState.loaded({
    required String name,
    required String description,
    required String aboutMe,
    required List<SkillEntity> skills,
  }) = _Loaded;
  const factory ResumeEditState.saved() = _Saved;
  const factory ResumeEditState.error(String message) = _Error;
}
